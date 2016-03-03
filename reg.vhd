----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:57:05 11/15/2013 
-- Design Name: 
-- Module Name:    reg - Behavioral 
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

entity reg is
  port(a:in std_logic_vector(15 downto 0);
       clk,wr:in std_logic;
		 q:out std_logic_vector(15 downto 0));
end reg;

architecture Behavioral of reg is

begin
	process(clk,wr)
	begin
		if wr = '1' then
			if clk'event and clk='0' then
			q <= a;
			end if;
		end if;
	end process;
end Behavioral;

