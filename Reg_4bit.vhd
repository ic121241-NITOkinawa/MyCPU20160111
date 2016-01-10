----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:39:53 01/04/2016 
-- Design Name: 
-- Module Name:    Reg_4bit - Behavioral 
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

entity Reg_4bit is
    Port ( D   : in   STD_LOGIC_VECTOR (3 downto 0);
           RST : in   STD_LOGIC;
           CLK : in   STD_LOGIC;
			  WRT : in   std_logic;
           Q   : out  STD_LOGIC_vector (3 downto 0));
end Reg_4bit;

architecture Behavioral of Reg_4bit is
	signal TMP : std_logic_vector (3 downto 0);
begin
	process (CLK, RST) begin
		if (RST = '1') then
			TMP <= (others => '0');
		elsif (CLK'event and CLK = '1') then
			if (WRT = '1') then
				TMP <= D;
			end if;
		end if;
	end process;
	
	Q <= TMP;
end Behavioral;

