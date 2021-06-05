LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memory_stage_integration IS
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
		SP_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

	);
END memory_stage_integration;

ARCHITECTURE a_memory_stage_integration OF memory_stage_integration IS
	COMPONENT n_mem IS
		PORT (
			CS_MEM_IN : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			Rsrc_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			offset_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			ALU_RESULT : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			RAM_READ_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			PORT_IN_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			SP_BUFFERED : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
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

	COMPONENT data_ram IS
		GENERIC (n : INTEGER := 32);
		PORT (
			clk : IN STD_LOGIC;
			we : IN STD_LOGIC;
			address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			datain : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			dataout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT sp_register IS
		GENERIC (n : INTEGER := 32);
		PORT (
			E, Clk, Rst : IN STD_LOGIC;
			d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
	END COMPONENT;

	COMPONENT tri_state_buffer IS
		GENERIC (n : INTEGER := 32);
		PORT (
			E : IN STD_LOGIC;
			d : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
			f : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0));

	END COMPONENT;
	SIGNAL flag_out_alu_in : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL alu_out_flag_in : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL WB_DATA_IN : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RAM_READ_DATA : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RAM_ADDRESS : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RAM_WE : STD_LOGIC;
	SIGNAL SP_IN : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL SP : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL SP_UPDATED : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL DATA_OUT_TRISTATE_EN : STD_LOGIC;
BEGIN

	DATA_OUT_TRISTATE_EN <= '1' WHEN CS_MEM_IN(5) = '1' AND CS_MEM_IN(4) = '1'
		ELSE
		'0';
	-- DATA_OUT_TRISTATE_EN <= CS_MEM_IN(5) = '1' AND CS_MEM_IN(4) = '1';

	SP_OUT <= SP;
	u1 : n_mem PORT MAP(CS_MEM_IN, Rsrc_IN, offset_IN, ALU_RESULT, RAM_READ_DATA, BUS_IN, SP_BUFFERED_IN, SP, SP_UPDATED, RAM_ADDRESS, WB_DATA_IN, RAM_WE);
	u2 : m_wb_register PORT MAP(clk, rst, CS_WB_IN, CS_WB_OUT, WB_DATA_IN, WB_DATA_OUT, dstbits_OUT, dstbits_IN);
	u3 : data_ram PORT MAP(clk, RAM_WE, RAM_ADDRESS, ALU_RESULT, RAM_READ_DATA);
	u4 : sp_register PORT MAP(CS_MEM_IN(0), clk, rst, SP_UPDATED, SP);
	u5 : tri_state_buffer PORT MAP(DATA_OUT_TRISTATE_EN, ALU_RESULT, BUS_OUT);

END a_memory_stage_integration;