library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity baudrate_generator is

  port (
    clock        : in  std_logic;
    baudrate_out : out std_logic);

end entity baudrate_generator;


architecture rtl of baudrate_generator is
  signal counter   : unsigned(9 downto 0) := (others => '0');
  constant divisor : unsigned(9 downto 0) := to_unsigned(867, 10);
begin  -- architecture rtl
  main : process (clock) is
  begin  -- process main
    if rising_edge(clock) then          -- rising clock edge
      counter <= counter + 1;
      if counter = divisor then
        baudrate_out <= '1';
        counter      <= (others => '0');
      else
        baudrate_out <= '0';
      end if;
    end if;
  end process main;

end architecture rtl;
