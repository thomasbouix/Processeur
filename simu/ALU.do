vlib work

vcom -93 ../src/ALU.vhd
vcom -93 tb_ALU.vhd

vsim -novopt tb_alu

view signals
add wave *

run -all