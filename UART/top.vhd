library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity top is

  port (

    CLK100MHZ    : in  std_logic;
    uart_txd_in  : in  std_logic;
    uart_rxd_out : out std_logic);

end entity top;



architecture str of top is
  signal clock        : std_logic;
  signal data_to_send : std_logic_vector(7 downto 0) := X"61";
  signal data_valid   : std_logic;
  signal busy         : std_logic;
  signal uart_tx      : std_logic;
  signal nn_in        : std_logic_vector(127 downto 0);
  signal nn_out_0     : std_logic_vector(15 downto 0);
  signal nn_out_1     : std_logic_vector(15 downto 0);
  signal nn_out_2     : std_logic_vector(15 downto 0);
  signal nn_out_3     : std_logic_vector(15 downto 0);
  signal nn_out_4     : std_logic_vector(15 downto 0);
  type in_nn_data is array (0 to 15) of std_logic_vector(7 downto 0);
  type out_nn_data is array (0 to 9) of std_logic_vector(7 downto 0);
  signal in_nn_data_arr : in_nn_data;
  signal out_nn_data_arr : out_nn_data;
  signal ap_start : std_logic := '0' ; 
  
function to_slv(slvv : in_nn_data) return STD_LOGIC_VECTOR is
  variable slv : STD_LOGIC_VECTOR((slvv'length * 8) - 1 downto 0);
begin
  for i in slvv'range loop
    slv((i * 8) + 7 downto (i * 8))      := slvv(i);
  end loop;
  return slv;
end function;

  component myproject is
    port (
    ap_start : IN STD_LOGIC;
    ap_clk : IN STD_LOGIC;
    fc1_input_V : IN STD_LOGIC_VECTOR (127 downto 0);
    layer13_out_0_V : OUT STD_LOGIC_VECTOR (15 downto 0);
    layer13_out_1_V : OUT STD_LOGIC_VECTOR (15 downto 0);
    layer13_out_2_V : OUT STD_LOGIC_VECTOR (15 downto 0);
    layer13_out_3_V : OUT STD_LOGIC_VECTOR (15 downto 0);
    layer13_out_4_V : OUT STD_LOGIC_VECTOR (15 downto 0));
  
  end component myproject;

  component uart_transmitter is
    port (
      clock        : in  std_logic;
      data_to_send : in  std_logic_vector(7 downto 0);
      data_valid   : in  std_logic;
      busy         : out std_logic;
      uart_tx      : out std_logic);
  end component uart_transmitter;

  component uart_receiver is
    port (
      clock         : in  std_logic;
      uart_rx       : in  std_logic;
      valid         : out std_logic;
      received_data : out std_logic_vector(7 downto 0));
  end component uart_receiver;
begin  -- architecture str

 main : process
begin
    split_in_nn : for i in 0 to 15 loop
        in_nn_data_arr(i) <= nn_in((15-i) * 8 + 7 downto (15-i) * 8);
    end loop split_in_nn;
    
    split_out_nn_0 : for j in 0 to 1 loop
        out_nn_data_arr(j) <= nn_out_0((1-j) * 8 + 7 downto (1-j) * 8);   
    end loop split_out_nn_0;

    split_out_nn_1 : for j in 2 to 3 loop
        out_nn_data_arr(j) <= nn_out_1((3-j) * 8 + 7 downto (3-j) * 8);   
    end loop split_out_nn_1;

    split_out_nn_2 : for j in 4 to 5 loop
        out_nn_data_arr(j) <= nn_out_2((5-j) * 8 + 7 downto (5-j) * 8);   
    end loop split_out_nn_2;

    split_out_nn_3 : for j in 6 to 7 loop
        out_nn_data_arr(j) <= nn_out_3((7-j) * 8 + 7 downto (7-j) * 8);   
    end loop split_out_nn_3;

    split_out_nn_4 : for j in 8 to 9 loop
        out_nn_data_arr(j) <= nn_out_4((9-j) * 8 + 7 downto (9-j) * 8);   
    end loop split_out_nn_4;
    

for x in 0 to 15 loop 
     if rising_edge(CLK100MHZ) then
        in_nn_data_arr(x) <= data_to_send;
     end if;     
end loop;

nn_in <= to_slv(in_nn_data_arr);
end process main;

  RX_1 : uart_receiver
    port map (
      clock         => CLK100MHZ,
      uart_rx       => uart_txd_in,
      valid         => data_valid,
      received_data => data_to_send);

  NN : myproject
    port map (
        ap_start => ap_start,
        ap_clk => CLK100MHZ,
        fc1_input_V => nn_in,
        layer13_out_0_V => nn_out_0,
        layer13_out_1_V => nn_out_1,
        layer13_out_2_V => nn_out_2,
        layer13_out_3_V => nn_out_3,
        layer13_out_4_V => nn_out_4);
 
  TX_1 : uart_transmitter
    port map (
      clock        => CLK100MHZ,
      data_to_send => data_to_send,
      data_valid   => data_valid,
      busy         => busy,
      uart_tx      => uart_rxd_out);
      
     

end architecture str;
