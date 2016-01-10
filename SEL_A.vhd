----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:00:25 01/04/2016 
-- Design Name: 
-- Module Name:    SEL_A - Behavioral 
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

entity SEL_A is
    Port ( A_REG   : in   STD_LOGIC_VECTOR (3 downto 0);
           SEL     : in   STD_LOGIC;
           ALU_OUT : out  STD_LOGIC_vector (3 downto 0));
end SEL_A;

architecture Behavioral of SEL_A is

begin
	ALU_OUT <=  A_REG when SEL = '1' else
					(others => '0');
end Behavioral;

