
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Prescaler is
    generic (
        PRE_VALUE : integer := 12500000
    );
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        clk_out : out std_logic
    );
end Prescaler;

architecture arch_prescaler of Prescaler is

-- Lines for a 125MHz clock
signal clk_cnt : integer range 0 to PRE_VALUE-1;
constant clk_div : integer := PRE_VALUE;
signal clk_new : std_logic;
-- end lines

begin


Prescaler : process (rst_n, clk)
    begin
        if rst_n = '0' then
            clk_cnt <= 0;
            clk_new <= '0';
        elsif rising_edge(clk) then
            if clk_cnt = clk_div-1 then
                clk_cnt <= 0;
                clk_new <= '1';
            else
                clk_cnt <= clk_cnt +1;
                clk_new <= '0';
            end if;
        end if;
    end process;
    
SYNCRONIZE_CLOCK : process(clk, rst_n)
    begin
        if rst_n = '0' then
            clk_out <= '0';
        elsif rising_edge(clk) then
            clk_out <= clk_new;
        end if;
    end process;

end arch_prescaler;
