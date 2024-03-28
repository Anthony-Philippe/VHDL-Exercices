library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity led is
port (CLK,RST : in std_logic;
		LED: out std_logic_vector(15 downto 0));
end led;
architecture rtl of led is
signal cnt : std_logic_vector(23 downto 0);
signal cnt_out : std_logic_vector(3 downto 0);
begin
	
process (CLK,RST)
begin
	if (RST = '1') then
		cnt <= (others => '0');
	elsif (CLK'event and CLK = '1') then
		cnt <= cnt +1;
	end if;
end process;


process(cnt(23), rst)
begin
	if (RST = '1') then
		cnt_out <= (others => '0');
	elsif (cnt(23)'event and cnt(23) = '1') then
		cnt_out <= cnt_out +1;
		
	end if;
end process;

process (cnt_out)
begin
	case cnt_out is
		when "0000" => LED <= "0000000000000001";
		when "0001" => LED <= "0000000000000011"; 
		when "0010" => LED <= "0000000000000111"; 
		when "0011" => LED <= "0000000000001111"; 
		when "0100" => LED <= "0000000000011111";
		when "0101" => LED <= "0000000000111111";
		when "0110" => LED <= "0000000001111111";
		when "0111" => LED <= "0000000011111111";
		when "1000" => LED <= "0000000111111111";
		when "1001" => LED <= "0000001111111111";
		when "1010" => LED <= "0000011111111111";
		when "1011" => LED <= "0000111111111111";
		when "1100" => LED <= "0001111111111111";
		when "1101" => LED <= "0011111111111111";
		when "1110" => LED <= "0111111111111111";
		when "1111" => LED <= "1111111111111111";
			
	
		when others => LED <= "0000000000000000";
	end case;
end process;
end rtl;