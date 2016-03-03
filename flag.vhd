----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:53 11/15/2013 
-- Design Name: 
-- Module Name:    flag - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flag is
   port(a:in std_logic_vector(7 downto 0);
		  clk,wr:in std_logic;
		  z:out std_logic;
		  cy:out std_logic);
end flag;

architecture Behavioral of flag is
	signal val:std_logic_vector(7 downto 0);
begin
	z <= val(1);
	cy <= val(0);
	
	process(clk)
		begin
			if wr = '1' then
				if clk'event and clk='0' then
				val <= a;
				end if;
			end if;
	end process;

end Behavioral;

