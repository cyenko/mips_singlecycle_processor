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

# Fill L1.
traceGen.comment("Fill the caches.")
traceGen.comment("No set associate support in L2 is required.")

traceGen.read(blkAddr(3 + 16 * 5))
traceGen.read(blkAddr(5 + 16 * 3))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# Fill L2.
traceGen.comment("Do more reads to fill the caches.")
traceGen.comment("Set associate support in L2 is required.")

traceGen.read(blkAddr(3 + 16 * 5 + 4))
traceGen.read(blkAddr(3 + 16 * 5 + 15))
traceGen.read(blkAddr(5 + 16 * 4 + 1))
traceGen.read(blkAddr(5 + 16 * 3 + 8))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# L2 subblocks.
traceGen.comment("Do more reads that missing in L2 because of subblocks.")
traceGen.comment("Address's tag is in cache, however its subblock is not in cache.")

traceGen.read(blkAddr(1 + 16 * 5))
traceGen.read(blkAddr(4 + 16 * 5))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# L1 hits
traceGen.comment("Read previous blocks. L1 hits. No counter changes in L2.")

traceGen.read(blkAddr(3 + 16 * 5))
traceGen.read(blkAddr(5 + 16 * 3))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# L1 replacement
traceGen.comment("Replace blocks in L1. L2 do not do replacement.")

traceGen.read(blkAddr(3 + 16 * 4))
traceGen.read(blkAddr(5 + 16 * 0))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# L1 miss, L2 hit.
traceGen.comment("L1 miss, L2 hit.")

traceGen.read(blkAddr(3 + 16 * 5))
traceGen.read(blkAddr(5 + 16 * 3))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# L2 replacement.
traceGen.comment("L2 replacement.")

traceGen.read(blkAddr(8 * 5 + 5))
traceGen.read(blkAddr(8 * 1 + 7))
traceGen.read(blkAddr(8 * 3 + 4))
traceGen.read(blkAddr(8 * 4 + 4))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# L2 LRU
traceGen.comment("Check L2 LRU.")

traceGen.read(blkAddr(5 + 16 * 4 + 2))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)

traceGen.read(blkAddr(5 + 16 * 3 + 8))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

traceGen.comment(l1cache.debugString())
traceGen.comment(l2cache.debugString())

traceGen.close()
