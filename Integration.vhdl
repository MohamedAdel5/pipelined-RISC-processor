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

	signal HazardDetection :std_logic;


BEGIN

fecthing: fetchingStage PORT map(HazardDetection,Clk,Rst,Offset,OpCode ,SrcBits ,DstBits);
decoding: decodingStage PORT map(Clk,Rst ,Offset ,OpCode ,SrcBitsIn ,DstBitsIn ,DstBitsWrite,HazardDetection ,ControlSignalsWBIN ,WriteBackData ,ExtendedOffset ,Rsrc ,Rdst ,DstBitsOut ,SrcBitsOut ,ControlSignalsEX ,ControlSignalsWB ,ControlSignalsM );
execution: alu_stage_integration PORT map(Clk, Rst , CS_WB_IN , CS_MEM_IN ,CS_EXEC,Rsrc_IN,Rdst,DstBits_IN,offset_IN,SP_IN,Forward_Source,Forward_Destination,Rdst_MEM,Rdst_WB,CS_WB_OUT,CS_MEM_OUT,Rsrc_OUT,DstBits_OUT,offset_OUT,ALU_RESULT,SP_OUT);
memory: memory_stage_integration PORT map(Clk ,Rst,CS_WB_IN,CS_MEM_IN ,dstbits_IN ,Rsrc_IN ,offset_IN ,ALU_RESULT ,SP_BUFFERED_IN,BUS_IN ,BUS_OUT ,CS_WB_OUT ,WB_DATA_OUT ,dstbits_OUT ,SP_OUT );
hazards: forwarding_hazard_unit PORT mapPORT(IF_ID_OP_CODE,IF_ID_src_bits,IF_ID_dst_bits,ID_EX_read_write,ID_EX_MEM_IO,ID_EX_PORT_IO,ID_EX_src_bits,ID_EX_dst_bits,EX_M_WB,EX_M_dst_bits,M_WB_WB,M_WB_dst_bits,forward_source,forward_destination,HazardDetection);

END int;