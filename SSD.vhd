----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2021 01:57:37 PM
-- Design Name: 
-- Module Name: SSD - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SSD is
    Port ( clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           cifra : in STD_LOGIC_VECTOR (15 downto 0));
end SSD;

architecture Behavioral of SSD is

signal cnt:std_logic_vector(15 downto 0):=x"0000";
signal digit:std_logic_vector(3 downto 0):="0000";

begin

    -- numarator
    process(clk)
    begin
        if clk'event and clk='1' then
            cnt <= cnt + 1;
        end if;
    end process;

    -- MUX 4:1
    process(cnt(15 downto 14), cifra)
    begin
        case cnt(15 downto 14) is
            when "00" => an <="0111"; digit<=cifra(15 downto 12);
            when "01" => an<="1011"; digit<=cifra(11 downto 8);
            when "10" => an<="1101"; digit<=cifra(7 downto 4);
            when others => an<="1110"; digit<=cifra(3 downto 0);
        end case;
    end process;

    -- 7 SEG DCD 
    process(digit)
    begin
        case digit is 
            when "0000" => cat<= "1000000";  --0
            when "0001" => cat<= "1111001";  --1
            when "0010" => cat<= "0100100";  --2
            when "0011" => cat<= "0110000";  --3
            when "0100" => cat<= "0011001";  --4
            when "0101" => cat<= "0010010";  --5
            when "0110" => cat<= "0000010";  --6
            when "0111" => cat<= "1111000";  --7
            when "1000" => cat<= "0000000";  --8
            when "1001" => cat<= "0010000";  --9
            when "1010" => cat<= "0001000";  --A
            when "1011" => cat<= "0000011";  --b
            when "1100" => cat<= "1000110";  --C
            when "1101" => cat<= "0100001";  --d
            when "1110" => cat<= "0000110";  --E
            when "1111" => cat<= "0001110";  --F  
        end case;
    end process;

end Behavioral;
