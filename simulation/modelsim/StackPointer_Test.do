vsim work.StackPointer

# Add signals to the wave window
add wave -format hex sim:/StackPointer/SP_OUTPUT
add wave -format bin sim:/StackPointer/SP_INC
add wave -format bin sim:/StackPointer/SP_DEC
add wave -format bin sim:/StackPointer/CLK
add wave -format bin sim:/StackPointer/RST

add wave -position insertpoint sim:/StackPointer/*

# Generate clock signal
force -freeze sim:/StackPointer/CLK 0 0ns, 1 10ns -repeat 20ns

# Testcase 1: Reset the StackPointer
force -freeze sim:/StackPointer/RST 1
force -freeze sim:/StackPointer/SP_INC 0
force -freeze sim:/StackPointer/SP_DEC 0
run 20ns
force -freeze sim:/StackPointer/RST 0

# Testcase 2: Increment the StackPointer
force -freeze sim:/StackPointer/SP_INC 1
force -freeze sim:/StackPointer/SP_DEC 0
run 40ns

# Testcase 3: Decrement the StackPointer
force -freeze sim:/StackPointer/SP_INC 0
force -freeze sim:/StackPointer/SP_DEC 1
run 40ns

# Testcase 4: No operation (both SP_INC and SP_DEC are 0)
force -freeze sim:/StackPointer/SP_INC 0
force -freeze sim:/StackPointer/SP_DEC 0
run 40ns

# Testcase 5: Conflict (both SP_INC and SP_DEC are 1)
force -freeze sim:/StackPointer/SP_INC 1
force -freeze sim:/StackPointer/SP_DEC 1
run 40ns

