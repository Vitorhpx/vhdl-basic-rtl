library IEEE;
use IEEE.numeric_bit.all;

entity soma_sub is
  generic (
    constant BITS : integer := 32
    );
  port(A,B    : in  SIGNED  (BITS-1 downto 0);
       SUB   : in  bit;
       SAIDA : out bit_vector  (BITS-1 downto 0)
       );
end soma_sub;

architecture comportamental of soma_sub is

  signal tempSoma : SIGNED (BITS downto 0);
  signal tempSub  : SIGNED (BITS downto 0);
  signal tempSaida  : SIGNED (BITS-1 downto 0);



begin
  process(a, b)
  begin
    tempSoma <= ('0' & A) + ('0' & B);
    tempSub  <= ('0' & A) - ('0' & B);
  end process;

  tempSaida <= tempSub(BITS - 1 downto 0) when (SUB = '1') else tempSoma(BITS - 1 downto 0);
  SAIDA <= BIT_VECTOR(tempSaida);

end comportamental;
