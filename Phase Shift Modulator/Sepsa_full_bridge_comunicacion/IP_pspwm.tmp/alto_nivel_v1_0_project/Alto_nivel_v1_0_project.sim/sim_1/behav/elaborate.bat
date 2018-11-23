@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto aaa14a8c59e142d0b35fc3573fd1e5eb -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Alto_nivel_behav xil_defaultlib.Alto_nivel -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
