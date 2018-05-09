###################################################################

# Created by write_sdc on Tue May  8 22:17:23 2018

###################################################################
set sdc_version 1.7

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_max_fanout 4 [current_design]
set_max_area 0
set_driving_cell -lib_cell INVX1TS [get_ports Clk]
set_driving_cell -lib_cell INVX1TS [get_ports Reset_n]
set_load -pin_load 0.005 [get_ports done]
set_max_capacitance 0.005 [get_ports Clk]
set_max_capacitance 0.005 [get_ports Reset_n]
set_max_fanout 4 [get_ports Clk]
set_max_fanout 4 [get_ports Reset_n]
