#!/usr/bin/env python
# -*- coding: utf-8 -*-
import argparse
import os
import logging

logging.basicConfig(
    format="%(asctime)s %(levelname)s %(message)s",
    datefmt="%d-%m-%Y %H:%M:%S",
    level=logging.INFO,
)

LOG = logging.getLogger()

def check_utf8(filename):
    file = codecs.open(filename, encoding='utf-8', errors='strict')
    iterator = iter(file)
    return next(iterator)

def get_args():
    parser = argparse.ArgumentParser(description='Create Location CSV')
    parser.add_argument('-i', '--input', help='Input CSV file', required=True)
    parser.add_argument('-o', '--output', help='Output CSV file',
                        default='output.csv')
    parsed = parser.parse_args()

    assert os.path.exists(parsed.input), 'Input file does not exist'
    assert check_utf8(parsed.input), 'Input file must be encoded with utf-8'
    return parsed

def main():
    args = get_args()


__name__ == "__main__" and main()
