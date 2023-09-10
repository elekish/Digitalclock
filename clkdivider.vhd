----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:44:32 09/10/2023 
-- Design Name: 
-- Module Name:    clkdivider - Behavioral 
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

entity clkdivider is
    Port ( clk_50 : in  STD_LOGIC;
           clk_1s : out  STD_LOGIC);
end clkdivider;

architecture Behavioral of clkdivider is
signal count:std_logic_vector(27 downto 0):=(others=>'0');
begin
process(clk_50)
begin
if(rising_edge(clk_50)) then count<=count+x"0000001";
if(count>="2FAF080") then count<=x"0000000";
end if;
end if;
end process;
clk_1s<='0' when count< x"17D7840" else '1';
end Behavioral;

