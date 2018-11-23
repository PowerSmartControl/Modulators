----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2016 15:36:03
-- Design Name: 
-- Module Name: Pwm_deadtime - Behavioral
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

entity Pwm_deadtime is
    Port ( Clk_150Mhz : in STD_LOGIC;
           Pwm_1 : in STD_LOGIC;
           Pwm_2 : in STD_LOGIC;
           clk_fs2 : in STD_LOGIC;
           Ciclo2: in std_logic_vector (31 downto 0);
           frecuencia2: in std_logic_vector (31 downto 0);
           deadtime3: in std_logic_vector (31 downto 0);
           deadtime4: in std_logic_vector (31 downto 0);
           Pwm_deadtime1 : out STD_LOGIC;
           Pwm_deadtime2 : out STD_LOGIC;
           Pwm_deadtime3 : out STD_LOGIC;
           Pwm_deadtime4 : out STD_LOGIC);
end Pwm_deadtime;

architecture Behavioral of Pwm_deadtime is
signal counter3: std_logic_vector (31 downto 0):= "00000000000000000000000000000000"; --valor inicial contador

signal a: std_logic := '1';
signal b: std_logic := '1';
signal j: std_logic;
signal v: std_logic;
begin
    Process (Clk_150Mhz)
    variable counter4: std_logic_vector (31 downto 0):= "00000000000000000000000000000000"; --valor inicial contador
    begin
    
    If rising_edge (Clk_150Mhz) then
        counter4 := counter4 + 1;
       
        If counter3 < frecuencia2 then -- frecuencia del clock deseada (clk_fpga/clk_deseada)/2
                counter3 <= counter3 + 1;
                
                
            else
                counter3 <= (others => '0');
                
            end if;
        If counter3 < deadtime3 then -- tiempo muerto de 300ns
            a <= '1';
         else
            a <= '0';   
         end if;
         
         If counter3 = Ciclo2 -1 then
            counter4 := (others => '0');
         end if;
         
--          If counter3 >= Ciclo2 then -- ciclo de trabajo
--                   counter4 := counter4 + 1;
                   If counter4 < deadtime4 then -- tiempo muerto
                        b <= '1';
                    else
                        b <='0';   
                    end if;
--               else 
--                        counter4 := (others => '0');
-- end if;

  end if;
  
end process;

Pwm_deadtime1 <= (a xor pwm_1)and pwm_1;
Pwm_deadtime2 <= (a xor not pwm_1)and not pwm_1;
Pwm_deadtime3 <= (b xor pwm_2)and pwm_2;
Pwm_deadtime4 <= (b xor not pwm_2)and not pwm_2;



end Behavioral;