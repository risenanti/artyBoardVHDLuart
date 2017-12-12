set_property -dict { PACKAGE_PIN K22 IOSTANDARD  DIFF_SSTL12 } [get_ports {SYSCLK_300_P}] ;
#TODO Specify period
create_clock -period 3.333 -name clk_freerun [get_ports {SYSCLK_300_P}]

#G10
set_property -dict { PACKAGE_PIN G10 IOSTANDARD  LVCMOS33 } [get_ports {heartBeatLED}] ;


set_property -dict { PACKAGE_PIN D13 IOSTANDARD  LVCMOS33 } [get_ports {USB_UART_RX_FPGA_TX_LS}] ;