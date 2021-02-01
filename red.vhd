library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity red is
    Port (Input, CLK, RST   : in STD_LOGIC;
          Output            : out STD_LOGIC );
end red;

architecture dataflow of red is
    signal d,q: STD_LOGIC;
    
begin

d<= Input;

process (CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                q <= '0';
            else
                q <= d;
            
            end if;
        end if;
end process;

Output <= not q and input;

end dataflow;
