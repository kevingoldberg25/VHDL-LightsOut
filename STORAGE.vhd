library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity STORAGE is
Port ( 
    NT: in STD_LOGIC_VECTOR(1 downto 9);
    RT: in STD_LOGIC_VECTOR(1 downto 9);
    CLK, RST: in STD_LOGIC;
    INIT_LIGHTS: in STD_LOGIC;
    TOGGLE_ALL: in STD_LOGIC;
    Q: out STD_LOGIC_VECTOR(1 downto 9)
);
end STORAGE;

architecture dataflow of STORAGE is
-- ENABLE/FF SIGNALS --
signal EN1, EN2, EN3, EN4, EN5, EN6, EN7, EN8, EN9: STD_LOGIC;
signal ENABLE: STD_LOGIC_VECTOR(1 to 9);
signal Q_temp: STD_LOGIC_VECTOR(1 to 9);

begin
-- GET ALL ENABLES
EN1 <= NT(1) OR (RT(1) AND INIT_LIGHTS) OR TOGGLE_ALL;
EN2 <= NT(2) OR (RT(2) AND INIT_LIGHTS) OR TOGGLE_ALL;
EN3 <= NT(3) OR (RT(3) AND INIT_LIGHTS) OR TOGGLE_ALL;
EN4 <= NT(4) OR (RT(4) AND INIT_LIGHTS) OR TOGGLE_ALL;
EN5 <= NT(5) OR (RT(5) AND INIT_LIGHTS) OR TOGGLE_ALL;
EN6 <= NT(6) OR (RT(6) AND INIT_LIGHTS) OR TOGGLE_ALL;
EN7 <= NT(7) OR (RT(7) AND INIT_LIGHTS) OR TOGGLE_ALL;
EN8 <= NT(8) OR (RT(8) AND INIT_LIGHTS) OR TOGGLE_ALL;
EN9 <= NT(9) OR (RT(9) AND INIT_LIGHTS) OR TOGGLE_ALL;

ENABLE <= EN1 & EN2 & EN3 & EN4 & EN5 & EN6 & EN7 & EN8 & EN9;
 
-- FLOPS --
PROCESS(CLK)
BEGIN
if rising_edge(CLK) then
    if RST = '1' then
        Q <= "000000000";
    else
        for i in 1 to 9 loop
            if ENABLE(i) = '1' then
                Q_temp(i) <= NOT(Q_temp(i));
            end if;
        end loop;
    end if;
end if;
END PROCESS;

Q <= Q_temp;
end dataflow;
