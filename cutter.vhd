----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2017/10/29 23:16:04
-- Design Name: 
-- Module Name: cutter1 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cutter is
    port ( 
        rst         : in std_logic;
        clk_in      : in STD_LOGIC;
        
        frame_in    : in std_logic;
        data_in     : in STD_LOGIC_VECTOR (11 downto 0);
        
        frame_out   : out std_logic;
        data_out    : out STD_LOGIC_VECTOR (5 downto 0)
    );
end cutter;

architecture Behavioral of cutter is

begin

process(rst, clk_in)
begin
    if rst = '0' then
        data_out <= "000000";
    elsif clk_in'event and clk_in = '1' then
        if frame_in = '1' then
            data_out  <=  data_in(11 downto 6);
        else
            data_out <=  data_in(5 downto 0);
        end if;
    end if;
end process;

process(rst, clk_in)
begin
    if rst = '0' then
        frame_out <= '0';
    elsif rising_edge(clk_in) then
        frame_out <= frame_in;
    end if;
end process;


end Behavioral;
