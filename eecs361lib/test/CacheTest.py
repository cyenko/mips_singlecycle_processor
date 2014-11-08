import sys
sys.path.insert(0, "./lib")
import Cache

l1cache = Cache.Cache("L1 Cache", 16, 64, 1, True, True, 1)
l2cache = Cache.Cache("L2 Cache", 2, 256, 8, False, False, 4)
l1cache.setLowerLevel(l2cache)

l1cache.read4(0)
l1cache.write4(0)

l1cache.dumpStats()
l2cache.dumpStats()
