library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROLLER is
Port ( 
    STARTp, WINp, CLK, RST: in STD_LOGIC;
    WIN, END_TIMER: in STD_LOGIC;
    EN_LFSR, INIT_LIGHTS, START_TIMER, EN_TIMER, TOGGLE_ALL: out STD_LOGIC
);
end CONTROLLER;

architecture dataflow of CONTROLLER is
TYPE STATE is(S_WAIT, S_PLAY, S_WIN);
signal state_reg: STATE;
signal state_next: STATE;
signal winner: STD_LOGIC;
begin

Winner <= WIN OR WINP;

DEFAULT_STATE: Process(CLK)
begin
if rising_edge(CLK) then
    if RST = '1' then
        state_reg <= S_WAIT;
    else
        state_reg <= state_next;
    end if;
end if;
end process;

ASM_STATE: Process(CLK)
begin
if rising_edge(CLK) then
    state_next <= state_reg;
    EN_LFSR <= '0';
    INIT_LIGHTS <= '0';
    START_TIMER <= '0';
    EN_TIMER <= '0';
    TOGGLE_ALL <= '0';
    START_TIMER <= '0';
    CASE state_reg IS
        WHEN S_WAIT =>
            EN_LFSR <= '1'; 
            if STARTp = '0' then
                state_next <= S_WAIT;
            else
                INIT_LIGHTS <= '1';
                state_next <= S_PLAY;
            end if;
        WHEN S_PLAY =>
            if Winner = '0' then
                state_next <= S_PLAY;
            else
                START_TIMER <= '1'; 
                state_next <= S_WIN;
            end if;
        WHEN S_WIN =>
            EN_TIMER <= '1';
            if END_TIMER = '0' then
                state_next <= S_WIN;
            else 
                TOGGLE_ALL <= '1';
                START_TIMER <= '1';
                state_next <= S_WIN;
            end if;
    END CASE;
end if;
end process;
end dataflow;
