----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:56:40 11/15/2013 
-- Design Name: 
-- Module Name:    regarray - Behavioral 
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

entity regarray is
  port(data:in std_logic_vector(15 downto 0);
		 sel: in std_logic_vector(2 downto 0);
		 clk,rd,wr:in std_logic;
		 q:out std_logic_vector(15 downto 0));

end regarray;

architecture Behavioral of regarray is
	type t_ram is array (0 to 7) of std_logic_vector(15 downto 0);
	signal temp_data: std_logic_vector(15 downto 0);
begin
	process(clk,sel,wr)
		variable ramdata:t_ram;
	begin
		if wr = '1' then
			if clk'event and clk='0' then
				ramdata(conv_integer(sel)):=data;
			end if;
		end if;
		temp_data <=ramdata(conv_integer(sel));
	end process;
	
	process(rd,temp_data)
	begin
		if rd='1' then
			q <= temp_data;
		else
			q <= "ZZZZZZZZZZZZZZZZ";
		end if;
	end process;

end Behavioral;

