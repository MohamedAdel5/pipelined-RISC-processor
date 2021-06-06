LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY int IS
	PORT(
		clk: IN std_logic;
		rst: IN std_logic;
		IO_PORT: INOUT std_logic_vector(31 DOWNTO 0)
	);
END int;

ARCHITECTURE a_int OF int IS

COMPONENT fetchingStage IS
	PORT(
		HazardDetection,Clk,Rst : IN std_logic;
		   Offset : OUT std_logic_vector(15 DOWNTO 0);
		   OpCode : OUT std_logic_vector(6 DOWNTO 0);
		   SrcBits : OUT std_logic_vector(2 DOWNTO 0);
		   DstBits : OUT std_logic_vector(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fetch_int IS
	PORT(
		clk: IN std_logic;

		IF_ID_OP_CODE: IN std_logic_vector(6 DOWNTO 0);
		IF_ID_src_bits: IN std_logic_vector(2 DOWNTO 0);
		IF_ID_dst_bits: IN std_logic_vector(2 DOWNTO 0);

		IF_ID_OP_CODE_OUT: OUT std_logic_vector(6 DOWNTO 0);
		IF_ID_src_bits_OUT: OUT std_logic_vector(2 DOWNTO 0);
		IF_ID_dst_bits_OUT: OUT std_logic_vector(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT decodingStage IS
	PORT(
		Clk,Rst : IN std_logic;
		Offset : IN std_logic_vector(15 DOWNTO 0);
		OpCode : IN std_logic_vector(6 DOWNTO 0);
		SrcBitsIn : IN std_logic_vector(2 DOWNTO 0);
		DstBitsIn : IN std_logic_vector(2 DOWNTO 0);
           	DstBitsWrite: IN std_logic_vector(2 DOWNTO 0);
           	HazardDetection : IN std_logic;
           	ControlSignalsWBIN : IN std_logic;
           	WriteBackData : IN std_logic_vector(31 DOWNTO 0);
		ExtendedOffset : Out std_logic_vector(31 DOWNTO 0);
		Rsrc : Out std_logic_vector(31 DOWNTO 0);
		Rdst : Out std_logic_vector(31 DOWNTO 0);
		DstBitsOut : Out std_logic_vector(2 DOWNTO 0);
		SrcBitsOut : Out std_logic_vector(2 DOWNTO 0);
           	ControlSignalsEX : Out std_logic_vector(5 DOWNTO 0);
           	ControlSignalsWB : Out std_logic;
           	ControlSignalsM : Out std_logic_vector(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dec_ex_int IS
	PORT(
		clk: IN std_logic;
		ExtendedOffset_IN : IN std_logic_vector(31 DOWNTO 0);
		ExtendedOffset : Out std_logic_vector(31 DOWNTO 0);
		Rsrc_IN : IN std_logic_vector(31 DOWNTO 0);
		Rsrc : Out std_logic_vector(31 DOWNTO 0);
		Rdst_IN : IN std_logic_vector(31 DOWNTO 0);
		Rdst : Out std_logic_vector(31 DOWNTO 0);
		DstBitsOut_IN : IN std_logic_vector(2 DOWNTO 0);
		DstBitsOut : Out std_logic_vector(2 DOWNTO 0);
		SrcBitsOut_IN : IN std_logic_vector(2 DOWNTO 0);
		SrcBitsOut : Out std_logic_vector(2 DOWNTO 0);
		ControlSignalsEX_IN : IN std_logic_vector(5 DOWNTO 0);
		ControlSignalsEX : Out std_logic_vector(5 DOWNTO 0);
		ControlSignalsWB_IN : IN std_logic;
		ControlSignalsWB : Out std_logic;
		ControlSignalsM_IN : IN std_logic_vector(5 DOWNTO 0);
		ControlSignalsM : Out std_logic_vector(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu_stage_integration IS
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
END COMPONENT;

COMPONENT memory_stage_integration IS
	PORT(
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;

		CS_WB_IN : IN STD_LOGIC;
		CS_MEM_IN : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		dstbits_IN : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		Rsrc_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		offset_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALU_RESULT : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		SP_BUFFERED_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

		BUS_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		BUS_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

		CS_WB_OUT : OUT STD_LOGIC;
		WB_DATA_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dstbits_OUT : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		SP_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT forwarding_hazard_unit IS
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
END COMPONENT;

-- Out from fetching
signal fetch_Offset :  std_logic_vector(15 DOWNTO 0);
signal fetch_OpCode :  std_logic_vector(6 DOWNTO 0);
signal fetch_SrcBits :  std_logic_vector(2 DOWNTO 0);
signal fetch_DstBits :  std_logic_vector(2 DOWNTO 0);

-- Out fetch int
signal fetch_int_IF_ID_OP_CODE_OUT: std_logic_vector(6 DOWNTO 0);
signal fetch_int_IF_ID_src_bits_OUT: std_logic_vector(2 DOWNTO 0);
signal fetch_int_IF_ID_dst_bits_OUT: std_logic_vector(2 DOWNTO 0);

-- Out from decoding
signal dec_ExtendedOffset : std_logic_vector(31 DOWNTO 0);
signal dec_Rsrc : std_logic_vector(31 DOWNTO 0);
signal dec_Rdst : std_logic_vector(31 DOWNTO 0);
signal dec_DstBitsOut : std_logic_vector(2 DOWNTO 0);
signal dec_SrcBitsOut : std_logic_vector(2 DOWNTO 0);
signal dec_ControlSignalsEX : std_logic_vector(5 DOWNTO 0);
signal dec_ControlSignalsWB : std_logic;
signal dec_ControlSignalsM : std_logic_vector(5 DOWNTO 0);

-- Out from interface
signal int_ExtendedOffset : std_logic_vector(31 DOWNTO 0);
signal int_Rsrc : std_logic_vector(31 DOWNTO 0);
signal int_Rdst : std_logic_vector(31 DOWNTO 0);
signal int_DstBitsOut : std_logic_vector(2 DOWNTO 0);
signal int_SrcBitsOut : std_logic_vector(2 DOWNTO 0);
signal int_ControlSignalsEX : std_logic_vector(5 DOWNTO 0);
signal int_ControlSignalsWB : std_logic;
signal int_ControlSignalsM : std_logic_vector(5 DOWNTO 0);

-- Out from execution
signal ex_CS_WB_OUT: std_logic;
signal ex_CS_MEM_OUT: std_logic_vector(5 DOWNTO 0);
signal ex_Rsrc_OUT: std_logic_vector(31 DOWNTO 0);
signal ex_Rdst_OUT: std_logic_vector(31 DOWNTO 0);
signal ex_DstBits_OUT: std_logic_vector(2 DOWNTO 0);
signal ex_offset_OUT: std_logic_vector(31 DOWNTO 0);
signal ex_ALU_RESULT: std_logic_vector(31 DOWNTO 0);
signal ex_SP_OUT: std_logic_vector(31 DOWNTO 0);

-- Out from memory
signal mem_CS_WB_OUT : STD_LOGIC;
signal mem_WB_DATA_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal mem_dstbits_OUT : STD_LOGIC_VECTOR(2 DOWNTO 0);
signal mem_SP_OUT: STD_LOGIC_VECTOR(31 DOWNTO 0);

-- Out from forward_hazard
signal forward_source: std_logic_vector(1 DOWNTO 0);
signal forward_destination: std_logic_vector(1 DOWNTO 0);
signal hazard_detected: std_logic;

BEGIN

	fetching: fetchingStage PORT MAP (hazard_detected, clk, rst, fetch_Offset, fetch_OpCode, fetch_SrcBits, fetch_DstBits);

	fetch_interface: fetch_int PORT MAP (clk, fetch_OpCode, fetch_SrcBits, fetch_DstBits, fetch_int_IF_ID_OP_CODE_OUT, fetch_int_IF_ID_src_bits_OUT, fetch_int_IF_ID_dst_bits_OUT);

	decoding: decodingStage PORT MAP (clk, rst, fetch_Offset, fetch_OpCode, fetch_SrcBits, fetch_DstBits, mem_dstbits_OUT, hazard_detected, mem_CS_WB_OUT, mem_WB_DATA_OUT, dec_ExtendedOffset, dec_Rsrc, dec_Rdst, dec_DstBitsOut, dec_SrcBitsOut, dec_ControlSignalsEX, dec_ControlSignalsWB, dec_ControlSignalsM);

	interface: dec_ex_int PORT MAP (clk, dec_ExtendedOffset, int_ExtendedOffset, dec_Rsrc, int_Rsrc, dec_Rdst, int_Rdst, dec_DstBitsOut, int_DstBitsOut, dec_SrcBitsOut, int_SrcBitsOut, dec_ControlSignalsEX, int_ControlSignalsEX, dec_ControlSignalsWB, int_ControlSignalsWB, dec_ControlSignalsM, int_ControlSignalsM);

	execution: alu_stage_integration PORT MAP (clk ,rst, int_ControlSignalsWB, int_ControlSignalsM, int_ControlSignalsEX, int_Rsrc, int_Rdst, int_DstBitsOut, int_ExtendedOffset, mem_SP_OUT, forward_source, forward_destination, ex_ALU_RESULT, mem_WB_DATA_OUT, ex_CS_WB_OUT, ex_CS_MEM_OUT, ex_Rsrc_OUT, ex_Rdst_OUT, ex_DstBits_OUT, ex_offset_OUT, ex_ALU_RESULT, ex_SP_OUT);

	memory: memory_stage_integration PORT MAP (clk, rst, ex_CS_WB_OUT, ex_CS_MEM_OUT, ex_DstBits_OUT, ex_Rsrc_OUT, ex_offset_OUT, ex_ALU_RESULT, ex_SP_OUT, IO_PORT, IO_PORT, mem_CS_WB_OUT, mem_WB_DATA_OUT, mem_dstbits_OUT, mem_SP_OUT);

	forward_hazard: forwarding_hazard_unit PORT MAP (fetch_int_IF_ID_OP_CODE_OUT, fetch_int_IF_ID_src_bits_OUT, fetch_int_IF_ID_dst_bits_OUT, int_ControlSignalsM(5), int_ControlSignalsM(3), int_ControlSignalsM(4), int_SrcBitsOut, int_DstBitsOut, ex_CS_WB_OUT, ex_DstBits_OUT, mem_CS_WB_OUT, mem_dstbits_OUT, forward_source, forward_destination, hazard_detected);

END a_int;
