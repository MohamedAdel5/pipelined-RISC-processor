LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ram IS
	GENERIC (n : INTEGER := 16);
	PORT (
		clk : IN STD_LOGIC;
		we : IN STD_LOGIC;
		address : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		datain : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		dataout : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
END ENTITY ram;

ARCHITECTURE syncrama OF ram IS

	TYPE ram_type IS ARRAY(0 TO 2047) OF STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
	SIGNAL ram : ram_type := (

		0 => STD_LOGIC_VECTOR(to_unsigned(4097,
		n)),
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
	dataout <= ram(to_integer(unsigned(address)));
END syncrama;