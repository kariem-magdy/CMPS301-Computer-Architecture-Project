vsim work.ALU

add wave -position insertpoint sim:/ALU/*

radix binary

# Operation: NOT
force -freeze sim:/ALU/OPERATION "0001"
force -freeze sim:/ALU/OP1 x"0000000F"    
force -freeze sim:/ALU/OP2 x"00000000"     
run 100ns

# Operation: NEG
force -freeze sim:/ALU/OPERATION "0010"
force -freeze sim:/ALU/OP1 x"0000000A"      
run 100ns

# Operation: INC
force -freeze sim:/ALU/OPERATION "0011"
force -freeze sim:/ALU/OP1 x"00000001"      
run 100ns

# Operation: DEC
force -freeze sim:/ALU/OPERATION "0100"
force -freeze sim:/ALU/OP1 x"00000005"    
run 100ns

# Operation: ADD
force -freeze sim:/ALU/OPERATION "0101"
force -freeze sim:/ALU/OP1 x"0000000A"     
force -freeze sim:/ALU/OP2 x"00000005"    
run 100ns

# Operation: SUB
force -freeze sim:/ALU/OPERATION "0110"
force -freeze sim:/ALU/OP1 x"0000000F"      
force -freeze sim:/ALU/OP2 x"00000005"      
run 100ns

# Operation: AND
force -freeze sim:/ALU/OPERATION "0111"
force -freeze sim:/ALU/OP1 x"0000000F"      
force -freeze sim:/ALU/OP2 x"00000003"      
run 100ns

# Operation: OR
force -freeze sim:/ALU/OPERATION "1000"
force -freeze sim:/ALU/OP1 x"0000000F"      
force -freeze sim:/ALU/OP2 x"00000003"      
run 100ns

# Operation: XOR
force -freeze sim:/ALU/OPERATION "1001"
force -freeze sim:/ALU/OP1 x"0000000F"      
force -freeze sim:/ALU/OP2 x"00000003"      
run 100ns

# Operation: LDM
force -freeze sim:/ALU/OPERATION "1011"
force -freeze sim:/ALU/OP2 x"0000000F"      
run 100ns

# Operation: JZ
force -freeze sim:/ALU/OPERATION "1111"
force -freeze sim:/ALU/OP1 x"00000000"     
run 100ns
