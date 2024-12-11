vsim work.ALU

add wave -format hex sim:/ALU/RESULT
add wave -format hex sim:/ALU/FLAGS
add wave -format hex sim:/ALU/OPERATION
add wave -format hex sim:/ALU/OP1
add wave -format hex sim:/ALU/OP2

add wave -position insertpoint sim:/ALU/*

# Testcase 1: NOT operation
force -freeze sim:/ALU/OPERATION "0001"
force -freeze sim:/ALU/OP1 x"AAAAAAAA"
force -freeze sim:/ALU/OP2 x"00000000"
run 20ns

# Testcase 2: NEG operation
force -freeze sim:/ALU/OPERATION "0010"
force -freeze sim:/ALU/OP1 x"00000005"
force -freeze sim:/ALU/OP2 x"00000000"
run 20ns

# Testcase 3: INC operation
force -freeze sim:/ALU/OPERATION "0011"
force -freeze sim:/ALU/OP1 x"00000005"
force -freeze sim:/ALU/OP2 x"00000000"
run 20ns

# Testcase 4: DEC operation
force -freeze sim:/ALU/OPERATION "0100"
force -freeze sim:/ALU/OP1 x"00000005"
force -freeze sim:/ALU/OP2 x"00000000"
run 20ns

# Testcase 5: ADD operation
force -freeze sim:/ALU/OPERATION "0101"
force -freeze sim:/ALU/OP1 x"00000005"
force -freeze sim:/ALU/OP2 x"00000003"
run 20ns

# Testcase 6: SUB operation
force -freeze sim:/ALU/OPERATION "0110"
force -freeze sim:/ALU/OP1 x"00000008"
force -freeze sim:/ALU/OP2 x"00000003"
run 20ns

# Testcase 7: AND operation
force -freeze sim:/ALU/OPERATION "0111"
force -freeze sim:/ALU/OP1 x"AAAAAAAA"
force -freeze sim:/ALU/OP2 x"55555555"
run 20ns

# Testcase 8: OR operation
force -freeze sim:/ALU/OPERATION "1000"
force -freeze sim:/ALU/OP1 x"AAAAAAAA"
force -freeze sim:/ALU/OP2 x"55555555"
run 20ns

# Testcase 9: XOR operation
force -freeze sim:/ALU/OPERATION "1001"
force -freeze sim:/ALU/OP1 x"AAAAAAAA"
force -freeze sim:/ALU/OP2 x"55555555"
run 20ns

# Testcase 10: LDM operation
force -freeze sim:/ALU/OPERATION "1011"
force -freeze sim:/ALU/OP1 x"00000000"
force -freeze sim:/ALU/OP2 x"12345678"
run 20ns

# Testcase 11: JZ operation
force -freeze sim:/ALU/OPERATION "1111"
force -freeze sim:/ALU/OP1 x"00000000"
force -freeze sim:/ALU/OP2 x"00000000"
run 20ns