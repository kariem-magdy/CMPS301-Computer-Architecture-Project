LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Memory_Writeback IS
    PORT (
        CLK               : IN  STD_LOGIC;
        RST               : IN  STD_LOGIC;
--      InData_ConSignal  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
--      OutData_ConSignal : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        InData_MemData    : IN  STD_LOGIC_VECTOR(15 DOWNTO 0); -- ICASE OF LOADED
        OutData_MemData   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        InData_ALUResult  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
        OutData_ALUResult : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        InData_RdstAddr   : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        OutData_RdstAddr  : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END Memory_Writeback;

ARCHITECTURE Memory_Writeback_Arch OF Memory_Writeback IS
--  SIGNAL ConSignal : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL MemData   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ALUResult : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL RdstAddr  : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    PROCESS (CLK, RST)
    BEGIN
        IF (RST = '1') THEN
         -- ConSignal <= (OTHERS => '0');
            MemData   <= (OTHERS => '0');
            ALUResult <= (OTHERS => '0');
            RdstAddr  <= (OTHERS => '0');
        ELSIF FALLING_EDGE(CLK) THEN
         -- ConSignal <= InData_ConSignal;
            MemData   <= InData_MemData;
            ALUResult <= InData_ALUResult;
            RdstAddr  <= InData_RdstAddr;
        END IF;
    END PROCESS;

  --OutData_ConSignal <= ConSignal;
    OutData_MemData   <= MemData;
    OutData_ALUResult <= ALUResult;
    OutData_RdstAddr  <= RdstAddr;
	 
END ARCHITECTURE Memory_Writeback_Arch;
