----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2021 02:12:35 PM
-- Design Name: 
-- Module Name: InstructionFetch - Behavioral
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

entity InstructionFetch is
    Port ( clk: in STD_LOGIC;   -- semnal de ceas pt PC
           rst : in STD_LOGIC;  -- pt a reseta registrul PC la valoarea 0
           en : in STD_LOGIC;   -- valideaza scrierea in PC
           BranchAddress : in STD_LOGIC_VECTOR(15 downto 0); -- adresa de branch
           JumpAddress : in STD_LOGIC_VECTOR(15 downto 0);   -- adresa de jump
           Jump : in STD_LOGIC;  -- semnal de control jump                        
           PCSrc : in STD_LOGIC; -- semnal de control pt branch
           Instruction : out STD_LOGIC_VECTOR(15 downto 0);  -- instructiunea de executat
           PCinc : out STD_LOGIC_VECTOR(15 downto 0));       -- adresa urmatoarei instructiuni
end InstructionFetch;

architecture Behavioral of InstructionFetch is

-- Memorie ROM
type tROM is array (0 to 19) of STD_LOGIC_VECTOR (15 downto 0);
signal ROM : tROM := (

--B"000_101_110_101_0_000",
--B"000_101_110_101_0_001",

--b"001_000_001_0000000",
--b"001_000_010_0000001",
--b"001_000_011_0000000",
--b"001_000_100_0000001",
--b"011_011_001_0000000",
--b"011_100_010_0000000",
--b"010_011_001_0000000",
--b"010_100_010_0000000",
--b"000_001_010_101_0_000",
--b"000_000_010_001_0_000",
--b"000_000_101_010_0_000",
--b"111_0000000001010",
--others=>X"0000");

B"001_000_001_0010000",        -- "2090"
B"000_000_000_011_0_000",      -- "0030"
B"001_000_100_0000001",	       -- "2201"
B"100_000_011_0001000",	       -- "8188"
B"100_100_011_0000111",	       -- "9187"	
B"100_001_011_0001000",	       -- "8588"	
B"000_000_011_101_0_000",	   -- "01D0"	
B"100_001_101_0000100",	       -- "8684"
B"110_001_101_0000011",	       -- "C683"
B"000_101_011_101_0_000",	   -- "15D0"
B"011_101_000_0000000",	       -- "7400"
B"111_0000000000111",	       -- "E007"
B"001_011_011_0000001",	       -- "2D81"
B"111_0000000000011",	       -- "E003"
B"000_000_000_011_0_000",      -- "0030"
B"100_001_011_0000011",	       -- "8583"
B"010_011_010_0000000",	       -- "4D00"
B"001_011_011_0000001",	       -- "2D81"
B"111_0000000001111",	       -- "E00F"
B"000_000_001_010_0_000",	   -- "00A0"
others=>X"0000");

signal PCD: STD_LOGIC_VECTOR(15 downto 0);
signal PCQ: STD_LOGIC_VECTOR(15 downto 0);
signal PCnumarator: STD_LOGIC_VECTOR(15 downto 0);
signal outmux1: STD_LOGIC_VECTOR(15 downto 0);

begin

    process(clk)
    begin
        if (rst = '1') then
            PCQ <= x"0000";
        end if;
        
        if rising_edge(clk) then
            if en = '1' then
                PCQ <= PCD;
            end if;
        end if;
    end process;

    outmux1 <= BranchAddress when PCSrc = '1' else PCnumarator;
    PCD <= JumpAddress when Jump = '1' else outmux1;
    PCnumarator <= PCQ + '1';
    PCinc <= PCnumarator;
    instruction <= ROM(conv_integer(PCQ));
    
end Behavioral;