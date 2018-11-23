----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.07.2017 17:53:27
-- Design Name: 
-- Module Name: codigo_ma_instantaneo - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Modulador_m_instant is
    Port ( Clk_inv : in STD_LOGIC;
           ma2 : in STD_LOGIC_VECTOR(10 DOWNTO 0);
           Fsw2: in STD_LOGIC_VECTOR(9 DOWNTO 0);
           ena: in std_logic;  
           refx : out STD_LOGIC;
           Pwm_A : out STD_LOGIC;
           NPwm_A: out STD_LOGIC;
           Pwm_B : out STD_LOGIC;
           NPwm_B: out STD_LOGIC;
           Pwm_C : out STD_LOGIC;
           NPwm_C: out STD_LOGIC);
end Modulador_m_instant;

architecture Behavioral of Modulador_m_instant is

file file_txt : text;
signal counter: integer:=0;
constant N_cortes: integer:=9;
constant Rows: integer:=54;

Type alpha IS ARRAY (1 to Rows,0 to N_cortes) OF INTEGER;


-- Ingresar Look up Table
signal alpha_a  : alpha;
--signal ena: std_logic:= '0';
signal Fsw: integer:=50;
signal ma: integer;
--signal i: integer:=1;
--signal j: integer:=1;
--signal k: integer:=N_cortes;
signal b: std_logic:= '1';
--signal sesenta: integer:= 41666667;
signal ciento_ochenta: integer:= 125000000;
--signal dos_cientos_cuarenta: integer:= 166666667;
signal tres_cientos_sesenta: integer:= 250000000;
signal ciento_veinte : integer := 83333333; 
--signal trescientos : integer := 208333333; 
signal noventa:integer:=62500000;
signal dos_cientos_setenta:integer:=187500000;
signal c: std_logic:= '1';
signal d: std_logic:= '0';
--signal x: integer:= 0;
signal ref2: std_logic:='1';
--signal PhaseA: integer;
--signal PhaseB: integer;
--signal PhaseC: integer;
--signal const2: integer:=13888;
--signal angulo: integer:=0;
--signal fila: integer:=1;
signal sal: integer:=0;
signal cuentas_max: integer:=0;
--signal xx: std_logic:='1';
--signal medio_periodo: integer;
--signal angulo_b: integer:=0;

signal m: integer:=230;
signal count: integer:=0;
signal count2: integer:=0;
TYPE vector_fase IS ARRAY (0 to 2) OF std_logic;
--signal  out_pwm : vector_fase;

--PROCEDURE inicio() IS
--        variable txt_line : line;
--        variable status   : file_open_status;
--        variable filas: integer:=1;
--        variable int      : integer;
--        variable separacion : character;
        
--     BEGIN
--        IF (sal =0) then
--             file_open(status,file_txt,"Tabla_SHE_60_9.txt",read_mode);
--                 assert status=open_ok 
--                 report "No se pudo abrir test.txt"
--                 severity failure;
--                 while not(endfile(file_txt)) loop --termina la sentencia cuando lee el ultimo valor de la linea
--                     readline(file_txt,txt_line);
--                     -- Acá extraemos lo que queremos de la línea
--                     for columna in 0 to N_cortes loop --recorrer los valores de las lineas 
--                         read(txt_line,int);
--                         alpha_a(filas,columna) <= int;
--                         read(txt_line,separacion);
--                     end loop;
--                     filas:= filas+1;      
--                 end loop; 
--             -- Cerramos el archivo
--             file_close(file_txt);
             
             
             
             
--             sal<=1;         
--         end if;
--     END PROCEDURE inicio;
--signal s: std_logic_vector (9 downto 0):="0000000000";



begin
 ma <= to_integer (unsigned(ma2));
 Fsw <= to_integer (unsigned(Fsw2));

alpha_a <= ( (100,7974776,8458822,16296311,16881622,24620940,25281988,32955906,33663790,41304801),
            (120,7902705,8483797,16221544,16924243,24544356,25338043,32879822,33729791,41232159),
            (140,7830505,8508708,16146530,16966717,24467495,25393968,32803521,33795759,41159418),
            (160,7758174,8533543,16071260,17009031,24390348,25449756,32726994,33861693,41086573),
            (180,7685707,8558290,15995727,17051172,24312905,25505398,32650233,33927592,41013619),
            (200,7613101,8582938,15919921,17093129,24235154,25560886,32573228,33993453,40940552),
            (220,7540351,8607475,15843834,17134885,24157085,25616210,32495968,34059275,40867366),
            (240,7467453,8631886,15767455,17176428,24078684,25671360,32418442,34125054,40794055),
            (260,7394403,8656158,15690775,17217742,23999939,25726325,32340639,34190789,40720613),
            (280,7321195,8680277,15613781,17258809,23920835,25781093,32262545,34256475,40647035),
            (300,7247825,8704227,15536463,17299612,23841357,25835651,32184147,34322110,40573312),
            (320,7174288,8727991,15458807,17340132,23761487,25889985,32105429,34387690,40499439),
            (340,7100579,8751552,15380800,17380348,23681209,25944081,32026376,34453209,40425408),
            (360,7026690,8774893,15302427,17420240,23600502,25997920,31946970,34518664,40351209),
            (380,6952617,8797993,15223673,17459784,23519346,26051486,31867193,34584049,40276835),
            (400,6878354,8820833,15144520,17498955,23437718,26104760,31787023,34649357,40202275),
            (420,6803893,8843390,15064952,17537725,23355594,26157718,31706438,34714582,40127519),
            (440,6729227,8865641,14984947,17576065,23272948,26210339,31625414,34779716,40052556),
            (460,6654348,8887561,14904486,17613944,23189750,26262596,31543924,34844750,39977373),
            (480,6579250,8909123,14823546,17651328,23105969,26314460,31461938,34909676,39901956),
            (500,6503922,8930299,14742102,17688179,23021570,26365902,31379426,34974481,39826292),
            (520,6428355,8951058,14660129,17724456,22936517,26416885,31296350,35039154,39750363),
            (540,6352541,8971367,14577598,17760114,22850768,26467371,31212673,35103682,39674150),
            (560,6276468,8991190,14494477,17795106,22764278,26517318,31128349,35168048,39597635),
            (580,6200124,9010488,14410732,17829376,22676998,26566679,31043332,35232234,39520795),
            (600,6123498,9029220,14326328,17862867,22588872,26615398,30957566,35296222,39443604),
            (620,6046576,9047340,14241223,17895513,22499840,26663417,30870991,35359987,39366034),
            (640,5969343,9064797,14155373,17927240,22409834,26710668,30783539,35423504,39288053),
            (660,5891784,9081538,14068729,17957969,22318779,26757073,30695133,35486743,39209625),
            (680,5813882,9097503,13981238,17987609,22226591,26802545,30605684,35549667,39130709),
            (700,5735616,9112626,13892839,18016059,22133175,26846984,30515094,35612236,39051256),
            (720,5656967,9126834,13803467,18043205,22038426,26890274,30423248,35674402,38971211),
            (740,5577911,9140047,13713048,18068918,21942221,26932284,30330013,35736109,38890511),
            (760,5498422,9152176,13621500,18093053,21844425,26972857,30235236,35797289,38809079),
            (780,5418471,9163119,13528728,18115441,21744881,27011813,30138738,35857862,38726827),
            (800,5338025,9172765,13434629,18135891,21643408,27048939,30040309,35917731,38643647),
            (820,5257048,9180984,13339082,18154181,21539799,27083980,29939699,35976779,38559410),
            (840,5175497,9187632,13241950,18170054,21433811,27116633,29836610,36034860,38473959),
            (860,5093323,9192543,13143076,18183206,21325161,27146529,29730680,36091793,38387100),
            (880,5010470,9195523,13042277,18193282,21213512,27173219,29621470,36147350,38298588),
            (900,4926871,9196348,12939336,18199855,21098464,27196148,29508437,36201236,38208113),
            (920,4842447,9194753,12833998,18202412,20979534,27214618,29390901,36253069,38115273),
            (940,4757101,9190423,12725957,18200329,20856132,27227742,29268001,36302337,38019532),
            (960,4670715,9182973,12614838,18192832,20727530,27234375,29138620,36348341,37920168),
            (980,4583143,9171932,12500173,18178948,20592807,27233002,29001292,36390100,37816167),
            (1000,4494193,9156704,12381372,18157429,20450785,27221581,28854035,36426182,37706064),
            (1020,4403614,9136514,12257658,18126634,20299908,27197271,28694106,36454414,37587644),
            (1040,4311058,9110322,12127977,18084328,20138055,27155998,28517567,36471307,37457369),
            (1060,4216021,9076655,11990824,18027339,19962207,27091650,28318525,36470853,37309182),
            (1080,4117717,9033281,11843890,17950859,19767775,26994520,28087634,36441673,37131662),
            (1100,4014776,8976438,11683242,17846861,19547060,26847831,27808761,36359017,36900074),
            (1120,3904329,8898485,11500786,17699335,19284614,26617957,27449598,36155936,36547796),
            (1140,3777263,8775819,11271146,17459932,18933380,26207804,26916713,35558578,35803522),
            (1160,3088293,7219125,9485755,14707826,16190492,22392075,23180809,30143793,30417279)  );


 -- cuentas_max <= 250000000/Fsw; --fclk/fsw


--Proceso para cargar la LUT
  
--  Process(ena,sal) 
--        variable txt_line : line;
--        variable status   : file_open_status;
--        variable filas: integer:=1;
--        variable int: integer:=0;
--        variable separacion : character;
--        --variable jjj:integer:=1;
--  begin
--   IF (sal =0) then
--        file_open(status,file_txt,"Tabla_SHE_60_9_v2.txt",read_mode);
--            assert status=open_ok 
--            report "No se pudo abrir test.txt"
--            severity failure;
--            while not(endfile(file_txt)) loop --termina la sentencia cuando lee el ultimo valor de la linea
--                readline(file_txt,txt_line);
--                -- Acá extraemos lo que queremos de la línea
--                for columna in 0 to N_cortes loop --recorrer los valores de las lineas 
--                    read(txt_line,int);
--                    alpha_a(filas,columna) <= int;
--                    read(txt_line,separacion);
--                end loop;
--                filas:= filas+1;      
--            end loop; 
--        -- Cerramos el archivo
--        file_close(file_txt);
        
        
        
        
--        sal<=1;         
--    end if;
-- end process;
        


 -- Programa de disparo de los angulos
 
Process (Clk_inv,ena)   
    variable fila: integer:=1;
    variable col: integer:=1;
    variable angulo: integer:=0;
    variable out_pwm: vector_fase;
    variable ref2: std_logic:='1';

    
    begin
    
    If rising_edge (Clk_inv) and ena = '1' then   
        cuentas_max <= 250000000/Fsw;   
         
         counter<= counter + 1;             -- cuentas del periodo FSW
         --RESETEO DE CONTADOR
         If counter+1 = cuentas_max then
             counter <= 0;
             count<=count+1;    
         end if;
         
         --TRIGGER
         If counter*Fsw >= ciento_ochenta then
             ref2:='0';
         else
             ref2:='1';               
         end if;           
        
--        --CAMBIO DE ma
--         If count=2 and counter*fsw >= ciento_ochenta then
--            m <= 820;    
--         end if;
         
--        --CAMBIO DE FRECUENCIA
--          If count=3 and counter*fsw = 0 then
--             Fsw <= 60;    
--          end if;                  
        
   
        --HALLAR LA FILA CORRESPONDIENTE AL INDICE DE MODULACION DE ENTRADA(ma)
        --      entrada externa m (registro?) que introduce cambios en el indice de modulacion
        --      variable interna para recorrer las filas de la matriz
        --      array_angulos -- array_angulos(filas: 0 to Rows-1)(columnas: 0 Ncortes-1 )    columna 0: indices de modulacion
        --      Rows    --número de filas del fichero            
       fila:=1;
       If ma < alpha_a(Rows,0) then   --comprobar que m es menor que el m_max de la tabla
            while (ma > alpha_a(fila,0)) loop    --si es menor que m_max encuentra la fila inmediatamente superior 
                if fila = Rows then 
                    exit;
                end if;     
                fila:=fila+1;            
            end loop;
            --redondear a la fila superior o inferior
            If fila > 1  and (ma - alpha_a(fila-1,0)) < (alpha_a(fila,0)-ma)  then       --ojo al fila > 0 : fila mayor que el número de la primera fila            
                fila:=fila-1;                     
            end if;                         
        else
            fila:=Rows;        
        end if; 
        
        
         
        
    for i in 0 to 2 loop
        
        --OBTENER CONTADORES     
        angulo:=counter*Fsw + ciento_veinte*i; --ojo!! FaseA i=0; Fase B i=2; FaseC i=1;
      
        if  angulo >= tres_cientos_sesenta then
            angulo := angulo - tres_cientos_sesenta;
        end if;        
  

        
        --MODULACIÓN:
        --          -Identificar tramo
        --          -Comparar con los valores de la tabla, en la fila del ma hallado
        --          -Dependiendo de que alfa sea el de referencia la salida toma a valor 1 o 0
        --              Alfa impar=> salida=1 *
        --              Alfa par=> salida=0 *
        --              *En el tramo de 180 a 360 es justo a la inversa   
                
        
        --Tramo 0-90
        col:=1;
        if angulo <= noventa then
            while angulo >= alpha_a(fila,col) loop
                col:=col+1;
                if col > N_cortes then 
                    exit; 
                end if;
            end loop;

            if (col REM 2)= 1 then  --obtener el resto de dividir entre 
                out_pwm(i):='1';
            else
                out_pwm(i):='0';
            end if;          
        end if;
        
        --Tramo 90-180
         col:=1;
         if angulo > noventa and angulo <= ciento_ochenta then
             while angulo < ciento_ochenta - alpha_a(fila,col) loop
                 col:=col+1;
                 if col > N_cortes then 
                     exit; 
                 end if;
             end loop;

            if (col REM 2)= 1 then  --obtener el resto de dividir entre 2
                out_pwm(i):='1';
            else
                out_pwm(i):='0';
            end if;
         end if;
         
        --Tramo 180-270
          col:=1;
          if angulo > ciento_ochenta and angulo <= dos_cientos_setenta then
              while angulo >= ciento_ochenta + alpha_a(fila,col) loop
                  col:=col+1;
                  if col > N_cortes then 
                      exit; 
                  end if;
              end loop;

              if (col REM 2)= 0 then  --obtener el resto de dividir entre 2
                  out_pwm(i):='1';
              else
                  out_pwm(i):='0';
              end if;
          end if;
           
         --Tramo 270-360
          col:=1;
          if angulo > dos_cientos_setenta and angulo <= tres_cientos_sesenta then
                while angulo < tres_cientos_sesenta - alpha_a(fila,col) loop
                    col:=col+1;
                    if col > N_cortes then 
                        exit; 
                    end if;
                end loop;

                if (col REM 2)= 0 then  --obtener el resto de dividir entre 2
                    out_pwm(i):='1';
                else
                    out_pwm(i):='0';
                end if; 
          end if;
    
    end loop; --fin del for que recorre las 3 fases
    
    b<=out_pwm(0);
    c<=out_pwm(2);
    d<=out_pwm(1);         
        
   
----------------------------------
    end if; --fin del rising edge

--Asignación de la variables a los puertos de salida
    if ena = '1' then 
        refx <= ref2;
        Pwm_A <= out_pwm(0);
        NPwm_A<= not out_pwm(0);
        Pwm_B <= out_pwm(2);
        NPwm_B<= not out_pwm(2);
        Pwm_C <= out_pwm(1);
        NPwm_C<= not out_pwm(1);
    else
            refx <= '0';
            Pwm_A <= '0';
            Pwm_B <= '0';
            Pwm_C <= '0';
    end if;     
end process;
  

end Behavioral;
