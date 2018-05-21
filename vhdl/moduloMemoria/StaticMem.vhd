library ieee;
use ieee.std_logic_1164.all;
entity rom24x8 is
port (
address: in integer range 0 to 25;
data:out std_logic_vector(7 downto 0)
);
end entity;
architecture sevenseg of rom24x8 is type rom_array is array(0 to 25) of std_logic_vector (7 downto 0);
constant rom: rom_array := ( x"61",x"62",x"63",x"64",x"65",x"66",
			     x"67",x"68",x"69",x"6A",x"6B",x"6C",
			     x"6D",x"6E",x"6F",x"70",x"71",x"72",
			     x"73",x"74",x"75",x"76",x"77",x"78",x"79",x"7A");
begin
data <= rom(address);
end architecture ;