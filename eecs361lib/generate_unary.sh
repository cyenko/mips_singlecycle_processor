#!/bin/bash

gate=$1

cp unary_operator_gate_template.vhd lib/${gate}_gate.vhd
cp unary_operator_gate_template_n.vhd lib/${gate}_gate_n.vhd
cp unary_operator_gate_template_32.vhd lib/${gate}_gate_32.vhd

sed -i "s/%GATE%/${gate}/g" lib/${gate}_gate.vhd
sed -i "s/%GATE%/${gate}/g" lib/${gate}_gate_n.vhd
sed -i "s/%GATE%/${gate}/g" lib/${gate}_gate_32.vhd
