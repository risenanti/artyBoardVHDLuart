-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.1 (lin64) Build 1846317 Fri Apr 14 18:54:47 MDT 2017
-- Date        : Tue Dec 12 11:11:54 2017
-- Host        : keith-OptiPlex-790 running 64-bit Ubuntu 16.04.3 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/keith/xilProjects/kintechUart/kintechUart.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_sim_netlist.vhdl
-- Design      : clk_wiz_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku5p-ffvb676-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_wiz_0_clk_wiz_0_clk_wiz is
  port (
    clk_out1 : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of clk_wiz_0_clk_wiz_0_clk_wiz : entity is "clk_wiz_0_clk_wiz";
end clk_wiz_0_clk_wiz_0_clk_wiz;

architecture STRUCTURE of clk_wiz_0_clk_wiz_0_clk_wiz is
  signal clk_in1_clk_wiz_0 : STD_LOGIC;
  signal clk_out1_clk_wiz_0 : STD_LOGIC;
  signal NLW_plle3_adv_inst_CLKFBIN_UNCONNECTED : STD_LOGIC;
  signal NLW_plle3_adv_inst_CLKFBOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_plle3_adv_inst_CLKOUT0B_UNCONNECTED : STD_LOGIC;
  signal NLW_plle3_adv_inst_CLKOUT1_UNCONNECTED : STD_LOGIC;
  signal NLW_plle3_adv_inst_CLKOUT1B_UNCONNECTED : STD_LOGIC;
  signal NLW_plle3_adv_inst_CLKOUTPHY_UNCONNECTED : STD_LOGIC;
  signal NLW_plle3_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_plle3_adv_inst_LOCKED_UNCONNECTED : STD_LOGIC;
  signal NLW_plle3_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of clkin1_bufg : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of clkin1_bufg : label is "BUFG";
  attribute BOX_TYPE of clkout1_buf : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of clkout1_buf : label is "BUFG";
  attribute BOX_TYPE of plle3_adv_inst : label is "PRIMITIVE";
begin
clkin1_bufg: unisim.vcomponents.BUFGCE
    generic map(
      CE_TYPE => "ASYNC"
    )
        port map (
      CE => '1',
      I => clk_in1,
      O => clk_in1_clk_wiz_0
    );
clkout1_buf: unisim.vcomponents.BUFGCE
    generic map(
      CE_TYPE => "ASYNC"
    )
        port map (
      CE => '1',
      I => clk_out1_clk_wiz_0,
      O => clk_out1
    );
plle3_adv_inst: unisim.vcomponents.PLLE4_ADV
    generic map(
      CLKFBOUT_MULT => 5,
      CLKFBOUT_PHASE => 0.000000,
      CLKIN_PERIOD => 3.333000,
      CLKOUT0_DIVIDE => 75,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT1_DIVIDE => 1,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUTPHY_MODE => "VCO_2X",
      COMPENSATION => "INTERNAL",
      DIVCLK_DIVIDE => 2,
      IS_CLKFBIN_INVERTED => '0',
      IS_CLKIN_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER => 0.010000,
      STARTUP_WAIT => "FALSE"
    )
        port map (
      CLKFBIN => NLW_plle3_adv_inst_CLKFBIN_UNCONNECTED,
      CLKFBOUT => NLW_plle3_adv_inst_CLKFBOUT_UNCONNECTED,
      CLKIN => clk_in1_clk_wiz_0,
      CLKOUT0 => clk_out1_clk_wiz_0,
      CLKOUT0B => NLW_plle3_adv_inst_CLKOUT0B_UNCONNECTED,
      CLKOUT1 => NLW_plle3_adv_inst_CLKOUT1_UNCONNECTED,
      CLKOUT1B => NLW_plle3_adv_inst_CLKOUT1B_UNCONNECTED,
      CLKOUTPHY => NLW_plle3_adv_inst_CLKOUTPHY_UNCONNECTED,
      CLKOUTPHYEN => '0',
      DADDR(6 downto 0) => B"0000000",
      DCLK => '0',
      DEN => '0',
      DI(15 downto 0) => B"0000000000000000",
      DO(15 downto 0) => NLW_plle3_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_plle3_adv_inst_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => NLW_plle3_adv_inst_LOCKED_UNCONNECTED,
      PWRDWN => '0',
      RST => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_wiz_0 is
  port (
    clk_out1 : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of clk_wiz_0 : entity is true;
end clk_wiz_0;

architecture STRUCTURE of clk_wiz_0 is
begin
inst: entity work.clk_wiz_0_clk_wiz_0_clk_wiz
     port map (
      clk_in1 => clk_in1,
      clk_out1 => clk_out1
    );
end STRUCTURE;
