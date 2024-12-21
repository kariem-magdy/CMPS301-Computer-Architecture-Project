LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Data_Memory IS
    PORT (
        CLK        : IN  STD_LOGIC;
        RST        : IN  STD_LOGIC;
        Addr_data  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);  
        Addr_instr : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);  

        MemRead    : IN  STD_LOGIC;
        ReadData   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        MemWrite   : IN  STD_LOGIC;
        WriteData  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);

        InstrRead  : IN  STD_LOGIC;
        InstrData  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);

        free_i     : IN  STD_LOGIC;
        prot_i     : IN  STD_LOGIC;

        EXCEP      : OUT STD_LOGIC
    );
END Data_Memory;

ARCHITECTURE Data_Memory_Arch OF Data_Memory IS


    TYPE dm_type IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR(16 DOWNTO 0);
    TYPE im_type IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL datamemory : dm_type;
    SIGNAL instrmemory : im_type; 

BEGIN
    PROCESS (CLK, RST)
    BEGIN
        IF (RST = '1') THEN
            datamemory <= ((OTHERS => (OTHERS => '0'))); 
            instrmemory <= ((OTHERS => (OTHERS => '0'))); 
            ReadData <= (OTHERS => '0');               
            InstrData <= (OTHERS => '0');              
            EXCEP <= '0';                            

        ELSIF RISING_EDGE(CLK) THEN

            IF (free_i = '1') THEN
                EXCEP <= '0';
                datamemory(to_integer(unsigned(Addr_data))) <= (OTHERS => '0');
					 
            ELSIF (prot_i = '1') THEN
                EXCEP <= '0';
                datamemory(to_integer(unsigned(Addr_data)))(16) <= '1';
            END IF;

            IF (MemRead = '1') THEN
                EXCEP <= '0';
                ReadData <= datamemory(to_integer(unsigned(Addr_data)))(15 DOWNTO 0);
            END IF;

            IF (MemWrite = '1') THEN
                IF (datamemory(to_integer(unsigned(Addr_data)))(16) = '0') THEN
                    EXCEP <= '0';
                    datamemory(to_integer(unsigned(Addr_data)))(15 DOWNTO 0) <= WriteData;
                ELSE
                    EXCEP <= '1';
                END IF;
            END IF;


            IF (InstrRead = '1') THEN
                InstrData <= instrmemory(to_integer(unsigned(Addr_instr)));
            END IF;
        END IF;
    END PROCESS;
END Data_Memory_Arch;
