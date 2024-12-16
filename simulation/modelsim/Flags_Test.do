vsim work.Flags

# Add waveforms for signals
add wave -format hex sim:/Flags/FlagOut
add wave -format hex sim:/Flags/FLAG
add wave -format hex sim:/Flags/ZNF
add wave -format hex sim:/Flags/OVCF
add wave -format hex sim:/Flags/FlagIn
add wave -format hex sim:/Flags/CLK
add wave -format hex sim:/Flags/RST

add wave -position insertpoint sim:/Flags/*

# Generate clock: Toggle CLK every 10 ns (20 ns period)
force -freeze sim:/Flags/CLK 0 0ns, 1 10ns -repeat 20ns

# Testcase 1: Reset the Flags
force -freeze sim:/Flags/RST '1'
force -freeze sim:/Flags/ZNF '0'
force -freeze sim:/Flags/OVCF '0'
force -freeze sim:/Flags/FlagIn "0000"
run 20ns

# Release reset
force -freeze sim:/Flags/RST '0'
run 20ns

# Testcase 2: Update upper 2 bits (OVCF = '1')
force -freeze sim:/Flags/OVCF '1'
force -freeze sim:/Flags/ZNF '0'
force -freeze sim:/Flags/FlagIn "1010"
run 20ns

# Testcase 3: Update lower 2 bits (ZNF = '1')
force -freeze sim:/Flags/OVCF '0'
force -freeze sim:/Flags/ZNF '1'
force -freeze sim:/Flags/FlagIn "1100"
run 20ns

# Testcase 4: Update both upper and lower bits (OVCF = '1', ZNF = '1')
force -freeze sim:/Flags/OVCF '1'
force -freeze sim:/Flags/ZNF '1'
force -freeze sim:/Flags/FlagIn "1111"
run 20ns

# Testcase 5: No updates, FlagIn = "0000"
force -freeze sim:/Flags/OVCF '0'
force -freeze sim:/Flags/ZNF '0'
force -freeze sim:/Flags/FlagIn "0000"
run 20ns

# Testcase 6: Check reset behavior again
force -freeze sim:/Flags/RST '1'
force -freeze sim:/Flags/ZNF '1'
force -freeze sim:/Flags/OVCF '1'
force -freeze sim:/Flags/FlagIn "1111"
run 20ns
