----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2017/09/21 20:57:40
-- Design Name: 
-- Module Name: ad9361_interface - Behavioral
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity ad9361_interface is
    Port (
        --    FPGA内部接口信号    --
        reset               : in std_logic;
        
        tx_frame_in         : in std_logic;
        tx_data_in_I        : in std_logic_vector(11 downto 0);
        tx_data_in_Q        : in std_logic_vector(11 downto 0);
        
        rx_clk_out          : out std_logic;
        rx_frame_out        : out std_logic;
        rx_data_out_I       : out std_logic_vector (11 downto 0);
        rx_data_out_Q       : out std_logic_vector (11 downto 0);
        
        ----    AD9361物理接口    -----
        rx_clk_in_p         : in std_logic;
        rx_clk_in_n         : in std_logic;
        rx_frame_in_p       : in std_logic;
        rx_frame_in_n       : in std_logic;
        rx_data_in_p        : in std_logic_vector (5 downto 0);
        rx_data_in_n        : in std_logic_vector (5 downto 0);
        
        tx_clk_out_p        : out std_logic;
        tx_clk_out_n        : out std_logic;
        tx_frame_out_p      : out std_logic;
        tx_frame_out_n      : out std_logic;
        tx_data_out_p       : out std_logic_vector (5 downto 0);
        tx_data_out_n       : out std_logic_vector (5 downto 0)
    );
end ad9361_interface;

architecture Behavioral of ad9361_interface is

signal clk_128M : std_logic;

component tx_interface
    port ( 
        reset : in std_logic;
        clk_in : in std_logic;
        
        tx_frame_in  : in std_logic;
        tx_data_in_I : in std_logic_vector(11 downto 0);
        tx_data_in_Q : in std_logic_vector(11 downto 0);
        
        tx_clk_out_p : out std_logic;
        tx_clk_out_n : out std_logic;
        tx_frame_out_p : out std_logic;
        tx_frame_out_n : out std_logic;
        tx_data_out_p : out std_logic_vector (5 downto 0);
        tx_data_out_n : out std_logic_vector (5 downto 0)
    );
end component;

component rx_interface
    Port ( 
        reset           : in std_logic;
        rx_clk_in_p     : in std_logic;
        rx_clk_in_n     : in std_logic;
        rx_frame_in_p   : in std_logic;
        rx_frame_in_n   : in std_logic;
        rx_data_in_p    : in std_logic_vector (5 downto 0);
        rx_data_in_n    : in std_logic_vector (5 downto 0);

        rx_clk_out      : out std_logic;
        rx_frame_out    : out std_logic;
        rx_data_out_I   : out std_logic_vector (11 downto 0);
        rx_data_out_Q   : out std_logic_vector (11 downto 0)
    );
end component;

begin

rx_clk_out <= clk_128M;

U1: tx_interface port map (

    reset           => reset,
    clk_in          => clk_128M,
    
    tx_frame_in     => tx_frame_in,
    tx_data_in_I    => tx_data_in_I,
    tx_data_in_Q    => tx_data_in_Q,
    
    tx_clk_out_p    => tx_clk_out_p,
    tx_clk_out_n    => tx_clk_out_n,
    tx_frame_out_p  => tx_frame_out_p,
    tx_frame_out_n  => tx_frame_out_n,
    tx_data_out_p   => tx_data_out_p,
    tx_data_out_n   => tx_data_out_n

);

U2: rx_interface port map (

    reset               => reset,
    rx_frame_in_p       => rx_frame_in_p,
    rx_frame_in_n       => rx_frame_in_n,
    rx_clk_in_p         => rx_clk_in_p,
    rx_clk_in_n         => rx_clk_in_n,
    rx_data_in_p        => rx_data_in_p,
    rx_data_in_n        => rx_data_in_n,

    rx_clk_out          => clk_128M,
    rx_frame_out        => rx_frame_out,
    rx_data_out_I       => rx_data_out_I,
    rx_data_out_Q       => rx_data_out_Q
);

end Behavioral;
