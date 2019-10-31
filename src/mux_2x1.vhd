library IEEE;
use IEEE.numeric_bit.all;

entity mux_2x1 is
  generic (
    constant BITS : integer := 4
    );
  port(D1, D0   : in  bit_vector (BITS-1 downto 0);
        SEL     : in  bit;
        MUX_OUT : out bit_vector (BITS-1 downto 0)
        );
end mux_2x1;

architecture arch_mux_2x1 of mux_2x1 is
begin
  MUX_OUT <= D1 when (SEL = '1') else
             D0 when (SEL = '0') else
             (others => '1');
end arch_mux_2x1;
