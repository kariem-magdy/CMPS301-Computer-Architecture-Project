library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hazard_Detection_Unit is
    Port (
        -- Inputs
        FD_RS  : in std_logic_vector(15 downto 0);  
        FD_RT  : in std_logic_vector(15 downto 0);  
        EX_RD     : in std_logic_vector(15 downto 0);
        MEM_RD    : in std_logic_vector(15 downto 0);
        EX_RegWrite       : in std_logic;                    --if EX write to a register =>1
        MEM_RegWrite      : in std_logic;                    -- if MEM write to a register =>1

        PCWrite           : out std_logic;                   -- STALL PC OPTION
        IFIDWrite         : out std_logic;                   -- STOP FD FROM GETTING INSTRUCTIONS(STALL)
        ForwardRS          : out std_logic_vector(1 downto 0); --00 Default 01 forward from EX 10 forward from MEM                  
        ForwardRT          : out std_logic_vector(1 downto 0)                    
    );
end Hazard_Detection_Unit;

architecture Behavioral of Hazard_Detection_Unit is
begin
    process (FD_RS, FD_RT, EX_RD, MEM_RD, EX_RegWrite, MEM_RegWrite)
    begin
        -- Default: Natural
        PCWrite <= '1';
        IFIDWrite <= '1';
        ForwardRS <= '00';
        ForwardRT <= '00';
        
			--IF STALL NEEDED
        --if (EX_RegWrite = '1' and (FD_RS = EX_RD or FD_RT = EX_RD)) then
            -- Stall
          --  PCWrite <= '0';         
           -- IFIDWrite <= '0';      
        --elsif (MEM_RegWrite = '1' and (FD_RS = MEM_RD or FD_RT = MEM_RD)) then
            -- Stall 
          --  PCWrite <= '0';        
          --  IFIDWrite <= '0';
        -- end if;

        -- Forwarding for RS
        if (EX_RegWrite = '1' and (FD_RS = EX_RD)) then --EX Stage
            ForwardRS <= '01';
        elsif (MEM_RegWrite = '1' and (FD_RS = MEM_RD)) then --MEM Stage
            ForwardRS <= '10';  
        end if;
		  -- Forwarding for RT
        if (EX_RegWrite = '1' and (FD_RT = EX_RD)) then
            ForwardRT <= '01';  --  EX stage 
        elsif (MEM_RegWrite = '1' and (FD_RT = MEM_RD)) then
            ForwardRT <= '10';  -- MEM stage 
        end if;

    end process;
end Behavioral;
