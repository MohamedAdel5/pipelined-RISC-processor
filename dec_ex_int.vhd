LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY dec_ex_int IS
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
END dec_ex_int;

ARCHITECTURE a_dec_ex_int OF dec_ex_int IS

BEGIN

	PROCESS(clk)
	BEGIN
		IF rising_edge(clk) THEN
			ExtendedOffset <= ExtendedOffset_IN;
			Rsrc <= Rsrc_IN;
			Rdst <= Rdst_IN;
			DstBitsOut <= DstBitsOut_IN;
			SrcBitsOut <= SrcBitsOut_IN;
			ControlSignalsEX <= ControlSignalsEX_IN;
			ControlSignalsWB <= ControlSignalsWB_IN;
			ControlSignalsM <= ControlSignalsM_IN;
		END IF;
	END PROCESS;

END a_dec_ex_int;
