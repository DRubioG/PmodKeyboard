library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debounce is
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        en : in std_logic;
        row : in std_logic_vector(3 downto 0);
        row_out : out std_logic_vector(3 downto 0)
    );
end Debounce;




architecture arch_debounce of Debounce is

component JK_FF 
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        en : in std_logic;
        J, K : in std_logic;
        Q : out std_logic
    );
end component;


-- debounce
signal row1, row2, row3, row4 : std_logic_vector(3 downto 0);
signal row_and, row_nand : std_logic_vector(3 downto 0);
-- end debounce

begin

debounce : process(clk, rst_n, en, row)
    begin
        if rst_n = '0' then
            row1 <= (others=>'0');
            row2 <= (others=>'0');
            row3 <= (others=>'0');
            row4 <= (others=>'0');
        elsif rising_edge(clk) then
            if en = '1' then
                row1 <= row;
                row2 <= row1;
                row3 <= row2;
                row4 <= row3;
            elsif en = '0' then
                row1 <= (others=>'0');
                row2 <= (others=>'0');
                row3 <= (others=>'0');
                row4 <= (others=>'0');
            end if;
        end if;
    end process; 
    
    row_and <= row1 and row2 and row3 and row4;
    row_nand <= not row1 and not row2 and not row3 and not row4;
     
    JK_Flip_flops: for i in 0 to 3 generate
        impl_JK_FF : JK_FF
        Port map( 
            clk => clk,
            rst_n => rst_n,
            en => en,
            J => row_and(i),
            K => row_nand(i),
            Q => row_out(i)
        );
    end generate;

end arch_debounce;
