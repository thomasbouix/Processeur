vlib work

vcom -93 ../src/data_memory.vhd
vcom -93 ../src/multiplexeur_2.vhd
vcom -93 ../src/unite_traitement_finale.vhd
vcom -93 tb_unite_traitement_finale.vhd

vsim -novopt tb_unite_traitement_finale

view signals 

add wave -radix unsigned *

add wave -radix unsigned -position insertpoint sim:/tb_unite_traitement_finale/unite_traitement/register_bank/Banc

add wave -radix unsigned -position insertpoint sim:/tb_unite_traitement_finale/unite_traitement/data_memory/Banc(0)

add wave -radix unsigned -position insertpoint sim:/tb_unite_traitement_finale/unite_traitement/data_memory/DataOut

run -all
