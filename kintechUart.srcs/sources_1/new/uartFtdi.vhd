library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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
		donetick               : OUT STD_LOGIC;
      
		DIN           		   : IN std_logic_vector(BitWidth-1 downto 0);
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

signal txDataBuffer : std_logic_vector(7 downto 0) := "01000001"; -- 'A'
signal baudRateTick: std_logic; --SETS BAUD RATE

type state_type is (init, send_A_byte, transmit, finishTransmission, done);
signal state : state_type;
signal state_next : state_type;

signal txShiftBuffer, txShiftBuffer_next : std_logic_vector (BitWidth-1 downto 0);

signal lower_Bounds : integer := 0;
signal lower_Bounds_next : integer := 0;
signal higher_Bounds : integer := 0;
signal higher_Bounds_next : integer := 0;
signal doneSig          : std_logic :='0';


 --(init, send_A_byte, transmit, finishTransmission, done);


begin
txDataBuffer <= txShiftBuffer( 7 downto 0);
        process(state)
			begin
				case state is
				
				when init =>
					higher_Bounds_next <= 7;
					doneSig <= '0';
					state_next <= send_A_byte;
				    txShiftBuffer_next <= DIN;
				    
				when send_A_byte =>
					if (higher_Bounds > bitWidth) then
							state_next <= done;
						else
							state_next <= transmit;
						end if;	
                     txShiftBuffer_next <= txShiftBuffer;
				
				when transmit => 
					if(txDone = '0') then 
						txStart_next <= '1';
						state_next <= transmit;
					else 
						txStart_next<='0';
						state_next <= finishTransmission;
					end if;					
					txShiftBuffer_next <= txShiftBuffer;				
				when finishTransmission =>					
					txStart_next <= '0';
                    txShiftBuffer_next <= "00000000" & txShiftBuffer(BitWidth-1 downto 8);
					higher_Bounds_next <= higher_Bounds+8;
					state_next <= send_A_byte;
					
				when done => 
					doneSig<='1';
					state_next <= init;
				
				end case;
		end process;
			
			
        
        --txCounter
        process(count)
        begin
         if (count > 60000) then --10000000 1 second
             count_next <= to_unsigned(0,16);
             blink_next   <= not blink;
             else
             count_next <=count+1;
             blink_next   <=  blink;
         end if;    
        end process; 
        
        --state shifting
        process(clk10MHZ)
            begin             
            
            if(rising_edge(clk10MHZ)) then
               count      <= count_next;
               blink      <= blink_next;
               txStart    <= txStart_next;
               state      <= state_next;
               higher_Bounds <= higher_Bounds_next;
               txShiftBuffer <= txShiftBuffer_next;
                end if;   
            end process;
         
        baudRateGenerator: mod_m_counter
						   generic map(N=>8, M=>62) 
						   port map(clk=>clk10MHZ, 
						   reset=>'0', max_tick=>baudRateTick, q=>open);     
	    tansmitOut       : uart_tx 
	                       generic map(DBIT=>8, SB_TICK=>16)
                           port map (clk=>clk10MHZ, reset => '0', 
						   tx_start => txStart, s_tick=>baudRateTick,
						   din => txDataBuffer,tx_done_tick => txDone, 
						   tx => USB_UART_RX_FPGA_TX_LS); 
       
--        txShiftBuffer <= unsigned(DIN); 
            donetick<=doneSig;
        heartBeatLED <= blink;
end Behavioral;
