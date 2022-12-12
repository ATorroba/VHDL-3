----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:49:24 12/24/2020 
-- Design Name: 
-- Module Name:    cont_clk - Behavioral 
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

entity cont_clk is
	Port ( enable : in STD_LOGIC;
		    reset : in STD_LOGIC;
			 clk : in STD_LOGIC;
			 rco : out STD_LOGIC;
			 q : out STD_LOGIC_VECTOR (13 downto 0));
end cont_clk;

architecture Behavioral of cont_clk is

	signal estado_act, estado_sig: STD_LOGIC_VECTOR(13 downto 0);
	constant max : std_logic_vector(13 downto 0) := "10011100001111";
	
	begin
	--logica estado siguiente
		process(estado_act, enable)
			begin
				if(enable = '1') then
				if(estado_act = max) then
					estado_sig <= (others => '0');
				else
					estado_sig <= std_logic_vector(unsigned(estado_act) + 1);

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
			if(estado_act = max) then
				rco <= '1';
			end if;
		end process;


end Behavioral;

