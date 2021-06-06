LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY fetch_int IS
	PORT(
		clk: IN std_logic;

		IF_ID_OP_CODE: IN std_logic_vector(6 DOWNTO 0);
		IF_ID_src_bits: IN std_logic_vector(2 DOWNTO 0);
		IF_ID_dst_bits: IN std_logic_vector(2 DOWNTO 0);

		IF_ID_OP_CODE_OUT: OUT std_logic_vector(6 DOWNTO 0);
		IF_ID_src_bits_OUT: OUT std_logic_vector(2 DOWNTO 0);
		IF_ID_dst_bits_OUT: OUT std_logic_vector(2 DOWNTO 0)
);
END fetch_int;

ARCHITECTURE a_fetch_int OF fetch_int IS

BEGIN

	PROCESS(clk)
	BEGIN
		IF rising_edge(clk) THEN
			IF_ID_OP_CODE_OUT <= IF_ID_OP_CODE;
			IF_ID_src_bits_OUT <= IF_ID_src_bits;
			IF_ID_dst_bits_OUT <= IF_ID_dst_bits;
		END IF;
	END PROCESS;

END a_fetch_int;
