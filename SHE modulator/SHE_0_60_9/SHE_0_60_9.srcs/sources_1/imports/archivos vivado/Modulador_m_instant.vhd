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

alpha_a <= ( 
        (100,298369,8133549,8615666,16399238,25342947,32986738,33692149,41306063,58649109),
        (120,359510,8095050,8673293,16346057,25411291,32917299,33763688,41233985,58712360),
        (140,421113,8057052,8731284,16292992,25479553,32847817,33835157,41161916,58775638),
        (160,483168,8019562,8789629,16240052,25547734,32778290,33906557,41089853,58838940),
        (180,545665,7982588,8848320,16187241,25615833,32708718,33977890,41017794,58902266),
        (200,608597,7946138,8907351,16134569,25683849,32639097,34049156,40945735,58965613),
        (220,671954,7910218,8966715,16082041,25751781,32569427,34120356,40873676,59028980),
        (240,735730,7874837,9026407,16029666,25819629,32499705,34191492,40801612,59092364),
        (260,799918,7840004,9086422,15977452,25887390,32429929,34262563,40729541,59155764),
        (280,864512,7805726,9146755,15925406,25955064,32360095,34333571,40657461,59219179),
        (300,929507,7772012,9207405,15873537,26022647,32290202,34404516,40585368,59282607),
        (320,994896,7738870,9268367,15821855,26090140,32220245,34475397,40513259,59346047),
        (340,1060677,7706311,9329641,15770368,26157537,32150222,34546215,40441131,59409497),
        (360,1126845,7674342,9391224,15719087,26224838,32080128,34616969,40368982,59472956),
        (380,1193398,7642973,9453118,15668021,26292038,32009960,34687658,40296806,59536422),
        (400,1260331,7612215,9515321,15617181,26359135,31939713,34758282,40224601,59599895),
        (420,1327644,7582075,9577837,15566578,26426122,31869381,34828839,40152363,59663372),
        (440,1395335,7552566,9640666,15516224,26492997,31798960,34899328,40080086,59726854),
        (460,1463402,7523696,9703812,15466132,26559753,31728442,34969747,40007767,59790338),
        (480,1531845,7495475,9767278,15416315,26626385,31657822,35040093,39935401,59853824),
        (500,1600665,7467916,9831071,15366788,26692886,31587091,35110363,39862982,59917310),
        (520,1669860,7441027,9895195,15317564,26759248,31516241,35180555,39790503,59980795),
        (540,1739434,7414821,9959657,15268660,26825462,31445264,35250664,39717959,60044278),
        (560,1809387,7389309,10024467,15220094,26891519,31374147,35320685,39645342,60107759),
        (580,1879721,7364501,10089634,15171882,26957407,31302880,35390613,39572644,60171236),
        (600,1950439,7340410,10155168,15124046,27023114,31231449,35460442,39499857,60234707),
        (620,2021545,7317048,10221082,15076605,27088625,31159839,35530163,39426969,60298173),
        (640,2093043,7294427,10287390,15029583,27153924,31088033,35599768,39353969,60361632),
        (660,2164936,7272559,10354108,14983004,27218992,31016011,35669246,39280844,60425083),
        (680,2237231,7251457,10421254,14936894,27283806,30943751,35738585,39207579,60488526),
        (700,2309934,7231134,10488848,14891282,27348341,30871227,35807769,39134156,60551959),
        (720,2383051,7211604,10556913,14846199,27412568,30798409,35876780,39060555,60615381),
        (740,2456589,7192880,10625474,14801680,27476453,30725262,35945598,38986752,60678792),
        (760,2530557,7174977,10694559,14757762,27539953,30651745,36014196,38912719,60742191),
        (780,2604964,7157909,10764201,14714486,27603021,30577809,36082543,38838421,60805577),
        (800,2679821,7141692,10834436,14671897,27665598,30503397,36150600,38763818,60868950),
        (820,2755138,7126340,10905305,14630045,27727616,30428439,36218321,38688859,60932308),
        (840,2830927,7111871,10976853,14588987,27788990,30352851,36285646,38613482,60995652),
        (860,2907203,7098301,11049132,14548783,27849615,30276529,36352500,38537609,61058981),
        (880,2983980,7085647,11122203,14509504,27909364,30199345,36418786,38461140,61122294),
        (900,3061274,7073930,11196132,14471228,27968074,30121140,36484379,38383947,61185593),
        (920,3139105,7063168,11270997,14434044,28025540,30041709,36549112,38305861,61248876),
        (940,3217492,7053385,11346889,14398053,28081496,29960788,36612761,38226651,61312145),
        (960,3296460,7044602,11423911,14363371,28135593,29878030,36675010,38146002,61375401),
        (980,3376035,7036848,11502186,14330132,28187359,29792968,36735413,38063459,61438645),
        (1000,3456249,7030155,11581859,14298496,28236148,29704961,36793302,37978353,61501881),
        (1020,3537142,7024560,11663108,14268651,28281041,29613099,36847645,37889646,61565114),
        (1040,3618766,7020116,11746148,14240826,28320695,29516048,36896748,37795639,61628352),
        (1060,3701191,7016893,11831258,14215309,28353049,29411763,36937623,37693342,61691606),
        (1080,3784526,7015006,11918815,14192480,28374770,29296934,36964452,37576934,61754901),
        (1100,3868965,7014666,12009378,14172890,28380031,29165761,36964137,37433336,61818280),
        (1120,3954949,7016364,12103962,14157491,28357338,29006768,36899548,37225506,61881845),
        (1140,4044055,7021900,12205471,14148874,28277037,28790056,36605303,36788702,61945961),
        (1160,4205136,7122439,12465446,14285272,26249321,26502832,30647396,30850632,62042540) );


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
