library ieee;
use ieee.numeric_bit.all;

entity fd is
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
end fd;

architecture arch_circuito_fd of fd is
  signal s_r1 : bit_vector(BITSFD-1 downto 0);
  signal s_r2 : bit_vector(BITSFD-1 downto 0);
  signal s_r3 : bit_vector(BITSFD-1 downto 0);

  signal s_muxr1 : bit_vector(BITSFD-1 downto 0);
  signal s_muxr2 : bit_vector(BITSFD-1 downto 0);
  signal s_muxr3 : bit_vector(BITSFD-1 downto 0);

  -- signal s_selmuxr1 : bit_vector(1 downto 0);
  -- signal s_selmuxr2 : bit_vector(1 downto 0);
  -- signal s_selmuxr3 : bit;

  signal s_modulo  : bit_vector(BITSFD-1 downto 0);
  signal s_somasub : bit_vector(BITSFD-1 downto 0);
  signal s_shift_l : bit_vector(BITSFD-1 downto 0);
  signal s_shift_r : bit_vector(BITSFD-1 downto 0);
  signal s_max     : bit_vector(BITSFD-1 downto 0);



  component max is
    generic (
      constant BITS : integer := 32
      );
    port(D1, D0 : in  bit_vector (BITS-1 downto 0);
         SAIDA  : out bit_vector (BITS-1 downto 0)
         );
  end component;

  component modulo is
    generic (
      constant BITS : integer := 32
      );
    port(D0    : in  bit_vector (BITS-1 downto 0);
         SAIDA : out bit_vector (BITS-1 downto 0)
         );
  end component;

  component mux_2x1 is
    generic (
      constant BITS : integer := 4
      );
    port(D1, D0  : in  bit_vector (BITS-1 downto 0);
         SEL     : in  bit;
         MUX_OUT : out bit_vector (BITS-1 downto 0)
         );
  end component;

  component mux_4x1 is
    generic (
      constant BITS : integer := 4
      );
    port(D3, D2, D1, D0 : in  bit_vector (BITS-1 downto 0);
         SEL            : in  bit_vector (1 downto 0);
         MUX_OUT        : out bit_vector (BITS-1 downto 0)
         );
  end component;

  component shift_l_1 is
    generic (
      constant BITS : integer := 32
      );
    port(D0    : in  bit_vector (BITS-1 downto 0);
         SAIDA : out bit_vector (BITS-1 downto 0)
         );
  end component;

  component shift_r_2 is
    generic (
      constant BITS : integer := 32
      );
    port(D0    : in  bit_vector (BITS-1 downto 0);
         SAIDA : out bit_vector (BITS-1 downto 0)
         );
  end component;

  component soma_sub is
  generic (
    constant BITS : integer := 32
    );
  port(A,B    : in  SIGNED  (BITS-1 downto 0);
       SUB   : in  bit;
       SAIDA : out bit_vector  (BITS-1 downto 0)
       );
  end component;

  component registrador is 
  generic (
    constant BITS : integer := 32
    );
    port(
    d   : in  bit_vector(BITS-1 downto 0);
    ld  : in  bit;                     -- load/enable.
    clr : in  bit;                     -- async. clear.
    clk : in  bit;                     -- clock.
    q   : out bit_vector(BITS-1 downto 0)  -- output
    );
  end component;


begin

  MUXR1 : mux_4x1 generic map(BITS => BITSFD) port map((others => '0'), s_max, s_shift_l, s_modulo, r1sel, s_muxr1);
  MUXR2 : mux_4x1 generic map(BITS => BITSFD) port map((others => '0'), s_modulo, s_somasub, a, r2sel, s_muxr2);
  MUXR3 : mux_2x1 generic map(BITS => BITSFD) port map(s_shift_r, b, r3sel, s_muxr3);

  R1 : registrador generic map(BITS => BITSFD) port map (s_muxr1, reg1, reset, clock, s_r1);
  R2 : registrador generic map(BITS => BITSFD) port map (s_muxr2, reg2, reset, clock, s_r2);
  R3 : registrador generic map(BITS => BITSFD) port map (s_muxr3, reg3, reset, clock, s_r3);


  MODU    : modulo generic map(BITS => BITSFD) port map(s_r2, s_modulo);
  SOMASUB : soma_sub generic map(BITS => BITSFD) port map(SIGNED(s_r2),SIGNED(s_r3), sub, s_somasub);
  SHIFTL  : shift_l_1 generic map(BITS => BITSFD) port map(s_r1, s_shift_l);
  SHIFTR  : shift_r_2 generic map(BITS => BITSFD) port map(s_r2, s_shift_r);
  MAXIMO     : max generic map(BITS => BITSFD) port map(s_r1, s_r2, s_max);

  
  SAIDA <= s_r1;
  
end arch_circuito_fd;

