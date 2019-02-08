vlib work

vcom -93 ../src/unite_traitement_finale.vhd
vcom -93 tb_unite_traitement_finale.vhd

vsim -novopt tb_unite_traitement_finale

view signals 
add wave -radix decimal *
add wave -radix unsigned -position insertpoint sim:/tb_unite_traitement_finale/unite_traitement/register_bank/Banc

run -all
