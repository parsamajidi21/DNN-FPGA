library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity top is
  generic(
    g_WIDTH : natural := 8;
    g_DEPTH : natural := 16);
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
  signal x_data_valid   : std_logic := '1';
  signal busy         : std_logic;
  signal uart_tx      : std_logic;
  signal f_WR_EN       : std_logic;
  signal f_WR_DT       : std_logic_vector (g_WIDTH-1 downto 0);
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
        i_rst_sync : in std_logic;
        i_clk      : in std_logic;
     
        -- FIFO Write Interface
        i_wr_en   : in  std_logic;
        i_wr_data : in  std_logic_vector(g_WIDTH-1 downto 0);
        o_full    : out std_logic;
     
        -- FIFO Read Interface
        i_rd_en   : in  std_logic;
        o_rd_data : out std_logic_vector(g_WIDTH-1 downto 0);
        f_RD_DT_128 : out std_logic_vector ((g_WIDTH * g_DEPTH) - 1 downto 0) := (others => '0');
        o_empty   : out std_logic);
   end component FIFO;
   
  
  component myproject is
    port (
    ap_start : IN STD_LOGIC;
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    fc1_input_V_ap_vld : IN STD_LOGIC;
    fc1_input_V : IN STD_LOGIC_VECTOR (127 downto 0);  
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
      valid         => x_data_valid,
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
        i_clk => CLK100MHZ,
        i_rst_sync => reset,
        i_wr_en => '1',
        i_wr_data => f_WR_DT,
        i_rd_en => '1',
        o_full => f_FULL_FIFO,
        f_RD_DT_128 => f_RD_DT_128,
        o_empty => f_EMPTY_FIFO);
  TX_1 : uart_transmitter
    port map (
      clock        => CLK100MHZ,
      data_to_send => data_to_send,
      data_valid   => x_data_valid,
      busy         => busy,
      uart_tx      => uart_rxd_out);

 
end architecture str;
