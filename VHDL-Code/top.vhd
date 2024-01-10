library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity top is
  generic(
    f_WIDTH : natural := 8;
    f_DEPTH : natural := 16);
  port (

    CLK100MHZ    : in  std_logic;
    reset   :   in std_logic;
    uart_txd_in  : in  std_logic;
    uart_rxd_out : out std_logic);

end entity top;



architecture str of top is
  signal clock        : std_logic;
  --signal reset        : std_logic;
  signal data_to_send: std_logic_vector(7 downto 0);
  signal data_to_send_out : std_logic_vector(7 downto 0);
  signal data_valid   : std_logic;
  signal busy         : std_logic;
  signal uart_tx      : std_logic;
  signal wr_enS       : std_logic;
  signal wr_dtS       : std_logic_vector (f_WIDTH-1 downto 0);
  signal full_fifoS   : std_logic;
  signal rd_enS       : std_logic;
  signal empty_fifoS   : std_logic;
  signal fc1_input_V_s : std_logic_vector(127 downto 0);
  signal nn_out_0     : std_logic_vector(15 downto 0);
  signal nn_out_1     : std_logic_vector(15 downto 0);
  signal nn_out_2     : std_logic_vector(15 downto 0);
  signal nn_out_3     : std_logic_vector(15 downto 0);
  signal nn_out_4     : std_logic_vector(15 downto 0);
  signal ap_start : std_logic := '0' ; 


  component FIFO is 
  port (
         f_RST : in std_logic;
         f_CLK : in std_logic;
        -- FIFO WRITE INTERFACE
         f_WR_EN : in std_logic;
         f_WR_DT : in std_logic_vector (f_WIDTH-1 downto 0);
         f_FULL_FIFO : out std_logic;
        -- FIFO READ INTERFACE
         f_RD_EN : in std_logic;
         f_RD_DT_128 : out std_logic_vector (f_DEPTH*f_WIDTH-1 downto 0);
         f_EMPTY_FIFO : out std_logic);
   end component FIFO;

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
        fc1_input_V => fc1_input_V_s,
        layer13_out_0_V => nn_out_0,
        layer13_out_1_V => nn_out_1,
        layer13_out_2_V => nn_out_2,
        layer13_out_3_V => nn_out_3,
        layer13_out_4_V => nn_out_4);
  FIFO_1 : FIFO
    port map (
        f_CLK => clock,
        f_RST => reset,
        f_WR_EN => wr_enS,
        f_WR_DT => data_to_send,
        f_RD_EN => rd_enS,
        f_FULL_FIFO => full_fifoS,
        f_RD_DT_128 => fc1_input_V_s,
        f_EMPTY_FIFO => empty_fifoS);
         
  TX_1 : uart_transmitter
    port map (
      clock        => CLK100MHZ,
      data_to_send => data_to_send_out,
      data_valid   => data_valid,
      busy         => busy,
      uart_tx      => uart_rxd_out);

end architecture str;

