vlib work

vcom -93 ../src/mux_PC.vhd
vcom -93 ../src/instruction_memory.vhd
vcom -93 ../src/extension_de_signe.vhd
vcom -93 ../src/PC_register.vhd
vcom -93 ../src/gestion_instructions.vhd
vcom -93 tb_gestion_instructions.vhd

vsim -novopt tb_gestion_instructions

view signals 
add wave -radix decimal -position insertpoint sim:/tb_gestion_instructions/* 
add wave -radix decimal -position insertpoint sim:/tb_gestion_instructions/unite_gestion_instruction/PC/*
add wave -radix decimal -position insertpoint sim:/tb_gestion_instructions/unite_gestion_instruction/multiplexeur/*
add wave -radix decimal -position insertpoint sim:/tb_gestion_instructions/unite_gestion_instruction/extender/*
add wave -radix hexadecimal -position inserpoint sim:/tb_gestion_instructions/unite_gestion_instruction/bus_adresse


run 200 ns;