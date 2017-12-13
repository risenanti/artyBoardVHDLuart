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
	generic(
		BitWidth 	  		   : integer := 32;
		NumberOfBytes 		   : integer :=4
	);
    Port ( 
		clk10MHZ  	  		   : IN std_logic; 
		heartBeatLED  		   : OUT STD_LOGIC;
      
		DIN           		   : IN std_logic_vector(BitWidth downto 0);
		USB_UART_RX_FPGA_TX_LS : OUT  STD_LOGIC
    );
end uartFtdi;

architecture Behavioral of uartFtdi is

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

signal count : unsigned(15 downto 0);
signal count_next : unsigned(15 downto 0);

signal blink : std_logic;
signal blink_next : std_logic;

signal txStart : STD_LOGIC;
signal txStart_next : std_logic;
signal txDone  : STD_LOGIC;
signal txDataBuffer : unsigned(7 downto 0) := "01000001"; -- 'A'
signal baudRateTick: std_logic; --SETS BAUD RATE

signal txShiftBuffer : unsigned (BitWidth downto 0);
signal txDataShiftTemp : unsigned (BitWidth downto 0);
signal lowerBounds : integer := 0;
--signal upperBounds : integer := 7;

begin
        
        process(count, blink)
        begin
         if (count > 60000) then --10000000 1 second
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
            
            txDataShiftTemp <= shift_right(txShiftBuffer, lowerBounds);
            txDataBuffer<= txDataShiftTemp(7 downto 0);
                        
            if(lowerBounds > BitWidth) then
				lowerBounds <= 0;
				end if;
            
            if(rising_edge(clk10MHZ)) then
               count <= count_next;
               blink  <=  blink_next;
               txStart<=txStart_next;
                end if;   
            end process;
            
        process(txDone)
           begin
            if(rising_edge(txDone)) then
            	--txStart<='0';
            	lowerBounds<=lowerBounds+7;
            end if;
            
            if (lowerBounds>BitWidth) then
                lowerBounds <= 0;
            end if;  
            end process;         
        
        txShiftBuffer <= unsigned(DIN);               
        baudRateGenerator: mod_m_counter
						
						   generic map(N=>8, M=>62) 
						   port map(clk=>clk10MHZ, 
						   reset=>'0', max_tick=>baudRateTick, q=>open);
            
	    tansmitOut       : uart_tx 
	                       generic map(DBIT=>8, SB_TICK=>16)
                           port map (clk=>clk10MHZ, reset => '0', 
						   tx_start => txStart, s_tick=>baudRateTick,
						   din => std_logic_vector(txDataBuffer),tx_done_tick => txDone, 
						   tx => USB_UART_RX_FPGA_TX_LS); 
        heartBeatLED <= blink;
end Behavioral;
