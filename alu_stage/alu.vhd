LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY n_alu IS
	PORT(
		CCR: IN std_logic_vector(2 DOWNTO 0);
		ALU_OP: IN std_logic_vector(4 DOWNTO 0);
		Source, Destination: IN std_logic_vector(31 DOWNTO 0);
		Alu_Result: OUT std_logic_vector(31 DOWNTO 0);
		CCR_Out: OUT std_logic_vector(2 DOWNTO 0)
	);
END n_alu;

ARCHITECTURE a_alu OF n_alu IS

SIGNAL intermediate_out: std_logic_vector(31 DOWNTO 0);
SIGNAL addition_result: std_logic_vector(32 DOWNTO 0);
SIGNAL shift_left_result: std_logic_vector(32 DOWNTO 0);
SIGNAL shift_right_result: std_logic_vector(32 DOWNTO 0);
SIGNAL zero_flag_result: std_logic;
SIGNAL negative_flag_result: std_logic;
SIGNAL carry_flag_result: std_logic;

BEGIN

	addition_result <= std_logic_vector(unsigned(('0' & Source)) + unsigned(('0' & Destination)));
	shift_left_result <= std_logic_vector(shift_left(unsigned(('0' & Destination)), to_integer(unsigned(Source))));
	shift_right_result <= std_logic_vector(shift_right(unsigned(('0' & Destination)), to_integer(unsigned(Source))));

	intermediate_out <= Destination WHEN ALU_OP = "00000"
		ELSE Source WHEN ALU_OP = "00001"
		ELSE Destination WHEN ALU_OP = "00010"
		ELSE Destination WHEN ALU_OP = "00011"
		ELSE (OTHERS => '0') WHEN ALU_OP = "00100"
		ELSE (NOT Destination) WHEN ALU_OP = "00101"
		ELSE std_logic_vector(unsigned(Destination) + 1) WHEN ALU_OP = "00110"
		ELSE std_logic_vector(unsigned(Destination) - 1) WHEN ALU_OP = "00111"
		ELSE std_logic_vector(unsigned((NOT Destination)) + 1) WHEN ALU_OP = "01000"
		ELSE addition_result(31 DOWNTO 0) WHEN ALU_OP = "01001"
		ELSE std_logic_vector(unsigned(Source) - unsigned(Destination)) WHEN ALU_OP = "01010"
		ELSE (Source AND Destination) WHEN ALU_OP = "01011"
		ELSE (Source OR Destination) WHEN ALU_OP = "01100"
		ELSE shift_left_result(31 DOWNTO 0) WHEN ALU_OP = "01101"
		ELSE shift_right_result(31 DOWNTO 0) WHEN ALU_OP = "01110"
		ELSE (Destination(30 DOWNTO 0) & CCR(2)) WHEN ALU_OP = "01111"
		ELSE (CCR(2) & Destination(31 DOWNTO 1)) WHEN ALU_OP = "10000";

	Alu_Result <= intermediate_out;
	zero_flag_result <= '1' WHEN (intermediate_out = "00000000000000000000000000000000") ELSE '0';
	negative_flag_result <= '1' WHEN (intermediate_out(31) = '1') ELSE '0';
	carry_flag_result <= '1' WHEN (unsigned(Source) < unsigned(Destination)) ELSE '0';

	-- Zero Flag
	CCR_Out(0) <= CCR(0) WHEN ALU_OP = "00000"
		ELSE CCR(0) WHEN ALU_OP = "00001"
		ELSE CCR(0) WHEN ALU_OP = "00010"
		ELSE CCR(0) WHEN ALU_OP = "00011"
		ELSE '1' WHEN ALU_OP = "00100"
		ELSE zero_flag_result WHEN ALU_OP = "00101"
		ELSE zero_flag_result WHEN ALU_OP = "00110"
		ELSE zero_flag_result WHEN ALU_OP = "00111"
		ELSE zero_flag_result WHEN ALU_OP = "01000"
		ELSE zero_flag_result WHEN ALU_OP = "01001"
		ELSE zero_flag_result WHEN ALU_OP = "01010"
		ELSE zero_flag_result WHEN ALU_OP = "01011"
		ELSE zero_flag_result WHEN ALU_OP = "01100"
		ELSE zero_flag_result WHEN ALU_OP = "01101"
		ELSE zero_flag_result WHEN ALU_OP = "01110"
		ELSE zero_flag_result WHEN ALU_OP = "01111"
		ELSE zero_flag_result WHEN ALU_OP = "10000";

	-- Negative Flag
	CCR_Out(1) <= CCR(1) WHEN ALU_OP = "00000"
		ELSE CCR(1) WHEN ALU_OP = "00001"
		ELSE CCR(1) WHEN ALU_OP = "00010"
		ELSE CCR(1) WHEN ALU_OP = "00011"
		ELSE CCR(1) WHEN ALU_OP = "00100"
		ELSE negative_flag_result WHEN ALU_OP = "00101"
		ELSE negative_flag_result WHEN ALU_OP = "00110"
		ELSE negative_flag_result WHEN ALU_OP = "00111"
		ELSE negative_flag_result WHEN ALU_OP = "01000"
		ELSE negative_flag_result WHEN ALU_OP = "01001"
		ELSE negative_flag_result WHEN ALU_OP = "01010"
		ELSE negative_flag_result WHEN ALU_OP = "01011"
		ELSE negative_flag_result WHEN ALU_OP = "01100"
		ELSE negative_flag_result WHEN ALU_OP = "01101"
		ELSE negative_flag_result WHEN ALU_OP = "01110"
		ELSE negative_flag_result WHEN ALU_OP = "01111"
		ELSE negative_flag_result WHEN ALU_OP = "10000";

	-- Carry Flag
	CCR_Out(2) <= CCR(2) WHEN ALU_OP = "00000"
		ELSE CCR(2) WHEN ALU_OP = "00001"
		ELSE '1' WHEN ALU_OP = "00010"
		ELSE '0' WHEN ALU_OP = "00011"
		ELSE CCR(2) WHEN ALU_OP = "00100"
		ELSE CCR(2) WHEN ALU_OP = "00101"
		ELSE CCR(2) WHEN ALU_OP = "00110"
		ELSE CCR(2) WHEN ALU_OP = "00111"
		ELSE CCR(2) WHEN ALU_OP = "01000"
		ELSE addition_result(32) WHEN ALU_OP = "01001"
		ELSE carry_flag_result WHEN ALU_OP = "01010"
		ELSE CCR(2) WHEN ALU_OP = "01011"
		ELSE CCR(2) WHEN ALU_OP = "01100"
		ELSE shift_left_result(32) WHEN ALU_OP = "01101"
		ELSE '0' WHEN ALU_OP = "01110"
		ELSE Destination(31) WHEN ALU_OP = "01111"
		ELSE Destination(0) WHEN ALU_OP = "10000";

END a_alu;
