library IEEE;
use IEEE.numeric_bit.all;

entity max is
  generic (
    constant BITS : integer := 32
    );
  port(D1, D0 : in  bit_vector (BITS-1 downto 0);
        SAIDA : out bit_vector (BITS-1 downto 0)
        );
end max;

architecture arch_max of max is

begin
  SAIDA <= D0 when (D0 > D1) else D1;
  
end arch_max;
