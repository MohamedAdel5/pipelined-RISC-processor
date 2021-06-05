Library ieee;
use ieee.std_logic_1164.all;
ENTITY decodingStage IS
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
END decodingStage;
ARCHITECTURE decode OF decodingStage IS

    COMPONENT registerFile IS
    PORT(Clk,Rst : IN std_logic;
		   WriteBackData : IN std_logic_vector(31 DOWNTO 0);
		   SrcBitsRead : IN std_logic_vector(2 DOWNTO 0);
		   DstBitsRead : IN std_logic_vector(2 DOWNTO 0);
		   DstBitsWrite : IN std_logic_vector(2 DOWNTO 0);
           ControlSignalWB : IN std_logic;
		   Rsrc : Out std_logic_vector(31 DOWNTO 0);
		   Rdst : Out std_logic_vector(31 DOWNTO 0));
    END COMPONENT;

    COMPONENT controlUnit IS
    PORT(Clk,Rst : IN std_logic;
		   OpCode : IN std_logic_vector(6 DOWNTO 0);
		   ControlSignals : Out std_logic_vector(12 DOWNTO 0));
    END COMPONENT;

    COMPONENT stageBuffer IS
    GENERIC ( n : integer := 114);
    PORT( E,Clk,Rst : IN std_logic;
            d : IN std_logic_vector(n-1 DOWNTO 0);
            q : OUT std_logic_vector(n-1 DOWNTO 0));
    END COMPONENT;   

signal DataToWrite :std_logic_vector(114 DOWNTO 0);
signal DataToRead :std_logic_vector(114 DOWNTO 0);
signal ControlSignals : std_logic_vector(12 DOWNTO 0);
signal ControlSignalsAfterHazard : std_logic_vector(12 DOWNTO 0);
signal ExOffset : std_logic_vector(31 DOWNTO 0) := "00000000000000000000000000000000";
signal RsrcDec : std_logic_vector(31 DOWNTO 0);
signal RdstDec : std_logic_vector(31 DOWNTO 0);
BEGIN
ExOffset(15 downto 0) <= Offset;
CU:  controlUnit PORT map (Clk,Rst,OpCode,ControlSignals);
RegFile: registerFile PORT map (Clk,Rst,WriteBackData,SrcBitsIn,DstBitsIn,DstBitsWrite,ControlSignalsWBIN,RsrcDec,RdstDec);
ControlSignalsAfterHazard <= "0000000000000" when HazardDetection ='1'
    else ControlSignals;
DataToWrite(114 downto 112) <= SrcBitsIn;
DataToWrite(111) <= ControlSignalsAfterHazard(0);
DataToWrite(110 downto 105) <= ControlSignalsAfterHazard(6 downto 1);
DataToWrite(104 downto 99) <= ControlSignalsAfterHazard(12 downto 7);
DataToWrite(98 downto 67) <= RsrcDec;
DataToWrite(66 downto 35) <= RdstDec;
DataToWrite(34 downto 32) <= DstBitsIn;
DataToWrite(31 downto 0) <= ExOffset;
IDEX: stageBuffer GENERIC MAP(115) port map('1' ,Clk,Rst,DataToWrite,DataToRead);
ExtendedOffset <= DataToRead(31 downto 0);
Rsrc <= DataToRead(98 downto 67) ;
Rdst <= DataToRead(66 downto 35);
DstBitsOut <=DataToRead(34 downto 32) ;
SrcBitsOut <=DataToRead(114 downto 112) ;
ControlSignalsEX <= DataToRead(104 downto 99) ;
ControlSignalsWB <= DataToRead(111) ;
ControlSignalsM  <= DataToRead(110 downto 105) ;
END decode;