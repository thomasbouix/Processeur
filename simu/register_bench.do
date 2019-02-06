vlib work

vcom -93 ../src/register_bench.vhd
vcom -93 tb_register_bench.vhd

vsim -novopt tb_register_bench

view signals
add wave *

run -all