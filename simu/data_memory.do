vlib work

vcom -93 ../src/data_memory.vhd
vcom -93 tb_data_memory.vhd

vsim -novopt tb_data_memory

view signals
add wave *

run -all