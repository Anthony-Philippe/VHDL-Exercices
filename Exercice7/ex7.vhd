library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga is
port (
	CLK,RST : in std_logic;
	vgaRed : out std_logic_vector (3 downto 0);
	vgaGreen : out std_logic_vector (3 downto 0);
	vgaBlue : out std_logic_vector (3 downto 0);
	Hsync : out std_logic;
	Vsync : out std_logic);
 	 
end vga;

architecture behavior of vga is

component vga_controller_640_60 is port
(
	rst : in std_logic;
	pixel_clk : in std_logic;
	
	HS : out std_logic;
	VS : out std_logic;
	hcount : out std_logic_vector(10 downto 0);
	vcount : out std_logic_vector(10 downto 0);
	blank : out std_logic
);
end component;

signal hcount : std_logic_vector (10 downto 0);
signal vcount : std_logic_vector(10 downto 0);
signal blank : std_logic;
signal pixel_clk : std_logic_vector(1 downto 0);

begin
	I0 : vga_controller_640_60 port map (RST, pixel_clk(1), Hsync, Vsync, hcount, vcount, blank);

	process (CLK,RST)
	begin
		if (RST = '1') then
			pixel_clk <= (others => '0');
		elsif (CLK'event and CLK = '1') then
			pixel_clk <= pixel_clk + '1';
		end if;	
	end process;

	process (blank1, blank2)
	begin

		if (blank = '0') then if((hcount>=0 and hcount<=150) AND (vcount>=0 and vcount<=500)) then
			vgaRed <= (others => '1');
			vgaGreen <= (others => '1');
			vgaBlue <= (others => '0');

		elseif (blank = '0') then if((hcount>=150 and hcount<=300) AND (vcount>=0 and vcount<=500)) then
			vgaRed <= (others => '1');
			vgaGreen <= (others => '1');
			vgaBlue <= (others => '0');

		elseif (blank = '0') then if((hcount>=300 and hcount<=450) AND (vcount>=0 and vcount<=500)) then
			vgaRed <= (others => '1');
			vgaGreen <= (others => '1');
			vgaBlue <= (others => '0');

		else
			vgaRed <= (others => '0');
			vgaGreen <= (others => '0');
			vgaBlue <= (others => '0');
		end if;
		end if;
		end if;
		end if;
	end process;
		
end behavior;