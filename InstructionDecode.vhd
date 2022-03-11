----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2021 02:56:34 PM
-- Design Name: 
-- Module Name: InstructionDecode - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstructionDecode is
    Port ( clk: in STD_LOGIC;    -- folosit pt scrierea in RF
           en : in STD_LOGIC;    
           Instr : in STD_LOGIC_VECTOR(12 downto 0);
           WD : in STD_LOGIC_VECTOR(15 downto 0);
           RegWrite : in STD_LOGIC;   -- validarea scrierii in RF
           RegDst : in STD_LOGIC;     -- selecteaza adresa de scriere in RF
           ExtOp : in STD_LOGIC;      -- selecteaza tipul extensiei pt campul imm(cu zero sau cu semn)
           RD1 : out STD_LOGIC_VECTOR(15 downto 0);     -- valoarea registrului de la adresa rs
           RD2 : out STD_LOGIC_VECTOR(15 downto 0);     -- valoarea registrului de la adresa rt
           Ext_Imm : out STD_LOGIC_VECTOR(15 downto 0); -- imediatul extins la 16 biti
           func : out STD_LOGIC_VECTOR(2 downto 0);
           sa : out STD_LOGIC);
end InstructionDecode;

architecture Behavioral of InstructionDecode is

signal WriteAddress: STD_LOGIC_VECTOR(2 downto 0);
signal RegAddress: STD_LOGIC_VECTOR(2 downto 0);
signal ExtUnit: STD_LOGIC_VECTOR(15 downto 0);
signal mux_out: STD_LOGIC_VECTOR(2 downto 0);

component RegisterFile is
    Port ( clk :in std_logic;
           regWrite: in std_logic;
           enable: in std_logic;
           ra1: in std_logic_vector(2 downto 0);
           ra2: in std_logic_vector(2 downto 0);
           wa :in std_logic_vector(2 downto 0);
           wd :in std_logic_vector(15 downto 0);
           rd1: out std_logic_vector(15 downto 0);
           rd2: out std_logic_vector(15 downto 0));
end component;

begin

    REG: RegisterFile port map(clk, RegWrite, en, Instr(12 downto 10), Instr(9 downto 7), mux_out, WD, RD1, RD2);
    
    -- IMMEDIATE EXTENDED
    mux_out <= Instr(6 downto 4) when RegDst = '1' else Instr(9 downto 7);
    ExtUnit<= "000000000" & instr(6 downto 0);
    Ext_Imm <= ExtUnit;
    
    sa <= Instr(3);
    func <= Instr(2 downto 0);

end Behavioral;
