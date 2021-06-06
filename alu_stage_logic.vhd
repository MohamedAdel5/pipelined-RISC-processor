LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY n_alu_logic IS
	PORT(
		CS_ALU_SOURCE: IN std_logic;
		CS_ALU_OPERATION: IN std_logic_vector(4 DOWNTO 0);
		Rsrc: IN std_logic_vector(31 DOWNTO 0);
		Rdst: IN std_logic_vector(31 DOWNTO 0);
		Offset: IN std_logic_vector(31 DOWNTO 0);
		Forward_Source: IN std_logic_vector(1 DOWNTO 0);
		Forward_Destination: IN std_logic_vector(1 DOWNTO 0);
		Rdst_MEM: IN std_logic_vector(31 DOWNTO 0);
		Rdst_WB: IN std_logic_vector(31 DOWNTO 0);
		CCR: IN std_logic_vector(2 DOWNTO 0);
		CCR_OUT: OUT std_logic_vector(2 DOWNTO 0);
		ALU_RESULT: OUT std_logic_vector(31 DOWNTO 0)
	);
END n_alu_logic;

ARCHITECTURE a_alu_logic OF n_alu_logic IS

COMPONENT n_alu IS
	PORT(
		CCR: IN std_logic_vector(2 DOWNTO 0);
		ALU_OP: IN std_logic_vector(4 DOWNTO 0);
		Source, Destination: IN std_logic_vector(31 DOWNTO 0);
		Alu_Result: OUT std_logic_vector(31 DOWNTO 0);
		CCR_Out: OUT std_logic_vector(2 DOWNTO 0)
	);
END COMPONENT;

SIGNAL first_source: std_logic_vector(31 DOWNTO 0);
SIGNAL source: std_logic_vector(31 DOWNTO 0);
SIGNAL destination: std_logic_vector(31 DOWNTO 0);

BEGIN

	first_source <= Rsrc WHEN Forward_Source = "00"
		ELSE Rdst_MEM WHEN Forward_Source = "01"
		ELSE Rdst_WB WHEN Forward_Source = "10";

	source <= first_source WHEN CS_ALU_SOURCE = '0'
		ELSE Offset;

	destination <= Rdst WHEN Forward_Destination = "00"
		ELSE Rdst_MEM WHEN Forward_Destination = "01"
		ELSE Rdst_WB WHEN Forward_Destination = "10";

	u1: n_alu PORT MAP (CCR, CS_ALU_OPERATION, source, destination, ALU_RESULT, CCR_OUT);

END a_alu_logic;
