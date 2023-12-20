library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity Keyboard is
    port(
        clk : in std_logic;
        rst : in std_logic;
        act_key : out std_logic_vector(3 downto 0);
        read_key : in std_logic_vector(3 downto 0);
        led : out std_logic_vector(3 downto 0)
    );
end entity;

architecture arch_Keyboard of Keyboard is
    signal cnt : unsigned(26 downto 0); --13 downto 0);
    signal cnt_mux : unsigned(2 downto 0);
    signal clk_1MHz : std_logic;
    signal aux : std_logic_vector(3 downto 0);
    type fsm is (S0, S1);
    signal state : fsm;
    signal col : std_logic_vector(3 downto 0);
    signal row : std_logic_vector(3 downto 0);
    signal pre_value : std_logic_vector(7 downto 0);

    COMPONENT vio_0
        PORT (
            clk : IN STD_LOGIC;
            probe_in0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            probe_in1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
begin

    your_instance_name : vio_0
        PORT MAP (
            clk => clk,
            probe_in0 => aux,
            probe_in1 => read_key
        );

    process(clk, rst)

    begin
        if rising_edge(clk) then
            if rst = '0' then
                cnt <= (others=>'0');
                clk_1MHz <= '0';
            else
                cnt <= cnt+1;
                clk_1MHz <= '0';
                if cnt = x"7735940" then             --2710" then
                    clk_1MHz <= '1';
                    cnt <= (others=>'0');
                end if;
            end if;
        end if;

    end process;

    process (clk, rst, clk_1MHz)

    begin
        if rising_edge(clk) then
            if rst='0' then
                cnt_mux<=(others => '0');
                aux <= (others => '0');
            else
                if clk_1MHz = '1' then
                    cnt_mux <= cnt_mux+1;
                    if cnt_mux = "100" then
                        cnt_mux <= "001";
                    end if;
                    case cnt_mux is
                        when "001" =>
                            aux     <= "0001";
                        when "010" =>
                            aux     <= "0010";
                        when "011" =>
                            aux     <= "0100";
                        when "100" =>
                            aux     <= "1000";
                        when others =>
                            null;
                    end case;
                end if;
            end if;
        end if;
    end process;

    act_key <= aux;

    process (clk, rst)

    begin
        if rising_edge(clk) then
            if rst = '0' then
                state <= S0;
            else
                case state is
                    when S0 =>
                        if read_key /= "0000" then
                            state <= S1;
                        end if;
                    when S1 =>
                        if read_key = "0000" then
                            state <= S0;
                        end if;
                end case;
            end if;
        end if;
    end process;


    process (state)

    begin
        case state is
            when S0 =>
                null;
            when S1 =>
                row <= aux;
                col <= read_key;
        end case;
    end process;

--    pre_value <= row & col;

end architecture;