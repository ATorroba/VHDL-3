----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:44:13 12/24/2020 
-- Design Name: 
-- Module Name:    cp - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cp is
	Port ( pulse : in STD_LOGIC;
			 rst : in STD_LOGIC;
			 clk : in STD_LOGIC;
			 tens : out STD_LOGIC_VECTOR (3 downto 0);
			 unity : out STD_LOGIC_VECTOR (3 downto 0));
end cp;

architecture Behavioral of cp is

component cont_clk is
	Port ( enable : in STD_LOGIC;
		    reset : in STD_LOGIC;
			 clk : in STD_LOGIC;
			 rco : out STD_LOGIC;
			 q : out STD_LOGIC_VECTOR (13 downto 0));
end component;

component cont_dec is
	Port ( enable : in STD_LOGIC;
			 reset : in STD_LOGIC;
			 clk : in STD_LOGIC;
			 rco : out STD_LOGIC;
			 q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal rco1, rco2, rco3 : STD_LOGIC;
signal out1 : STD_LOGIC_VECTOR (13 downto 0);

begin

U1 : cont_clk 
	port map (enable => pulse, reset => rst, clk => clk, rco => rco1, q => out1);

U2 : cont_dec 
	port map (enable => pulse and rco1, reset => rst, clk => clk, rco => rco2, q => unity);
	
U3 : cont_dec 
	port map (enable => pulse and rco1 and rco2, reset => rst, clk => clk, rco => rco3, q => tens);
	
end Behavioral;

