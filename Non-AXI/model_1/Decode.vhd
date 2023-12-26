library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Decode is
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        row : in std_logic_vector(3 downto 0);
        col : in std_logic_vector(3 downto 0);
        value : out std_logic_vector(15 downto 0)
    );
end Decode;

architecture arch_decode of Decode is

signal value_sync : std_logic_vector(15 downto 0);

begin


READ_ROW : process(clk, rst_n, row)
    begin
        if rst_n = '0' then
            value_sync <= (others=>'0');
        elsif rising_edge(clk) then
            if row = "0111" then
                case col is
                    when "0111" =>
                        value_sync <= (1 => '1', others=> '0'); -- 1
                    when "1011" =>
                        value_sync <= (4 => '1', others=> '0'); -- 4
                    when "1101" =>
                        value_sync <= (7 => '1', others=> '0'); -- 7
                    when "1110" =>
                        value_sync <= (0 => '1', others=> '0'); -- 0
                    when others => 
                        value_sync <= (others=>'0');
                end case;
            elsif row = "1011" then
                case col is
                    when "0111" =>
                        value_sync <= (2 => '1', others=> '0'); -- 2
                    when "1011" =>
                        value_sync <= (5 => '1', others=> '0'); -- 5
                    when "1101" =>
                        value_sync <= (8 => '1', others=> '0'); -- 8
                    when "1110" =>
                        value_sync <= (15 => '1', others=> '0');-- F
                    when others => 
                        value_sync <= (others=>'0');
                end case;
            elsif row = "1101" then
                case col is
                    when "0111" =>
                        value_sync <= (3 => '1', others=> '0'); -- 3
                    when "1011" =>
                        value_sync <= (6 => '1', others=> '0'); -- 6
                    when "1101" =>
                        value_sync <= (9 => '1', others=> '0'); -- 9
                    when "1110" =>
                        value_sync <= (14 => '1', others=> '0');-- E
                    when others => 
                        value_sync <= (others=>'0');
                end case;
            elsif row = "1110" then
                case col is
                    when "0111" =>
                        value_sync <= (10 => '1', others=> '0');-- A
                    when "1011" =>
                        value_sync <= (11 => '1', others=> '0');-- B
                    when "1101" =>
                        value_sync <= (12 => '1', others=> '0');-- C
                    when "1110" =>
                        value_sync <= (13 => '1', others=> '0');-- D
                    when others => 
                        value_sync <= (others=>'0');
                end case;
            else 
               value_sync <= (others=>'0');
            end if;
        end if;
    end process;
    
    
SYNCRONIZE : process(clk, rst_n, value_sync)
    begin
        if rst_n = '0' then
            value <= (others=>'0');
        elsif rising_edge(clk) then
            value <= value_sync;
        end if;
    end process;

end arch_decode;
