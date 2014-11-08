import sys
sys.path.insert(0, "./lib")
import TraceGen
import Cache
sys.path.insert(0, "./test")
import TraceCommon
from random import randint

mem_trace = open(sys.argv[1], 'w')
addr_trace = open(sys.argv[2], 'w')
data_trace = open(sys.argv[3], 'w')

traceGen = TraceGen.TraceGen(addr_trace, data_trace)
l1cache = Cache.Cache("L1 Cache", 16, 64, 1, True, True, 1)
l2cache = Cache.Cache("L2 Cache", 2, 256, 8, False, False, 4)
l1cache.setLowerLevel(l2cache)
traceGen.setCache(l1cache)

def blkAddr(index):
    return 0x3e8e8000 + index * 64 + randint(0, 15) * 4

# Setup common memory
# Initialize 8K data starting at 0x3e8e8000
TraceCommon.initMem(traceGen)
traceGen.dumpMemory(mem_trace)

traceGen.comment("Random trace.")

for i in xrange(200):
    isRead = randint(0, 1)
    blkid = randint(0, 16 * 8 - 1)
    if isRead == 1:
        traceGen.read(blkAddr(blkid))
    else:
        traceGen.qwrite(blkAddr(blkid))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

traceGen.comment(l1cache.debugString())
traceGen.comment(l2cache.debugString())

traceGen.close()
