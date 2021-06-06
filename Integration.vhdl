Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY integration IS
PORT( Clk,Rst : IN std_logic;
		   IOPort : INOUT std_logic_vector(31 DOWNTO 0));
END integration;
ARCHITECTURE int OF integration IS

    COMPONENT fetchingStage IS
    PORT( HazardDetection,Clk,Rst : IN std_logic;
		   Offset : OUT std_logic_vector(15 DOWNTO 0);
		   OpCode : OUT std_logic_vector(6 DOWNTO 0);
		   SrcBits : OUT std_logic_vector(2 DOWNTO 0);
		   DstBits : OUT std_logic_vector(2 DOWNTO 0));
    END  COMPONENT;

    COMPONENT decodingStage IS
    PORT(Clk,Rst : IN std_logic;
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
           ControlSignalsM : Out std_logic_vector(5 DOWNTO 0));
    END  COMPONENT;

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
		ControlSignalsM : Out std_logic_vector(5 DOWNTO 0));
    END  COMPONENT;

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
		SP_OUT: OUT std_logic_vector(31 DOWNTO 0));
    END  COMPONENT;

    COMPONENT memory_stage_integration IS
	PORT (
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
		SP_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    END  COMPONENT;

    Component forwarding_hazard_unit IS
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
		hazard_detected: OUT std_logic);
    END component;

	--Fetching Signals
	signal Offset :std_logic_vector(15 DOWNTO 0);
	signal OpCode : std_logic_vector(6 DOWNTO 0);
	signal SrcBitsFetch : std_logic_vector(2 DOWNTO 0);
	signal DstBitsFetch : std_logic_vector(2 DOWNTO 0);
	--Decoding Signals
	signal ExtendedOffset : std_logic_vector(31 DOWNTO 0);
	signal RsrcDec : std_logic_vector(31 DOWNTO 0);
	signal RdstDec : std_logic_vector(31 DOWNTO 0);
	signal DstBitsDec : std_logic_vector(2 DOWNTO 0);
	signal SrcBitsDec : std_logic_vector(2 DOWNTO 0);
	signal ControlSignalsEX : std_logic_vector(5 DOWNTO 0);
	signal ControlSignalsWB : std_logic;
	signal ControlSignalsM : std_logic_vector(5 DOWNTO 0);

	--Interface Signals
	signal ExtendedOffset_int : std_logic_vector(31 DOWNTO 0);
	signal RsrcDec_int : std_logic_vector(31 DOWNTO 0);
	signal RdstDec_int : std_logic_vector(31 DOWNTO 0);
	signal DstBitsDec_int : std_logic_vector(2 DOWNTO 0);
	signal SrcBitsDec_int : std_logic_vector(2 DOWNTO 0);
	signal ControlSignalsEX_int : std_logic_vector(5 DOWNTO 0);
	signal ControlSignalsWB_int : std_logic;
	signal ControlSignalsM_int : std_logic_vector(5 DOWNTO 0);

	--Execution Signals
	signal CS_WB_EX:  std_logic;
	signal CS_MEM_EX:  std_logic_vector(5 DOWNTO 0);
	signal RsrcEX:  std_logic_vector(31 DOWNTO 0);
	signal RdstEX:  std_logic_vector(31 DOWNTO 0);
	signal DstBits_EX:  std_logic_vector(2 DOWNTO 0);
	signal offset_EX:  std_logic_vector(31 DOWNTO 0);
	signal ALU_RESULT:  std_logic_vector(31 DOWNTO 0);
	signal SP_EX:  std_logic_vector(31 DOWNTO 0);
	--Memory Signals
	signal ControlSignalsWBIN : STD_LOGIC;
	signal WriteBackData : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal DstBitsWrite : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal SPMem : STD_LOGIC_VECTOR(31 DOWNTO 0);

	--Hazard Signals
	signal HazardDetection :std_logic;
	signal forward_source: std_logic_vector(1 DOWNTO 0);
	signal forward_destination: std_logic_vector(1 DOWNTO 0);



BEGIN

fecthing: fetchingStage PORT map(HazardDetection,Clk,Rst,Offset,OpCode ,SrcBitsFetch ,DstBitsFetch);
decoding: decodingStage PORT map(Clk,Rst ,Offset ,OpCode ,SrcBitsFetch ,DstBitsFetch ,DstBitsWrite,HazardDetection ,ControlSignalsWBIN ,WriteBackData ,ExtendedOffset ,RsrcDec ,RdstDec ,DstBitsDec ,SrcBitsDec ,ControlSignalsEX ,ControlSignalsWB ,ControlSignalsM );
interface: dec_ex_int PORT map (Clk,ExtendedOffset ,ExtendedOffset_int ,RsrcDec ,RsrcDec_int ,RdstDec ,RdstDec_int,DstBitsDec ,DstBitsDec_int ,SrcBitsDec ,SrcBitsDec_int,ControlSignalsEX ,ControlSignalsEX_int,ControlSignalsWB ,ControlSignalsWB_int ,ControlSignalsM ,ControlSignalsM_int);
execution: alu_stage_integration PORT map(Clk, Rst , ControlSignalsWB_int , ControlSignalsM_int ,ControlSignalsEX_int,RsrcDec_int,RdstDec_int,DstBitsDec_int,ExtendedOffset_int,SPMem,forward_source,forward_destination,RdstEX,WriteBackData,CS_WB_EX,CS_MEM_EX,RsrcEX,RdstEX,DstBits_EX,offset_EX,ALU_RESULT,SP_EX);
memory: memory_stage_integration PORT map(Clk ,Rst,CS_WB_EX,CS_MEM_EX ,DstBits_EX ,RsrcEX ,offset_EX ,ALU_RESULT ,SP_EX,IOPort ,IOPort ,ControlSignalsWBIN ,WriteBackData ,DstBitsWrite ,SPMem );
hazards: forwarding_hazard_unit PORT map(OpCode,SrcBitsFetch,DstBitsFetch,ControlSignalsM_int(5),ControlSignalsM_int(3),ControlSignalsM_int(4),SrcBitsDec_int,DstBitsDec_int,CS_WB_EX,DstBits_EX ,ControlSignalsWBIN,DstBitsWrite,forward_source,forward_destination,HazardDetection);

END int;