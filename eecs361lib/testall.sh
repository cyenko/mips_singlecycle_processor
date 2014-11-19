#!/bin/bash

./buildall.sh

vcom test/dec_n_test.vhd
vcom test/dff_test.vhd
vcom test/dffr_test.vhd
vcom test/dffr_a_test.vhd
vcom test/mux_n_test.vhd
vcom test/sram_test.vhd
vcom test/fulladder_n_test.vhd
vcom test/cache_test_test.vhd
vcom test/csram_test.vhd
vcom test/cmp_n_test.vhd

vsim -c -do 'run 1000ns; quit' dec_n_test
vsim -c -do 'run 1000ns; quit' dff_test
vsim -c -do 'run 1000ns; quit' dffr_test
vsim -c -do 'run 1000ns; quit' dffr_a_test
vsim -c -do 'run 1000ns; quit' mux_n_test
vsim -c -do 'run 1000ns; quit' sram_test
vsim -c -do 'run 1000ns; quit' fulladder_n_test
vsim -c -do 'run 1000ns; quit' csram_test
vsim -c -do 'run 1000ns; quit' cmp_n_test

./gen_cache_trace.py

vsim -c -do 'run 200ns; quit' cache_test_test
