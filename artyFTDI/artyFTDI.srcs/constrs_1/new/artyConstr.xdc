set_property -dict { PACKAGE_PIN E3 IOSTANDARD  LVCMOS33 } [get_ports {clk100MHZ}] ;
#TODO Specify period
create_clock -period 10.00 -waveform {0 5} [get_ports {clk100MHZ}]


set_property -dict { PACKAGE_PIN H5 IOSTANDARD LVCMOS33 } [get_ports {led}];

set_property -dict { PACKAGE_PIN D10 IOSTANDARD LVCMOS33 } [get_ports { usbTXOut }];
