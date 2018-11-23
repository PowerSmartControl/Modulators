-- (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:user:Modulador_m_instant:1.0
-- IP Revision: 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY design_1_Modulador_m_instant_0_1 IS
  PORT (
    Clk_inv : IN STD_LOGIC;
    ma2 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    Fsw2 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    ena : IN STD_LOGIC;
    refx : OUT STD_LOGIC;
    Pwm_A : OUT STD_LOGIC;
    NPwm_A : OUT STD_LOGIC;
    Pwm_B : OUT STD_LOGIC;
    NPwm_B : OUT STD_LOGIC;
    Pwm_C : OUT STD_LOGIC;
    NPwm_C : OUT STD_LOGIC
  );
END design_1_Modulador_m_instant_0_1;

ARCHITECTURE design_1_Modulador_m_instant_0_1_arch OF design_1_Modulador_m_instant_0_1 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF design_1_Modulador_m_instant_0_1_arch: ARCHITECTURE IS "yes";
  COMPONENT Modulador_m_instant IS
    PORT (
      Clk_inv : IN STD_LOGIC;
      ma2 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      Fsw2 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      ena : IN STD_LOGIC;
      refx : OUT STD_LOGIC;
      Pwm_A : OUT STD_LOGIC;
      NPwm_A : OUT STD_LOGIC;
      Pwm_B : OUT STD_LOGIC;
      NPwm_B : OUT STD_LOGIC;
      Pwm_C : OUT STD_LOGIC;
      NPwm_C : OUT STD_LOGIC
    );
  END COMPONENT Modulador_m_instant;
BEGIN
  U0 : Modulador_m_instant
    PORT MAP (
      Clk_inv => Clk_inv,
      ma2 => ma2,
      Fsw2 => Fsw2,
      ena => ena,
      refx => refx,
      Pwm_A => Pwm_A,
      NPwm_A => NPwm_A,
      Pwm_B => Pwm_B,
      NPwm_B => NPwm_B,
      Pwm_C => Pwm_C,
      NPwm_C => NPwm_C
    );
END design_1_Modulador_m_instant_0_1_arch;
