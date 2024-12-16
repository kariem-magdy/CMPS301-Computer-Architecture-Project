vsim work.instructionmemory

# Add signals to the waveform
add wave -format hex sim:/instructionmemory/instruction
add wave -format hex sim:/instructionmemory/address
add wave -format logic sim:/instructionmemory/clk
add wave -format logic sim:/instructionmemory/reset
add wave -format logic sim:/instructionmemory/exception
add wave -format logic sim:/instructionmemory/interrupt

add wave -position insertpoint sim:/instructionmemory/*

# Initialize testbench
force -freeze sim:/instructionmemory/clk 0 0ns, 1 10ns -repeat 20ns
force -freeze sim:/instructionmemory/reset 1
force -freeze sim:/instructionmemory/exception 0
force -freeze sim:/instructionmemory/interrupt 0

# Testcase 1: Reset behavior
run 40ns
force -freeze sim:/instructionmemory/reset 0
run 20ns

# Testcase 2: Valid address range
force -freeze sim:/instructionmemory/address "000000000001"  
run 20ns
force -freeze sim:/instructionmemory/address "000000111111"   
run 20ns
force -freeze sim:/instructionmemory/address "111111111110" 
run 20ns

# Testcase 3: Out of range address
force -freeze sim:/instructionmemory/address "111111111111"   
run 20ns
force -freeze sim:/instructionmemory/address "111111111110"  
run 20ns

# Testcase 4: Exception and Interrupt
force -freeze sim:/instructionmemory.exception 1
run 20ns
force -freeze sim:/instructionmemory.exception 0
force -freeze sim:/instructionmemory.interrupt 1
run 20ns
force -freeze sim:/instructionmemory.interrupt 0

