LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Program_Counter IS
	PORT (
		CLK      : IN  STD_LOGIC;
		RST      : IN  STD_LOGIC;
		INT      : IN  STD_LOGIC;
		IntptVal : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		EXCP     : IN  STD_LOGIC;
		EXCPVal  : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		PAUSE    : IN  STD_LOGIC;
		JUMP     : IN  STD_LOGIC;
		JMPVAL   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		RET      : IN  STD_LOGIC;
		RETVAL   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		BRKPROT  : IN  STD_LOGIC;
		NewValue : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Outdata  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END Program_Counter;

ARCHITECTURE Program_Counter_Arch OF Program_Counter IS

   SIGNAL PC : STD_LOGIC_VECTOR(31 DOWNTO 0);
		
	SIGNAL PROTECTOR : STD_LOGIC; --prtoects the pc from being updated with NewValue/jumpvalue but it will be updated with intval,expval when int/excption occurs

	SIGNAL IS_UPDATED : STD_LOGIC; -- flag for saved_value
	
	SIGNAL SAVED_VALUE : STD_LOGIC_VECTOR(31 DOWNTO 0); -- saves the value that the pc should have but the pc can't have this value due to int.

	BEGIN
		PROCESS (CLK, RST, INT, EXCP, RET, JUMP, BRKPROT)
		BEGIN
			IF (RST = '1') THEN
				PC <= (OTHERS => '0');
				PROTECTOR <= '0';
				IS_UPDATED <= '0';
				SAVED_VALUE <= (OTHERS => '0');
				
			ELSIF (INT = '1') THEN
				PROTECTOR <= '1';
				PC <= IntptVal;
				
			ELSIF (EXCP = '1') THEN
				PROTECTOR <= '1';
				PC <= EXCPVal;
				
			ELSIF (RET = '1') THEN
				IF (IS_UPDATED = '1') THEN
					IS_UPDATED <= '0';
					PC <= SAVED_VALUE;
				ELSE
					PC <= RETVAL;
				END IF;
				
			ELSIF (JUMP = '1') THEN
				IF (PROTECTOR = '0') THEN
					PC <= JMPVAL;
				ELSE
					IS_UPDATED <= '1';
					SAVED_VALUE <= JMPVAL;--awel ma el int y5las hatygy hena
				END IF;
				
			ELSIF (BRKPROT = '1') THEN
				PROTECTOR <= '0';
				
			ELSIF RISING_EDGE(CLK) THEN
				IF (PAUSE = '0' and PROTECTOR='0') THEN
					PC <= NewValue;
				END IF;
			END IF;
		END PROCESS;	
		OutData <= PC;
END architecture Program_Counter_Arch;