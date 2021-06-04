LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY data_ram IS
	GENERIC (n : INTEGER := 32);
	PORT (
		clk : IN STD_LOGIC;
		we : IN STD_LOGIC;
		address : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		datain : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		dataout : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
END ENTITY data_ram;

ARCHITECTURE syncrama OF data_ram IS

	TYPE ram_type IS ARRAY(0 TO 2047) OF STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
	SIGNAL ram : ram_type := (
		OTHERS => STD_LOGIC_VECTOR(to_unsigned(0,
		n))
	);

BEGIN
	PROCESS (clk) IS
	BEGIN
		IF rising_edge(clk) THEN
			IF we = '1' THEN
				ram(to_integer(unsigned(address))) <= datain;
			END IF;
		END IF;
	END PROCESS;
	dataout <= ram(to_integer(unsigned(address))) WHEN to_integer(unsigned(address)) < 2048;
END syncrama;