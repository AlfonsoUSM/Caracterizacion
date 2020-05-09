@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Sun May 03 20:54:25 -0400 2020
REM SW Build 2552052 on Fri May 24 14:49:42 MDT 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim topmodule_behav -key {Behavioral:sim_1:Functional:topmodule} -tclbatch topmodule.tcl -view C:/Users/Alfonso/Documents/GitKraken/DigitalAvanzado/Tarea3_FPGA/proyecto_pipe/proyecto_pipe.sim/topmodule_behav.wcfg -log simulate.log"
call xsim  topmodule_behav -key {Behavioral:sim_1:Functional:topmodule} -tclbatch topmodule.tcl -view C:/Users/Alfonso/Documents/GitKraken/DigitalAvanzado/Tarea3_FPGA/proyecto_pipe/proyecto_pipe.sim/topmodule_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0