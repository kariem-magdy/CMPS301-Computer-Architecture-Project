LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY registerfile IS
    PORT (
        CLK       : IN  STD_LOGIC;
        RST       : IN  STD_LOGIC;
        Rsrc1     : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rsrc2     : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rsrc1Data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        Rsrc2Data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        WE        : IN  STD_LOGIC;
        Rdst      : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        RdstData  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
        R0        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        R1        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        R2        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        R3        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        R4        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        R5        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        R6        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        R7        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END registerfile;

ARCHITECTURE registerfile_arch OF registerfile IS

    TYPE register_type IS ARRAY(0 TO 7) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL registerfile : register_type := (OTHERS => (OTHERS => '0'));

BEGIN

    PROCESS (CLK, RST)
    BEGIN
        IF RST = '1' THEN
            registerfile <= (OTHERS => (OTHERS => '0'));
        ELSIF rising_edge(CLK) THEN
            IF WE = '1' THEN
                IF to_integer(unsigned(Rdst)) < 8 THEN  
                    registerfile(to_integer(unsigned(Rdst))) <= RdstData;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    Rsrc1Data <= registerfile(to_integer(unsigned(Rsrc1)));
    Rsrc2Data <= registerfile(to_integer(unsigned(Rsrc2)));

    R0 <= registerfile(0);
    R1 <= registerfile(1);
    R2 <= registerfile(2);
    R3 <= registerfile(3);
    R4 <= registerfile(4);
    R5 <= registerfile(5);
    R6 <= registerfile(6);
    R7 <= registerfile(7);

END registerfile_arch;
