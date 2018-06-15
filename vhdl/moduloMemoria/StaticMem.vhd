library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity rom is
port (
address: in integer range 0 to 30;
data:out std_logic_vector(7 downto 0)
);
end entity;
architecture sevenseg of rom is type rom_array is array(0 to 30) of std_logic_vector (7 downto 0);
constant rom: rom_array := ( x"61",x"62",x"63",x"64",x"65",x"66",
			     			 x"67",x"68",x"69",x"6A",x"6B",x"6C",
			     			 x"6D",x"6E",x"6F",x"70",x"71",x"72",
			     			 x"73",x"74",x"75",x"76",x"77",x"78",
			     			 x"79",x"7A",x"20",x"40",x"41",x"58",
			     			 x"3B");
--------------------------------------------------------------------------------------------------------------------------------------------
--Contenido de la ROM:
--Con Posici�n nos referimos a la posicion que se encuentra cada letra del codigo ascii en nuestra ROM.
--Significado traduccion de  lo que representa en el codigo ascii. 
-- [Posici�n/Significado]-->{ [0,A,61],[1,B,62],[2,C,63],[3,D,64],[4,E,65],[5,F,66],[6,G,67]
--							  [7,H,68],[8,I,69],[9,J,6A],[10,K,6B],[11,L,6C],[12,M,6D]
--							  [13,N,6E],[14,O,6F],[15,P,70],[16,Q,71],[17,R,72],[18,S,73]
--							  [19,T,74],[20,U,75],[21,V,76],[22,W,77],[23,X,78],[24,Y,79]
--							  [25,Z,7A],[26,"ESPACIO",20],[27,"(",40],[28,")",41]
--			      			  [29,":",58],[30,";",3B].}
----------------------------------------------------------------------------------------------------------------------------------------------

--20=(espacio) ;40= "("; 41= ")" ; 58=":" ; 59=";"
begin
data <= rom(address);
end architecture ;