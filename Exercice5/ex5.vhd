library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sujet5 is
    Port (
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        seg : out STD_LOGIC_VECTOR(6 downto 0);
        an : out STD_LOGIC_VECTOR(3 downto 0)
    );
end sujet5;

architecture Behavioral of sujet5 is
signal counter : integer := 0;
signal div_4hz : integer := 0;
signal div_1hz : integer := 0;
signal digit : STD_LOGIC_VECTOR(3 downto 0);
signal cur_digit : integer := 0;

begin

process(CLK, RST)
begin
    if RST = '1' then
        counter <= 0;
        div_4hz <= 0;
        div_1hz <= 0;
        digit <= "0000";
        cur_digit <= 0;
    elsif rising_edge(CLK) then
        counter <= counter + 1;
        if counter = 1000 then -- 2500000
            counter <= 0;
            div_4hz <= div_4hz + 1;
            if div_4hz = 4 then
                div_4hz <= 0;
                div_1hz <= div_1hz + 1;
                if div_1hz = 10 then
                    div_1hz <= 0;
                    digit <= digit + 1;
                    if digit = "10000" then
                        digit <= "0000";
                    end if;
                end if;
            end if;
            cur_digit <= (cur_digit + 1) mod 4;
        end if;
    end if;
end process;

seg <= "0100100" when cur_digit = 0 else -- 2
       "0010010" when cur_digit = 1 else -- 5
       "0011001" when cur_digit = 2 else -- 4
       "1000000" when cur_digit = 3; -- 0

an <= "1110" when cur_digit = 0 else -- Afficheur à droite
      "1101" when cur_digit = 1 else
      "1011" when cur_digit = 2 else
      "0111"; -- Afficheur à gauche 

end Behavioral;