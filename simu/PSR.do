vlib work

vcom -93 ../src/PSR.vhd
vcom -93 PSR_tb.vhd

vsim -novopt PSR_tb

view signals
add wave *

run -all