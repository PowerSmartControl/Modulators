----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2016 13:03:07
-- Design Name: 
-- Module Name: Clk_pwm - Behavioral
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

entity Clk_pwm is
    Port ( Clk_150Mhz : in STD_LOGIC;
           Ciclo: in std_logic_vector (31 downto 0);
           frecuencia: in std_logic_vector (31 downto 0);
           Clk_fs : out STD_LOGIC;
           Pwm_ref : out STD_LOGIC;
           reset1: out STD_LOGIC);
end Clk_pwm;

architecture Behavioral of Clk_pwm is
    signal counter: std_logic_vector (31 downto 0):= "00000000000000000000000000000000";
    signal counter2: std_logic_vector (3 downto 0):= "0000";
    signal clk_d: std_logic;
    signal pwmref: std_logic;
    signal pre_reset: std_logic := '0';
begin
Clk_fs <= clk_d;
Pwm_ref <= pwmref;

 Process (Clk_150Mhz)
    begin
    If rising_edge (Clk_150Mhz) then
            
        If counter < frecuencia then -- Frequency of desired clock (clk_fpga/clk_desired)/2
            counter <= counter + 1;
            counter2 <= counter2 + 1; 
        else
             Clk_d <= not Clk_d;
            counter <= (others => '0');
            pre_reset <= '1';
        end if;
        
        if pre_reset = '1' then  --sentencia de reset que solo funciona una vez en el encendido
            reset1 <= '0';
            else
            reset1 <= '1';
        end if;
        
        If counter2 >"1110" then
        clk_d <= '0';
        counter2 <= (others => '0');
        end if;
        
        If counter < ciclo then   -- This counter sets the duty cycle
            pwmref <= '1';
        else 
            pwmref <= '0'; 
        end if;
    end if;
 End process;
 
 end Behavioral;