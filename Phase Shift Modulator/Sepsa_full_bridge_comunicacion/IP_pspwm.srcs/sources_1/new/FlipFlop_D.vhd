----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2016 12:46:15
-- Design Name: 
-- Module Name: FlipFlop_D - Behavioral
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

entity FlipFlop_D is
    Port ( Clk : in STD_LOGIC;
           D : in STD_LOGIC;
           Q : out STD_LOGIC;
           nQ : out STD_LOGIC);
end FlipFlop_D;

architecture Behavioral of FlipFlop_D is
signal counter: std_logic_vector (1 downto 0):= "00";
begin
    Process (Clk)
        begin
            If rising_edge (Clk) then
                If counter < "01" then
                    counter <= counter + 1;
                    Q <= '1';
                    nQ <= '0';
                else 
                    Q <= '0';
                    nQ <= '1';
                    counter <= (others => '0');
                end if;
            end if;
          end process;
end Behavioral;
