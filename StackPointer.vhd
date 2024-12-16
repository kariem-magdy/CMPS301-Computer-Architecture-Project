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
    SIGNAL SP : UNSIGNED(15 DOWNTO 0) := x"0FFF";
BEGIN

    PROCESS (CLK, RST)
    BEGIN
        IF RST = '1' THEN
            SP <= x"0FFF";
        ELSIF rising_edge(CLK) THEN
            IF SP_INC = '1' AND SP_DEC = '0' THEN
                SP <= SP + 2;
            ELSIF SP_DEC = '1' AND SP_INC = '0' THEN
                SP <= SP - 2;
            END IF;
        END IF;
    END PROCESS;

    SP_OUTPUT <= STD_LOGIC_VECTOR(SP);

END StackPointer_arch;
