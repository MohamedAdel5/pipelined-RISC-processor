LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY data_bus IS
    PORT (
        datain : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        dataout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY data_bus;

ARCHITECTURE n_data_bus OF ram IS
BEGIN
    dataout <= datain;
END n_data_bus;