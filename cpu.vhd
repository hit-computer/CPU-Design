----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:58:57 11/15/2013 
-- Design Name: 
-- Module Name:    cpu - Behavioral 
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

entity cpu is
 port(rst,clk:in std_logic;
      abus:out std_logic_vector(15 downto 0);
		dbus:inout std_logic_vector(15 downto 0);
		aled,dled,ir:out std_logic_vector(15 downto 0);
		a7,a6,a5,a4,a3:out std_logic;
		mreq,rd,wr,bhe,ble:out std_logic;
		b8:out std_logic_vector(7 downto 0));
end cpu;

architecture Behavioral of cpu is
 component regarray
  port(data:in std_logic_vector(15 downto 0);
		 sel: in std_logic_vector(2 downto 0);
		 clk,rd,wr:in std_logic;
		 q:out std_logic_vector(15 downto 0));
 end component;
 
 component reg
  port(a:in std_logic_vector(15 downto 0);
       clk,wr:in std_logic;
		 q:out std_logic_vector(15 downto 0));
 end component;
 
 component trireg
  port(a:in std_logic_vector(15 downto 0);
		 clk,rd,wr:in std_logic;
		 q:out std_logic_vector(15 downto 0));
 end component;
 
 component control
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
 end component;
 
 component alu
	port(a,b:in std_logic_vector(15 downto 0);
		  sel:in std_logic_vector(3 downto 0);
		  z:in std_logic;
		  cy:in std_logic;
		  flag:out std_logic_vector(7 downto 0);
		  c:out std_logic_vector(15 downto 0));
 end component;
 
 component flag
	port(a:in std_logic_vector(7 downto 0);
		  clk,wr:in std_logic;
		  z:out std_logic;
		  cy:out std_logic);
 end component;
 
 component progcntr
	port(a:in std_logic_vector(15 downto 0);
		  clk,rd,wr:in std_logic;
		  inc:in std_logic;
		  q:out std_logic_vector(15 downto 0));
 end component;
 
 signal opdata,aluout,instrregout:std_logic_vector(15 downto 0);
 signal regsel:std_logic_vector(2 downto 0);
 signal regrd,regwr,opregwr,outregrd,outregwr,addrregwr,
 instrregwr,progcntrrd,progcntrwr,pcinc:std_logic;
 signal alusel:std_logic_vector(3 downto 0);
 signal fz,fcy,flagwr:std_logic;
 signal fg:std_logic_vector(7 downto 0);
 signal adrr:std_logic_vector(15 downto 0);
 signal mreq1,rd1,wr1,bhe1,ble1:std_logic;
begin
	ral:regarray port map(dbus,regsel,clk,regrd,regwr,dbus);
	opreg:reg port map(dbus,clk,opregwr,opdata);
	alu1:alu port map(dbus,opdata,alusel,fz,fcy,fg,aluout);
	outreg:trireg port map(aluout,clk,outregrd,outregwr,dbus);
	addrreg:reg port map(dbus,clk,addrregwr,adrr);
	progcntr1:progcntr port map(dbus,clk,progcntrrd,progcntrwr,pcinc,dbus);
	instr1:reg port map(dbus,clk,instrregwr,instrregout);
	con1:control port map(clk,rst,instrregout,progcntrwr,progcntrrd,addrregwr,
	outregwr,outregrd,alusel,opregwr,instrregwr,regsel,regwr,regrd,mreq1,rd1,wr1,
	bhe1,ble1,pcinc,flagwr,b8);
	flag1:flag port map(fg,clk,flagwr,fz,fcy);
	
	ir <= instrregout;
	abus <= adrr;
	aled <= adrr;
	dled <= dbus;
	mreq <= mreq1;
	rd <= rd1;
	wr <= wr1;
	bhe <= bhe1;
	ble <= ble1;
	a7 <= not mreq1;
	a6 <= not wr1;
	a5 <= not rd1;
	a4 <= not bhe1;
	a3 <= not ble1;
end Behavioral;
