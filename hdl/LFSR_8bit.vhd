----------------------------------------------------------------------------------
-- Company: Technische Universität Hamburg
-- Engineer: Shashwat Samir Sanghavi
-- 
-- Create Date: 12.02.2020 13:56:23
-- Design Name: 
-- Module Name: LFSR_8bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: Vivado 2018.2
-- Description: 
-- 
-- Dependencies: None
-- 
-- Revision 1.0  - Script written
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

entity LFSR_8bit is
    Port ( clk_in : in STD_LOGIC;
           rstn_in : in STD_LOGIC;
           seed_in : in STD_LOGIC_VECTOR (7 downto 0);
           pn_out : out STD_LOGIC;
           random_vector : out STD_LOGIC_VECTOR(7 downto 0));
end LFSR_8bit;

architecture Behavioral of LFSR_8bit is

signal lfsr_register : std_logic_vector(8 downto 1);


begin
    process(clk_in)
    begin
        if(rising_edge(clk_in))then
            if(rstn_in='0')then
                if(seed_in/=x"00")then
                    lfsr_register <= seed_in;
                else
                    lfsr_register <= x"A4";
                end if;
            else
                if(lfsr_register/=x"00")then
                    pn_out <= lfsr_register(8);
                    lfsr_register(8) <= lfsr_register(7);
                    lfsr_register(7) <= lfsr_register(6);
                    lfsr_register(6) <= lfsr_register(5);
                    lfsr_register(5) <= lfsr_register(4);
                    lfsr_register(4) <= lfsr_register(3);
                    lfsr_register(3) <= lfsr_register(2);
                    lfsr_register(2) <= lfsr_register(1);
                    lfsr_register(1) <= lfsr_register(4) xor lfsr_register(8) xor lfsr_register(3) xor lfsr_register(6);
                else
                    lfsr_register <= x"A4";
                end if;
            end if;
        end if;
    end process;

    random_vector <= lfsr_register(8 downto 1);
end Behavioral;
