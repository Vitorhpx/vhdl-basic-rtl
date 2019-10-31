library IEEE;
use IEEE.numeric_bit.all;

entity shift_r_2 is
  generic (
    constant BITS : integer := 32
    );
  port(D0     : in  bit_vector (BITS-1 downto 0);
        SAIDA : out bit_vector (BITS-1 downto 0)
        );
end shift_r_2;

architecture arch_shift_r_2 of shift_r_2 is
begin
  SAIDA <= "00" & D0(BITS-1 downto 2);
end arch_shift_r_2;
