LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY alu_stage_integration IS
	PORT(
		clk: IN std_logic;
		rst: IN std_logic;

		CS_WB_IN: IN std_logic;
		CS_MEM_IN: IN std_logic_vector(5 DOWNTO 0);
		CS_EXEC: IN std_logic_vector(5 DOWNTO 0);

		Rsrc_IN: IN std_logic_vector(31 DOWNTO 0);
		Rdst: IN std_logic_vector(31 DOWNTO 0);
		DstBits_IN: IN std_logic_vector(2 DOWNTO 0);
		offset_IN: IN std_logic_vector(31 DOWNTO 0);

		SP_IN: IN std_logic_vector(31 DOWNTO 0);

		Forward_Source: IN std_logic_vector(1 DOWNTO 0);
		Forward_Destination: IN std_logic_vector(1 DOWNTO 0);
		Rdst_MEM: IN std_logic_vector(31 DOWNTO 0);
		Rdst_WB: IN std_logic_vector(31 DOWNTO 0);

		CS_WB_OUT: OUT std_logic;
		CS_MEM_OUT: OUT std_logic_vector(5 DOWNTO 0);
		Rsrc_OUT: OUT std_logic_vector(31 DOWNTO 0);
		Rdst_OUT: OUT std_logic_vector(31 DOWNTO 0);
		DstBits_OUT: OUT std_logic_vector(2 DOWNTO 0);
		offset_OUT: OUT std_logic_vector(31 DOWNTO 0);
		ALU_RESULT: OUT std_logic_vector(31 DOWNTO 0);
		SP_OUT: OUT std_logic_vector(31 DOWNTO 0)
	);
END alu_stage_integration;

ARCHITECTURE a_alu_stage_integration OF alu_stage_integration IS

COMPONENT n_alu_logic IS
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
		ALU_RESULT: OUT std_logic_vector(31 DOWNTO 0);
		SrcFinal: OUT std_logic_vector(31 DOWNTO 0);
		DstFinal: OUT std_logic_vector(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ccr_register IS
	PORT(
		clk: IN std_logic;
		rst: IN std_logic;
		DATA_IN: IN std_logic_vector(2 DOWNTO 0);
		DATA_OUT: OUT std_logic_vector(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ex_m_register IS
	PORT(
		clk: IN std_logic;
		rst: IN std_logic;
		CS_MEM_IN: IN std_logic_vector(5 DOWNTO 0);
		CS_MEM_OUT: OUT std_logic_vector(5 DOWNTO 0);
		CS_WB_IN: IN std_logic;
		CS_WB_OUT: OUT std_logic;
		Rsrc_IN: IN std_logic_vector(31 DOWNTO 0);
		Rsrc_OUT: OUT std_logic_vector(31 DOWNTO 0);
		Rdst_IN: IN std_logic_vector(31 DOWNTO 0);
		Rdst_OUT: OUT std_logic_vector(31 DOWNTO 0);
		dstbits_IN: IN std_logic_vector(2 DOWNTO 0);
		dstbits_OUT: OUT std_logic_vector(2 DOWNTO 0);
		offset_IN: IN std_logic_vector(31 DOWNTO 0);
		offset_OUT: OUT std_logic_vector(31 DOWNTO 0);
		ALU_RESULT_IN: IN std_logic_vector(31 DOWNTO 0);
		ALU_RESULT_OUT: OUT std_logic_vector(31 DOWNTO 0);
		SP_BUFFERED_IN: IN std_logic_vector(31 DOWNTO 0);
		SP_BUFFERED_OUT: OUT std_logic_vector(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL flag_out_alu_in: std_logic_vector(2 DOWNTO 0);
SIGNAL alu_out_flag_in: std_logic_vector(2 DOWNTO 0);
SIGNAL ALU_OUT_TEMP: std_logic_vector(31 DOWNTO 0);
Signal RsrcFinal: std_logic_vector(31 DOWNTO 0);
Signal RdstFinal: std_logic_vector(31 DOWNTO 0);

BEGIN

	u1: n_alu_logic PORT MAP (CS_EXEC(5), CS_EXEC(4 DOWNTO 0), Rsrc_IN, Rdst, offset_IN, Forward_Source, Forward_Destination, Rdst_MEM, Rdst_WB, flag_out_alu_in, alu_out_flag_in, ALU_OUT_TEMP,RsrcFinal,RdstFinal);
	u2: ccr_register PORT MAP (clk, rst, alu_out_flag_in, flag_out_alu_in);
	u3: ex_m_register PORT MAP (clk, rst, CS_MEM_IN, CS_MEM_OUT, CS_WB_IN, CS_WB_OUT, RsrcFinal, Rsrc_OUT,Rdst, Rdst_OUT, DstBits_IN, DstBits_OUT, offset_IN, offset_OUT, ALU_OUT_TEMP, ALU_RESULT, SP_IN, SP_OUT);

END a_alu_stage_integration;
