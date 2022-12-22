import numpy as np
import math
import matplotlib.pyplot as plt
import sys
import subprocess

def main():
    cmd = "memtier_benchmark --ratio 1:1 -t 4 -c 10 -n 10 --hide-histogram -s 172.44.0.2"
    ret = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    buf = []
    for line in ret.stdout:
        buf.append(line)
    joined = ''.join(buf)
    



if __name__ == "__main__":
    main()