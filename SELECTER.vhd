----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:17:56 01/07/2016 
-- Design Name: 
-- Module Name:    SELECTER - Behavioral 
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

entity SELECTER is
    Port ( SEL_IN    : in   STD_LOGIC_VECTOR (3 downto 0);
           FLAG_IN   : in   STD_LOGIC_VECTOR (1 downto 0);
           OUT_LATCH : out  STD_LOGIC_VECTOR (2 downto 0);
           OUT_ALU   : out  STD_LOGIC_VECTOR (2 downto 0);
           OUT_ZERO  : out  STD_LOGIC);
end SELECTER;

architecture Behavioral of SELECTER is
	type STATE is (LOAD_A, OUT_A, ADD_O, ADD_A, SUB_A, CMP_A, AND_A, OR_A, XOR_A, SHL_A, SHR_A, NOT_A, JMP, JMC, JMZ);
	signal CRST : STATE;
begin
	process (SEL_IN) begin
		   if (SEL_IN = "0000") then CRST <= LOAD_A;
		elsif (SEL_IN = "0001") then CRST <= OUT_A;
		elsif (SEL_IN = "0010") then CRST <= ADD_O;
		elsif (SEL_IN = "0011") then CRST <= ADD_A;
		elsif (SEL_IN = "0100") then CRST <= SUB_A;
		elsif (SEL_IN = "0101") then CRST <= CMP_A;
		elsif (SEL_IN = "0110") then CRST <= AND_A;
		elsif (SEL_IN = "0111") then CRST <= OR_A;
		elsif (SEL_IN = "1000") then CRST <= XOR_A;
		elsif (SEL_IN = "1001") then CRST <= SHL_A;
		elsif (SEL_IN = "1010") then CRST <= SHR_A;
		elsif (SEL_IN = "1011") then CRST <= NOT_A;
		elsif (SEL_IN = "1100") then CRST <= JMP;
		elsif (SEL_IN = "1101") then CRST <= JMC;
		elsif (SEL_IN = "1110") then CRST <= JMZ;
--		elsif (SEL_IN = "1111") then CRST <= JMV;
		end if;
	end process;

	process (CRST) begin
		case CRST is
			when LOAD_A => OUT_ALU   <= "000";
								OUT_ZERO  <= '0';
								OUT_LATCH <= "100";
			when OUT_A  => OUT_ALU   <= "000";
								OUT_ZERO  <= '0';
								OUT_LATCH <= "010";
			when ADD_O  => OUT_ALU   <= "000";
								OUT_ZERO  <= '1';
								OUT_LATCH <= "010";
			when ADD_A  => OUT_ALU   <= "000";
								OUT_ZERO  <= '1';
								OUT_LATCH <= "100";
			when SUB_A  => OUT_ALU   <= "001";
								OUT_ZERO  <= '1';
								OUT_LATCH <= "100";
			when CMP_A  => OUT_ALU   <= "010";
								OUT_ZERO  <= '1';
								OUT_LATCH <= "100";
			when AND_A  => OUT_ALU   <= "011";
								OUT_ZERO  <= '1';
								OUT_LATCH <= "100";
			when OR_A   => OUT_ALU   <= "100";
								OUT_ZERO  <= '1';
								OUT_LATCH <= "100";
			when XOR_A  => OUT_ALU   <= "101";
								OUT_ZERO  <= '1';
								OUT_LATCH <= "100";
			when SHL_A  => OUT_ALU   <= "110";
								OUT_ZERO  <= '0';
								OUT_LATCH <= "100";
			when SHR_A  => OUT_ALU   <= "111";
								OUT_ZERO  <= '0';
								OUT_LATCH <= "100";
			when NOT_A  => OUT_ALU   <= "001";
								OUT_ZERO  <= '1';
								OUT_LATCH <= "100";
								
			when JMP    => OUT_ALU   <= "000";
								OUT_ZERO  <= '0';
								OUT_LATCH <= "001";
			when JMC    => OUT_ALU   <= "000";
								OUT_ZERO  <= '0';
								OUT_LATCH <= "001";
			when JMZ    => OUT_ALU   <= "000";
								OUT_ZERO  <= '0';
								OUT_LATCH <= "001";
			when others  => null;
		end case;
	end process;
end Behavioral;
