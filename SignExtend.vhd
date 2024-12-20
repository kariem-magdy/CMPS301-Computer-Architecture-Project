LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY SignExtend IS
	PORT ( 
		input_16_bit : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
      output_32_bit : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END SignExtend;

ARCHITECTURE SignExtend_arch OF SignExtend IS
	BEGIN
		PROCESS(input_16_bit)
		BEGIN
        		IF input_16_bit(15) = '1' THEN
            			output_32_bit <= x"FFFF" & input_16_bit;
        		ELSE
            			output_32_bit <= x"0000" & input_16_bit;
        		END IF;
    		END PROCESS;
END SignExtend_arch;
