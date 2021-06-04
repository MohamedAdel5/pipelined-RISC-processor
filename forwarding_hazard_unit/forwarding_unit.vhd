LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY forwarding_unit IS
	PORT(
		EX_M_WB: IN std_logic;
		EX_M_dst_bits: IN std_logic_vector(2 DOWNTO 0);


		M_WB_WB: IN std_logic;
		M_WB_dst_bits: IN std_logic_vector(2 DOWNTO 0);

		ID_EX_src_bits: IN std_logic_vector(2 DOWNTO 0);
		ID_EX_dst_bits: IN std_logic_vector(2 DOWNTO 0);		

		forward_source: OUT std_logic_vector(1 DOWNTO 0);
		forward_destination: OUT std_logic_vector(1 DOWNTO 0)
	);
END forwarding_unit;

ARCHITECTURE a_forwarding_unit OF forwarding_unit IS


BEGIN

	forward_source <= "01" WHEN ((EX_M_WB = '1') AND (EX_M_dst_bits = ID_EX_src_bits))
		ELSE "10" WHEN ((M_WB_WB = '1') AND (M_WB_dst_bits = ID_EX_src_bits))
		ELSE "00";

	forward_destination <= "01" WHEN ((EX_M_WB = '1') AND (EX_M_dst_bits = ID_EX_dst_bits))
		ELSE "10" WHEN ((M_WB_WB = '1') AND (M_WB_dst_bits = ID_EX_dst_bits))
		ELSE "00";

END a_forwarding_unit;
