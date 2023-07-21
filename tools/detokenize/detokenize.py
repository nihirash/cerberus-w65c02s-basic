#!/usr/bin/env python3

# Detokenizes Cerberus basic program to plain text
# Requires basic65.lbl from current basic build as source of tokens and RAMSTART2 label

import argparse
import os

tokens = dict()
ramstart2 = 0

replacement = {
    'MIDSTR': 'MID$(',
    'RIGHTSTR': 'RIGHT$(',
    'LEFTSTR': 'LEFT$(',
    'ASC': 'ASC(',
    'VAL': 'VAL(',
    'LEN': 'LEN(',
    'PEEK': 'PEEK(',
    'ATN': 'ATN(',
    'TAN': 'TAN(',
    'SIN': 'SIN(',
    'COS': 'COS(',
    'EXP': 'EXP(',
    'LOG': 'LOG(',
    'RND': 'RND(',
    'SQR': 'SQR(',
    'POS': 'POS(',
    'FRE': 'FRE(',
    'CHR': 'CHR$(',
    'STR': 'STR$(',
    'KEY': 'KEY$(',
    'SPC': 'SPC(',
    'TAB': 'TAB(',
    'LESS': '<',
    'EQUAL': '=',
    'GREATER': '>',
    'POW': '^',
    'DIV': '/',
    'MUL': '*',
    'MINUS': '-',
    'PLUS': '+',
}
def read_tokens():
    global tokens, ramstart2, replacement
    with open("basic65.lbl", "r") as file:
        lines = file.readlines()
        for line in lines:
            line = line.strip().split(' ')
            addr=int("0x"+line[1], 16)
            label=line[2][1:]

            # Found program store memory
            if label=='RAMSTART2':
                ramstart2 = addr

            if label[:6]=='TOKEN_' and addr<256:
                token = label[6:]
                if replacement.get(token):
                    token = replacement[token]
                tokens[addr] = token

def read_byte(ptr):
    global ramstart2, data
    addr_offset = ramstart2 + 1
    try:
        return data[ptr - addr_offset]
    except:
        return 0

def read_word(ptr):
    global ramstart2, data
    addr_offset = ramstart2 + 1
    addr = ptr - addr_offset
    try:
        return data[addr] + (data[addr + 1] * 256)
    except:
        return 0

def detokenize(name):
    global tokens, ramstart2, data
    addr_offset = ramstart2 + 1
    next_line = addr_offset
    pointer = next_line
    result = ""
    with open(name, "rb") as source:
        data=source.read()
        while (True):
            code_line = ""
            next_line=read_word(pointer)
                        
            if next_line == 0:
                return result
            
            pointer = pointer + 2

            # line number
            code_line =str(read_word(pointer))+" "

            pointer = pointer + 2
            while (char := read_byte(pointer)):
                if tokens.get(char):
                    code_line = code_line + tokens[char]
                else:
                    code_line = code_line + chr(char)
                pointer = pointer + 1
            result =  result + code_line + "\r\n"

            pointer = next_line

        
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Detokenize Cerberus Basic program')
    parser.add_argument('prg', help='Cerberus Basic source code')
    args = parser.parse_args()

    src = os.path.realpath(args.prg)
    read_tokens()
    result = detokenize(src)
    print(result)