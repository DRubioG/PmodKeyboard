----------------------------------------------------------------------------------
-- Values in one hot
--            Values     : Keys
--      0000000000000001 :  0
--      0000000000000010 :  1
--      0000000000000100 :  2
--      0000000000001000 :  3
--      0000000000010000 :  4
--      0000000000100000 :  5
--      0000000001000000 :  6
--      0000000010000000 :  7
--      0000000100000000 :  8
--      0000001000000000 :  9
--      0000010000000000 :  A
--      0000100000000000 :  B
--      0001000000000000 :  C
--      0010000000000000 :  D
--      0100000000000000 :  E
--      1000000000000000 :  F
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PmodKYPD is
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        col : out std_logic_vector(3 downto 0);
        row : in std_logic_vector(3 downto 0);
        value : out std_logic_vector(15 downto 0)
    );
end PmodKYPD;




architecture arch_PmodKYPD of PmodKYPD is

component Debounce is
Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        row : in std_logic_vector(3 downto 0);
        row_out : out std_logic_vector(3 downto 0)
    );
end component;



component Decode is
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        row : in std_logic_vector(3 downto 0);
        col : in std_logic_vector(3 downto 0);
        value : out std_logic_vector(15 downto 0)
    );
end component;



component Prescaler is
    generic (
        PRE_VALUE : integer := 12500000
    );
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        clk_out : out std_logic
    );
end component;



component Generate_column_pulses is
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        clk_presc : in std_logic;
        col : out std_logic_vector(3 downto 0)
    );
end component;

signal clk_presc : std_logic;
signal col_signal : std_logic_vector(3 downto 0);
signal row_clean : std_logic_vector(3 downto 0);

begin




impl_Debounce : Debounce
Port map ( 
        clk => clk,
        rst_n => rst_n,
        row => row,
        row_out => row_clean
    );


implr_prescaler : Prescaler 
    generic map (
        PRE_VALUE => 12500000
    )
    Port map ( 
        clk => clk,
        rst_n => rst_n,
        clk_out => clk_presc
    );


impl_gen_col_pulses :  Generate_column_pulses
    Port map ( 
        clk => clk,
        rst_n => rst_n,
        clk_presc => clk_presc,
        col => col_signal
    );
col <= col_signal;
    
    
impl_Decode : Decode
    Port map ( 
        clk => clk,
        rst_n => rst_n,
        row => row_clean,
        col => col_signal,
        value => value
    );


end arch_PmodKYPD;