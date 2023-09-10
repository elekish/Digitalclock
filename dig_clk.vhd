----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:57:53 09/10/2023 
-- Design Name: 
-- Module Name:    dig_clk - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dig_clk is
    Port ( clk : in  STD_LOGIC;
	        reset: in std_logic;
           h1 : in  STD_LOGIC_VECTOR (1 downto 0);
           h2 : in  STD_LOGIC_VECTOR (3 downto 0);
           m1 : in  STD_LOGIC_VECTOR (3 downto 0);
           m2 : in  STD_LOGIC_VECTOR (3 downto 0);
           ho1 : out  STD_LOGIC_VECTOR (6 downto 0);
           ho2 : out  STD_LOGIC_VECTOR (6 downto 0);
           mo1 : out  STD_LOGIC_VECTOR (6 downto 0);
           mo2 : out  STD_LOGIC_VECTOR (6 downto 0));
end dig_clk;

architecture Behavioral of dig_clk is
component bin_hex
port(
b:in std_logic_vector(3 downto 0);
h: out std_logic_vector(6 downto 0)
);
end component;
component clk_div
port(
clk_50 : in std_logic;
clk_1s : out std_logic
);
end component;

signal clk_1s: std_logic;
signal count_h,count_m,count_s:integer;
signal ho_b1,ho_b2,mo_b1,mo_b2: std_logic_vector(3 downto 0);

begin
create_clk : clk_div port map(clk,clk_1s);

process(clk_1s,reset)    --updating counts of hours, minutes and seconds
begin
if(reset='0') then count_h<=to_integer(unsigned(h1))*10+to_integer(unsigned(h2));
count_m<=to_integer(unsigned(m1))*10+to_integer(unsigned(m2));
count_s<=0;
elsif(rising_edge(clk_1s)) then count_s<=count_s+1;
if(count_s>=60) then count_m<=count_m+1;
count_s<=0;
if(count_m>=60) then count_h<=count_h+1;
count_m<=0;
if(count_h>=24) then count_h<=0;
end if;
end if;
end if;
end if;
end process;

ho_b1<= x"2" when count_h>=20 else x"1" when count_h>=10 else x"0"; --updating integer value of MSB
convert_hob1 : bin_hex port map(ho_b1,ho1); --conversion to hexadecimal

ho_b2 <= std_logic_vector(to_unsigned((count_h-to_integer(unsigned(ho_b1))*10),4)); --updating integer value of LSB5
convert_hob2 : bin_hex port map(ho_b2,ho2); --conversion to hexadecimal

mo_b1 <= x"5" when count_m>=50 else  --updating integer value of LSB4
x"4" when count_m>=40 else
x"3" when count_m>=30 else
x"2" when count_m>=20 else
x"1" when count_m>=10 else
x"0";
convert_mob1 : bin_hex port map(mo_b1,mo1); --conversion to hexadecimal

mo_b2 <= std_logic_vector(to_unsigned((count_m-to_integer(unsigned(mo_b1))*10),4)); --updating integer value of LSB3
convert_mob2 : bin_hex port map(mo_b2,mo2); --conversion to hexadecimal
end Behavioral;
