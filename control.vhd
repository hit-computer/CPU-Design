----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:43 11/15/2013 
-- Design Name: 
-- Module Name:    control - Behavioral 
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

entity control is
  port(clk,rst:in std_logic;
		 instrreg:in std_logic_vector(15 downto 0);
		 progcntrwr,progcntrrd:out std_logic;
		 addrregwr:out std_logic;
		 outregwr,outregrd:out std_logic;
		 alusel:out std_logic_vector(3 downto 0);
		 opregwr:out std_logic;
		 instrwr:out std_logic;
		 regsel:out std_logic_vector(2 downto 0);
		 regwr,regrd:out std_logic;
		 mreq,rd,memwr,bhe,ble:out std_logic;
		 progcntrinc:out std_logic;
		 flagwr:out std_logic;
		 cur_state:out std_logic_vector(7 downto 0));
end control;

architecture Behavioral of control is
	type state is(reset1,reset2,reset3,get1,get2,execute,mov01,mov02,mov11,mov12,mov13,mov21,mov22,mov23,mov31,mov32,mov33,mov41,mov42,mov51,mov52,mov53,mov54,mov55,adc01,adc02,adc03,adc04,adc11,adc12,adc13,sbb01,sbb02,sbb03,sbb04,sbb11,sbb12,sbb13,and01,and02,and03,and04,and11,and12,and13,or01,or02,or03,or04,or11,or12,or13,clc0,stc0,jmp01,jmp02,jz0,jz1,jc0,jc1);
	signal current_state,next_state:state;
	signal tempinstr:std_logic_vector(15 downto 0);
	signal wr:std_logic;
begin
	process(current_state,instrreg)
	begin
		 progcntrwr <= '0';
		 progcntrrd <= '0';
		 addrregwr <= '0';
		 outregwr <= '0';
		 outregrd <= '0';
		 alusel <= "0000";
		 opregwr <= '0';
		 instrwr <= '0';
		 regsel <= "000";
		 regwr <= '0';
		 regrd <= '0';
		 mreq <= '1';
		 rd <= '1';
		 wr <= '1';
		 bhe <= '1';
		 ble <= '1';
		 progcntrinc <= '0';
		 flagwr <= '0';
		 cur_state <= "00000000";
		 case current_state is
			when reset1 =>
				alusel <= "0000";
				next_state <= reset2;
			when reset2 =>
				alusel <= "0000";
				outregwr <= '1';
				flagwr <= '1';
				next_state <= reset3;
			when reset3 =>
				outregrd <= '1';
				progcntrwr <= '1';
				next_state <= get1;
			when get1 =>
				progcntrrd <= '1';
				addrregwr <= '1';
				cur_state(0) <= '1';
				next_state <= get2;
			when get2 =>
				progcntrinc <= '1';
				mreq <= '0';
				rd <= '0';
				bhe <= '0';
				ble <= '0';
				instrwr <= '1';
				opregwr <= '1';
				cur_state(1) <= '1';
				next_state <= execute;
			when execute =>
				tempinstr <= instrreg;
				cur_state(2) <= '1';
				case instrreg(15 downto 11) is
					when "00000" =>						
						next_state <= mov01;
					when "00001" =>
						next_state <= mov11;
					when "00010" =>
						next_state <= mov21;
					when "00011" =>
						next_state <= mov31;
					when "00100" =>
						next_state <= mov41;
					when "00101" =>
						next_state <= mov51;
					when "00110" =>
						next_state <= adc01;
					when "00111" =>
						next_state <= adc11;
					when "01000" =>
						next_state <= sbb01;
					when "01001" =>
						next_state <= sbb11;
					when "01010" =>
						next_state <= and01;
					when "01011" =>
						next_state <= and11;
					when "01100" =>
						next_state <= or01;
					when "01101" =>
						next_state <= or11;
					when "01110" =>
						next_state <= clc0;
					when "01111" =>
						next_state <= stc0;
					when "10000" =>
						next_state <= jmp01;
					when "10001" =>
						next_state <= jz0;
					when "10010" =>
						next_state <= jc0;
					when others =>
						next_state <= get1;
					end case;
				
				when mov01 =>
					progcntrrd <= '1';
					addrregwr <= '1';
					cur_state(3) <= '1';
					next_state <= mov02;
				when mov02 =>
					progcntrinc <= '1';
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(4) <= '1';
					next_state <= get1;
				when mov11 =>
					progcntrrd <= '1';
					addrregwr <= '1';
					cur_state(3) <= '1';
					next_state <= mov12;
				when mov12 =>
					progcntrinc <= '1';
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					addrregwr <= '1';
					cur_state(4) <= '1';
					next_state <= mov13;
				when mov13 =>
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(5) <= '1';
					next_state <= get1;
				when mov21 =>
					progcntrrd <= '1';
					addrregwr <= '1';
					cur_state(3) <= '1';
					next_state <= mov22;
				when mov22 =>
					progcntrinc <= '1';
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					addrregwr <= '1';
					cur_state(4) <= '1';
					next_state <= mov23;
				when mov23 =>
					regsel <= tempinstr(2 downto 0);
					regrd <= '1';
					mreq <= '0';
					wr <= '0';
					bhe <= '0';
					ble <= '0';
					cur_state(5) <= '1';
					next_state <= get1;
				when mov31 =>
					regsel <= tempinstr(5 downto 3);
					regrd <= '1';
					opregwr <= '1';
					cur_state(3) <= '1';
					next_state <= mov32;
				when mov32 =>
					alusel <= "0111";
					outregwr <= '1';
					cur_state(4) <= '1';
					next_state <= mov33;
				when mov33 =>
					outregrd <= '1';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(5) <= '1';
					next_state <= get1;
				when mov41 =>
					regsel <= tempinstr(5 downto 3);
					regrd <= '1';
					addrregwr <= '1';
					cur_state(3) <= '1';
					next_state <= mov42;
				when mov42 =>
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(4) <= '1';
					next_state <= get1;
				when mov51 =>
					progcntrrd <= '1';
					addrregwr <= '1';
					cur_state(3) <= '1';
					next_state <= mov52;
				when mov52 =>
					progcntrinc <= '1';
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					opregwr <= '1';
					cur_state(4) <= '1';
					next_state <= mov53;
				when mov53 =>
					regsel <= tempinstr(5 downto 3);
					regrd <= '1';
					alusel <= "0001";
					outregwr <= '1';
					cur_state(5) <= '1';
					next_state <= mov54;
				when mov54 =>
					outregrd <= '1';
					addrregwr <= '1';
					cur_state(6) <= '1';
					next_state <= mov55;
				when mov55 =>
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					regsel <= tempinstr(2 downto 0);
					cur_state(7) <= '1';
					regwr <= '1';
					next_state <= get1;
				when adc01 =>
					regsel <= tempinstr(2 downto 0);
					regrd <= '1';
					opregwr <= '1';
					cur_state(3) <= '1';
					next_state <= adc02;
				when adc02 =>
					progcntrrd <= '1';
					addrregwr <= '1';
					cur_state(4) <= '1';
					next_state <= adc03;
				when adc03 =>
					progcntrinc <= '1';
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					alusel <= "1001";
					outregwr <= '1';
					flagwr <= '1';
					cur_state(5) <= '1';
					next_state <= adc04;
				when adc04 =>
					outregrd <= '1';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(6) <= '1';
					next_state <= get1;
				when adc11 =>
					regsel <= tempinstr(5 downto 3);
					regrd <= '1';
					opregwr <= '1';
					cur_state(3) <= '1';
					next_state <= adc12;
				when adc12 =>
					regsel <= tempinstr(2 downto 0);
					regrd <= '1';
					alusel <= "1001";
					outregwr <= '1';
					flagwr <= '1';
					cur_state(4) <= '1';
					next_state <= adc13;
				when adc13 =>
					outregrd <= '1';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(5) <= '1';
					next_state <= get1;
				when sbb01 =>
					regsel <= tempinstr(2 downto 0);
					regrd <= '1';
					opregwr <= '1';
					cur_state(3) <= '1';
					next_state <= sbb02;
				when sbb02 =>
					progcntrrd <= '1';
					addrregwr <= '1';
					cur_state(4) <= '1';
					next_state <= sbb03;
				when sbb03 =>
					progcntrinc <= '1';
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					alusel <= "1010";
					outregwr <= '1';
					flagwr <= '1';
					cur_state(5) <= '1';
					next_state <= sbb04;
				when sbb04 =>
					outregrd <= '1';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(6) <= '1';
					next_state <= get1;
				when sbb11 =>
					regsel <= tempinstr(2 downto 0);
					regrd <= '1';
					opregwr <= '1';
					cur_state(3) <= '1';
					next_state <= sbb12;
				when sbb12 =>
					regsel <= tempinstr(5 downto 3);
					regrd <= '1';
					alusel <= "1010";
					outregwr <= '1';
					flagwr <= '1';
					cur_state(4) <= '1';
					next_state <= sbb13;
				when sbb13 =>
					outregrd <= '1';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(5) <= '1';
					next_state <= get1; 
				when and01 =>
					regsel <= tempinstr(2 downto 0);
					regrd <= '1';
					opregwr <= '1';
					cur_state(3) <= '1';
					next_state <= and02;
				when and02 =>
					progcntrrd <= '1';
					addrregwr <= '1';
					cur_state(4) <= '1';
					next_state <= and03;
				when and03 =>
					progcntrinc <= '1';
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					alusel <= "0011";
					outregwr <= '1';
					flagwr <= '1';
					cur_state(5) <= '1';
					next_state <= and04;
				when and04 =>
					outregrd <= '1';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(6) <= '1';
					next_state <= get1;
				when and11 =>
					regsel <= tempinstr(5 downto 3);
					regrd <= '1';
					opregwr <= '1';
					cur_state(3) <= '1';
					next_state <= and12;
				when and12 =>
					regsel <= tempinstr(2 downto 0);
					regrd <= '1';
					alusel <= "0011";
					outregwr <= '1';
					flagwr <= '1';
					cur_state(4) <= '1';
					next_state <= and13;
				when and13 =>
					outregrd <= '1';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(5) <= '1';
					next_state <= get1; 
				when or01 =>
					regsel <= tempinstr(2 downto 0);
					regrd <= '1';
					opregwr <= '1';
					cur_state(3) <= '1';
					next_state <= or02;
				when or02 =>
					progcntrrd <= '1';
					addrregwr <= '1';
					cur_state(4) <= '1';
					next_state <= or03;
				when or03 =>
					progcntrinc <= '1';
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					alusel <= "0100";
					outregwr <= '1';
					flagwr <= '1';
					cur_state(5) <= '1';
					next_state <= or04;
				when or04 =>
					outregrd <= '1';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(6) <= '1';
					next_state <= get1;
				when or11 =>
					regsel <= tempinstr(5 downto 3);
					regrd <= '1';
					opregwr <= '1';
					cur_state(3) <= '1';
					next_state <= or12;
				when or12 =>
					regsel <= tempinstr(2 downto 0);
					regrd <= '1';
					alusel <= "0100";
					outregwr <= '1';
					flagwr <= '1';
					cur_state(4) <= '1';
					next_state <= or13;
				when or13 =>
					outregrd <= '1';
					regsel <= tempinstr(2 downto 0);
					regwr <= '1';
					cur_state(5) <= '1';
					next_state <= get1;
				when clc0 =>
					alusel <= "1011";
					flagwr <= '1';
					cur_state(3) <= '1';
					next_state <= get1;
				when stc0 =>
					alusel <= "1100";
					flagwr <= '1';
					cur_state(3) <= '1';
					next_state <= get1;
				when jmp01 =>
					progcntrrd <= '1';
					addrregwr <= '1';
					progcntrinc <= '1';
					progcntrwr <= '1';
					cur_state(3) <= '1';
					next_state <= jmp02;
				when jmp02 =>
					mreq <= '0';
					rd <= '0';
					bhe <= '0';
					ble <= '0';
					progcntrwr <= '1';
					cur_state(4) <= '1';
					next_state <= get1;
				when  jz0 =>
					progcntrrd <= '1';
					alusel <= "0101";
					outregwr <= '1';
					cur_state(3) <= '1';
					next_state <= jz1;
				when jz1 =>
					outregrd <= '1';
					progcntrwr <= '1';
					cur_state(4) <= '1';
					next_state <= get1;
				when  jc0 =>
					progcntrrd <= '1';
					alusel <= "0110";
					outregwr <= '1';
					cur_state(3) <= '1';
					next_state <= jz1;
				when jc1 =>
					outregrd <= '1';
					progcntrwr <= '1';
					cur_state(4) <= '1';
					next_state <= get1;
				when others =>
					null;
			end case;
			
	end process;
	
	
	
	process(clk,rst)
	begin
		if rst = '1' then
			current_state <= reset1;
		elsif clk'event and clk='1' then
			current_state <= next_state;
		end if;
	end process;
	
	process(wr,clk)
	begin
		if wr = '0' then
			if clk'event and clk='0' then
				memwr <= '0';
			end if;
		else
			memwr <= '1';
		end if;
	end process;

end Behavioral;

