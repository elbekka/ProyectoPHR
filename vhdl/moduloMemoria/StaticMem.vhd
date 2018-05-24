library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity rom24x8 is
port (
address: in integer range 0 to 25;
data:out std_logic_vector(7 downto 0)
);
end entity;
architecture sevenseg of rom24x8 is type rom_array is array(0 to 30) of std_logic_vector (7 downto 0);
constant rom: rom_array := ( x"61",x"62",x"63",x"64",x"65",x"66",
			     x"67",x"68",x"69",x"6A",x"6B",x"6C",
			     x"6D",x"6E",x"6F",x"70",x"71",x"72",
			     x"73",x"74",x"75",x"76",x"77",x"78",
			     x"79",x"7A",x"32",x"40",x"41",x"58",
			     x"59");
--------------------------------------------------------------------------------------------------------------------------------------------
--Contenido de la ROM:
--Con Posición nos referimos a la posicion que se encuentra cada letra del codigo ascii en nuestra ROM.
--Significado traduccion de  lo que representa en el código ascii. 
-- [Posición/Significado]-->{ [0,A],[1,B],[2,C],[3,D],[4,E],[5,F],[6,G],[7,H],[8,I],[9,J],[10,K],[11,L],[12,M],[13,N],[14,O],[15,P]
-- 			      [16,Q],[17,R],[18,S],[19,T],[20,U],[21,V],[22,W],[23,X],[24,Y],[25,Z],[26,"ESPACIO"],[27,"("],[28,")"],
--			      [29,":"],[30,";"].}
----------------------------------------------------------------------------------------------------------------------------------------------

--32=(espacio) ;40= "("; 41= ")" ; 58=":" ; 59=";"
begin
data <= rom(address);
end architecture ;