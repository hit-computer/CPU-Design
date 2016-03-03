----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:29 11/15/2013 
-- Design Name: 
-- Module Name:    progcntr - Behavioral 
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

entity progcntr is
   port(a:in std_logic_vector(15 downto 0);
		  clk,rd,wr:in std_logic;
		  inc:in std_logic;
		  q:out std_logic_vector(15 downto 0));
end progcntr;

architecture Behavioral of progcntr is
	signal val:std_logic_vector(15 downto 0);
begin
	process(clk,inc,wr)
		begin
			if clk'event and clk='0' then
				if wr = '1' then
					val <= a;
				elsif inc = '1' then
					val <= val + 1;
				end if;
			end if;
	end process;
	
	process(rd,val)
	begin
		if rd='1' then
			q <= val;
		else
			q <= "ZZZZZZZZZZZZZZZZ";
		end if;
	end process;
	
end Behavioral;

