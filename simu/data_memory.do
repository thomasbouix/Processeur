vlib work

vcom -93 ../src/data_memory.vhd
vcom -93 tb_data_memory.vhd

vsim -novopt tb_data_memory

view signals
add wave -radix signed *
add wave -radix signed sim:/tb_data_memory/data_memory_0/Banc

run -all
