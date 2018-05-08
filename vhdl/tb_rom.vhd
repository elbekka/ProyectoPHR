
entity tb_test is
end entity;

architecture test of tb_test is
 component rom24x8
	signal adress : integer range 0 to 23;
	port (
	address: in integer range 0 to 23;
	data:out std_ulogic_vector(7 downto 0)
	);
end component;
begin
 adress <= 0 ;
 UT : rom24x8 port map (adress,data);
end test;