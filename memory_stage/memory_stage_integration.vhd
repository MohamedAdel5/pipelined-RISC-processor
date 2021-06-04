LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY alu_stage_integration IS
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

		CS_WB_OUT : OUT STD_LOGIC;
		WB_DATA_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dstbits_OUT : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		SP_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

	);
END alu_stage_integration;

ARCHITECTURE a_alu_stage_integration OF alu_stage_integration IS
	COMPONENT n_mem IS
		PORT (
			CS_MEM_IN : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			Rsrc_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			offset_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			ALU_RESULT : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			RAM_READ_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			PORT_IN_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			SP_BUFFERED_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			SP_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			SP_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			RAM_ADDRESS : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			WB_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			RAM_WE : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT m_wb_register IS
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			CS_WB_IN : IN STD_LOGIC;
			CS_WB_OUT : OUT STD_LOGIC;
			WB_DATA_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			WB_DATA_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			dstbits_OUT : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			dstbits_IN : IN STD_LOGIC_VECTOR(2 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT ram IS
		PORT (
			clk : IN STD_LOGIC;
			we : IN STD_LOGIC;
			address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			datain : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			dataout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT n_register IS
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			DATA_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			DATA_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT data_bus IS
		PORT (
			datain : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			dataout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;

	SIGNAL flag_out_alu_in : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL alu_out_flag_in : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL WB_DATA_IN : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RAM_READ_DATA : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RAM_ADDRESS : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RAM_WE : STD_LOGIC;
	SIGNAL SP_IN : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PORT_IN_DATA : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL data_bus_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL SP : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL SP_UPDATED : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

	data_bus_in <= ALU_RESULT WHEN CS_MEM_IN(3) = '1' AND CS_MEM_IN(4) = '1';
	SP_OUT <= SP;
	u1 : n_mem PORT MAP(CS_MEM_IN, Rsrc_IN, offset_IN, ALU_RESULT, RAM_READ_DATA, PORT_IN_DATA, SP_BUFFERED_IN, SP, SP_UPDATED, RAM_ADDRESS, WB_DATA_IN, RAM_WE);
	u2 : m_wb_register PORT MAP(clk, rst, CS_WB_IN, CS_WB_OUT, WB_DATA_IN, WB_DATA_OUT, dstbits_OUT, dstbits_IN);
	u3 : ram PORT MAP(clk, RAM_WE, RAM_ADDRESS, ALU_RESULT, RAM_READ_DATA);
	u4 : n_register PORT MAP(clk, rst, SP_UPDATED, SP);
	u5 : data_bus PORT MAP(data_bus_in, PORT_IN_DATA);

END a_alu_stage_integration;