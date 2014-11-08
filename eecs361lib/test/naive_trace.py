import sys
sys.path.insert(0, "./lib")
import TraceGen

mem_trace = open(sys.argv[1], 'w')
addr_trace = open(sys.argv[2], 'w')
data_trace = open(sys.argv[3], 'w')

traceGen = TraceGen.TraceGen(addr_trace, data_trace)

# init memory
traceGen.qset(0x00007878)
traceGen.qset(0x00007888)
traceGen.dumpMemory(mem_trace)

# trace start
traceGen.read(0x00007888)
traceGen.read(0x00007878)
traceGen.qwrite(0x00008080)
traceGen.qwrite(0x00008084)
traceGen.qwrite(0x00008088)
traceGen.qwrite(0x0000808c)
traceGen.read(0x00008080)
traceGen.read(0x00008084)
traceGen.read(0x00008088)
traceGen.read(0x0000808c)
traceGen.close()
