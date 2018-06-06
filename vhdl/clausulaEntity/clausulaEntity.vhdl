library ieee;
use ieee.std_logic_1164.all;

entity entityClaus is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end entity;

architecture behavioral of entityClaus is

    signal entDetected,endDetected,charPuntoComa,interrupcion : std_logic := '0';
    signal seguimiento : std_logic_vector(2 downto 0);
    type state_type is (stringEntity,stringEnd,puntoComa);
    signal state : state_type := stringEntity;

    component entityDetection is
        port (
          clk: in std_logic;
          reset : in std_logic;
          bitInput : in std_logic_vector(7 downto 0);
          detectedBit : out std_logic -- '1' si ha detectado la secuencia.
        ) ;
      end component;
      component CharDetector is
        port (
          clk: in std_logic;
          reset : in std_logic;
          bitInput : in std_logic_vector(7 downto 0);
          detectedBit : out std_logic -- '1' si ha detectado la secuencia.
        ) ;
      end component;
      component is_Detector is
        port (
          clk: in std_logic;
          bitInput : in std_logic_vector(7 downto 0);
          detectedBit : out std_logic -- '1' si ha detectado la secuencia.
        ) ;
      end component;
      
    component end_Detector is
    port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
    ) ;
    end component;

    component memCompare is
    port (
      charInput : in std_logic_vector(7 downto 0);
      address   : in integer range 0 to 30 ;
      isCorrect : out std_logic
    ) ;
  end component;
begin
 entDetector : entityDetection port map (clk,reset,bitInput,entDetected);
 --charDetector : CharDetector port map (clk,reset,bitInput);
 --isDetector : is_Detector port map (clk,bitInput);
 endDetector : end_Detector port map(clk,reset,bitInput,endDetected);
 --espacioCompare : memCompare port map(bitInput);
 puntoCompare : memCompare port map (bitInput,30,charPuntoComa);

 process (clk)
    begin
	if(reset='1') then
		detectedBit <='0';
		state <= stringEntity;
		interrupcion <= '0';
	elsif(rising_edge(clk)) then
    case state is
      when stringEntity =>
        detectedBit <= '0';
        seguimiento <= "000";
        if(entDetected = '1')then 
        
          state <= stringEnd;
        end if;
        when stringEnd =>
        seguimiento <= "010";
         if(endDetected = '1') then
          state <= PuntoComa;
         end if;
         when PuntoComa =>
         seguimiento <= "100";
          if(charPuntoComa = '1') then
            detectedBit <= '1';
             end if;
            when OTHERS => null;
		end case;
	end if;
   end process;
end behavioral ; -- behavioral