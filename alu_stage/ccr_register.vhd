LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY ccr_register IS
	PORT(
		clk: IN std_logic;
		rst: IN std_logic;
		DATA_IN: IN std_logic_vector(2 DOWNTO 0);
		DATA_OUT: OUT std_logic_vector(2 DOWNTO 0)
	);
END ccr_register;

ARCHITECTURE a_ccr_register OF ccr_register IS

SIGNAL storage: std_logic_vector(2 DOWNTO 0);

BEGIN

	PROCESS(clk, rst)
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

END a_ccr_register;
