library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Generate_column_pulses is
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        clk_presc : in std_logic;
        col : out std_logic_vector(3 downto 0)
    );
end Generate_column_pulses;

architecture arch_generate_column_pulses of Generate_column_pulses is

-- Synchronize signals
signal col_sync : std_logic_vector(3 downto 0);

signal cont : integer range 0 to 3;

begin

GEN_PULSES: process(clk, rst_n, clk_presc)
    begin
        if rst_n = '0' then
            cont <= 0;
            col_sync <= (others=>'1');
        elsif rising_edge(clk) then
            if clk_presc = '1' then
                if cont = 3 then
                    cont <= 0;
                else
                    cont <= cont +1;
                end if;
                
                case cont is
                    when 0 =>
                        col_sync <= "0111";
                    when 1 =>
                        col_sync <= "1011";
                    when 2 =>
                        col_sync <= "1101";
                    when 3 =>
                        col_sync <= "1110";
                    when others=> 
                        col_sync <= (others=>'1');
                end case;
            end if;
        end if;
    end process;
    
    
 SYNCRONIZE : process(clk, rst_n, col_sync)
    begin
        if rst_n = '0' then
            col  <= (others=>'1');
        elsif rising_edge(clk) then
            col <= col_sync;
        end if;
    end process;

end arch_generate_column_pulses;
