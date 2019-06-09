----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2017/09/24 22:49:56
-- Design Name: 
-- Module Name: IDDR_module_1 - Behavioral
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

library UNISIM;
use UNISIM.VComponents.all;

entity jointer is
    Port ( 
        clk : in STD_LOGIC;
        reset : in std_logic;
        
        frame_in : in std_logic;
        data_in : in STD_LOGIC_VECTOR (5 downto 0);

        frame_out : out std_logic;
        data_out : out std_logic_vector(11 downto 0)
    );
end jointer;

architecture Behavioral of jointer is

signal dout_tmp : std_logic_vector(11 downto 0);

begin

process(reset, clk)
begin
    if reset = '0' then
        data_out_tmp <= (others => '0');
    elsif rising_edge(clk) then
        if frame_in = '1' then
            data_out_tmp(11 downto 6) <= data_in;
        else
            data_out_tmp(5 downto 0) <= data_in;
        end if;
    end if;
end process;

process(reset, clk)
begin
    if reset = '0' then
        frame_out <= '0'
        data_out <= (others => '0');
    elsif rising_edge(clk) then
        frame_out <= frame_in;
        data_out <= data_out_tmp;
    end if;
end process;

end Behavioral;
