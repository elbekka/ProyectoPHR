library ieee;
use ieee.std_logic_1164.all;

entity entityDetection is
  port (
    charInput : in std_logic_vector(7 downto 0);
    Y: out std_logic;
    state: out std_logic_vector(2 downto 0);
    reset: in std_logic;
    clk: in std_logic
  ) ;
end entity;

architecture arquitectura of entityDetection is

    
    signal internal_state:std_logic_vector(2 downto 0); 
    signal auxCorrect0,auxCorrect1,auxCorrect2,auxCorrect3,auxCorrect4,auxCorrect5:std_logic;

    component memCompare
    port (
    charInput : in std_logic_vector(7 downto 0);
    address   : in integer range 0 to 25 ;
    isCorrect : out std_logic
  ) ;
    end component;
begin    
salida:process (internal_state) is
begin
    case internal_state is
	when "110" =>Y <='1';
	when others =>Y <='0';
    end case;
end process salida;

--LLAMADAS A LAS ENTIDADES

comp1 : memCompare port map (charInput,4,auxCorrect0);
comp2 : memCompare port map (charInput,13,auxCorrect1);
comp3 : memCompare port map (charInput,19,auxCorrect2);
comp4 : memCompare port map (charInput,8,auxCorrect3);
comp5 : memCompare port map (charInput,19,auxCorrect4);
comp6 : memCompare port map (charInput,24,auxCorrect5);


proximo_estado:process(clk,reset)
begin
	if(reset='1') then
		internal_state<="111";
	elsif(rising_edge(clk)) then
		case internal_state is
			when "000"=>
				if auxCorrect0='1' then
					internal_state<="001";
				else
					internal_state<="111";
				end if;
			when "001"=>
				if auxCorrect1='1' then
					internal_state<="010";
				else
					internal_state<="111";		
				end if;	
			when "010"=>
				if auxCorrect2='1' then
					internal_state<="011";
				else
					internal_state<="111";
				end if;
			when "011"=>
				if auxCorrect3='1' then
					internal_state<="100";
				else
					internal_state<="111";
				end if;
			when "100"=>
				if auxCorrect4='1' then
					internal_state<="101";
				else
					internal_state<="111";
				end if;
			when "101"=>
				if auxCorrect5='1' then
					internal_state<="110";
				else
					internal_state<="111";
				end if;
			when others=>
				internal_state<="111";
		end case;
	end if;
end process proximo_estado;


end arquitectura;
