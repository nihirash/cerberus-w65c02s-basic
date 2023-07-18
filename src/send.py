#!/usr/bin/env python3

import sys
import serial
import time
import os.path

## syntax
## send.py FILENAME <SERIAL PORT> <START ADDRESS>
## 
## SERIAL PORT defaults to /dev/ttyUSB0
## START ADDRESS defaults to 0x0205

if len(sys.argv) == 1:
  sys.exit('Usage: send.py FILENAME <SERIAL_PORT> <START_ADDRESS>')

if not os.path.isfile(sys.argv[1]):
  sys.exit(f'Error: file \'{sys.argv[1]}\' not found')

if len(sys.argv) == 2:
  serialport = '/dev/ttyUSB0'

if len(sys.argv) == 3:
  serialport = sys.argv[2]

if len(sys.argv) == 4:
  startAddress = sys.argv[3]
else:
  startAddress = 0x0205

print(f'Sending {sys.argv[1]}')
print(f'Using port {serialport}')

f = open(sys.argv[1], "rb")

content = f.read()
checkError = False
blockSize = 10

try:
  with serial.Serial(serialport, 115200) as ser: ## 9600,8,N,1
    print('Opening serial port...')
    time.sleep(3)
    print('Writing file to serial port')
    blockIndex = 0
    blockBytesRemaining = len(content)
    while (blockBytesRemaining > 0) and (not checkError):
      print(f'{(blockIndex/len(content))*100:3.0f}% - {blockIndex:6d} of {len(content):6d} - ', end="")
      blockSize = min(blockBytesRemaining, blockSize)
      header = f'0x{(startAddress + blockIndex):04x}'
      print(header, end="")
      for byte in header:
          ser.write(str(byte).encode('ascii'))
      checka = 1
      checkb = 0
      for i in range(blockSize):
        data = content[blockIndex]
        blockIndex = blockIndex + 1
        checka = (checka + data) % 256
        checkb = (checkb + checka) % 256
        block = f' {data:02X}'
        blockBytesRemaining = blockBytesRemaining - 1
        print(block, end="")
        for byte in block:
          ser.write(str(byte).encode('ascii'))
      checksum = f'{((checka << 8) | checkb):0X}'
      ser.write(b'\r')
      ret = ser.readline()
      ret = ret.strip()
      if not ret.endswith(bytes(checksum, 'ascii')):
        print(' -- recv error')
        checkError = True
      else:
        print(' -- recv ok')
    ser.write(b'\r')
    if checkError:
      print("Upload error - mismatched checksum")

    f.close()
    ser.write(b'run\r')
except serial.SerialException:
  print('Error: serial port unavailable, quiting.')
