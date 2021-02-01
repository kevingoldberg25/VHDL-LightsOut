library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity debouncer is
    GENERIC (k: integer; DD:integer);
    Port ( Input, CLK, RST : in STD_LOGIC;
           Output          : out STD_LOGIC);
end debouncer;

architecture dataflow of debouncer is
signal d_in: STD_LOGIC;
signal q_in: STD_LOGIC;

signal d_mid: STD_LOGIC;
signal q_mid: STD_LOGIC;

signal d_out: STD_LOGIC;
signal q_out: STD_LOGIC;

signal counter_q: unsigned(k-1 downto 0);

signal XOR_in: STD_LOGIC;
signal AND_mid: STD_LOGIC;
signal set_mid: STD_LOGIC;

signal counter_ld: STD_LOGIC;
signal counter_en: STD_LOGIC;
signal eq: STD_LOGIC;
begin

    d_in <= Input;
    XOR_in <= q_in xor Input;
    
    AND_mid <= XOR_in and not q_mid;
    set_mid <= AND_mid;

    d_mid <= q_mid when eq = '0' else '0';

   counter_en <= q_mid;
   
   eq <= '1' when counter_q = to_unsigned(DD-1, k) else '0'; 
   counter_ld <= eq;
   
    d_out <= Input when q_mid = '0' else q_out;
    output <= q_out;
    
    process (CLK)
    begin
        if rising_edge(CLK) then
            q_in <= d_in;
            q_out <= d_out;

            if RST = '1' then 
                q_mid <= '0';
            elsif set_mid = '1' then
                q_mid <= '1';
            else 
                q_mid <= d_mid;
            end if;
            
            if RST = '1' then 
                counter_q <= (OTHERS => '0');
            elsif counter_ld = '1' then 
                counter_q <= (OTHERS => '0');
            elsif counter_en = '1' then
                counter_q <= counter_q + 1;
            end if;
        end if;
    end process;
   
end dataflow;
