vlib work

vcom -93 ../src/PC_register.vhd
vcom -93 PC_register_tb.vhd

vsim -novopt PC_register_tb

view signals
add wave *

run -all