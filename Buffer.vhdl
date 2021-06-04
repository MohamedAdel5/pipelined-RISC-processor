Library ieee;
use ieee.std_logic_1164.all;
ENTITY stageBuffer IS
GENERIC ( n : integer := 256);
PORT( E,Clk,Rst : IN std_logic;
		   d : IN std_logic_vector(n-1 DOWNTO 0);
		   q : OUT std_logic_vector(n-1 DOWNTO 0));
END stageBuffer;

ARCHITECTURE SB OF stageBuffer IS
BEGIN
PROCESS (E,Clk,Rst)
BEGIN
IF Rst = '1' THEN
		q <= (OTHERS=>'0');
ELSIF falling_edge(Clk) and E='1' THEN
		q <= d;
END IF;
END PROCESS;
END SB;