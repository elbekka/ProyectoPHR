library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

entity jk_ff is
    port(
        J,K,Clk : in std_logic;        --JK Flip-Flop gate input 1 & 2
        Q,notQ : out std_logic         --JK Flip-Flop gate output
    );
end entity;

architecture result of jk_ff is        
signal out1,out2: std_logic;
signal out3 : std_logic := '0'; -- Need proper initialization
signal out4 : std_logic := '0'; -- Need proper initialization

begin

    process(clk)

    begin
       if(rising_edge(clk)) then
           out1    <= NOT(J AND out4);
           out2    <= NOT(K AND out3); 
       end if;
    end process;
    out3    <= out1 NAND out4;
    out4    <= out2 NAND out3; 
    Q       <= out3;
    notQ    <= out4;    

end result;