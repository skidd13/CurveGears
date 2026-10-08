"""Write configuration identity only when renderer or flags change."""
from pathlib import Path
import shutil
import sys
from .build_inventory import write_if_changed


def main():
    target, renderer, *flags = sys.argv[1:]
    executable = Path(shutil.which(renderer) or renderer)
    identity = (str(executable.resolve()), executable.stat().st_mtime_ns, executable.stat().st_size) if executable.is_file() else (renderer, 'unavailable')
    write_if_changed(target, repr((identity, flags)) + '\n')


if __name__ == '__main__':
    main()
