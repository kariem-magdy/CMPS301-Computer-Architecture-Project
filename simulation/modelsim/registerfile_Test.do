vsim work.registerfile

# Add all signals to waveform
add wave -position insertpoint sim:/registerfile/*

# Set up initial conditions
force CLK 0 0ns, 1 5ns -repeat 10ns
force RST 1 0ns
run 20ns
force RST 0 0ns

# Testcase 1: Write to Register 1 and Read from it
force WE1 1
force Rdst1 "001"
force RdstData1 x"1234"
run 20ns

# Read Register 1
force WE1 0
force Rsrc1 "001"
run 20ns

# Testcase 2: Write to Register 3 and Read from it
force WE1 1
force Rdst1 "011"
force RdstData1 x"ABCD"
run 20ns

# Read Register 3
force WE1 0
force Rsrc1 "011"
run 20ns

# Testcase 3: Write to Register 5 and Read from it
force WE1 1
force Rdst1 "101"
force RdstData1 x"FFFF"
run 20ns

# Read Register 5
force WE1 0
force Rsrc1 "101"
run 20ns

# Testcase 4: Reset the Register File
force RST 1
run 20ns
force RST 0
