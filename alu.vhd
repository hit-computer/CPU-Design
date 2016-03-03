----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:57:59 11/15/2013 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
   port(a,b:in std_logic_vector(15 downto 0);
		  sel:in std_logic_vector(3 downto 0);
		  z:in std_logic;
		  cy:in std_logic;
		  flag:out std_logic_vector(7 downto 0);
		  c:out std_logic_vector(15 downto 0));
end alu;

architecture Behavioral of alu is
	signal a17:std_logic_vector(16 downto 0);
	signal b17:std_logic_vector(16 downto 0);
	signal f17:std_logic_vector(16 downto 0);
	signal jmp:std_logic_vector(16 downto 0);
	signal b7:std_logic_vector(6 downto 0);
begin
	a17 <= '0'&a;
	b17 <= '0'&b;
	b7 <= b(6 downto 0);
	jmp <= "0000000000"&b7;
	process(sel,a17,b17,jmp,a,b,cy,z)
	begin
		case sel is
			when "0000" =>
				f17 <= "00000000000000000";
			when "0001" =>
				f17 <= a17+b17;
			when "1001" =>
				f17 <= a17+b17+cy;
			when "1010" =>
				f17 <= b17-a17-cy;
			when "0011" =>
				f17 <= a17 and b17;
			when "0100" =>
				f17 <= a17 or b17;
			when "0101" =>
				if z='1' then
					if b17(7) = '0' then
						f17 <= a17 + jmp;
					else
						f17 <= a17 - jmp;
					end if;
				else
					f17 <= a17;
				end if;
			when "0110" =>
				if cy='1' then
					if b17(7) = '0' then
						f17 <= a17 + jmp;
					else
						f17 <= a17 - jmp;
					end if;
				else
					f17 <= a17;
				end if;
			when "0111" =>
				f17 <= b17;
			when "1011" =>
				if z='1' then
					f17 <= "00000000000000000";
				else
					f17 <= "00000000000000001";
				end if;
			when "1100" =>
				if z='1' then
					f17 <= "10000000000000000";
				else
					f17 <= "10000000000000001";
				end if;
			when others =>
				f17 <= a17;
		end case;
	end process;
	
	process(sel,f17)
	begin
		flag <= "00000000";
		if sel(3)='1' then
			flag(0) <= f17(16);
		elsif sel = "0000" then
			flag(0) <= '0';
		else
			flag(0) <= cy;
		end if;
		if f17(15 downto 0)="0000000000000000" then
			flag(1) <= '1';
		else
			flag(1) <= '0';
		end if;
		c <= f17(15 downto 0);
	end process;

end Behavioral;

