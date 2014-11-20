#!/bin/bash

./buildall.sh

vcom demo/fulladder.vhd
vcom demo/fulladder_demo.vhd
vcom demo/sram_demo.vhd

vsim -c -do 'add list -hex *;run -all; quit' fulladder_demo
vsim -c -do 'add list -hex *;run -all; quit' sram_demo
