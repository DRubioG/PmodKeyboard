library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity JK_FF is
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        en : in std_logic;
        J, K : in std_logic;
        Q : out std_logic
    );
end JK_FF;


architecture arch_JK_FF of JK_FF is
signal Q_aux : std_logic;
begin

    process(clk, rst_n, en, J, K)
    begin
        if rst_n = '0' then
            Q_aux <= '0';
        elsif rising_edge(clk) then
            if en = '1' then
                if J = '1' and K = '0' then
                    Q_aux <= '1';
                elsif J = '1' and K = '1' then
                    Q_aux <= not Q_aux;
                elsif J = '0' and K = '1' then
                    Q_aux <= '0';
                else 
                    Q_aux <= Q_aux;
                end if;
            elsif en = '0' then
                Q_aux <= '0';
            end if;
        end if;
    end process;
    
    Q <= Q_aux;
    
end arch_JK_FF;
