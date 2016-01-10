----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:00:46 01/03/2016 
-- Design Name: 
-- Module Name:    FlagRegistor - Behavioral 
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

entity FlagRegistor is
    Port ( ALU_Z : in   STD_LOGIC_VECTOR (4 downto 0);
           ZF    : out  STD_LOGIC;
           CF    : out  STD_LOGIC;
           MF    : out  STD_LOGIC);
end FlagRegistor;

architecture Behavioral of FlagRegistor is

begin
		ZF <= '1' when ALU_Z = "00000" else
				'0' ;
		CF <= ALU_Z(4);
		MF <= ALU_Z(3);
end Behavioral;

