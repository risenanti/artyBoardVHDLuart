library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
  Port 
  (
    CLK100MHZ : in std_logic;
    btn        : in std_logic_vector(3 downto 0);
    sw        : in std_logic_vector(3 downto 0);
    led       : out std_logic_vector(3 downto 0);
    
    uart_txd_in  : in std_logic; --transmit from ftdi to fpga
    uart_rxd_out : out std_logic --from fpga to ftdi
    
   );
end top;

architecture Behavioral of top is

component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  locked            : out    std_logic;
  clk_in1           : in     std_logic
 );
end component;

component uart_tx is
   generic(
      DBIT: integer:=8;     -- # data bits
      SB_TICK: integer:=16  -- # ticks for stop bits
   );
   port(
      clk, reset: in std_logic;
      tx_start: in std_logic;
      s_tick: in std_logic;
      din: in std_logic_vector(7 downto 0);
      tx_done_tick: out std_logic;
      tx: out std_logic
   );
end component;

component mod_m_counter 
   generic(
      N: integer := 4;     -- number of bits
      M: integer := 10     -- mod-M
  );
   port(
      clk, reset: in std_logic;
      max_tick: out std_logic;
      q: out std_logic_vector(N-1 downto 0)
   );
end component;

signal CLK50MHZ : std_logic:='0';
signal txStart  : std_logic:='0';
signal txDone   : std_logic:='0';
signal txDataBuffer : std_logic_vector(7 downto 0);
signal baudRateTick: std_logic;    --SETS BAUD RATE

begin

pllCLK : clk_wiz_0 port map ( 
  -- Clock out ports  
   clk_out1 => CLK50MHZ,
  -- Status and control signals                
   reset => '0',
   locked => open,
   -- Clock in ports
   clk_in1 => CLK100MHZ
 );
 
 baudRateGenerator: mod_m_counter
     generic map(N=>8, M=>163)
     port map(clk=>CLK50MHZ, reset=>'0', max_tick=>baudRateTick, q=>open);
 
 tansmitOut : uart_tx generic map(DBIT=>8, SB_TICK=>16)
			  port map (clk=>CLK50MHZ, reset => '0', 
			  tx_start => txStart, s_tick=>baudRateTick,
			  din => txDataBuffer,tx_done_tick => txDone, 
			  tx => uart_rxd_out);
			  
led<=sw;

end Behavioral;
