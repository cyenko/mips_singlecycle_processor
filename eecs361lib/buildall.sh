#!/bin/bash

function generate_binary {
    ./generate_binary.sh $1
    vcom lib/$1_gate.vhd
    vcom lib/$1_gate_n.vhd
    vcom lib/$1_gate_32.vhd
}

vcom lib/dec_n.vhd
vcom lib/dff.vhd
vcom lib/dffr.vhd
vcom lib/dffr_a.vhd
vcom lib/mux_n.vhd
vcom lib/mux_32.vhd
vcom lib/mux.vhd
vcom lib/fulladder_n.vhd
vcom lib/fulladder_32.vhd
vcom lib/cmp_n.vhd
vcom lib/cache_test.vhd

./generate_unary.sh not
vcom lib/not_gate.vhd
vcom lib/not_gate_n.vhd
vcom lib/not_gate_32.vhd

generate_binary and
generate_binary or
generate_binary nand
generate_binary nor
generate_binary xor
generate_binary xnor

./generate_gate_library.sh > lib/eecs361_gates.vhd

vcom lib/sram.vhd
vcom lib/syncram.vhd
vcom lib/csram.vhd

vcom lib/eecs361_gates.vhd
vcom lib/eecs361.vhd
