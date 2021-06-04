LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY my_nDFF IS
    GENERIC (n : INTEGER := 32);
    PORT (
        E, Clk, Rst : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
END my_nDFF;

ARCHITECTURE a_my_nDFF OF my_nDFF IS
BEGIN
    PROCESS (E, Clk, Rst)
    BEGIN
        IF Rst = '1' THEN
            q <= (OTHERS => '0');
        ELSIF rising_edge(Clk) AND E = '1' THEN
            q <= d;
        END IF;
    END PROCESS;
END a_my_nDFF;