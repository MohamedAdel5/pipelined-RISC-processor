LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY forwarding_hazard_unit IS
	PORT(
		IF_ID_OP_CODE: IN std_logic_vector(6 DOWNTO 0);
		IF_ID_src_bits: IN std_logic_vector(2 DOWNTO 0);
		IF_ID_dst_bits: IN std_logic_vector(2 DOWNTO 0);

		ID_EX_read_write: IN std_logic;
		ID_EX_MEM_IO: IN std_logic;
		ID_EX_PORT_IO: IN std_logic;
		ID_EX_src_bits: IN std_logic_vector(2 DOWNTO 0);
		ID_EX_dst_bits: IN std_logic_vector(2 DOWNTO 0);

		EX_M_WB: IN std_logic;
		EX_M_dst_bits: IN std_logic_vector(2 DOWNTO 0);

		M_WB_WB: IN std_logic;
		M_WB_dst_bits: IN std_logic_vector(2 DOWNTO 0);

		forward_source: OUT std_logic_vector(1 DOWNTO 0);
		forward_destination: OUT std_logic_vector(1 DOWNTO 0);
		hazard_detected: OUT std_logic
	);
END forwarding_hazard_unit;

ARCHITECTURE a_forwarding_hazard_unit OF forwarding_hazard_unit IS

COMPONENT hazard_detection IS
	PORT(
		ID_EX_read_write: IN std_logic;
		ID_EX_MEM_IO: IN std_logic;
		ID_EX_PORT_IO: IN std_logic;
		ID_EX_dst_bits: IN std_logic_vector(2 DOWNTO 0);
		IF_ID_OP_CODE: IN std_logic_vector(6 DOWNTO 0);
		IF_ID_src_bits: IN std_logic_vector(2 DOWNTO 0);
		IF_ID_dst_bits: IN std_logic_vector(2 DOWNTO 0);
		hazard_detected: OUT std_logic
	);
END COMPONENT;

COMPONENT forwarding_unit IS
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
END COMPONENT;

BEGIN

	u1: hazard_detection PORT MAP (ID_EX_read_write, ID_EX_MEM_IO, ID_EX_PORT_IO, ID_EX_dst_bits, IF_ID_OP_CODE, IF_ID_src_bits, IF_ID_dst_bits, hazard_detected);
	u2: forwarding_unit PORT MAP (EX_M_WB, EX_M_dst_bits, M_WB_WB, M_WB_dst_bits, ID_EX_src_bits, ID_EX_dst_bits, forward_source, forward_destination);

END a_forwarding_hazard_unit;
