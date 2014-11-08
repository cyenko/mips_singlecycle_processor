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
traceGen.comment("Fill the caches with writes.")

traceGen.qwrite(blkAddr(3 + 16 * 5))
traceGen.qwrite(blkAddr(5 + 16 * 3))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# Fill L2.
traceGen.comment("Do more writes to fill the caches.")
traceGen.comment("Set associate support in L2 is required.")

traceGen.qwrite(blkAddr(3 + 16 * 5 + 4))
traceGen.qwrite(blkAddr(3 + 16 * 5 + 15))
traceGen.qwrite(blkAddr(5 + 16 * 4 + 1))
traceGen.qwrite(blkAddr(5 + 16 * 3 + 8))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# Check the blocks are written.
traceGen.comment("Check the blocks are written.")
traceGen.comment("They are all L1 hits.")

traceGen.read(blkAddr(3 + 16 * 5))
traceGen.read(blkAddr(5 + 16 * 3))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# Evict dirty blocks.
traceGen.comment("Do more writes that evicts the dirty blocks.")

traceGen.qwrite(blkAddr(3 + 16 * 8))
traceGen.qwrite(blkAddr(5 + 16 * 2))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# Check the blocks are correctly written back to L2.
traceGen.comment("Check the blocks are written back to L2.")

traceGen.read(blkAddr(3 + 16 * 5))
traceGen.read(blkAddr(5 + 16 * 3))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# Evict block in L2.
traceGen.comment("Evict block in L2.")

traceGen.read(blkAddr(7))
traceGen.qwrite(blkAddr(4 + 16 * 8))
traceGen.qwrite(blkAddr(15 + 16 * 8))
traceGen.qwrite(blkAddr(5 + 16 * 7))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# Check the evicted block is written back.
traceGen.comment("Check the evicted block is written back.")

traceGen.read(blkAddr(7 + 16 * 5))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

# Evict L1 block which is not cached by L2.
traceGen.comment("Evict a L1 block which is not cached by L2.")

traceGen.read(blkAddr(6))

traceGen.comment("Counters now:")
l1cache.commentStats(traceGen)
l2cache.commentStats(traceGen)
traceGen.comment()

traceGen.comment(l1cache.debugString())
traceGen.comment(l2cache.debugString())

traceGen.close()
