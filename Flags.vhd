LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Flags IS
    PORT (
        CLK     : IN  STD_LOGIC;
        RST     : IN  STD_LOGIC;
        ZNF     : IN  STD_LOGIC;
        OVCF    : IN  STD_LOGIC;
        FlagIn  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        FlagOut : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END Flags;

ARCHITECTURE Flags_arch OF Flags IS
    SIGNAL FLAG : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    PROCESS (CLK, RST)
    BEGIN
        IF (RST = '1') THEN
            FLAG <= (OTHERS => '0');  
        ELSIF rising_edge(CLK) THEN
            IF (OVCF = '1') THEN
                FLAG(3 DOWNTO 2) <= FlagIn(3 DOWNTO 2); 
            END IF;
            IF (ZNF = '1') THEN
                FLAG(1 DOWNTO 0) <= FlagIn(1 DOWNTO 0);  
            END IF;
        END IF;
    END PROCESS;

    FlagOut <= FLAG; 
END Flags_arch;
