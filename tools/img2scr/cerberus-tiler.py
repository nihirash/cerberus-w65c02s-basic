#!/usr/bin/env python3
import os
import argparse
import PIL
import itertools
from collections import Counter
from PIL import Image


def get_tiles(img):
    width, height = img.size
    data = img.tobytes()
    rows, cols = height // 8, width // 8
    for row in range(rows):
       for col in range(cols):
           yield tuple(data[cols * (row * 8 + line) + col] for line in range(8))


def convert(img):
    tiles = list(get_tiles(img))
    ctr = Counter(tiles)
    print(f'Unique tiles: {len(ctr)}')
    lut = { tile: idx for idx, (tile, cnt) in enumerate(ctr.most_common(256)) }
    tilemap = [ lut[tile] if tile in lut else 0 for tile in tiles ]
    tileset = list(itertools.chain(*lut.keys()))
    tileset += [0] * (256 * 8 - len(tileset))

    return tilemap, tileset


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Convert image to Cerberus tilemap/tileset')
    parser.add_argument('src', help='Source image name (has to be 320x240 monochrome')
    args = parser.parse_args()

    src = os.path.realpath(args.src)
    basename = os.path.splitext(src)[0]
    output = f'{basename}.scr'

    img = Image.open(src).convert('L').resize((320, 240), 0).convert('1')
    tilemap, tileset = convert(img)

    with open (output, 'wb') as file:
        file.write(bytes(tileset))
        file.seek(2048)
        file.write(bytes(tilemap))