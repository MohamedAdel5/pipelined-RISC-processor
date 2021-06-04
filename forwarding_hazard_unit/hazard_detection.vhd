LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY hazard_detection IS
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
END hazard_detection;

ARCHITECTURE a_hazard_detection OF hazard_detection IS

SIGNAL IF_ID_reads_src: std_logic;
SIGNAL IF_ID_reads_dst: std_logic;

BEGIN

	IF_ID_reads_src <= '1'
		WHEN ((IF_ID_OP_CODE >= "0010000") AND (IF_ID_OP_CODE <= "0010100")) OR (IF_ID_OP_CODE = "0100011") OR (IF_ID_OP_CODE = "0100100")
		ELSE '0';

	IF_ID_reads_dst <= '0'
		WHEN (IF_ID_OP_CODE = "0000000") OR (IF_ID_OP_CODE = "0000001") OR (IF_ID_OP_CODE = "0000010") OR (IF_ID_OP_CODE = "0000011")
		ELSE '1';

	hazard_detected <= '1'
		WHEN ((ID_EX_MEM_IO = '1') OR (ID_EX_PORT_IO = '1')) AND (ID_EX_read_write = '0') AND (((IF_ID_src_bits = ID_EX_dst_bits) AND (IF_ID_reads_src = '1')) OR ((IF_ID_dst_bits = ID_EX_dst_bits) AND (IF_ID_reads_dst = '1')))
		ELSE '0';

END a_hazard_detection;
