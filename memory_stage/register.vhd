LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY n_register IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        DATA_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DATA_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END n_register;

ARCHITECTURE a_register OF n_register IS

    SIGNAL storage : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            storage <= (OTHERS => '0');
            DATA_OUT <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            DATA_OUT <= storage;
        ELSIF falling_edge(clk) THEN
            storage <= DATA_IN;
        END IF;
    END PROCESS;

END a_register;