LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY instructionmemory IS
    PORT (
        clk          : IN  STD_LOGIC;
        reset        : IN  STD_LOGIC;
        exception    : IN  STD_LOGIC;
        interrupt    : IN  STD_LOGIC;
        address      : IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
        instruction  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END instructionmemory;

ARCHITECTURE instructionmemory_arch OF instructionmemory IS

    TYPE im IS ARRAY (0 TO 4095) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL instructions : im;

BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            instruction <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF to_integer(unsigned(address)) < 4095 THEN
                instruction <= instructions(to_integer(unsigned(address))) & instructions(to_integer(unsigned(address + 1)));
            ELSE
                instruction <= (OTHERS => '0');
            END IF;
        END IF;
    END PROCESS;
END instructionmemory_arch;