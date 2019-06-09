library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity tx_interface is
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
end tx_interface;

architecture Behavioral of tx_interface is


signal tx_data_DDR_out : std_logic_vector(5 downto 0);
signal clk_in_128M_s : std_logic;

signal tx_data_out_I : std_logic_vector(5 downto 0);
signal tx_data_out_Q : std_logic_vector(5 downto 0);
signal tx_frame_out_I : std_logic;
signal tx_frame_out_Q : std_logic;

signal tx_frame_out : std_logic;
signal tx_data_out : std_logic_vector(5 downto 0);

component cutter
    port (
        rst         : in std_logic;
        clk_in      : in std_logic;
        
        frame_in    : in std_logic;
        data_in     : in std_logic_vector(11 downto 0);
        
        frame_out   : out std_logic;
        data_out    : out std_logic_vector(5 downto 0)
    );
end component;

begin

----    data    ----
tx_data_ODDR: for i in 0 to 5 generate
    data_ODDR_inst : ODDR
        generic map (
            DDR_CLK_EDGE => "SAME_EDGE",    -- "OPPOSITE_EDGE" or "SAME_EDGE" 
            INIT => '0',                    -- Initial value for Q port ('1' or '0')
            SRTYPE => "SYNC"                -- Reset Type ("ASYNC" or "SYNC")
        )
        port map (
            Q => tx_data_out(i),            -- 1-bit DDR output
            C => clk_in,                    -- 1-bit clock input
            CE => '1',                      -- 1-bit clock enable input
            D1 => tx_data_out_I(i),         -- 1-bit data input (positive edge)
            D2 => tx_data_out_Q(i),         -- 1-bit data input (negative edge)
            R => '0',                       -- 1-bit reset input
            S => '0'                        -- 1-bit set input
        );
        
    data_OBUFDS_inst: OBUFDS
        generic map (
            IOSTANDARD => "LVDS",       -- Specify the output I/O standard
            SLEW => "SLOW"              -- Specify the output slew rate
        )
        port map (
            O => tx_data_out_p(i),      -- Diff_p output (connect directly to top-level port)
            OB => tx_data_out_n(i),     -- Diff_n output (connect directly to top-level port)
            I => tx_data_out(i)         -- Buffer input 
         );
end generate;


-- clk_in_128M_s <= not clk_in;
----    clk    ----
clk_OBUFDS_inst: OBUFDS
    generic map (
        IOSTANDARD => "LVDS",   -- Specify the output I/O standard
        SLEW => "SLOW"          -- Specify the output slew rate
    )
    port map (
        O => tx_clk_out_p,      -- Diff_p output (connect directly to top-level port)
        OB => tx_clk_out_n,     -- Diff_n output (connect directly to top-level port)
        I => clk_in             -- Buffer input 
    );

----    frame    ----
frame_ODDR_inst : ODDR
        generic map (
            DDR_CLK_EDGE => "SAME_EDGE",    -- "OPPOSITE_EDGE" or "SAME_EDGE" 
            INIT => '0',                    -- Initial value for Q port ('1' or '0')
            SRTYPE => "SYNC"                -- Reset Type ("ASYNC" or "SYNC")
        )
        port map (
            Q => tx_frame_out,              -- 1-bit DDR output
            C => clk_in,                    -- 1-bit clock input
            CE => '1',                      -- 1-bit clock enable input
            D1 => tx_frame_out_I,           -- 1-bit data input (positive edge)
            D2 => tx_frame_out_Q,           -- 1-bit data input (negative edge)
            R => '0',                       -- 1-bit reset input
            S => '0'                        -- 1-bit set input
        );

frame_OBUFGDS_inst: OBUFDS
    generic map (
       IOSTANDARD => "LVDS",   -- Specify the output I/O standard
       SLEW => "SLOW"          -- Specify the output slew rate
    )
    port map (
       O => tx_frame_out_p,     -- Diff_p output (connect directly to top-level port)
       OB => tx_frame_out_n,    -- Diff_n output (connect directly to top-level port)
       I => tx_frame_out        -- Buffer input 
    );

U1: cutter port map (
    rst         => reset,
    clk_in      => clk_in,
    
    frame_in    => tx_frame_in,
    data_in     => tx_data_in_I,
    
    frame_out   => tx_frame_out_I,
    data_out    => tx_data_out_I
);

U2: cutter port map (
    rst         => reset,
    clk_in      => clk_in,
    
    frame_in    => tx_frame_in,
    data_in     => tx_data_in_Q,
    
    frame_out   => tx_frame_out_Q,
    data_out    => tx_data_out_Q
);

end Behavioral;