"""Shared validation for OpenSCAD output logs."""
from pathlib import Path


def clean_log(path):
    text = Path(path).read_text()
    failures = ('WARNING:', 'ERROR:', 'Parser error',
                'requires the following features', 'Incompatible processor')
    if any(token in text for token in failures):
        raise ValueError(f'failed OpenSCAD log {path}: {text[-2000:]}')
    return text
