library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SSD_DRIVER is
GENERIC(K: INTEGER := 7);
Port(   
    HEX0 : in STD_LOGIC_VECTOR (3 downto 0);
    HEX1 : in STD_LOGIC_VECTOR (3 downto 0);
    HEX2 : in STD_LOGIC_VECTOR (3 downto 0);
    HEX3 : in STD_LOGIC_VECTOR (3 downto 0);
    CLK : in STD_LOGIC;
    Reset : in STD_LOGIC;
    SEG : out STD_LOGIC_VECTOR (6 downto 0);
    AN : out STD_LOGIC_VECTOR(3 downto 0)
    );
end SSD_DRIVER;

architecture Behavioral of SSD_DRIVER is
signal MUX: std_logic_vector(3 downto 0);
signal decode: std_logic_vector(3 downto 0);
signal Q: unsigned(k-1 downto 0);
signal OP: std_logic_vector(1 downto 0);

begin

process(CLK) begin
    if(Reset = '1') then
        Q <= (OTHERS => '0');
    else
        Q <= Q + 1;
    end if;
    OP <= std_logic_vector(Q(K-1 downto K-2));  
end process;
    
with OP select
MUX <=  HEX0 when "00",
        HEX1 when "01",
        HEX2 when "10",
        HEX3 when "11",
        "0000" when others;
           
with OP select
Decode <=   "0001" when "00",
            "0010" when "01",
            "0100" when "10",
            "1000" when "11",
            "0000" when others;       
    
with MUX select
SEG <=  "0000001" when "0000",
        "1001111" when "0001",
        "0010010" when "0010",
        "0000110" when "0011",
        "1001100" when "0100",
        "0100100" when "0101",
        "0100000" when "0110",
        "0001111" when "0111",
        "0000000" when "1000",
        "0000100" when "1001",
        "0001000" when "1010",
        "1100000" when "1011",
        "0110001" when "1100",
        "1000010" when "1101",
        "0110000" when "1110",
        "0111000" when "1111",
        "1111111" when others;
         
AN <= NOT(Decode);

end Behavioral;
