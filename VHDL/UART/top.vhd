library ieee;
use ieee.std_logic_1164.all;



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
  
  component myproject is
    port (
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

split_data : process
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
    
end process split_data;

  connect_in : for n in 0 to 15 generate
  RX_1 : uart_receiver
    port map (
      clock         => CLK100MHZ,
      uart_rx       => uart_txd_in,
      valid         => data_valid,
      received_data => in_nn_data_arr(n));
  end generate connect_in;   
  NN : myproject
    port map (
        fc1_input_V => nn_in,
        layer13_out_0_V => nn_out_0,
        layer13_out_1_V => nn_out_1,
        layer13_out_2_V => nn_out_2,
        layer13_out_3_V => nn_out_3,
        layer13_out_4_V => nn_out_4);
 
 connect_out : for k in 0 to 9 generate       
  TX_1 : uart_transmitter
    port map (
      clock        => CLK100MHZ,
      data_to_send => out_nn_data_arr(k),
      data_valid   => data_valid,
      busy         => busy,
      uart_tx      => uart_rxd_out);
  end generate connect_out;  
end architecture str;
