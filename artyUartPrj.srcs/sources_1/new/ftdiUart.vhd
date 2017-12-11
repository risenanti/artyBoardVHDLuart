library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ftdiUart is
  Port ( 
  CLK : IN STD_LOGIC;
  data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  
  start : in std_logic;
  done  : out std_logic;
  
  );
end ftdiUart;

architecture Behavioral of ftdiUart is

begin


end Behavioral;
