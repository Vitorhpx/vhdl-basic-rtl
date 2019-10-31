library IEEE;
use IEEE.numeric_bit.all;

entity shift_l_1 is
  generic (
    constant BITS : integer := 32
    );
  port(D0     : in  bit_vector (BITS-1 downto 0);
        SAIDA : out bit_vector (BITS-1 downto 0)
        );
end shift_l_1;

architecture arch_shift_l_1 of shift_l_1 is
begin
  SAIDA <= D0(BITS-2 downto 0) & '0';
end arch_shift_l_1;
