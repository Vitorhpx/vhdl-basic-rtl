library IEEE;
use IEEE.numeric_bit.all;

entity mux_4x1 is
  generic (
    constant BITS : integer := 4
    );
  port(D3, D2, D1, D0 : in  bit_vector (BITS-1 downto 0);
        SEL           : in  bit_vector (1 downto 0);
        MUX_OUT       : out bit_vector (BITS-1 downto 0)
        );
end mux_4x1;

architecture arch_mux_4x1 of mux_4x1 is
begin
  MUX_OUT <= D3 when (SEL = "11") else
             D2 when (SEL = "10") else
             D1 when (SEL = "01") else
             D0 when (SEL = "00") else
             (others => '1');
end arch_mux_4x1;
