LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sp_register IS
    GENERIC (n : INTEGER := 32);
    PORT (
        E, Clk, Rst : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
END sp_register;

ARCHITECTURE a_sp_register OF sp_register IS
BEGIN
    PROCESS (E, Clk, Rst)
    BEGIN
        IF Rst = '1' THEN
            q <= STD_LOGIC_VECTOR(to_unsigned(2047,
                n));

        ELSIF rising_edge(Clk) AND E = '1' THEN
            q <= d;
        END IF;
    END PROCESS;
END a_sp_register;