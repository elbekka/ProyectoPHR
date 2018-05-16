library ieee;
use ieee.std_logic_1164.all;

entity test_entityDetection is
end entity;

architecture dataFlow of test_entityDetection is
 signal charInput : std_logic_vector(7 downto 0);
 signal Y : std_logic;
 signal state : std_logic_vector(2 downto 0);
 signal reset: std_logic;
 signal clk: std_logic;
 constant ClockFrequency : integer := 100e6; -- 100 MHz
 constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

    component entityDetection
    port (   charInput : in std_logic_vector(7 downto 0);
   		 Y: out std_logic;
    		state: out std_logic_vector(2 downto 0);
    		reset: in std_logic;
    		clk: in std_logic
  ) ;

    end component;

begin
ed1: entityDetection port map(charInput,Y,state,reset,clk);

	clk <= not clk after ClockPeriod / 2;
	reset <= '0' after 0 ns;
	charInput <= "01100101" after 10 ns , "01101110" after 20 ns ,
             "01110100" after 30 ns ,"01101001" after 40 ns ,
	     "01110100" after 50 ns ,"01111001" after 60 ns ;
 	reset <= '1' after 70 ns;
	

end dataFlow ;