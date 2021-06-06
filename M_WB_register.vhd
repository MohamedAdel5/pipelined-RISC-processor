LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY m_wb_register IS
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
END m_wb_register;

ARCHITECTURE a_m_wb_register OF m_wb_register IS

    SIGNAL CS_WB_storage : STD_LOGIC;
    SIGNAL WB_DATA_storage : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL dstbits_storage : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            CS_WB_storage <= '0';
            WB_DATA_storage <= (OTHERS => '0');
            dstbits_storage <= (OTHERS => '0');

            CS_WB_OUT <= '0';
            WB_DATA_OUT <= (OTHERS => '0');
            dstbits_OUT <= (OTHERS => '0');

        ELSIF rising_edge(clk) THEN
            CS_WB_OUT <= CS_WB_storage;
            dstbits_OUT <= dstbits_storage;
            WB_DATA_OUT <= WB_DATA_storage;

        ELSIF falling_edge(clk) THEN
            CS_WB_storage <= CS_WB_IN;
            dstbits_storage <= dstbits_IN;
            WB_DATA_storage <= WB_DATA_IN;
        END IF;
    END PROCESS;

END a_m_wb_register;