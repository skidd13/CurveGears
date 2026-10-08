"""Inspect Make-owned compile, image, mesh and collision outputs."""
from pathlib import Path
import argparse
import math
from collections import Counter
import re
import struct
import zlib
from .build_inventory import numeric
from .regression.stl import assert_closed_mesh


def clean_log(path):
    text = Path(path).read_text()
    if any(token in text for token in ('WARNING:', 'ERROR:', 'Parser error', 'requires the following features', 'Incompatible processor')):
        raise ValueError(f'failed OpenSCAD log {path}: {text[-2000:]}')
    return text


def nonblank_png(data):
    """Decode OpenSCAD's 8-bit RGB/RGBA PNG rows without extra dependencies."""
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


def closed_dxf(output):
    lines = output.read_text().splitlines()
    if len(lines) % 2:
        raise ValueError(f"invalid DXF group pairs: {output}")
    entities = []
    current = []
    in_entities = False
    for code, value in zip(lines[::2], lines[1::2]):
        code, value = int(code.strip()), value.strip()
        if code == 2 and value == "ENTITIES":
            in_entities = True
        elif in_entities and code == 0:
            if current:
                entities.append(current)
            current = [] if value == "ENDSEC" else [(code, value)]
            if value == "ENDSEC":
                in_entities = False
        elif in_entities:
            current.append((code, value))
    degrees = Counter()
    for entity in entities:
        fields = dict(entity[1:])
        if entity[0] == (0, "LINE"):
            edges = [((float(fields[10]), float(fields[20])),
                      (float(fields[11]), float(fields[21])))]
        elif entity[0] == (0, "LWPOLYLINE"):
            vertices = []
            x = None
            for code, value in entity[1:]:
                if code == 10:
                    x = float(value)
                elif code == 20:
                    if x is None:
                        raise ValueError("DXF vertex lacks x coordinate")
                    vertices.append((x, float(value)))
                    x = None
                elif code == 42 and float(value) != 0:
                    raise ValueError("curved DXF edges cannot represent the sampled outline")
            if not int(fields.get(70, 0)) & 1 or len(vertices) != int(fields[90]):
                raise ValueError(f"open or incomplete DXF polyline: {output}")
            edges = list(zip(vertices, vertices[1:] + vertices[:1]))
        else:
            raise ValueError(f"unsupported DXF entity: {entity[0]}")
        for a, b in edges:
            if not all(math.isfinite(value) for value in (*a, *b)):
                raise ValueError(f"invalid DXF edge: {output}")
            # DXF decimal export can repeat adjacent polygon vertices.
            # Such a zero-length edge adds no boundary and is ignored by import.
            if a != b:
                degrees.update((a, b))

    if len(degrees) < 3 or any(value != 2 for value in degrees.values()):
        raise ValueError(f"open or non-manifold DXF outline: {output}")


def check(output, mode, source='', size=None):
    output = Path(output)
    log = Path(str(output) + '.log') if mode == 'image' else output.with_suffix('.profile.log' if mode == 'profile' else '.log')
    text = clean_log(log)
    if mode == 'empty':
        if 'Current top level object is empty.' not in text or output.exists():
            raise ValueError(f'collision probe is not empty: {output}')
        return
    if not output.is_file() or not output.stat().st_size:
        raise ValueError(f'missing/empty output: {output}')
    if mode == 'compile':
        if numeric(source):
            if 'ECHO:' not in text or re.search(r'\b(?:undef|nan|inf)\b', text, re.I):
                raise ValueError(f'invalid numeric example: {source}: {text}')
        elif not output.read_text().strip():
            raise ValueError(f'empty geometry compilation: {source}')
    elif mode == 'image':
        data = output.read_bytes()
        header = data[:24]
        if header[:8] != b'\x89PNG\r\n\x1a\n' or struct.unpack('>II', header[16:24]) != tuple(map(int, size.split(','))):
            raise ValueError(f'incorrect PNG dimensions: {output}')
        if not nonblank_png(data) or 'Current top level object is empty.' in text:
            raise ValueError(f'blank image: {output}')
    elif mode == 'profile':
        closed_dxf(output)
    elif mode == 'mesh':
        assert_closed_mesh(output)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('mode', choices=['compile','image','mesh','empty','profile'])
    parser.add_argument('output')
    parser.add_argument('--source', default='')
    parser.add_argument('--size')
    args = parser.parse_args()
    check(args.output, args.mode, args.source, args.size)


if __name__ == '__main__':
    main()
