----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:37:37 12/24/2020 
-- Design Name: 
-- Module Name:    cont_dec - Behavioral 
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

entity cont_dec is
	Port ( enable : in STD_LOGIC;
			 reset : in STD_LOGIC;
			 clk : in STD_LOGIC;
			 rco : out STD_LOGIC;
			 q : out STD_LOGIC_VECTOR (3 downto 0));
end cont_dec;

architecture Behavioral of cont_dec is

	signal estado_act, estado_sig: STD_LOGIC_VECTOR(3 downto 0);
	
	begin
	
	--logica estado siguiente
		process(estado_act, enable)
			begin
				if(enable = '1') then
					if(estado_act /= "1001") then
						estado_sig <= std_logic_vector(unsigned(estado_act) + 1);
					else
						estado_sig <= (others => '0');
					end if;
					else
						estado_sig <= estado_act; 
				end if;
		end process;
		
	--almacenamiento del estado
		process(clk)
			begin
				if(clk'event and clk= '1') then
					if(reset = '1') then
						estado_act <= (others => '0');
					else
						estado_act <= estado_sig;
					end if;
				end if;
		end process;
		
	--lógica de la salida
	q <= estado_act;
		process(estado_act)
		begin
			rco <= '0';
			if(estado_act = "1001") then
				rco <= '1';
			end if;
		end process;
		
end Behavioral;
