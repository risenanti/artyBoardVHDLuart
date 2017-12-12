library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity uartFtdi is
  Port ( 
      SYSCLK_300_P           : IN STD_LOGIC; --300MHZ CLK
      SYSCLK_300_N           : IN STD_LOGIC; 
      heartBeatLED           : OUT STD_LOGIC;
      
      USB_UART_RX_FPGA_TX_LS : OUT  STD_LOGIC
  );
end uartFtdi;

architecture Behavioral of uartFtdi is

--signal count : integer := 0;
signal count : unsigned(15 downto 0);
signal count_next : unsigned(15 downto 0);
constant one : unsigned(15 downto 0) := "0000000000000001";
signal clk300MHZ : std_logic;
signal clk10MHZ  : std_logic;
signal blink : std_logic;
signal blink_next : std_logic;

component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  clk_in1           : in     std_logic
 );
end component;

component mod_m_counter is
   generic(
      N: integer := 4;     -- number of bits
      M: integer := 10     -- mod-M
  );
   port(
      clk, reset: in std_logic;
      max_tick: out std_logic;
      q: out std_logic_vector(N-1 downto 0)
		--slower_clk:out std_logic
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

signal txStart : STD_LOGIC;
signal txStart_next : std_logic;
signal txDone  : STD_LOGIC;
signal txDataBuffer : std_logic_vector(7 downto 0) := "01000001"; -- 'A'
signal baudRateTick: std_logic; --SETS BAUD RATE

begin
    clk_buf :IBUFGDS
        generic map(
            IBUF_LOW_PWR => TRUE,
            -- low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
            IOSTANDARD => "LVDS"
        )
        port map (
            O  => clk300MHZ, -- clock buffer output
            I  => SYSCLK_300_P,    -- diff_p clock buffer input
            IB => SYSCLK_300_N     -- diff_n clock buffer input
        );
        
        clkMHZ : clk_wiz_0
           port map ( 
          -- Clock out ports  
           clk_out1 => clk10MHZ,
           -- Clock in ports
           clk_in1 => clk300MHZ
         );
        
        process(count, blink)
        begin
         if (count > 60000) then --300000000 1 second
             blink_next   <= not blink;
             count_next <= to_unsigned(0,16);
             txStart_next <= not txStart;
             else
             count_next <=count+1;
             blink_next   <=  blink;
         end if;    
        end process;
        
        
        
        process(clk10MHZ)
            begin
            if(rising_edge(clk10MHZ)) then
               --count <= std_logic_vector (unsigned(count)+unsigned(one));
               count <= count_next;
               blink  <=  blink_next;
               txStart<=txStart_next;
                end if;   
            end process;
                       
baudRateGenerator: mod_m_counter
    generic map(N=>8, M=>62) --10mhz clk to get 115200 * 16 for oversampling
    port map(clk=>clk10MHZ, reset=>'0', max_tick=>baudRateTick, q=>open);
            
tansmitOut : uart_tx generic map(DBIT=>8, SB_TICK=>16)
                 port map (clk=>clk10MHZ, reset => '0', 
                          tx_start => txStart, s_tick=>baudRateTick,
                          din => txDataBuffer,tx_done_tick => txDone, 
                          tx => USB_UART_RX_FPGA_TX_LS); 
heartBeatLED <= blink;
end Behavioral;
