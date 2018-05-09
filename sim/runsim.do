##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog -incr ../rfft.v 
vlog -incr const_tb.v 
vlog -incr test_ald.v 

# Run Simulator 
vsim -t ns -lib work testbench 
do waveformat.do   
run -all
