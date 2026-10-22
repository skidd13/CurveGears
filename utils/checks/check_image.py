"""Validate a rendered OpenSCAD PNG and its dimensions."""
import argparse
from pathlib import Path
import struct
import zlib

from .logs import clean_log


def nonblank_png(data):
    width, height, depth, colour = struct.unpack(">IIBB", data[16:26])
    if depth != 8 or colour not in (2, 6):
        raise ValueError("unsupported PNG format; cannot verify visible geometry")
    channels = 3 if colour == 2 else 4
    compressed = bytearray()
    offset = 8
    while offset < len(data):
        length = struct.unpack(">I", data[offset:offset + 4])[0]
        if data[offset + 4:offset + 8] == b"IDAT":
            compressed.extend(data[offset + 8:offset + 8 + length])
        offset += length + 12
    raw = zlib.decompress(compressed)
    stride = width * channels
    if len(raw) != height * (stride + 1):
        raise ValueError("invalid PNG scanline length")
    previous = bytearray(stride)
    first = None
    different = False
    for y in range(height):
        offset = y * (stride + 1)
        filter_type = raw[offset]
        row = bytearray(raw[offset + 1:offset + 1 + stride])
        for x in range(stride):
            left = row[x - channels] if x >= channels else 0
            above = previous[x]
            upper_left = previous[x - channels] if x >= channels else 0
            if filter_type == 0:
                predictor = 0
            elif filter_type == 1:
                predictor = left
            elif filter_type == 2:
                predictor = above
            elif filter_type == 3:
                predictor = (left + above) // 2
            elif filter_type == 4:
                estimate = left + above - upper_left
                choices = (left, above, upper_left)
                predictor = min(choices, key=lambda value: abs(estimate - value))
            else:
                raise ValueError("invalid PNG filter")
            row[x] = (row[x] + predictor) % 256
        for x in range(0, stride, channels):
            pixel = bytes(row[x:x + channels])
            if first is None:
                first = pixel
            different |= pixel != first
        previous = row
    return different


def check(output, size):
    output = Path(output)
    text = clean_log(Path(str(output) + '.log'))
    if not output.is_file() or not output.stat().st_size:
        raise ValueError(f'missing/empty output: {output}')
    data = output.read_bytes()
    header = data[:24]
    expected_size = tuple(map(int, size.split(',')))
    if (header[:8] != b'\x89PNG\r\n\x1a\n'
            or struct.unpack('>II', header[16:24]) != expected_size):
        raise ValueError(f'incorrect PNG dimensions: {output}')
    if not nonblank_png(data) or 'Current top level object is empty.' in text:
        raise ValueError(f'blank image: {output}')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output')
    parser.add_argument('--size', required=True)
    args = parser.parse_args()
    check(args.output, args.size)


if __name__ == '__main__':
    main()
