LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ram IS
	GENERIC (n : INTEGER := 16);
	PORT (
		clk : IN STD_LOGIC;
		we : IN STD_LOGIC;
		address : IN STD_LOGIC_VECTOR(2 * n - 1 DOWNTO 0);
		datain : IN STD_LOGIC_VECTOR(2 * n - 1 DOWNTO 0);
		dataout : OUT STD_LOGIC_VECTOR(2 * n - 1 DOWNTO 0));
END ENTITY ram;

ARCHITECTURE syncrama OF ram IS

	TYPE ram_type IS ARRAY(0 TO 2047) OF STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
	SIGNAL ram : ram_type := (
		OTHERS => X"0000"
	);
	SIGNAL RamOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
	PROCESS (clk) IS
	BEGIN
		IF rising_edge(clk) THEN
			IF we = '1' THEN
				ram(to_integer(unsigned(address))) <= datain;
			END IF;
		END IF;
	END PROCESS;
	RamOut(15 DOWNTO 0) <= ram(to_integer(unsigned(address)));
	RamOut(31 DOWNTO 16) <= ram(to_integer(unsigned(address)) + 1);
	dataout <= RamOut;
END syncrama;