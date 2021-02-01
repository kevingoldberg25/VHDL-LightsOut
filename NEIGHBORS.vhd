library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NEIGHBORS is
Port ( 
    SWp: in STD_LOGIC_VECTOR(1 downto 9);
    SW0: in STD_LOGIC;
    NT: out STD_LOGIC_VECTOR(1 downto 9)
);
end NEIGHBORS;

architecture dataflow of NEIGHBORS is
-- GATES --
signal AND1: STD_LOGIC_VECTOR(8 downto 0);
signal temp: STD_LOGIC_VECTOR(8 downto 0);
-- ENCODER --
signal ENC: STD_LOGIC_VECTOR(3 downto 0);
signal Z: STD_LOGIC;
-- ROM --
signal ROM1, ROM2, ROM3, ROM4: STD_LOGIC_VECTOR(3 downto 0);
type vector_array is array (0 to 9) of std_logic_vector(3 downto 0);
constant up: vector_array := ("0000", "0000", "0001", "0010", "0000", "0100", "0101", "0000", "0111", "1000");
constant dwn: vector_array := ("0000", "0010", "0011", "0000", "0101", "0110", "0000", "1000", "1001", "0000");
constant lft: vector_array := ("0000", "0000", "0000", "0000", "0001", "0010", "0011", "0100", "0101", "0110");
constant rght: vector_array:= ("0000", "0100", "0101", "0110", "0111", "1000", "1001", "0000", "0000", "0000");
-- DECODER --
signal DIN1, DIN2, DIN3, DIN4: STD_LOGIC_VECTOR(4 downto 0);
signal DEC1, DEC2, DEC3, DEC4: STD_LOGIC_VECTOR(8 downto 0);
-- OUTPUTS--
signal NT_temp: STD_LOGIC_VECTOR(8 downto 0);

begin
-- AND GATES --
temp <= (OTHERS => SW0);
AND1 <= temp AND SWp;

-- 9 to 4 DECODER --
ENC <= "0001" when SWp = "100000000" else
    "0010" when SWp = "010000000" else
    "0011" when SWp = "001000000" else
    "0100" when SWp = "000100000" else
    "0101" when SWp = "000010000" else
    "0110" when SWp = "000001000" else
    "0111" when SWp = "000000100" else
    "1000" when SWp = "000000010" else
    "1001" when SWp = "000000001" else
    "0000";
Z <= '0' when SWp = "00000000" else '1';

-- ROM --
ROM1 <= up(to_integer(unsigned(ENC)));
ROM2 <= dwn(to_integer(unsigned(ENC)));
ROM3 <= lft(to_integer(unsigned(ENC)));
ROM4 <= rght(to_integer(unsigned(ENC)));

DIN1 <= Z & ROM1;
DIN2 <= Z & ROM2;
DIN3 <= Z & ROM3;
DIN4 <= Z & ROM4;

-- DECODER -- 
DEC1 <= "100000000" when DIN1 = "10001" else
        "010000000" when DIN1 = "10010" else
        "001000000" when DIN1 = "10011" else
        "000100000" when DIN1 = "10100" else
        "000010000" when DIN1 = "10101" else
        "000001000" when DIN1 = "10110" else
        "000000100" when DIN1 = "10111" else
        "000000010" when DIN1 = "11000" else
        "000000001" when DIN1 = "11001" else
        "000000000";
DEC2 <= "100000000" when DIN2 = "10001" else
        "010000000" when DIN2 = "10010" else
        "001000000" when DIN2 = "10011" else
        "000100000" when DIN2 = "10100" else
        "000010000" when DIN2 = "10101" else
        "000001000" when DIN2 = "10110" else
        "000000100" when DIN2 = "10111" else
        "000000010" when DIN2 = "11000" else
        "000000001" when DIN2 = "11001" else
        "000000000";
DEC3 <= "100000000" when DIN3 = "10001" else
        "010000000" when DIN3 = "10010" else
        "001000000" when DIN3 = "10011" else
        "000100000" when DIN3 = "10100" else
        "000010000" when DIN3 = "10101" else
        "000001000" when DIN3 = "10110" else
        "000000100" when DIN3 = "10111" else
        "000000010" when DIN3 = "11000" else
        "000000001" when DIN3 = "11001" else
        "000000000";
DEC4 <= "100000000" when DIN4 = "10001" else
        "010000000" when DIN4 = "10010" else
        "001000000" when DIN4 = "10011" else
        "000100000" when DIN4 = "10100" else
        "000010000" when DIN4 = "10101" else
        "000001000" when DIN4 = "10110" else
        "000000100" when DIN4 = "10111" else
        "000000010" when DIN4 = "11000" else
        "000000001" when DIN4 = "11001" else
        "000000000";

-- OUTPUT --
NT_temp <= AND1 OR DEC1 OR DEC2 OR DEC3 OR DEC4;

NT <= NT_temp;
end dataflow;
