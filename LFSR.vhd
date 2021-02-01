library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LFSR is
Port (
    CLK, INIT, EN: in STD_LOGIC;
    RT: out StD_LOGIC_VECTOR(1 to 9)
);
end LFSR;

architecture dataflow of LFSR is
signal AND1: STD_LOGIC;
signal Q: STD_LOGIC_VECTOR(1 to 9);
begin

AND1 <= Q(4) XOR Q(9);

Process(CLK)
begin
if rising_edge(CLK) then
    if INIT = '1' AND EN = '0' then
        Q <= "010101010";
    else
        Q(1) <= AND1;
        Q(2) <= Q(1);
        Q(3) <= Q(2);
        Q(4) <= Q(3);
        Q(5) <= Q(4);
        Q(6) <= Q(5);
        Q(7) <= Q(6);
        Q(8) <= Q(7);
        Q(9) <= Q(8);
    end if;
end if;
end Process;

RT <= Q;
end dataflow;