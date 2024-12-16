library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Forwarding_Unit is
    Port (
        
        ForwardRS : in std_logic;  --  Forwarding RS 0=>NO forward ,1=>Forward
        ForwardRT : in std_logic;  --  Forwarding RT 0=>NO forward, 1=>Forward
        
       
        EX_Data : in std_logic_vector(15 downto 0);  -- Data from EX stage 
        MEM_Data : in std_logic_vector(15 downto 0);       -- Data from MEM stage
        
     
		  SelectorRS     : out std_logic;   --1 =>bt5tar el RS mn forwarding unit  /selector l RS mux ben Forward w regfile
		  SelectorRT     : out std_logic;   --1 =>bt5tar el RT mn forwarding unit  /selector l RT mux ben Forward w regfile
        Forwarded_RS : out std_logic_vector(15 downto 0);  -- Forwarded data for Rs
        Forwarded_RS : out std_logic_vector(15 downto 0)   -- Forwarded data for Rt
    );
end Forwarding_Unit;

architecture Behavioral of Forwarding_Unit is
begin
    
    process (ForwardRS, ForwardRT, EX_ALU_Result, MEM_Data)
    begin
        -- Forward Rs 
        if (ForwardRS = "01") then
            -- Forward from EX stage
            Forwarded_Rs <= EX_ALU_Result;
				SelectorRS<='1';
        elsif (ForwardRS = "10") then
            -- Forward from MEM stage
            Forwarded_Rs <= MEM_Data;
				SelectorRS<='1';
        end if;

        -- Forward Rt (
        if (ForwardRT = "01") then
            -- Forward from EX stage
            Forwarded_Rt <= EX_ALU_Result;
				SelectorRT<='1';
        elsif (ForwardRT = "10") then
            -- Forward from MEM stage
            Forwarded_Rt <= MEM_Data;
				SelectorRT<='1';
        end if;
    end process;
end Behavioral;
