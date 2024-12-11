vsim work.SignExtend

add wave -format hex sim:/SignExtend/input_16_bit

# Add waves for all signals in SignExtend
add wave -position insertpoint sim:/SignExtend/*

# Set the initial values of the signals
force -freeze sim:/SignExtend/input_16_bit x"0000" 
run 20ns

# Testcase 1: Positive input (input = 0000, expect output = 00000000)
force -freeze sim:/SignExtend/input_16_bit x"0000"
run 20ns
# Expected output: 00000000

# Testcase 2: Negative input (input = FFFF, expect output = FFFFFFFF)
force -freeze sim:/SignExtend/input_16_bit x"FFFF"
run 20ns
# Expected output: FFFFFFFF

# Testcase 3: Another positive input (input = 1234, expect output = 00001234)
force -freeze sim:/SignExtend/input_16_bit x"1234"
run 20ns
# Expected output: 00001234

# Testcase 4: Another negative input (input = 8000, expect output = FFFFFF80)
force -freeze sim:/SignExtend/input_16_bit x"8000"
run 20ns
# Expected output: FFFFFF80

# Testcase 5: Zero input (input = 0000, expect output = 00000000)
force -freeze sim:/SignExtend/input_16_bit x"0000"
run 20ns
# Expected output: 00000000

# Testcase 6: Another negative input (input = C000, expect output = FFFFFC00)
force -freeze sim:/SignExtend/input_16_bit x"C000"
run 20ns
# Expected output: FFFFFC00

# Testcase 7: Another positive input (input = 7FFF, expect output = 00007FFF)
force -freeze sim:/SignExtend/input_16_bit x"7FFF"
run 20ns
# Expected output: 00007FFF

# Testcase 8: Another negative input (input = 8001, expect output = FFFFF801)
force -freeze sim:/SignExtend/input_16_bit x"8001"
run 20ns
# Expected output: FFFFF801

# Testcase 9: Maximum negative value (input = 8000, expect output = FFFFFF80)
force -freeze sim:/SignExtend/input_16_bit x"8000"
run 20ns
# Expected output: FFFFFF80

# Testcase 10: Maximum positive value (input = 7FFF, expect output = 00007FFF)
force -freeze sim:/SignExtend/input_16_bit x"7FFF"
run 20ns
# Expected output: 00007FFF
