vlib work

vcom -93 ../src/extension_de_signe.vhd
vcom -93 tb_extension_de_signe.vhd

vsim -novopt tb_extension_de_signe

view signals
add wave *

run -all
