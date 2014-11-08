#!/bin/bash

python ./test/readonly_trace.py ./data/mem_init ./data/readonly_addr_trace ./data/readonly_data_trace
python ./test/write_trace.py ./data/mem_init ./data/write_addr_trace ./data/write_data_trace
python ./test/random_trace.py ./data/mem_init ./data/random_addr_trace ./data/random_data_trace
