vsim work.StackPointer

# Add waves for stack pointer signals
add wave -format hex sim:/StackPointer/SP
add wave -format hex sim:/StackPointer/SP_INC_VAL
add wave -format hex sim:/StackPointer/SP_DEC_VAL
add wave -format hex sim:/StackPointer/SP_OUTPUT
add wave sim:/StackPointer/CLK

# Add waves for all signals in StackPointer
add wave -position insertpoint sim:/StackPointer/*

# Set the initial values of the signals
force -freeze sim:/StackPointer/SP_INC '0'
force -freeze sim:/StackPointer/SP_DEC '0'
force -freeze sim:/StackPointer/SP x"FFFE"
force -freeze sim:/StackPointer/CLK '0'  
run 20ns

# Testcase 1: Increment stack pointer (SP = FFFE)
# Apply SP_INC and run for a clock cycle
force -freeze sim:/StackPointer/SP_INC '1'
force -freeze sim:/StackPointer/SP_DEC '0'
run 10ns
# Clock cycle (SP should increment after the clock)
force -freeze sim:/StackPointer/CLK '1'
run 10ns
force -freeze sim:/StackPointer/CLK '0'
run 10ns
# Expected output: 0000

# Testcase 2: Decrement stack pointer (SP = FFFE)
force -freeze sim:/StackPointer/SP_INC '0'
force -freeze sim:/StackPointer/SP_DEC '1'
run 10ns
# Clock cycle (SP should decrement after the clock)
force -freeze sim:/StackPointer/CLK '1'
run 10ns
force -freeze sim:/StackPointer/CLK '0'
run 10ns
# Expected output: FFFC

# Testcase 3: Increment stack pointer (SP = 0000)
force -freeze sim:/StackPointer/SP_INC '1'
force -freeze sim:/StackPointer/SP_DEC '0'
force -freeze sim:/StackPointer/SP x"0000"
run 10ns
# Clock cycle (SP should increment after the clock)
force -freeze sim:/StackPointer/CLK '1'
run 10ns
force -freeze sim:/StackPointer/CLK '0'
run 10ns
# Expected output: 0002

# Testcase 4: Decrement stack pointer (SP = 0002)
force -freeze sim:/StackPointer/SP_INC '0'
force -freeze sim:/StackPointer/SP_DEC '1'
force -freeze sim:/StackPointer/SP x"0002"
run 10ns
# Clock cycle (SP should decrement after the clock)
force -freeze sim:/StackPointer/CLK '1'
run 10ns
force -freeze sim:/StackPointer/CLK '0'
run 10ns
# Expected output: 0000

# Testcase 5: Increment stack pointer (SP = FFFC)
force -freeze sim:/StackPointer/SP_INC '1'
force -freeze sim:/StackPointer/SP_DEC '0'
force -freeze sim:/StackPointer/SP x"FFFC"
run 10ns
# Clock cycle (SP should increment after the clock)
force -freeze sim:/StackPointer/CLK '1'
run 10ns
force -freeze sim:/StackPointer/CLK '0'
run 10ns
# Expected output: 0000

# Testcase 6: Decrement stack pointer (SP = 0002)
force -freeze sim:/StackPointer/SP_INC '0'
force -freeze sim:/StackPointer/SP_DEC '1'
force -freeze sim:/StackPointer/SP x"0002"
run 10ns
# Clock cycle (SP should decrement after the clock)
force -freeze sim:/StackPointer/CLK '1'
run 10ns
force -freeze sim:/StackPointer/CLK '0'
run 10ns
# Expected output: 0000

# Testcase 7: Zero input, expect no change in stack pointer (SP = 0000)
force -freeze sim:/StackPointer/SP_INC '0'
force -freeze sim:/StackPointer/SP_DEC '0'
run 10ns
# Clock cycle (SP should remain unchanged after the clock)
force -freeze sim:/StackPointer/CLK '1'
run 10ns
force -freeze sim:/StackPointer/CLK '0'
run 10ns
# Expected output: 0000

# Testcase 8: Another increment (SP = 0002)
force -freeze sim:/StackPointer/SP_INC '1'
force -freeze sim:/StackPointer/SP_DEC '0'
force -freeze sim:/StackPointer/SP x"0002"
run 10ns
# Clock cycle (SP should increment after the clock)
force -freeze sim:/StackPointer/CLK '1'
run 10ns
force -freeze sim:/StackPointer/CLK '0'
run 10ns
# Expected output: 0004

# Testcase 9: Another decrement (SP = 0004)
force -freeze sim:/StackPointer/SP_INC '0'
force -freeze sim:/StackPointer/SP_DEC '1'
force -freeze sim:/StackPointer/SP x"0004"
run 10ns
# Clock cycle (SP should decrement after the clock)
force -freeze sim:/StackPointer/CLK '1'
run 10ns
force -freeze sim:/StackPointer/CLK '0'
run 10ns
# Expected output: 0002

# Testcase 10: Maximum decrement (SP = 0000)
force -freeze sim:/StackPointer/SP_INC '0'
force -freeze sim:/StackPointer/SP_DEC '1'
force -freeze sim:/StackPointer/SP x"0000"
run 10ns
# Clock cycle (SP should wrap around to FFFE after the clock)
force -freeze sim:/StackPointer/CLK '1'
run 10ns
force -freeze sim:/StackPointer/CLK '0'
run 10ns
# Expected output: FFFE
