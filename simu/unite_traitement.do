vlib work

vcom -93 ../src/unite_traitement.vhd
vcom -93 unite_traitement_tb.vhd

vsim -novopt unite_traitement_tb

view signals
add wave  -radix unsigned *
add wave  -radix unsigned sim:/unite_traitement_tb/traitement_unity/banc_registre/Banc


run 200 ns
