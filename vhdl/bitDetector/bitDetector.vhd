library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit_Detector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end bit_Detector;

architecture Behavioral of bit_Detector is
type estado is (B,I,T,space);
    signal estado_ini,estado_sig: estado ;
    signal charB,charI,charT,charSpace,estadoAnt: std_logic:='0';
    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
      end component;
      -- (A:61, B:62, C:63, D:64, E:65, F:66, G:67, H:68, I:69, J:6A,
-- K:6B, L:6C, M:6D, N:6E, O:6F, P:70, Q:71, R:72, S:73, T:74, U:75, V:76, W:77, X:78, Y:79, Z:7A)

-- (A:0, B:1, C:2, D:3, E:4, F:5, G:6, H:7, I:8, J:9,
-- K:10, L:11, M:12, N:13, O:14, P:15, Q:16, R:17, S:18, T:19, U:20, V:21, W:22, X:23, Y:24, Z:25)
begin
    memCompareB: memCompare port map (bitInput,1,isCorrect=>charB);
    memCompareI: memCompare port map (bitInput,8,isCorrect=>charI);
    memCompareT: memCompare port map (bitInput,19,isCorrect=>charT);
    memCompareSpace : memCompare port map(bitInput,26,isCorrect=>charSpace);
    process (clk , reset)
    begin   
        if(reset = '1') then 
        estado_ini <= B;
        elsif(rising_edge(clk)) then
            estado_ini<=estado_sig;
        end if;
     end process;
     process (charB,charI,charT,charSpace,estado_ini)
     begin
      case estado_ini is
-----------------------------------------------------------------------------
        when B =>
        if(charB = '1') then
            detectedBit<='0';
            estado_sig <=I;
        	elsif(estadoAnt = '1' and charSpace ='1') then 
            	detectedBit<='1';
        else
        detectedBit<='0';
        estadoAnt <='0';
        estado_sig <=B;
        end if;
---------------------------------------------------------------------------------
        when I =>
        if(charI = '1') then
                estado_sig<=T ;
        else
                estado_sig <=B;
        end if; 
------------------------------------------------------------------------------------
        when T =>
        if(charT = '1') then
            estado_sig <=space;
        else
            estado_sig <=B;
        end if;
----------------------------------------------------------------------------
        when space =>
        if(charSpace = '1')then
            detectedBit<='1';
            estadoAnt<='1';
            estado_sig<=B;
        else
            estado_sig<=B;
            estadoAnt<= '0';
            end if;
        when others => estadoAnt <='0';
    end case;
     end process;
end Behavioral ; -- Behavioral
