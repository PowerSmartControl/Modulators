----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2016 08:26:55
-- Design Name: 
-- Module Name: Alto_nivel - Behavioral
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

entity Alto_nivel is
    Port ( Clk_fpga : in STD_LOGIC;
           ciclo_trabajo: in std_logic_vector (31 downto 0);
           frecuencia_conmutacion: in std_logic_vector (31 downto 0);
           deadtime1: in std_logic_vector (31 downto 0);
           deadtime2: in std_logic_vector (31 downto 0);
           Pwm1 : out STD_LOGIC;
           Pwm2 : out STD_LOGIC;
           Pwm3 : out STD_LOGIC;
           Pwm4 : out STD_LOGIC;
           reset: out STD_LOGIC);
end Alto_nivel;

architecture Behavioral of Alto_nivel is

Component Clk_pwm is
     Port ( Clk_150Mhz : in STD_LOGIC;
           Ciclo: in std_logic_vector (31 downto 0);
           frecuencia: in std_logic_vector (31 downto 0);
           Clk_fs : out STD_LOGIC;
           Pwm_ref : out STD_LOGIC;
           reset1: out STD_LOGIC);
end component;

Component FlipFlop_D is
     Port ( Clk : in STD_LOGIC;
           D : in STD_LOGIC;
           Q : out STD_LOGIC;
           nQ : out STD_LOGIC);
end component;

Component Pwm_deadtime is
     Port ( Clk_150Mhz : in STD_LOGIC;
            Pwm_1 : in STD_LOGIC;
            Pwm_2 : in STD_LOGIC;
            clk_fs2: in STD_LOGIC;
            Ciclo2: in std_logic_vector (31 downto 0);
            frecuencia2: in std_logic_vector (31 downto 0);
            deadtime3: in std_logic_vector (31 downto 0);
            deadtime4: in std_logic_vector (31 downto 0);
            Pwm_deadtime1 : out STD_LOGIC;
            Pwm_deadtime2 : out STD_LOGIC;
            Pwm_deadtime3 : out STD_LOGIC;
            Pwm_deadtime4 : out STD_LOGIC);
end component;

signal x: std_logic;
signal y: std_logic;
signal a: std_logic;
signal b: std_logic;
signal c: std_logic;
signal d: std_logic;
signal f: std_logic;
--signal ciclo_trabajo: std_logic_vector (27 downto 0):="0000000000000000010100100000"; -- ciclo de trabajo entre 0 y 1 (d=0.42)
--signal frecuencia_conmutacion: std_logic_vector (27 downto 0):= "0000000000000000110000110101"; -- (125000000/clk_deseada)/2 (20000 Hz)
--signal deadtime1: std_logic_vector (27 downto 0):= "0000000000000000000000110101"; -- tiempo muerto de 424 ns
--signal deadtime2: std_logic_vector (27 downto 0):= "0000000000000000000000110101"; -- tiempo muerto de 424 ns

--datos a ingresar
--signal Fs: integer:= 20000; -- Frecuencia de conmutación en Hz
--signal p: integer := 504; -- tiempo muerto en nanosegundos entre Pwm1 y Pwm2 
--signal n: integer := 504; -- tiempo muerto en nanosegundos entre Pwm3 y Pwm4 
--signal l: integer:= 38; -- ciclo de trabajo en porcentaje

--signal k: integer;
--signal frecuencia_conmutacion: std_logic_vector (27 downto 0);
--signal m: integer;
--signal ciclo_trabajo: std_logic_vector (27 downto 0);
--signal o: integer;
--signal deadtime1: std_logic_vector (27 downto 0);
--signal r: integer;
--signal deadtime2: std_logic_vector (27 downto 0);

begin
d <= b xor '0';
f <= b xor y;
--k <= (125000000/(2*Fs));
--m <= (k*l)/100;
--o <= n/8;
--r <= p/8; 
--frecuencia_conmutacion <=conv_std_logic_vector(k,28);
--ciclo_trabajo <= conv_std_logic_vector(m,28);
--deadtime1 <= conv_std_logic_vector(o,28);
--deadtime2 <= conv_std_logic_vector(r,28);

    Inst_Clk_pwm: Clk_pwm PORT MAP (
        Clk_150Mhz => Clk_fpga,
        Ciclo => ciclo_trabajo,
        frecuencia => frecuencia_conmutacion, 
        Clk_fs => x,
        Pwm_ref => y,
        reset1 => reset
    );
    Inst_FlipFlop_D: FlipFlop_D PORT MAP (
            Clk => y,
            nQ => b,
            D => c,
            Q => a   
        );

    Inst_Pwm_deadtime: Pwm_deadtime PORT MAP (
            Clk_150Mhz => Clk_fpga,
            Pwm_1 => d,
            Pwm_2 => f,
            clk_fs2 => x,
            Ciclo2 => ciclo_trabajo,
            frecuencia2 => frecuencia_conmutacion,
            deadtime3 => deadtime1,
            deadtime4 => deadtime2,
            Pwm_deadtime1 => Pwm1,
            Pwm_deadtime2 => Pwm2,
            Pwm_deadtime3 => Pwm3,
            Pwm_deadtime4 => Pwm4    
        );

end Behavioral;