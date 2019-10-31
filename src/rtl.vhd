library ieee;
use ieee.numeric_bit.all;

entity rtl is
    generic (
    constant BITS	 : integer := 10
    );
  port (
    clock   : in bit;
    reset   : in bit;
    iniciar : in bit;

    a : in bit_vector(BITS-1 downto 0);
    b : in bit_vector(BITS-1 downto 0);

    SAIDA : out bit_vector(BITS-1 downto 0);
    ok    : out bit

    );
end rtl;

architecture arch_circuito_rtl of rtl is

  signal s_ldr1 : bit;
  signal s_ldr2 : bit;
  signal s_ldr3 : bit;
  signal s_sub : bit;
  signal s_selmuxr1 : bit_vector(1 downto 0);
  signal s_selmuxr2 : bit_vector(1 downto 0);
  signal s_selmuxr3 : bit;


  component uc is
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
  end component;

  component fd is
    generic (
    constant BITSFD : integer := 32
    );
    port (
      clock : in bit;
      reset : in bit;

      a : in bit_vector(BITSFD-1 downto 0);
      b : in bit_vector(BITSFD-1 downto 0);

      r1sel : in bit_vector(1 downto 0);
      r2sel : in bit_vector(1 downto 0);
      r3sel : in bit;
      reg1  : in bit;
      reg2  : in bit;
      reg3  : in bit;

      sub : in bit;

      SAIDA : out bit_vector(BITSFD-1 downto 0)

      );
  end component;

begin

  UCI: uc  port map(clock, reset, iniciar, s_selmuxr1, s_selmuxr2, s_selmuxr3, s_ldr1, s_ldr2, s_ldr3, s_sub, ok);
  FDI: fd  generic map(BITSFD => 10) port map(clock, reset, a, b, s_selmuxr1, s_selmuxr2, s_selmuxr3, s_ldr1, s_ldr2, s_ldr3, s_sub, saida);

end arch_circuito_rtl;

