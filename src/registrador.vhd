
library IEEE;
use IEEE.numeric_bit.all;

entity registrador IS 

generic (
    constant BITS : integer := 32
    );
PORT(
    d   : IN bit_vector(BITS-1 DOWNTO 0);
    ld  : IN bit; -- load/enable.
    clr : IN bit; -- async. clear.
    clk : IN bit; -- clock.
    q   : OUT bit_vector(BITS-1 DOWNTO 0) -- output
);
END registrador;

ARCHITECTURE description OF registrador IS

BEGIN
    process(clk, clr)
    begin
        if clr = '1' then
            q <= (others => '0');
        elsif rising_edge(clk) then
            if ld = '1' then
                q <= d;
            end if;
        end if;
    end process;
END description;