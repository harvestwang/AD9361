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
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity rx_interface is
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
end rx_interface;

architecture Behavioral of rx_interface is

signal rx_dout_ibufds : std_logic_vector(5 downto 0);
signal rx_data_I : std_logic_vector(5 downto 0);
signal rx_data_Q : std_logic_vector(5 downto 0);


signal rx_frame_inbufds : std_logic;
signal rx_frame_I : std_logic;
signal rx_frame_Q : std_logic;

signal clk_out : std_logic;
signal rx_clk_in : std_logic;

signal rx_frame_out_I : std_logic;
signal rx_frame_out_Q : std_logic;

signal rx_data_out_I_debug : std_logic_vector(11 downto 0);
signal rx_data_out_Q_debug : std_logic_vector(11 downto 0);


component jointer
    port(
        clk : in STD_LOGIC;
        reset : in std_logic;
        
        frame_in : in std_logic;
        data_in : in STD_LOGIC_VECTOR (5 downto 0);

        frame_out : out std_logic;
        data_out : out std_logic_vector(11 downto 0)
    );
end component;


COMPONENT ila_9

PORT (
	clk : IN STD_LOGIC;



	probe0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe2 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe3 : IN STD_LOGIC_VECTOR(5 DOWNTO 0); 
	probe4 : IN STD_LOGIC_VECTOR(5 DOWNTO 0); 
	probe5 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	probe6 : IN STD_LOGIC_VECTOR(11 DOWNTO 0)
);
END COMPONENT  ;

begin

debug_ad9361_rx : ila_9
PORT MAP (
	clk => clk_out,

	probe0(0) => rx_frame_I,
	probe1(0) => rx_frame_Q,
	probe2(0) => rx_frame_out_I,
	probe3 => rx_data_I,
	probe4 => rx_data_Q,
	probe5 => rx_data_out_I_debug,
	probe6 => rx_data_out_Q_debug
);


----    data    ----
rx_data_IDDR: for i in 0 to 5 generate

    data_IBUFDS_inst : IBUFDS
        generic map (
            DIFF_TERM => TRUE,      -- Differential Termination 
            IBUF_LOW_PWR => TRUE,   -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
            IOSTANDARD => "LVDS"
        )
        port map(
            I => rx_data_in_p(i),
            IB => rx_data_in_n(i),
            O => rx_dout_ibufds(i)
        );
        
    data_IDDR_inst: IDDR
        generic map (
            DDR_CLK_EDGE => "OPPOSITE_EDGE",    -- "OPPOSITE_EDGE", "SAME_EDGE" 
                                                -- or "SAME_EDGE_PIPELINED" 
            INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
            INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
            SRTYPE => "SYNC"
        ) -- Set/Reset type: "SYNC" or "ASYNC" 
        port map (
            CE  => '1',
            R => '0',
            S => '0',
            C => clk_out,
            D => rx_dout_ibufds(i),
            Q1 => rx_data_I(i),
            Q2 => rx_data_Q(i)
        );
end generate;

----    frame    ----
frame_IBUFDS_inst : IBUFDS
    generic map (
        DIFF_TERM => FALSE,     -- Differential Termination 
        IBUF_LOW_PWR => TRUE,   -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
        IOSTANDARD => "DEFAULT")
    port map(
        I => rx_frame_in_p,
        IB => rx_frame_in_n,
        O => rx_frame_inbufds
    );

frame_IDDR_inst : IDDR
    generic map (
        DDR_CLK_EDGE => "OPPOSITE_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE" 
                                       -- or "SAME_EDGE_PIPELINED" 
        INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
        INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
        SRTYPE => "SYNC"
    ) -- Set/Reset type: "SYNC" or "ASYNC" 
    port map (
        CE  => '1',
        R => '0',
        S => '0',
        C => clk_out,
        D => rx_frame_inbufds,
        Q1 => rx_frame_I,
        Q2 => rx_frame_Q
    );

----    clk    ----
clk_IBUFDS_inst : IBUFDS
   generic map (
      DIFF_TERM => TRUE, -- Differential Termination 
      IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD => "LVDS")
   port map (
      O => rx_clk_in,       -- Clock buffer output
      I => rx_clk_in_p,     -- Diff_p clock buffer input (connect directly to top-level port)
      IB => rx_clk_in_n     -- Diff_n clock buffer input (connect directly to top-level port)
   );

clk_BUFG_inst: BUFG port map (
    I => rx_clk_in,
    O => clk_out
);

rx_clk_out <= clk_out;

U1: jointer port map(

    clk         => clk_out,
    reset       => reset,

    frame_in    => rx_frame_I,
    data_in     => rx_data_I,

    frame_out   => rx_frame_out_I,
    data_out    => rx_data_out_I_debug
);

U2: jointer port map(
    clk         => clk_out,
    reset       => reset,

    frame_in    => rx_frame_Q,
    data_in     => rx_data_Q,

    frame_out   => rx_frame_out_Q,
    data_out    => rx_data_out_Q_debug
);

rx_frame_out <= rx_frame_out_I;
rx_data_out_I <= rx_data_out_I_debug;
rx_data_out_Q <= rx_data_out_Q_debug;

end Behavioral;
