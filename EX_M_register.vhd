LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY ex_m_register IS
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
END ex_m_register;

ARCHITECTURE a_ex_m_register OF ex_m_register IS

SIGNAL CS_MEM_storage: std_logic_vector(5 DOWNTO 0);
SIGNAL CS_WB_storage: std_logic;
SIGNAL Rsrc_storage: std_logic_vector(31 DOWNTO 0);
SIGNAL Rdst_storage: std_logic_vector(31 DOWNTO 0);
SIGNAL dstbits_storage: std_logic_vector(2 DOWNTO 0);
SIGNAL offset_storage: std_logic_vector(31 DOWNTO 0);
SIGNAL ALU_RESULT_storage: std_logic_vector(31 DOWNTO 0);
SIGNAL SP_BUFFERED_storage: std_logic_vector(31 DOWNTO 0);

BEGIN

	PROCESS(clk, rst)
	BEGIN
		IF rst = '1' THEN
			CS_MEM_storage <= (OTHERS => '0');
			CS_WB_storage <= '0';
			Rsrc_storage <= (OTHERS => '0');
			Rdst_storage <= (OTHERS => '0');
			dstbits_storage <= (OTHERS => '0');
			offset_storage <= (OTHERS => '0');
			ALU_RESULT_storage <= (OTHERS => '0');
			SP_BUFFERED_storage <= (OTHERS => '0');

			CS_MEM_OUT <= (OTHERS => '0');
			CS_WB_OUT <= '0';
			Rsrc_OUT <= (OTHERS => '0');
			Rdst_OUT <= (OTHERS => '0');
			dstbits_OUT <= (OTHERS => '0');
			offset_OUT <= (OTHERS => '0');
			ALU_RESULT_OUT <= (OTHERS => '0');
			SP_BUFFERED_OUT <= (OTHERS => '0');

		ELSIF rising_edge(clk) THEN
			CS_MEM_OUT <= CS_MEM_storage;
			CS_WB_OUT <= CS_WB_storage;
			Rsrc_OUT <= Rsrc_storage;
			Rdst_OUT <= Rdst_storage;
			dstbits_OUT <= dstbits_storage;
			offset_OUT <= offset_storage;
			ALU_RESULT_OUT <= ALU_RESULT_storage;
			SP_BUFFERED_OUT <= SP_BUFFERED_storage;

		ELSIF falling_edge(clk) THEN
			CS_MEM_storage <= CS_MEM_IN;
			CS_WB_storage <= CS_WB_IN;
			Rsrc_storage <= Rsrc_IN;
			Rdst_storage <= Rdst_IN;
			dstbits_storage <= dstbits_IN;
			offset_storage <= offset_IN;
			ALU_RESULT_storage <= ALU_RESULT_IN;
			SP_BUFFERED_storage <= SP_BUFFERED_IN;
		END IF;
	END PROCESS;

END a_ex_m_register;