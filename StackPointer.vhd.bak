LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY StackPointer IS
    PORT (
        CLK       : IN  STD_LOGIC;
        RST       : IN  STD_LOGIC;
        SP_INC    : IN  STD_LOGIC;
        SP_DEC    : IN  STD_LOGIC;
        SP_OUTPUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY StackPointer;

ARCHITECTURE StackPointer_arch OF StackPointer IS
    SIGNAL SP      : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL SP_INC_VAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL SP_DEC_VAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
    
BEGIN

    PROCESS (CLK, RST)
    BEGIN
        IF RST = '1' THEN
            SP <= x"FFFE";  
        ELSIF RISING_EDGE(CLK) THEN
            IF SP_INC = '1' THEN
                SP <= SP_INC_VAL;
            ELSIF SP_DEC = '1' THEN
                SP <= SP_DEC_VAL;
            END IF;
        END IF;
    END PROCESS;

    SP_INC_VAL <= std_logic_vector(unsigned(SP) + 2);
    SP_DEC_VAL <= std_logic_vector(unsigned(SP) - 2);

    PROCESS (SP, SP_INC, SP_DEC)
    BEGIN
        IF SP_DEC = '1' THEN
            SP_OUTPUT <= SP;
        ELSIF SP_INC = '1' THEN
            SP_OUTPUT <= SP_INC_VAL;
        ELSE
            SP_OUTPUT <= SP;
        END IF;
    END PROCESS;

END StackPointer_arch;
