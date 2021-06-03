Library ieee;
use ieee.std_logic_1164.all;
ENTITY controlUnit IS
PORT(Clk,Rst : IN std_logic;
		   OpCode : IN std_logic_vector(6 DOWNTO 0);
		   ControlSignals : Out std_logic_vector(12 DOWNTO 0));
END controlUnit;

ARCHITECTURE CU OF controlUnit IS
BEGIN
        ControlSignals <= "0000000000000" when Rst= '1'
                else "0000000000000" when OpCode = "0000000"  --NOP
                else "0000100000000" when OpCode = "0000001"   --SETC
                else "0000110000000" when OpCode = "0000010"   --CLRC    
                else "0001000000001" when OpCode = "0000011"   --CLR RDST
                else "0001010000001" when OpCode = "0000100"   --NOT RDST
                else "0001100000001" when OpCode = "0000101"   --INC
                else "0001110000001" when OpCode = "0000110"   --DEC
                else "0010000000001" when OpCode = "0000111"   --NEG
                else "0000001100000" when OpCode = "0001000"   --Out
                else "0000000100001" when OpCode = "0001001"   --IN
                else "0011110000001" when OpCode = "0001010"   --RLC
                else "0100000000001" when OpCode = "0001011"   --RRC
                else "0000010000001" when OpCode = "0010000"   --MOV
                else "0010010000001" when OpCode = "0010001"   --Add
                else "0010100000001" when OpCode = "0010010"   --SUB
                else "0010110000001" when OpCode = "0010011"   --AND
                else "0011000000001" when OpCode = "0010100"   --OR
                else "1010010000001" when OpCode = "0010101"   --IADD
                else "1011010000001" when OpCode = "0010110"   --SHL
                else "1011100000001" when OpCode = "0010111"   --SHR
                else "0000000101001" when OpCode = "0100000"   --PUSH
                else "0000000001101" when OpCode = "0100001"   --POP
                else "1000010000000" when OpCode = "0100010"   --LDM
                else "0000000001010" when OpCode = "0100011"   --LDD
                else "0000000101010" when OpCode = "0100100"   --STD
                else "0000000000000" when OpCode = "1110000";   --RESET
END CU;