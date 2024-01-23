-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity dense_resource_ap_fixed_16_6_5_3_0_ap_fixed_16_6_5_3_0_config5_s_w5_V_rom is 
    generic(
             DWIDTH     : integer := 1017; 
             AWIDTH     : integer := 5; 
             MEM_SIZE    : integer := 32
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of dense_resource_ap_fixed_16_6_5_3_0_ap_fixed_16_6_5_3_0_config5_s_w5_V_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 => "000000000000000000000000000000000110101011111111110110001111111111111111111111111111111100000000000000000000000000101101000000000000000001111111111111111000000000000010011111111111111110000000000000000111111111111111100000000000000101111111111111001000000000000011000000000100110010000000000000010000000001000001011111110011001100000000000001000111111111000111011111111111110100000000010100110111111111111110011111111110101001111111101111000000000000000000000000000000000001111111100110100000000000000000011111111111111010000000000000011111111111111101111111111110010110000000000000101000000001110011011111111111111110000000000000000000000000000001000000000000000000000000100010101111111111111111000000000000000000000000000000000111111111111110111111111111111111111111111101011111111111001101011111111111111110000000000000011000000000000110100000000000000001111111111111011000000000000001111111111111111110000000000000000000000011100000100000000000000011111111011010101000000000110111000000000000000001111111101100011", 
    1 => "111001110000000000000001000000001010100110000000101111100000000000111001011111111111001110000000001010100111111111111110111111111111111110000000000000000000000010001100011111111010001110000000010111100000000000000000000000001001111110000000000000000111111111101011100000000000110110000000000010000000000000000000000000000000000010000000000110110000000000000001000000000000000110000000000101000000000000001000111111111110111100000000100100101111111111111111111111111111111100000000000010000000000001100111011111111111111100000000010011010000000000101110111111111111110000000000000000100111111111111110000000000000000001111111111111111111111111110110011111111111000100000000000000000111111110000110000000000011011101111111110100011111111111111111100000000000000001111111111111110000000001011010100000000011011000000000001100101000000000010010100000000000101001111111111111101000000000000010000000000000000000000000000000010000000001011011011111111111111101111111010110001000000000010111000000010011011011111111111101010", 
    2 => "000000000111111111111111111111111100100110000000000000000111111111111111111111111111111110000000011111110000000000000000011111111111111111111111111111111111111111111100100000000000000001111111111001010111111111111111100000000000000000000000000000000000000011000000000000000000000000000000010000101000000000000000000000000100011100000000000000000000000000000010000000000000000000000000000000001111111111111111100000000011011000000000000000000111111111111111011111111111111110000000001101101111111111111111100000000000000111111111111111111111111111011111000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100011000000000000000011111111110110110000000000000000111111111111111100000000000000001111111100100110000000000000000000000000000000010000000000000000111111110101100000000000000000000000000000000000111111111111111111111111111111111111111111111111000000001100101000000000000000000000000001100110000000000000000011111111100100001111111111111111", 
    3 => "000000001111111111111111111111111111111010000000000010000000000000000000000000000000000000000000000000001000000000000000000000000000000001111111111111111111111111111110100000000000000000000000000000000111111111111111100000000110000001111111111111111111111111100100100000000000000000000000101101100000000000000000000000000001010111111111111111111111111111111111100000000000000000000000000000000000000000000000000000000010011000000000000001101111111111111111100000000000000000000000000110010111111111111111100000000000001111111111111111111000000000100101100000000000000001111111111110100000000000000000011111111111111110000000000000000111111111111011000000000000000001111111111110010000000000000000000000000000000000000000000000000111111111010100100000000000000000000000000000001000000000000000011111111111111110000000000000000111111111111110111111111111111111111111111110100000000000000000011111111111111110000000000000000111111111111110000000000000000000000000000000001111111111111111100000001000000010000000000000000", 
    4 => "000111000111111111111110111111111101011110000000000000000000000000000000111111111111111101111111111111101000000000000000111111111111111111111111111111111111111111111101111111111111111100000000000000000111111111111111000000001000001111111111111111110111111111000101100000000000000000000000001101111000000000010111000000000000000000000000000011101000000000111101000000000011000011111111111100011111111011000111000000000000100101111111111111101111111111111111111111111111111100000000010011100000000000000001100000000011001100000000000000000111111111111110111111111111111110000000000000000000000000000010111111111111111110000000000000000111111101111110011111111111111111111111111111110111111111111111100000000100010010000000001001100111111111111111111111111111111101111111111111101000000000000000111111111110100110000000000000011000000001110100111111101100110101111111101000001111111111111111000000000000000010000000000000000111111111111111111111111011010110000000011000101111111111111111000000000000001101111111110101001", 
    5 => "000000000111111111111001000000001110100100000000111000110111111111111111100000000000000010000000000000000111111111111111000000000000000000000000000000000111111111111101111111111111111011111111111111111000000000000000111111111111111110000000000000010000000000101101100000000001001001111111111101001000000000000001100000000000000000000000000000000000000000001110000000000000000001111111111111111000000001101010011111111111110000000000001101100111111111111111111111111111111111111111111111111000000000001110000000000111011111111111111111111000000000001100011111111111111100000000000000100000000000101011100000000000000000000000000000000000000000000000011111111111010110000000000000000000000001101110000000000011010101111111111111111000000001000101111111111111111111111111111111110111111111111111100000000000001011111111111111111000000010011100011111111111111000000000000000000000000000000001000000000000000010000000000000000000000000000011100000000100001110000000000000010111111111111110011111111111111011111111111111111", 
    6 => "000000000000000000000000000000000111011111111111111011110000000000000001000000000000000011111111111111111000000010010101011111111111111110000000000000000111111111111110111111111111111011111111111111111000000000000000100000000000000000000000000010111000000000000001011111111100001100000000000000010000000000111011011111111111111110000000010011111111111011100101011111111111111110000000011110101111111111111111100000000000000001111111110111100111111111111111111111111111111111111111111111101000000000111100111111111111111000000000000000000000000000000000000000000000001101111111111111111111111111111110100000000000000000000000000000000111111111111111100000000000000010000000000000010111111111001100011111111111111010000000000001111000000000000000000000000000000001111111111111101111111111111110100000000011111111111111111111111111111111111110011111111111110101111111111111111111111111110110100000000000000001111111101111001000000000110010100000000000101111111111111101101000000010100110011111111111101110000000001000111", 
    7 => "000000100000000000000000011111111111001111111111011010000000000000000000100000000000000001111111111001110000000000011000111111111111111110000000000000000000000000001111100000000000000001111111111111110111111111111111111111111111111110000000000000011111111111110010111111111110111110000000000000000000000000000101111111111111101001111111111111111111111111111101011111111110101101111111111111111111111111111100011111111110000100000000111001000000000000000000000000000000000001111111101110010000000010001000000000001001001100000000001010000000000000000011100000000000001001111111111111111000000000000000111111111111111110000000000000000111111110101010000000000000000001111111111111101111111111011110000000000010101110000000000000011000000000000000011111111111111111111111111010101000000001000000100000000000000000000000000000011000000010100101011111111100100000000000000000001000000000000010000000000000000001111111111111111000000000000000111111111110111011111111111111111111111111111111111111111111100101111111111011101", 
    8 => "111111111111111111111110111111111011011110000000000101111000000000000000011111111111111100000000001101011000000000000000000000000000000001111111111111111000000000000000011111111111111101111111111110001111111111111111011111111111111000000000000000000000000001000010011111111111111110000000000000001000000000000001011111111111111110000000000000001111111111111101000000000000000011111111110100100111111111111001011111111110100101111111111111111000000000000000011111111111111111111111111110100000000000010001000000000000000011111111111111111111111111111110000000000001000100000000000000010000000000001100011111111111111110000000000000000111111111111111111111111111111110000000001001010000000000000000000000000011010010000000000011101000000000000000111111111111111111111111111111101000000000000110100000000000000110000000000000000111111111111111111111111111111111111111100000011000000000000000011111111111111110000000000000000000000001100110100000000000000011111111111111111111111111111111100000000010110000000000000111010", 
    9 => "111111011000000000000000111111111000100011111111101101100111111111111111100000000000000000000000000100000000000000110110100000000000000001111111111111111111111111111110100000000000000000000000000000001000000000000000000000000000000011111111111111111000000000110100100000000000000000000000000000001000000001111001100000000000000101111111111111111111111111111011111111111111111010000000101111010111111111111110111111110011111110000000000110110000000000000000011111111111111111111111110100000000000000010001011111111100001000000000000000110111111111010000011111111111111100000000000100100111111111111111100000000000000000000000000000000111111111111101011111111111111110000000000000101111111110010110000000000000000000000000000110100111111111111111111111111111111111111111101111100111111111101001111111110011010010000000000000001111111111111110011111110011110101111111111111110000000000000011111111111111111111111111111111111000000000000000111111111001111110000000000000010111111111111110111111111111111011111111111100101", 
    10 => "010000000000000000000000011111111111111010000000000000001000000000000000111111111111111100000000000110000111111110100110111111111111111111111111111111111111111111111111111111111111111000000000000000001111111111111111100000000000001001111111111111110111111111010101111111111111111000000000001110111111111110011000000000000001001101111111111111111111111111010101011111111111111101111111111010101111111111111010000000000000011111111111111111100000000000000000011111111111111111111111111111100111111111110111000000000010010011111111111110111000000000000000100000000011010101111111101010000000000000111110000000000000000001111111111111111111111111111111100000000000000001111111111111001000000000010101100000000000000010000000010110110111111111111111100000000000000000000000000000001000000000110000011111111111111100000000000000100111111111111111111111111111011101111111111111111111111111111111111111111111111100000000000000000111111111111100100000000000001010000000000000001000000000000000000000000000000111111111111111111", 
    11 => "010111001000000000000000011111111111110010000000010010010000000000000001000000000000000001111111111101100111111111111111000000000000000001111111111111111000000000000000000000001001010111111111111111111111111111111111100000000000001011111111111111111111111110110101111111111111111000000000000101000000000000000000011111111111110111111111111111100111111111110000011111111111110110000000001001010000000000000000100000000000000011111111110100100111111111111111111111111111111111111111111010101111111111111011100000001000001000000000000000101000000000011110000000000000000100000000000000000000000000000000111111111111111110000000000000000111111101011101111111111111101100000000000000001111111111111111100000000000010100000000000011111111111111111111111111111111111100000000001000011111111111111000011111111111000000000000000000001000000000000011000000000001000100000000000000010000000000000001111111111111111111111111111111111000000000100011100000000000000110000000000000000111111110101111111111111111111010000000010010110", 
    12 => "000000010111111111100110011111111101010101111111111000000111111111111111011111111111111111111111111111101000000011110101100000000000000000000000000000000111111111111110111111111111111111111111110110110111111111111111111111111101000110000000000000000111111101101100000000010100010100000000000011101000000000000000011111111111110000000000000011111000000000011000100000000000001001111111111011100000000000011000011111111010010101111111111111001111111111111111111111111111111100000000010001100111111111111111111111111110110100000000000000000111111111111101111111111100100011111111111111110000000000000001000000000000000001111111111111111000000001100100100000000000000010000000000000010000000000000000011111111111111111111111111111111111111111111111011111111111111101111111101110111111111100101110011111111101110010000000000000100000000000000000111111111001010100000000001010011000000000000000000000000010011000000000000000000111110000000101100000001010011011111111111111011111111111010001111111111111110111111111111000111", 
    13 => "111111100111111111111111111111111111010001111111111111111111111111111110100000000000000000000000000011000111111111111111100000000000000001111111111111111111111111111110000000000000000001111111111111010111111111111111111111111111111101111111111111111000000000001000111111111111111110000000011101010000000000000000000000000100011010000000000000000000000000000101011111111111111111111111101100100000000000000000011111111111111101111111111111111111111111111110100000000000000000000000000000011111111111111111100000000000000001111111111111111111111111111111111111111111111110000000010011110111111111111111111111111111111111111111111111111000000000000000011111111111111111111111111100000111111111111111100000000011011100000000000000000111111111111111000000000000000000000000001010000000000000000000000000000000000100000000000000000111111010001100000000000000000001111111111111110111111111111111100000000000000001111111111111111111111101111001100000000000000000000000000110100000000000000000011111111101111000000000000000000", 
    14 => "111111111111111111111111100000000000000000000000000000000111111111111111111111111111111111111111111111111000000000000000011111111111111110000000000000000000000000000000011111111111111110000000000000000111111111111111111111111111111111111111111111111000000000001110011111111111111111111111111111111111111111111111111111111111111110000000000000000000000000000000011111111111111110000000000000000000000000000000011111111111111111111111111111111000000000000000000000000000000000000000000000000111111111111111111111111111111111111111111111111000000000000000000000000000000001111111111111111000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111111111000000000000000000000000000000001111111111111111111111111111111100000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111100000000000000000000000000000000111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000000000000000", 
    15 => "000000000000000000000000111111111111111111111111101111100000000000000000011111111111111110000000000000000000000000111010100000000000000000000000000000000111111111111111111111111111111111111111111111111000000000000000011111111111111110000000000000001111111111111111111111111111101001111111111111111000000010010010000000000000000000000000000000001111111111111111111111111111010100000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111110000000000000000000000000000000100000000000000001111111111111110000000000000000000000000000000011111111111111111000000000000000011111111111111111111111111111111111111111111111111111111111111101111111111111111111111111111101111111111111111110000000000000000111111111111111111111111111111110000000000000000000000000000000111111111111111111111111111111110000000000000000000000000000000000000000000000000111111111111111000000000000000000000000000000000000000000000000011111111111111110000000000000000000000000000000100000000000000000000000000000100", 
    16 => "000000000111111111111111100000000001000010000000001010010000000000010011111111111111111010000000000111010111111110111010000000000000000001111111111111111000000000000000011111111111111011111111111111111111111111111111100000000010001110000000000011010111111111000001111111111110010010000000001010100111111111011110000000000000001100000000000011111111111111111111100000000100110101111111111111001111111111111110111111111100010011111111011000101111111111111111111111111111111110000000000000101111111110001010011111111111111011111111110010011111111110111010100000000000000010000000010111010000000000000000100000000000000001111111111111111000000000000000000000000000000001111111111111110111111111111111100000000010000110000000001100111000000000000000000000000000000001111111100100101000000001011110000000000000000010000000000000011111111100011100011111111111111001111111111111111000000000000000000000000000000000000000000000000000000000000101111111111001101111111111111111110111111111111111100000000110101100000000000101010", 
    17 => "111111111000000000000000011111111111101000000000010100011111111111111111100000000000000100000000001101110111111111100001000000000000000001111111111111111000000000000000000000000111001101111111111111111000000001011011000000000000000110000000000000110111111111011111111111111111110100000000001110001111111111101111000000000000001001111111111111101111111111111111111111111111111000000000000000010000000000000001011111111111111001111111110110100111111111111111100000000000000000000000110011111111111101101010111111111111111000000000000110110000000001000100000000000000000000000000000000001111111111111110100000000000000001111111111111111111111111111111111111111110010011111111111001010111111111111111100000000001111010000000000000100000000000000000000000000000000001111111111111110111111111110101100000000000000110000000000000001111111111000101000000000000010100000000000000000111111111111111100000000000000001111111111111100000000001101100100000000101001100000000000000000111111111100100000000001101001010000000010011010", 
    18 => "111111001000000000000001000000000100110011111111010010101000000001010001111111111111111111111111100100100000000000100110000000000000000001111111111111111000000000111110011111111111111011111111111111010000000000000000000000000000001011111111111111101111111011001011111111111000010010000000001010101000000000000000111111111010010011111111111111100000000010001011000000000001110011111110001111010000000000111110111111111110101101111111110110100111111111111110111111111111101110000000000000001000000001001100111111111001001000000000000000000000000010011101011111100110010010000000000000110111111111111111100000000000000001111111111111111111111111111111100000001000001001111111101110011000000000000001000000010100000111111110101011111111111111111111011111111110011010000000011010001111111111110111011111110010111110000000000000000111111111000000000000000001100101111111111111010000000001100111100000000000000000000000001011111111110111100101011111111111000101111111110101110111111111011011000000001101001111111111110001100", 
    19 => "111111111000000000000001000000000000000011111111111111101111111111111111100000000000000001111111111111101111111111111111100000000000000001111111111111111000000000000000011111111111111001111111111111111000000000000000100000000000000101111111111111111000000000010111111111111111111110000000000000001000000000000000100000000000000001111111111111111111111111111111111111111000001010000000000000000000000000111000111111111111110111111111101110111000000000000000011111111111111111111111111111000000000000000000011111111111111001111111110000101111111111111111011111111111111110000000000000001000000000000000000000000000000000000000000000000000000001011100000000000010111010000000000000010000000000000000111111111111111111111111000101101000000000000000000000000000000001111111111111010111111111111110000000000000000000000000000000000000000000000000011111111111111101111111111111111000000011000111111111111111111110000000000000000000000000000100100000000000000011111111110000001111111111111111111111111111111101111111111111100", 
    20 => "010100100000000001001110011111111110010101111111111000100000000000000000111111111111111110000000011000010111111110010110111111111111111111111111111111111111111111111110011111111010111001111111111101011000000000000000000000000000001010000000000011111111111111101001011111111111111000000000010101011000000000000000100000000000000110000000000001000111111111010101011111111111111110000000011101100000000000000000100000000010000101111111111111100111111111111111111111111111111110000000000000010111111111111100100000000000100100000000000001000000000001000001100000000000001001111111010001100111111111110111111111111111111111111111111111111111111101101110011111111111111101111111111111110111111111111111100000000001011101111111111111111111111111111111000000000000000000000000000001111000000000001110011111111101000101111111111111110111111111111111000000000000000010000000000000000000000000000000100000000000000011111111111111110000000000101100111111111111111010000000000011111000000010110011100000000010010011111111100000011", 
    21 => "000000001000000000001001100000001011101000000000000011110000000000000000000000000000000011111111111111111111111111111111000000000000000001111111111111111111111111111110100000000000000001111111111111111000000000000000100000000000000001111111101011010111111111110110011111110111010100000000000000000000000000100001100000000000000001111111111111110000000000000010011111111111110011111111111111001111111111011011000000001000101000000000011001110111111111111111111111111111111111111111111111101000000010110101100000000011000010000000000000001000000010111110000000000000000001111111101111100111111111111111011111111111111111111111111111111111111111111110000000000011100111111111111111110111111101100011011111111111111111111111010010000000000000000000000000000000000000000000011000011111111111111110100000000000010001111111111111111111111111111111011111111101101010000000000000011000000011101011000000000000000010000000000000000000000000011100111111101100011010000000000001010111111111111110111111111111111100000000000000100", 
    22 => "111111111000000000000000100000000000000100000000000000000111111111111111100000000000000001111111110011110000000000000100111111111111111110000000000000000000000000000001011111111111110101111111111111111000000000000001011111111111111110000000000000000111111111111110000000000000001110000000000000000000000000000000011111111111111100000000011110010111111111111101100000000011011111111111111111110111111111111111100000000000000011111111101101101111111111111111111111111111111111111111111111111000000000010000100000000000000000000000010110100000000000000000111111111001001000000000111111110111111111111111111111111111111111111111111111111111111111111111100000000000000000000000000111011111111111001101100000000000000001111111111111011111111111111111000000000000101011111111111111100111111111101110111111111111111100000000011010100000000000000100000000000011000110000000000000001000000000000000011111111111111110000000000000000000000001101110000000000011011001111111100100000000000000011010100000000000000001111111111110111", 
    23 => "000000001111111111111111000000000000000000000000000000010000000000000000111111111111111111111111111111100111111111111111111111111111111110000000000000000111111111111110100000000000000000000000000000010000000000000000011111111111111110000000000000000000000000000000000000000000000001111111111101111111111111001110111111111111111101111111111111111111111100101000000000000000000010000000101111100111111111111011111111111011111101111111111001000111111111111111111111111111111100000000000110000111111111111100011111111101111101111111111111110111111111101001000000000000011101111111111111101000000000101001000000000000000001111111111111111000000000100011000000000000000000000000000000011000000000111111111111110010001000000000000001000000000000101000011111111111111111111111111111011000000000010100000000000010000100000000000000011000000001001001000000001000010110000000111000010111111111111110100000000001110011111111111111111000000000101111000000000000111011111111111111111111111111111111011111111001110010000000000000000", 
    24 => "111111111111111111111110111111101001000110000000011110110000000000000000100000000000000000000011010101000111111111111110111111111111111111111111111111111111111111111111111111111111111100000000000000011000000000000000000000000000001000000000000000100000000110001111100000000001011100000001110110110111111110100101000000001111101110000000000000010000000000000010000000000011101110000001101110010000000000000000011111110011000011111111111100001111111111111111000000000000000001111111111111111111111111111011011111010111000001111111111101011111110101000011011111111111111110000000000000001000000000000000100000000000000000000000000000000000000001100111100000000000010111111111101111110000000000011101111111100101101100000000000011010111111110100000111111111111111111111100111011001111111111111110100000000011111000000000000000010111110110100100111111111111111110000000001011000111111111111110111111111111111101111111111111110000000001100100000000000011011111111111111111101111111111111111100000000000100111111111111111111", 
    25 => "010000100000000000011011011111111101110101111111110011100000000000000000011111111111110111111111111111110000000000000000111111111111111111111111111111111111111111111110111111111111011010000000000000000111111111101110111111111111110111111111111111111111111110111000100000000111001100000000010010100000000000110101111111111111111111111111111111111111111111100001100000001001011101111111111011000111111100000011000000000000110001111111111111100000000000000000011111111111110111111111111111100000000000010001100000000000011001111111101101101000000000000010011111111100011001111111001011001111111111100010011111111111111111111111111111111000000000001000100000000000000001111111011011110000000001011110100000000000000000000000011010100111111111111111111111111110111010000000000000011000000000001010100000000000100110000000000000000000000000000001011111100100001011111111111111000111111111111101011111111111110111111111111111111000000000000000111111110010011000000000000000001000000010001001011111111111110001111111011010101", 
    26 => "111111110111111111111101111111111101011000000000000001101111111111111101100000000000000100000000000011100000000000000001000000000000000001111111111111111111111111111110011111111111111101111111111111001000000000000001111111111111100110000000000010110000000001000000100000000111001100000000000100011111111111111110100000000110111000000000001001000111111111111101011111111111110111111111111111011111111111111111011111111001010001111111111110010111111111111111111111111111111111111111101011000111111111111011111111111001011010000000000000000111111111001100011111111101110100000000000000100111111111111111000000000000000001111111111111111111111111111111111111111111111101111111111111111000000000000001111111111110100000000000000000000000000000000000011111111111111111111111101100100000000000000000000000000000000110000000000000000111111101100000111111111101010001111111111110100111111111111111000000000000000001111111111111111000000000011011100000000011110100000000000000000000000010010000111111111111111011111111111111110", 
    27 => "110011101000000000000000000000000000000000000000000101001111111111111111111111111111111110000000000000010000000000000000000000000000000000000000000000000000000000110110111111111111111110000000000000000000000000000000000000000000000100000000000000000000000000100011011111111111111100000000000000000000000000000000100000000000000011111111111111111000000000000001011111111111111110000000000000000000000000000000011111111111110101111111111111111111111111111111100000000000000001111111111111100000000000000000011111111111111100000000000000000111111111111110000000000000000000000000000000001111111111111111100000000000000001111111111111111111111111111111111111111110100001111111111111111111111111111111000000000100011000000000000000000111111111111111011111111111111111111111111111101000000000000000000000000000000100000000000000000111111111111111100000000000000001111111111111110111111111111111100000000000000001111111111111111000000001101011011111111111111011111111111111110111111111111111100000000111110000000000000000001", 
    28 => "010010110000000000000000000000000011100000000000001100110000000000000000100000000000000001111111100110010111111111101010011111111111111111111111111111111111111111111111100000000000000000000000000110001111111111111111100000000100100111111111111111111111111111001010011111111111111010000000000000010000000000000000111111111111111101111111111000111000000001011100111111111111111011111111111111111111111111111111100000000001001110000000000000000111111111111111000000000000000001111111111111101111111111011110100000000011110100000000001000101000000000000000100000000000000011111111111111101000000000000000011111111111111111111111111111111111111101110001111111111111110111111111111110111000000000001100100000000011011110000000000000001000000000000000011111111111111110000000000010101111111111111111011111111110001010000000000000000000000100001111100000000110001000000000000000000111111111111111111111111111111111111111111111111111111110100000100000000010101110000000000000111111111111111011100000000001110111111111111111110", 
    29 => "111111111000000000000000000000000001000001111111101110110111111111111111100000000000000010000000000000010000000000000000100000000000000000000000000000000000000001110100111111111111111010000000000000000000000000000001100000000000000100000000100101000111111111011111011111111111111000000000000000010000000000011110000000000000001000000000100100010111111111111111111111111111111111111111111101011000000000000000011111111100011111111111110100100111111111111111111111111111111110000000011001111000000000100111011111111111111101111111111100001000000000000100000000000000000110000000000000010111111111111110111111111111111110000000000000000000000010000110111111111100100100000000000000000111111111111110100000000001111010000000000001100000000000000000011111111110011111111111111110111000000000000010000000000000001100000000000100100111111111111000100000000000000001111111111111011111111111111111011111111111111101111111111111110000000001011100100000000011110011111110101101100000000000000000000000000111000110000000010000110", 
    30 => "000000000111111111010000000000000011000000000000000100011111111111111111111111111111111101111111111010010111111111101101011111111111111110000000000000000111111111111110111111111101000000000000000000000000000000000000000000000100000010000000000000001111111111111100100000001000001011111111100000001111111111111111111111111111111110000000000000001111111111111111100000000101100101111111111011111111111110110000100000000111110110000000001011000111111111111111011111111111111101111111111111111000000000000000000000000000001000000000000000010000000001111111111111111111110111111111111111111000000000010000111111111111111110000000000000000111111110001111111111111111111000000000001111110000000010001000100000000011011000000000000000001000000000000000111111111111111110000000011001111000000000101110100000000011011010000000000000000000000010000010100000000001100001111111111111110000000000000001011111111111111111111111111111110000000000011001000000000000000001111111111101011111111111111111100000000000000101111111100001100", 
    31 => "111111111111111111111111100000000001011110000000011111011111111111111111111111111111111101111111111111101111111110011111111111111111111110000000000000000111111111111111100000000000000001111111111111110111111111111111100000000000001001111111111111110000000000000000011111111111111001111111110110111111111111111111100000000000000011111111111111101000000000000000100000000000101010000000000000000111111110001110011111111011111111111111111111011111111111111111111111111111111111111111111110110111111111111111100000000000000000000000000000010000000000000000000000000000000000000000001101000000000010101111111111111111111111111111111111111111111111111111111111111111111110000000000000000000000000000000000000000100000010000000000111001111111111111111111111111111111101111111111111101000000000000000100000000000000010000000000000010000000000000000011111111111111111111111111111110000000000000000111111111111111110000000000000000000000001000101111111110101111100000000000000000111111111110110000000000001011101111111111110110" );


begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity dense_resource_ap_fixed_16_6_5_3_0_ap_fixed_16_6_5_3_0_config5_s_w5_V is
    generic (
        DataWidth : INTEGER := 1017;
        AddressRange : INTEGER := 32;
        AddressWidth : INTEGER := 5);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of dense_resource_ap_fixed_16_6_5_3_0_ap_fixed_16_6_5_3_0_config5_s_w5_V is
    component dense_resource_ap_fixed_16_6_5_3_0_ap_fixed_16_6_5_3_0_config5_s_w5_V_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    dense_resource_ap_fixed_16_6_5_3_0_ap_fixed_16_6_5_3_0_config5_s_w5_V_rom_U :  component dense_resource_ap_fixed_16_6_5_3_0_ap_fixed_16_6_5_3_0_config5_s_w5_V_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;

