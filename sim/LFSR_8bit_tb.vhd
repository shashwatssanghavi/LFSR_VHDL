----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2020 14:18:15
-- Design Name: 
-- Module Name: LFSR_8bit_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LFSR_8bit_tb is
--  Port ( );
end LFSR_8bit_tb;

architecture Behavioral of LFSR_8bit_tb is
component LFSR_8bit is
    Port ( clk_in : in STD_LOGIC;
           rstn_in : in STD_LOGIC;
           seed_in : in STD_LOGIC_VECTOR (7 downto 0);
           pn_out : out STD_LOGIC;
           random_vector : out STD_LOGIC_VECTOR(7 downto 0));
end component;

signal clk_in : std_logic:='0';
signal rstn_in : std_logic;
signal seed_in : std_logic_vector(7 downto 0):=x"10";
signal pn_out : std_logic;
signal random_vector : std_logic_vector(7 downto 0);


signal half_period : time := 5ns;
signal clk_cycle : time := 2*half_period;


signal out_acc : std_logic_vector(63 downto 0):=(others=>'0');


begin
clk_in <= not clk_in after half_period;

process
begin
    
    rstn_in <= '1';
    wait for 10ns;
    
    rstn_in <= '0';
    seed_in <= x"A4";
    wait for 10ns;
    
    rstn_in <= '1';
    seed_in <= x"A4";
    wait;
    
end process;

uut : LFSR_8bit
port map(
        clk_in => clk_in,
        rstn_in => rstn_in,
        seed_in => seed_in,
        pn_out => pn_out,
        random_vector => random_vector
);
end Behavioral;
