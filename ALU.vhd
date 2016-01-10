----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:52:02 01/02/2016 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( ALU_A : in   STD_LOGIC_VECTOR (3 downto 0);
           ALU_B : in   STD_LOGIC_VECTOR (3 downto 0);
			  ALU_S : in   STD_LOGIC_VECTOR (2 downto 0);
           ALU_Z : out  STD_LOGIC_VECTOR (4 downto 0));
end ALU;

architecture Behavioral of ALU is
	type STATE is (a_ADD, a_SUB, a_COMP, l_And, l_OR, l_XOR, l_SHR, l_SHL);
	signal CRST : STATE;
--	signal Resuly : std_logic_vector(4 downto 0) := "00000";
begin
	process (ALU_S) begin
		   if (ALU_S = "000") then CRST <= a_ADD;
		elsif (ALU_S = "001") then CRST <= a_SUB;
		elsif (ALU_S = "010") then CRST <= a_COMP;
		elsif (ALU_S = "011") then CRST <= l_AND;
		elsif (ALU_S = "100") then CRST <= l_OR;
		elsif (ALU_S = "101") then CRST <= l_XOR;
		elsif (ALU_S = "110") then CRST <= l_SHL;
		elsif (ALU_S = "111") then CRST <= l_SHR;
		else null;
		end if;
	end process;
	
	process (CRST) begin
		case CRST is
			when a_ADD  => ALU_Z <= '0' & ALU_A + '0' & ALU_B;
			when a_SUB  => ALU_Z <= '0' & ALU_A - '0' & ALU_B;
			when a_COMP => if (ALU_A > ALU_B) then
									ALU_Z <= '0' & ALU_A;
								else
									ALU_Z <= '0' & ALU_B;
								end if;
			when l_AND=> ALU_Z <= '0' & ALU_A and '0' & ALU_B;
			when l_OR=>  ALU_Z <= '0' & ALU_A or  '0' & ALU_B;
			when l_XOR=> ALU_Z <= '0' & ALU_A xor '0' & ALU_B;
			when l_SHL=> ALU_Z <= '0' & ALU_A(2 downto 0) & ALU_A(3);
			when l_SHR=> ALU_Z <= '0' & ALU_A(0) & ALU_A(3 downto 1);
			when others => ALU_Z <= (others => '0');
		end case;
	end process;
--	process (ALU_S) begin
--		if (ALU_S = "000") then
--			ALU_Z <= ALU_A + ALU_B;
--		elsif (ALU_S = "001") then
--			ALU_Z <= ALU_A - ALU_B;
--		elsif (ALU_S = "010") then
--			if (ALU_A < ALU_B) then
--				ALU_Z <= '0' & ALU_B;
--			else
--				ALU_Z <= '0' & ALU_A;
--			end if;
--		elsif (ALU_S = "011") then
--			ALU_Z <= ALU_A or ALU_B;
--		elsif (ALU_S = "100") then
--			ALU_Z <= ALu_A and ALU_B;
--		elsif (ALU_S = "101") then
--			ALU_Z <= ALU_A xor ALU_B;
--		elsif (ALU_S = "110") then
--			ALU_Z <= '0' & ALU_A(2 downto 0) & ALU_A(3);
--		elsif (ALU_S = "111") then
--			ALU_Z <= '0' & ALU_A(0) & ALU_A(3 downto 1);
--		else
--			ALU_Z <= (others => '0');
--		end if;
--	end process;
end Behavioral;

