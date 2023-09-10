----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:36:50 09/10/2023 
-- Design Name: 
-- Module Name:    bin_hex - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin_hex is
    Port ( b : in  STD_LOGIC_VECTOR (3 downto 0);
           h : out  STD_LOGIC_vector(6 downto 0));
end bin_hex;

architecture Behavioral of bin_hex is
begin
process(b)
begin
case b is
when "0000" => h<="1000000";
when "0001" => h<="1111001";
when "0010" => h<="0100100";
when "0011" => h<="0110000";
when "0100" => h<="0011001";
when "0101" => h<="0010010";
when "0110" => h<="0000010";
when "0111" => h<="1111000";
when "1000" => h<="0000000";
when "1001" => h<="0010000";
when "1010" => h<="0001000";
when "1011" => h<="0000011";
when "1100" => h<="1000110";
when "1101" => h<="0100001";
when others => h<="0001110";
end case;
end process;
end Behavioral;

