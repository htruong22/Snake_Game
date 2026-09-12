transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {Snake_Top.vo}

vlog -vlog01compat -work work +incdir+E:/CE213/Project_Final {E:/CE213/Project_Final/tb_Keyboard.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L cycloneii_ver -L gate_work -L work -voptargs="+acc"  tb_Keyboard

add wave *
view structure
view signals
run -all
