library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity top is
  generic(
    f_WIDTH : natural := 8;
    f_DEPTH : natural := 16);
  port (

    CLK100MHZ    : in  std_logic;
    reset        : in std_logic;
    uart_txd_in  : in  std_logic;
    uart_rxd_out : out std_logic);

end entity top;



architecture str of top is
  signal clock        : std_logic;
  signal received_data: std_logic_vector(7 downto 0);
  signal data_to_send : std_logic_vector(7 downto 0);
  signal data_valid   : std_logic;
  signal busy         : std_logic;
  signal uart_tx      : std_logic;
  signal f_WR_EN       : std_logic;
  signal f_WR_DT       : std_logic_vector (f_WIDTH-1 downto 0);
  signal f_FULL_FIFO   : std_logic;
  signal f_RD_EN       : std_logic;
  signal f_EMPTY_FIFO   : std_logic;
  signal f_RD_DT_128 : std_logic_vector(127 downto 0);
  signal fc1_input_V : std_logic_vector(127 downto 0);
  signal layer13_out_0_V     : std_logic_vector(7 downto 0);
  signal layer13_out_1_V     : std_logic_vector(7 downto 0);
  signal layer13_out_2_V     : std_logic_vector(7 downto 0);
  signal layer13_out_3_V     : std_logic_vector(7 downto 0);
  signal layer13_out_4_V     : std_logic_vector(7 downto 0);
  signal ap_start : std_logic := '1'; 


    
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
   
--  component FIFO_out is 
--    generic(
--        f_WIDTH_tx : natural := 8;
--        f_DEPTH_tx : natural := 5);
--      port (
--         f_RST_tx : in std_logic;
--         f_CLK_tx : in std_logic;
--        -- FIFO WRITE INTERFACE
--         f_WR_EN_tx : in std_logic;
--         f_WR_DT_tx : in std_logic_vector (f_WIDTH_tx-1 downto 0);
--         f_FULL_FIFO_tx : out std_logic;
--        -- FIFO READ INTERFACE
--         f_RD_EN_tx : in std_logic;
--         f_RD_DT_tx : out std_logic_vector (f_WIDTH_tx-1 downto 0);
--         f_EMPTY_FIFO_tx : out std_logic);
--  end component FIFO_out;
  
  component myproject is
    port (
    ap_start : IN STD_LOGIC;
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    fc1_input_V_ap_vld : IN STD_LOGIC;
    fc1_input_V : IN STD_LOGIC_VECTOR (127 downto 0);
--    layer13_out_0_V_ap_vld : OUT STD_LOGIC;
--    layer13_out_1_V_ap_vld : OUT STD_LOGIC;
--    layer13_out_2_V_ap_vld : OUT STD_LOGIC;
--    layer13_out_3_V_ap_vld : OUT STD_LOGIC;
--    layer13_out_4_V_ap_vld : OUT STD_LOGIC;     
    layer13_out_0_V : OUT STD_LOGIC_VECTOR (7 downto 0);
    layer13_out_1_V : OUT STD_LOGIC_VECTOR (7 downto 0);
    layer13_out_2_V : OUT STD_LOGIC_VECTOR (7 downto 0);
    layer13_out_3_V : OUT STD_LOGIC_VECTOR (7 downto 0);
    layer13_out_4_V : OUT STD_LOGIC_VECTOR (7 downto 0));
  
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
    process(CLK100MHZ) 
    begin
        if rising_edge(CLK100MHZ) then
           fc1_input_V <= f_RD_DT_128;
           f_WR_DT <= received_data;
           data_to_send <= layer13_out_0_V;
           data_to_send <= layer13_out_1_V;
           data_to_send <= layer13_out_2_V;
           data_to_send <= layer13_out_3_V;
           data_to_send <= layer13_out_4_V;
        end if;
    end process;
       
  RX_1 : uart_receiver
    port map (
      clock         => CLK100MHZ,
      uart_rx       => uart_txd_in,
      valid         => data_valid,
      received_data => received_data);

  NN : myproject
    port map (
        ap_start => ap_start,
        ap_rst => reset,
        ap_clk => CLK100MHZ,
        fc1_input_V_ap_vld => '1',
        fc1_input_V => fc1_input_V,        
        layer13_out_0_V => layer13_out_0_V,
        layer13_out_1_V => layer13_out_1_V,
        layer13_out_2_V => layer13_out_2_V,
        layer13_out_3_V => layer13_out_3_V,
        layer13_out_4_V => layer13_out_4_V);
  FIFO_1 : FIFO
    port map (
        f_CLK => CLK100MHZ,
        f_RST => reset,
        f_WR_EN => '1',
        f_WR_DT => f_WR_DT,
        f_RD_EN => '1',
        f_FULL_FIFO => f_FULL_FIFO,
        f_RD_DT_128 => f_RD_DT_128,
        f_EMPTY_FIFO => f_EMPTY_FIFO);
  TX_1 : uart_transmitter
    port map (
      clock        => CLK100MHZ,
      data_to_send => data_to_send,
      data_valid   => data_valid,
      busy         => busy,
      uart_tx      => uart_rxd_out);

--    FIFO_2 : FIFO_out
--        port map(
--        f_CLK_tx => CLK100MHZ,
--        f_RST_tx => reset,
--        f_WR_EN_tx => '1',
--        f_WR_DT_tx => f_WR_DT,
--        f_RD_EN_tx => '1',
--        f_FULL_FIFO_tx => f_FULL_FIFO,
--        f_EMPTY_FIFO_tx => f_EMPTY_FIFO);   
end architecture str;
