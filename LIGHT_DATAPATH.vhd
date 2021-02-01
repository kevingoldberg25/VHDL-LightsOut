library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LIGHT_DATAPATH is
Port (
    SW: in STD_LOGIC_VECTOR(1 to 9);
    SW0: in STD_LOGIC;
    EN_TIMER, EN_LSFR: in STD_LOGIC;
    INIT_LIGHTS: in STD_LOGIC;
    TOGGLE_ALL: in STD_LOGIC;
    START_TIMER: in STD_LOGIC; 
    CLK, RST: in STD_LOGIC;
    WIN: out STD_LOGIC;
    END_TIMER: out STD_LOGIC;
    SSEG1, SSEG2, SSEG3: out STD_LOGIC_VECTOR(2 downto 0)
);
end LIGHT_DATAPATH;

architecture dataflow of LIGHT_DATAPATH is
-- COMPONENT --
signal NT1: STD_LOGIC_VECTOR(1 to 9);
signal RT1: STD_LOGIC_VECTOR(1 to 9);
-- SSD/TIMER/WIN --
signal Q: INTEGER; 
signal SEG: STD_LOGIC_VECTOR(1 downto 9);
begin

NBR_COMP: ENTITY work.NEIGHBORS(dataflow)
Port Map(
        SWp => SW,
        SW0 => SW0, 
        NT => NT1
);

LFSR_COMP: ENTITY work.LFSR(dataflow)
Port Map(
        CLK => CLK,
        EN => EN_LSFR,
        INIT => RST,
        RT => RT1
);

STORE_COMP: ENTITY work.STORAGE(dataflow)
Port Map(
        NT => NT1,
        RT => RT1,
        CLK => CLK,
        RST => RST,
        INIT_LIGHTS => INIT_LIGHTS,
        TOGGLE_ALL => TOGGLE_ALL,
        Q => SEG
);

-- CLOCK --
Process(CLK)
begin
if rising_edge(CLK) then
    if START_TIMER = '1' then
        Q <= 0;
    elsif EN_TIMER = '1' then
        Q <= Q + 1; 
    end if; 
end if;
end Process;

-- SDD CONVERTER --
END_TIMER <= '1' when Q = 50000000 else '0';
WIN <= NOT(SEG(1) OR SEG(2) OR SEG(3) OR SEG(4) OR SEG(5) OR SEG(6) OR SEG(7) OR SEG(8) OR SEG(9));

SSEG1 <= SEG(7) & SEG(8) & SEG(9);
SSEG2 <= SEG(4) & SEG(5) & SEG(6);
SSEG3 <= SEG(1) & SEG(2) & SEG(3);

end dataflow; 