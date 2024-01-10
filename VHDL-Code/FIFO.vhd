library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity FIFO is
  generic(
    f_WIDTH : natural := 8;
    f_DEPTH : natural := 16);
 
  port (
         f_RST : in std_logic;
         f_CLK : in std_logic;
        -- FIFO WRITE INTERFACE
         f_WR_EN : in std_logic;
         f_WR_DT : in std_logic_vector (f_WIDTH-1 downto 0);
         f_FULL_FIFO : out std_logic;
        -- FIFO READ INTERFACE
         f_RD_EN : in std_logic;
         f_RD_DT : out std_logic_vector (f_WIDTH-1 downto 0);
         f_RD_DT_128 : out std_logic_vector ((f_WIDTH*f_DEPTH) - 1 downto 0);
         f_EMPTY_FIFO : out std_logic);
         
end FIFO;

architecture FIFO_Arch of FIFO is

type f_FIFO_DATA is array (0 to f_DEPTH) of std_logic_vector (f_WIDTH-1 downto 0);
signal fs_FIFO_DATA : f_FIFO_DATA := (others => (others => '0'));

signal f_WR_INDEX : integer range 0 to f_DEPTH-1 :=0;
signal f_RD_INDEX : integer range 0 to f_DEPTH-1 :=0;
signal f_FIFO_COUNT : integer range -1 to f_DEPTH+1 := 0;

signal f_FULL : std_logic;
signal f_EMPTY : std_logic;

signal f_RD_DATA_128 : std_logic_vector ((f_WIDTH*f_DEPTH) - 1 downto 0);

begin  
    fifo : process (f_CLK) is
    begin
        if rising_edge(f_CLK) then
            if f_RST = '1' then
               f_FIFO_COUNT <= 0;
               f_WR_INDEX <= 0;
               f_RD_INDEX <= 0; 
            else
                if (f_WR_EN = '1' and f_RD_EN = '0') then
                    f_FIFO_COUNT <= f_FIFO_COUNT + 1;
                elsif (f_WR_EN = '0' and f_RD_EN = '1') then
                    f_FIFO_COUNT <= f_FIFO_COUNT - 1;
                end if;
                
                if (f_WR_EN = '1' and f_FULL = '0') then
                    if f_WR_INDEX = f_DEPTH - 1 then
                        f_WR_INDEX <= 0;
                    else
                        f_WR_INDEX <= f_WR_INDEX + 1;
                    end if;
                end if;
                if (f_RD_EN = '1' and f_EMPTY = '0') then
                    if f_RD_INDEX = f_DEPTH - 1 then
                        f_RD_INDEX <= 0;
                    else
                        f_RD_INDEX <= f_RD_INDEX + 1;
                    end if;
                end if;    
                
                if f_WR_EN = '1' then
                    fs_FIFO_DATA(f_WR_INDEX) <= f_WR_DT;
                end if;             
                           
            end if; --end of RESET STATUS 'if'
        end if;     --end of rising edge clock 'if'
    end process fifo;
    
    -- f_RD_DT <= fs_FIFO_DATA(f_RD_INDEX);



-- ***************************************************** Concatination to have 128 bit output in FIFO ******************************************--
    concatination : process
        variable concatenated_output : std_logic_vector(127 downto 0) := (others => '0');
    begin
        -- Iterate through the array and concatenate the elements
        
        for i in 0 to f_DEPTH - 1 loop
            -- for j in 0 to f_WIDTH - 1 loop
            concatenated_output(((i+1)*8) - 1 downto i*8) := fs_FIFO_DATA(i);
                
            -- end loop;

            -- Assign the concatenated output to the corresponding part of the result
            f_RD_DT_128 <= concatenated_output;
        end loop;

        -- Assign the result to the output signal
        
        if f_FIFO_COUNT = f_DEPTH  then
            f_FULL <= '1';
        else 
            f_FULL <= '0';
        end if;
        
        -- f_EMPTY <= '1' if f_FIFO_COUNT = 0 else '0';
        if f_FIFO_COUNT = 0  then
            f_EMPTY <= '1';
        else 
            f_EMPTY <= '0';
        end if;
    end process concatination;
 -- ****************************************************************************************************************************--
   
    f_FULL_FIFO <= f_FULL;
    f_EMPTY_FIFO <= f_empty;
end FIFO_Arch;
