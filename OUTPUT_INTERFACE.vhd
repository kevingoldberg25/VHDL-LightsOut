library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OUTPUT_INTERFACE is
Port ( 
    SSEG1, SSEG2, SSEG3: in STD_LOGIC_VECTOR(2 downto 0); 
    CLK: in STD_LOGIC;
    AN: out STD_LOGIC_VECTOR(3 downto 0);
    CACG: out STD_LOGIC_VECTOR(6 downto 0)
);
end OUTPUT_INTERFACE;

architecture dataflow of OUTPUT_INTERFACE is
signal SEG: STD_LOGIC_VECTOR(6 downto 0);
begin

Process(CLK, SSEG1, SSEG2, SSEG3)
begin 
if rising_edge(CLK) then
    AN <= "110";
    with SSEG1 select
    SEG <=  "1111111" when "000",
            "1110111" when "001",
            "1111110" when "010",
            "1110110" when "011",
            "0111111" when "100",
            "0110111" when "101",
            "0111110" when "110",
            "0110110" when "111",
            "1111111" when OTHERS;
            
    AN <= "101";
    with SSEG2 select
    SEG <=  "1111111" when "000",
            "1110111" when "001",
            "1111110" when "010",
            "1110110" when "011",
            "0111111" when "100",
            "0110111" when "101",
            "0111110" when "110",
            "0110110" when "111",
            "1111111" when OTHERS;
    
    AN <= "011";
    with SSEG3 select
    SEG <=  "1111111" when "000",
            "1110111" when "001",
            "1111110" when "010",
            "1110110" when "011",
            "0111111" when "100",
            "0110111" when "101",
            "0111110" when "110",
            "0110110" when "111",
            "1111111" when OTHERS; 
end if;
end process;   
end dataflow;
