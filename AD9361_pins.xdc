# AD9361 constraints
# RX port
set_property -dict {PACKAGE_PIN M6 IOSTANDARD LVDS DIFF_TERM 1} [get_ports rx_clk_in_p]
set_property -dict {PACKAGE_PIN M5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports rx_clk_in_n]
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports rx_frame_in_p]
set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports rx_frame_in_n]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_p[0]}]
set_property -dict {PACKAGE_PIN L2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_n[0]}]
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_p[1]}]
set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_n[1]}]
set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_p[2]}]
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_n[2]}]
set_property -dict {PACKAGE_PIN M7 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_p[3]}]
set_property -dict {PACKAGE_PIN L7 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_n[3]}]
set_property -dict {PACKAGE_PIN K5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_p[4]}]
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_n[4]}]
set_property -dict {PACKAGE_PIN M8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_p[5]}]
set_property -dict {PACKAGE_PIN L8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {rx_data_in_n[5]}]

# TX port
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports tx_clk_out_p]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports tx_clk_out_n]
set_property -dict {PACKAGE_PIN L5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports tx_frame_out_p]
set_property -dict {PACKAGE_PIN L4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports tx_frame_out_n]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_p[0]}]
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_n[0]}]
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_p[1]}]
set_property -dict {PACKAGE_PIN D3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_n[1]}]
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_p[2]}]
set_property -dict {PACKAGE_PIN F2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_n[2]}]
set_property -dict {PACKAGE_PIN D1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_p[3]}]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_n[3]}]
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_p[4]}]
set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_n[4]}]
set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_p[5]}]
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {tx_data_out_n[5]}]

# AD9361 GPIO
set_property -dict {PACKAGE_PIN K2  IOSTANDARD LVCMOS18} [get_ports {gpio_status[0]}]
set_property -dict {PACKAGE_PIN K1  IOSTANDARD LVCMOS18} [get_ports {gpio_status[1]}]
set_property -dict {PACKAGE_PIN H2  IOSTANDARD LVCMOS18} [get_ports {gpio_status[2]}]
set_property -dict {PACKAGE_PIN G1  IOSTANDARD LVCMOS18} [get_ports {gpio_status[3]}]
set_property -dict {PACKAGE_PIN L3  IOSTANDARD LVCMOS18} [get_ports {gpio_status[4]}]
set_property -dict {PACKAGE_PIN K3  IOSTANDARD LVCMOS18} [get_ports {gpio_status[5]}]
set_property -dict {PACKAGE_PIN K6  IOSTANDARD LVCMOS18} [get_ports {gpio_status[6]}]
set_property -dict {PACKAGE_PIN J6  IOSTANDARD LVCMOS18} [get_ports {gpio_status[7]}]

set_property -dict {PACKAGE_PIN J1  IOSTANDARD LVCMOS18} [get_ports {gpio_ctl[0]}]
set_property -dict {PACKAGE_PIN H1  IOSTANDARD LVCMOS18} [get_ports {gpio_ctl[1]}]
set_property -dict {PACKAGE_PIN H4  IOSTANDARD LVCMOS18} [get_ports {gpio_ctl[2]}]
set_property -dict {PACKAGE_PIN H3  IOSTANDARD LVCMOS18} [get_ports {gpio_ctl[3]}]
set_property -dict {PACKAGE_PIN N7  IOSTANDARD LVCMOS18} [get_ports gpio_en_agc]
set_property -dict {PACKAGE_PIN G9  IOSTANDARD LVCMOS18} [get_ports gpio_resetb]
set_property -dict {PACKAGE_PIN N6  IOSTANDARD LVCMOS18} [get_ports enable]
set_property -dict {PACKAGE_PIN K8  IOSTANDARD LVCMOS18} [get_ports txnrx]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS18} [get_ports gpio_sync]

# AD9361 SPI Config
set_property -dict {PACKAGE_PIN G6  IOSTANDARD LVCMOS18} [get_ports spi_csn]
set_property PULLUP true [get_ports spi_csn]
set_property -dict {PACKAGE_PIN J11 IOSTANDARD LVCMOS18} [get_ports spi_clk]
set_property -dict {PACKAGE_PIN H11 IOSTANDARD LVCMOS18} [get_ports spi_mosi]
set_property -dict {PACKAGE_PIN G5  IOSTANDARD LVCMOS18} [get_ports spi_miso]