library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity topDriver is
  Port ( 
        SYSCLK_300_P           : IN STD_LOGIC; --300MHZ CLK
        SYSCLK_300_N           : IN STD_LOGIC; 
        heartBeatLED           : OUT STD_LOGIC;
        
        USB_UART_RX_FPGA_TX_LS : OUT  STD_LOGIC
  );
end topDriver;

architecture Behavioral of topDriver is

component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  clk_in1           : in     std_logic
 );
end component;

signal clk300MHZ : std_logic := '0';
signal clk10MHZ  : std_logic := '0';

component uartFtdi is
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
end component;

signal txData1 : std_logic_vector(7 downto 0) := "01000001"; --'A'
signal txData2 : std_logic_vector(7 downto 0) := "01000010"; --'B'
signal txData3 : std_logic_vector(7 downto 0) := "01000011"; --'C'
signal txData4 : std_logic_vector(7 downto 0) := "01000100"; --'D'

signal txDataSend : std_logic_vector (31 downto 0);

begin

    txDataSend <= txData1&txData2&txData3&txData4;

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
         
       test1 : uartFTDI
       generic map (BitWidth => 32, NumberOfBytes => 4)
			port map(
			clk10MHZ => clk10MHZ, heartBeatLED => heartBeatLED, donetick=>open, 
			DIN => txDataSend,
			USB_UART_RX_FPGA_TX_LS => USB_UART_RX_FPGA_TX_LS);
			

end Behavioral;
