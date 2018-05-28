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

    signal 
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
 entDetector : entityDetection port map (clk,reset,bitInput);
 charDetector : CharDetector port map (clk,reset,bitInput);
 isDetector : is_Detector port map (clk,bitInput);
 endDetector : end_Detector port map(clk,reset,bitInput);
 espacioCompare : memCompare port map(bitInput);
 puntoCompare : memCompare port map (bitInput);
end behavioral ; -- behavioral