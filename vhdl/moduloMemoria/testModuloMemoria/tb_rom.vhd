
library ieee;
use ieee.std_logic_1164.all;

entity tb_test is
end entity;

architecture test of tb_test is
	
 component rom
	port (
	address: in integer range 0 to 30;
	data:out std_logic_vector(7 downto 0)
	);
end component;
	signal address : integer range 0 to 30 ;
	signal data : std_logic_vector(7 downto 0);
begin
 UT : rom port map (address,data);
 address <= 0 after 0 ms , 1 after 5 ms , 2 after 10 ms , 2 after 15 ms , 4 after 20 ms  , 23 after 21 ms ;
end test;