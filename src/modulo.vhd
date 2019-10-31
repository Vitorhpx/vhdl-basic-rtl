library IEEE;
use IEEE.numeric_bit.all;

entity modulo is
  generic (
    constant BITS : integer := 32
    );
  port(D0     : in  bit_vector (BITS-1 downto 0);
        SAIDA : out bit_vector (BITS-1 downto 0)
        );
end modulo;

architecture arch_modulo of modulo is

begin
  SAIDA <= '0' & D0(BITS-2 downto 0);
  
end arch_modulo;
