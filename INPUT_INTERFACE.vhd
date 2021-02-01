library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity INPUT_INTERFACE is
Port(
    SW: in STD_LOGIC_VECTOR(1 to 9);
    BTNU, BTNC, BTND: in STD_LOGIC;
    CLK: in STD_LOGIC;
    SWp: out STD_LOGIC_VECTOR(1 to 9);
    RSTp, STARTp, WINp: out STD_LOGIC
);
end INPUT_INTERFACE;

architecture Behavioral of INPUT_INTERFACE is
constant DD: INTEGER := 1000000;
constant K: INTEGER := 20;
constant K_SDD: INTEGER := 17;

signal RED1, RED2, RED3, RED4, RED5, RED6, RED7, RED8, RED9: STD_LOGIC;
signal RED_C, RED_D, RED_U: STD_LOGIC;
begin

-- SWITCHES --
SW1_DB: ENTITY work.debouncer(dataflow)
GENERIC MAP(K => K, DD => DD)
Port Map( 
    Input => SW(1),
    RST => BTNU,
    CLK => CLK,
    Output => RED1
);
SW1_RED: ENTITY work.red(dataflow)
Port Map(
    Input => RED1,
    RST => BTNU,
    CLK => CLK,
    Output => SWp(1)
);
SW2_DB: ENTITY work.debouncer(dataflow)
GENERIC MAP(K => K, DD => DD)
Port Map( 
    Input => SW(2),
    RST => BTNU,
    CLK => CLK,
    Output => RED2
);
SW2_RED: ENTITY work.red(dataflow)
Port Map(
    Input => RED2,
    RST => BTNU,
    CLK => CLK,
    Output => SWp(2)
);
SW3_DB: ENTITY work.debouncer(dataflow)
GENERIC MAP(K => K, DD => DD)
Port Map( 
    Input => SW(3),
    RST => BTNU,
    CLK => CLK,
    Output => RED3
);
SW3_RED: ENTITY work.red(dataflow)
Port Map(
    Input => RED3,
    RST => BTNU,
    CLK => CLK,
    Output => SWp(3)
);
SW4_DB: ENTITY work.debouncer(dataflow)
GENERIC MAP(K => K, DD => DD)
Port Map( 
    Input => SW(4),
    RST => BTNU,
    CLK => CLK,
    Output => RED4
);
SW4_RED: ENTITY work.red(dataflow)
Port Map(
    Input => RED4,
    RST => BTNU,
    CLK => CLK,
    Output => SWp(4)
);
SW5_DB: ENTITY work.debouncer(dataflow)
GENERIC MAP(K => K, DD => DD)
Port Map( 
    Input => SW(5),
    RST => BTNU,
    CLK => CLK,
    Output => RED5
);
SW5_RED: ENTITY work.red(dataflow)
Port Map(
    Input => RED5,
    RST => BTNU,
    CLK => CLK,
    Output => SWp(5)
);
SW6_DB: ENTITY work.debouncer(dataflow)
GENERIC MAP(K => K, DD => DD)
Port Map( 
    Input => SW(6),
    RST => BTNU,
    CLK => CLK,
    Output => RED6
);
SW6_RED: ENTITY work.red(dataflow)
Port Map(
    Input => RED6,
    RST => BTNU,
    CLK => CLK,
    Output => SWp(6)
);
SW7_DB: ENTITY work.debouncer(dataflow)
GENERIC MAP(K => K, DD => DD)
Port Map( 
    Input => SW(7),
    RST => BTNU,
    CLK => CLK,
    Output => RED7
);
SW7_RED: ENTITY work.red(dataflow)
Port Map(
    Input => RED7,
    RST => BTNU,
    CLK => CLK,
    Output => SWp(7)
);
SW8_DB: ENTITY work.debouncer(dataflow)
GENERIC MAP(K => K, DD => DD)
Port Map( 
    Input => SW(8),
    RST => BTNU,
    CLK => CLK,
    Output => RED8
);
SW8_RED: ENTITY work.red(dataflow)
Port Map(
    Input => RED8,
    RST => BTNU,
    CLK => CLK,
    Output => SWp(8)
);
SW9_DB: ENTITY work.debouncer(dataflow)
GENERIC MAP(K => K, DD => DD)
Port Map( 
    Input => SW(9),
    RST => BTNU,
    CLK => CLK,
    Output => RED9
);
SW9_RED: ENTITY work.red(dataflow)
Port Map(
    Input => RED9,
    RST => BTNU,
    CLK => CLK,
    Output => SWp(9)
);

-- BUTTONS --
BTNC_DB: ENTITY work.debouncer(dataflow)
GENERIC MAP (K => K, DD=> DD)
PORT MAP ( 
    Input => BTNC,
    RST => BTNU,
    CLK => CLK,
    Output => RED_C
 );
 BTNC_RED: ENTITY work.red(dataflow)
 PORT MAP ( 
    Input => RED_C,
    RST => BTNU,
    CLK => CLK,
    Output => STARTp
 );
 BTND_DB: ENTITY work.debouncer(dataflow)
 GENERIC MAP (K => K, DD=> DD)
 PORT MAP ( 
    Input => BTND,
    RST => BTNU,
    CLK => CLK,
    Output => RED_D
 );
 BTND_RED: ENTITY work.red(dataflow)
 PORT MAP ( 
    Input => RED_D,
    RST => BTNU,
    CLK => CLK,
    Output => Winp
 );
 BTNU_DB: ENTITY work.debouncer(dataflow)
 GENERIC MAP (K => K, DD=> DD)
 PORT MAP ( 
    Input => BTNU,
    RST => BTNU,
    CLK => CLK,
    Output => RED_U
 );
 BTNU_RED: ENTITY work.red(dataflow)
 PORT MAP ( 
    Input => RED_U,
    RST => BTNU,
    CLK => CLK,
    Output => RSTp
 );
end Behavioral;