library ieee;
use ieee.numeric_bit.all;

entity uc is
  port (
    clock   : in  bit;
    reset   : in  bit;
    iniciar : in  bit;
    r1sel   : out bit_vector(1 downto 0);
    r2sel   : out bit_vector(1 downto 0);
    r3sel   : out bit;
    reg1    : out bit;
    reg2    : out bit;
    reg3    : out bit;
    sub     : out bit;
    ok      : out bit
    );
end;

architecture architecture_uc of uc is

  type   tipo_estado is (inicial, s0, s1, s2, s3, s4, s5, s6, s7, pronto);
  signal Eatual : tipo_estado;          -- estado atual
  signal Eprox  : tipo_estado;          -- proximo estado

begin


  process (reset, clock)
  begin
    if reset = '1' then
      Eatual <= inicial;
    elsif clock'event and clock = '1' then
      Eatual <= Eprox;
    end if;
  end process;

  -- logica de proximo estado
  process (Eatual)
  begin

    case Eatual is

      when inicial => if (iniciar = '1') then Eprox <= s0;
                      else Eprox <= inicial;
                      end if;
      when s0     => Eprox <= s1;
      when s1     => Eprox <= s2;
      when s2     => Eprox <= s3;
      when s3     => Eprox <= s4;
      when s4     => Eprox <= s5;
      when s5     => Eprox <= s6;
      when s6     => Eprox <= s7;
      when s7     => Eprox <= pronto;
      when pronto => Eprox <= pronto;
      when others => Eprox <= inicial;

    end case;
    
    
  end process;

  -- logica de saida (Moore)

  with Eatual select
    r1sel <= "00" when s1,
    "01"          when s4,
    "10"          when s7,
    "00"          when others;
  
  with Eatual select
    r2sel <= "00" when s0,
    "01"          when s2,
    "01"          when s6,
    "10"          when s3,
    "00"          when others;

  with Eatual select
    r3sel <= '0' when s0,
    '1'          when s5,
    '0'          when others;

  with Eatual select
    reg1 <= '1' when s1,
    '1'         when s4,
    '1'         when s7,
    '0'         when others;

  with Eatual select
    reg2 <= '1' when s0,
    '1'         when s2,
    '1'         when s3,
    '1'         when s6,
    '0'         when others;
  with Eatual select
    reg3 <= '1' when s0,
    '1'         when s5,
    '0'         when others;


  with Eatual select
    sub <= '1' when s6,
    '0'        when others;
  
  with Eatual select
    ok <= '1' when pronto,
    '0'       when others;
  


end architecture_uc;
