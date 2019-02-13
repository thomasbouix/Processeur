vlib work

vcom -93 ../src/gestion_instructions.vhd
vcom -93 tb_gestion_instructions.vhd

vsim -novopt tb_gestion_instructions

view signals 
add wave *
add wave -radix hexadecimal -position insertpoint sim:/tb_gestion_instructions/unite_gestion_instruction/PC/*
add wave -radix hexadecimal -position insertpoint sim:/tb_gestion_instructions/unite_gestion_instruction/multiplexeur/*
add wave -radix hexadecimal -position insertpoint sim:/tb_gestion_instructions/unite_gestion_instruction/extender/*

run 200 ns;