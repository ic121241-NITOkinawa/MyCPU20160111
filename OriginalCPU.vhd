----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:41:40 01/02/2016 
-- Design Name: 
-- Module Name:    OriginalCPU - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OriginalCPU is
    Port ( RST     : in std_logic;
			  CLK     : in std_logic;
			  ROM_IN  : in  STD_LOGIC_VECTOR (7 downto 0);
           ROM_OUT : out STD_LOGIC_VECTOR (3 downto 0);
           OUTPUT  : out STD_LOGIC_VECTOR (3 downto 0));
end OriginalCPU;

architecture Behavioral of OriginalCPU is
	type STATE is (READBACK, FETCH, DECODE, EXECUTE, WRITEBACK);
	signal CRST, NXST : STATE;
	
	signal ONE : std_logic := '1';
	
--	for main memory
	subtype ROM_WORD is std_logic_vector (7 downto 0);
	type ROM is array (0 to 2**4 - 1) of ROM_WORD;
	
--	Operation Code
	constant LD_A  : std_logic_vector(3 downto 0) := "0000"; --LD  A, Imm
	constant OUT_A : std_logic_vector(3 downto 0) := "0001"; --OUT A
	constant ADD_O : std_logic_vector(3 downto 0) := "0010"; --ADD OUT, Imm
	constant ADD_A : std_logic_vector(3 downto 0) := "0011"; --ADD A, Imm
	constant SUB_A : std_logic_vector(3 downto 0) := "0100"; --SUB A, Imm
	constant CMP_A : std_logic_vector(3 downto 0) := "0101"; --CMP A, Imm
	constant AND_A : std_logic_vector(3 downto 0) := "0110"; --AND A, Imm
	constant OR_A  : std_logic_vector(3 downto 0) := "0111"; --OR  A, Imm
	constant XOR_A : std_logic_vector(3 downto 0) := "1000"; --XOR A, Imm
	constant SHL_A : std_logic_vector(3 downto 0) := "1001"; --SHL A
	constant SHR_A : std_logic_vector(3 downto 0) := "1010"; --SHR A
	constant NOT_A : std_logic_vector(3 downto 0) := "1011"; --NOT A
	constant JMP_I : std_logic_vector(3 downto 0) := "1100"; --JMP Imm
	constant JMC_I : std_logic_vector(3 downto 0) := "1101"; --JMC Imm
	constant JMZ_I : std_logic_vector(3 downto 0) := "1110"; --JMZ Imm
--	constant  : std_logic_vector(3 downto 0) := "1111"; --JMV Imm
	
	--selecter bus
	signal BUS_LATCH  : std_logic_vector (2 downto 0);
	signal BUS_IR     : std_logic_vector (7 downto 0);
	signal BUS_FR     : std_logic_vector (2 downto 0);
	signal BUS_ALU_Sel: std_logic_vector (2 downto 0);
	--ALU bus
	signal BUS_ALU_A 	: std_logic_vector (3 downto 0);
	signal BUS_ALU_B	: std_logic_vector (3 downto 0);
	signal BUS_ALU_Z  : std_logic_vector (4 downto 0);
	--A registor bus
	signal BUS_AREG_O : std_logic_vector (3 downto 0);
	--select ZERO for A registor
	signal SEL_Z	   : std_logic;
	
	component Reg_4bit
		port ( D : in std_logic_vector (3 downto 0);
				 RST, CLK, WRT : in std_logic;
				 Q : out std_logic_vector (3 downto 0));
	end component;
	
	component FlagRegistor
		port ( ALU_Z : in std_logic_vector (4 downto 0);
				 ZF, CF, MF : out std_logic);
	end component;
	
	component SEL_A
		port ( A_REG : in std_logic_vector (3 downto 0);
				 SEL   : in std_logic;
				 ALU_OUT : out std_logic_vector (3 downto 0));
	end component;
	
	component ALU
		port ( ALU_A, ALU_B : in std_logic_vector (3 downto 0);
				 ALU_S : in  std_logic_vector (2 downto 0);
				 ALU_Z : out std_logic_vector (4 downto 0));
	end component;
	
	component SELECTER
		port ( SEL_IN  : in  std_logic_vector (3 downto 0);
				 FLAG_IN : in  std_logic_vector (1 downto 0);
				 OUT_LATCH : out std_logic_vector (2 downto 0);
				 OUT_ALU   : out std_logic_vector (2 downto 0);
				 OUT_ZERO  : out std_logic);
	end component;
--	
begin
	CPU_ALU   : ALU      port map(BUS_ALU_A, BUS_ALU_B, BUS_ALU_SEL, BUS_ALU_Z);
	COU_FR    : FlagRegistor port map(BUS_ALU_Z,BUS_FR(2), BUS_FR(1), BUS_FR(0));
	
	CPU_A_REG : Reg_4bit port map(BUS_ALU_Z(3 downto 0), RST, CLK, BUS_LATCH(2), BUS_AREG_O);
	CPU_O_REG : Reg_4bit port map(BUS_ALU_Z(3 downto 0), RST, CLK, BUS_LATCH(1), OUTPUT);
	CPU_PC    : Reg_4bit port map(BUS_ALU_Z(3 downto 0), RST, CLK, BUS_LATCH(0), ROM_OUT);
	CPU_IR1	 : Reg_4bit port map(ROM_IN(7 downto 4), RST, CLK, ONE, BUS_IR(7 downto 4));
	CPU_IR2	 : Reg_4bit port map(ROM_IN(3 downto 0), RST, CLK, ONE, BUS_IR(3 downto 0));
	
	CPU_SEL_A : SEL_A port map (BUS_AREG_O, SEL_Z, BUS_ALU_A);
	
	CPU_SEL   : SELECTER port map (BUS_IR(7 downto 4), BUS_FR(2 downto 1), BUS_LATCH(2 downto 0), BUS_ALU_SEL(2 downto 0), SEL_Z);
	
	
end Behavioral;