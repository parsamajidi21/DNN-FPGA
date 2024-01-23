library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity tb_top is
end tb_top;
 
architecture behave of tb_top is

  signal r_RESET   : std_logic := '0';
  signal r_CLOCK   : std_logic := '0';
  signal r_uart_txd_in : std_logic := '0';
  signal r_uart_rxd_out : std_logic := '0'; 
  component top is
      port (

        CLK100MHZ    : in  std_logic;
        reset        : in std_logic;
        uart_txd_in  : in  std_logic;
        uart_rxd_out : out std_logic);
  end component top;
 
   
begin
 
  MODULE_FIFO_REGS_NO_FLAGS_INST : top
    port map (
      CLK100MHZ => r_CLOCK,
      reset => r_RESET,
      uart_txd_in  => r_uart_txd_in,
      uart_rxd_out => r_uart_rxd_out
      );
 
 
  r_CLOCK <= not r_CLOCK after 10 ps;
 r_uart_txd_in <= not r_uart_txd_in after 2ns;

   
   
end behave;