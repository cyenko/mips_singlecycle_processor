import random

random.seed(0)

def initMem(traceGen):
    base = 0x3e8e8000
    for i in xrange(2048):
        addr = base + i * 4
        traceGen.set(addr, random.randint(0, 2147483647))
