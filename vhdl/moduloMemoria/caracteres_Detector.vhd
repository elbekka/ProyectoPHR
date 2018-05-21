library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity caracteres_Detector  is 
port (
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end caracteres_Detector;

architecture Behavioral of caracteres_Detector is
	component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
      end component;
     
      signal k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,
	     k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,
	     k20,k21,k22,k23,k24,k25: std_logic;
begin 
	i0: memCompare port map (bitInput,0,isCorrect=>k0);
i1: memCompare port map (bitInput,0,isCorrect=>k0);
i2: memCompare port map (bitInput,1,isCorrect=>k1);
i3: memCompare port map (bitInput,2,isCorrect=>k2);
i4: memCompare port map (bitInput,3,isCorrect=>k3);
i5: memCompare port map (bitInput,4,isCorrect=>k4);
i6: memCompare port map (bitInput,5,isCorrect=>k5);
i7: memCompare port map (bitInput,6,isCorrect=>k6);
i8: memCompare port map (bitInput,7,isCorrect=>k7);
i9: memCompare port map (bitInput,8,isCorrect=>k8);
i10: memCompare port map (bitInput,9,isCorrect=>k9);
i11: memCompare port map (bitInput,10,isCorrect=>k10);
i12: memCompare port map (bitInput,11,isCorrect=>k11);
i13: memCompare port map (bitInput,12,isCorrect=>k12);
i14: memCompare port map (bitInput,13,isCorrect=>k13);
i15: memCompare port map (bitInput,14,isCorrect=>k14);
i16: memCompare port map (bitInput,15,isCorrect=>k15);
i17: memCompare port map (bitInput,16,isCorrect=>k16);
i18: memCompare port map (bitInput,17,isCorrect=>k17);
i19: memCompare port map (bitInput,18,isCorrect=>k18);
i20: memCompare port map (bitInput,19,isCorrect=>k19);
i21: memCompare port map (bitInput,20,isCorrect=>k20);
i22: memCompare port map (bitInput,21,isCorrect=>k21);
i23: memCompare port map (bitInput,22,isCorrect=>k22);
i24: memCompare port map (bitInput,23,isCorrect=>k23);
i25: memCompare port map (bitInput,24,isCorrect=>k24);
i26: memCompare port map (bitInput,25,isCorrect=>k25);

operacion: detectedBit<=k0 or k1 or k2 or k3 or k4 or k5 or 
			k6 or k7 or k8 or k9 or k10 or k11 or 
			k12 or k13  or k14 or k15 or k16 or
			k17 or k18 or k19 or k20 or k21 or k22 or
			k23 or k24 or k25;

end architecture;