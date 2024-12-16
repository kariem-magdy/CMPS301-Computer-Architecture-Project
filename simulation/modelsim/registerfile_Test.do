# Load the design
vsim work.registerfile

# Add signals to the waveform
add wave -format hex sim:/registerfile/CLK
add wave -format hex sim:/registerfile/RST
add wave -format hex sim:/registerfile/Rsrc1
add wave -format hex sim:/registerfile/Rsrc2
add wave -format hex sim:/registerfile/Rsrc1Data
add wave -format hex sim:/registerfile/Rsrc2Data
add wave -format hex sim:/registerfile/WE
add wave -format hex sim:/registerfile/Rdst
add wave -format hex sim:/registerfile/RdstData
add wave -format hex sim:/registerfile/R0
add wave -format hex sim:/registerfile/R1
add wave -format hex sim:/registerfile/R2
add wave -format hex sim:/registerfile/R3
add wave -format hex sim:/registerfile/R4
add wave -format hex sim:/registerfile/R5
add wave -format hex sim:/registerfile/R6
add wave -format hex sim:/registerfile/R7

add wave -position insertpoint sim:/registerfile/*

# Initialize clock
force -freeze sim:/registerfile/CLK 0 0ns, 1 {10ns} -repeat 20ns

# Testcase 1: Reset the register file
force -freeze sim:/registerfile/RST 1
force -freeze sim:/registerfile/WE 0
run 20ns

# Deassert reset
force -freeze sim:/registerfile/RST 0
run 20ns

# Testcase 2: Write to register 0
force -freeze sim:/registerfile/WE 1
force -freeze sim:/registerfile/Rdst "000"
force -freeze sim:/registerfile/RdstData x"AAAA"
run 20ns

# Testcase 3: Write to register 1
force -freeze sim:/registerfile/Rdst "001"
force -freeze sim:/registerfile/RdstData x"BBBB"
run 20ns

# Testcase 4: Write to register 2
force -freeze sim:/registerfile/Rdst "010"
force -freeze sim:/registerfile/RdstData x"CCCC"
run 20ns

# Testcase 5: Read from registers 0 and 1
force -freeze sim:/registerfile/WE 0
force -freeze sim:/registerfile/Rsrc1 "000"
force -freeze sim:/registerfile/Rsrc2 "001"
run 20ns

# Testcase 6: Read from registers 2 and 0
force -freeze sim:/registerfile/Rsrc1 "010"
force -freeze sim:/registerfile/Rsrc2 "000"
run 20ns

# Testcase 7: Write to register 7
force -freeze sim:/registerfile/WE 1
force -freeze sim:/registerfile/Rdst "111"
force -freeze sim:/registerfile/RdstData x"FFFF"
run 20ns

# Testcase 8: Read from registers 7 and 1
force -freeze sim:/registerfile/WE 0
force -freeze sim:/registerfile/Rsrc1 "111"
force -freeze sim:/registerfile/Rsrc2 "001"
run 20ns
