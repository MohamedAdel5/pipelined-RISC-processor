Library ieee;
use ieee.std_logic_1164.all;
ENTITY registerFile IS
PORT(Clk,Rst : IN std_logic;
		   WriteBackData : IN std_logic_vector(31 DOWNTO 0);
		   SrcBitsRead : IN std_logic_vector(2 DOWNTO 0);
		   DstBitsRead : IN std_logic_vector(2 DOWNTO 0);
		   DstBitsWrite : IN std_logic_vector(2 DOWNTO 0);
           ControlSignalWB : IN std_logic;
		   Rsrc : Out std_logic_vector(31 DOWNTO 0);
		   Rdst : Out std_logic_vector(31 DOWNTO 0));
END registerFile;

ARCHITECTURE regFile OF registerFile IS
	COMPONENT my_nDFF IS
		GENERIC ( n : integer := 32);
		PORT( E,Clk,Rst : IN std_logic;
			d : IN std_logic_vector(n-1 DOWNTO 0);
			q : OUT std_logic_vector(n-1 DOWNTO 0));
	END COMPONENT;

	COMPONENT tri_state_buffer IS
        GENERIC ( n : integer := 16);
	port( E : in std_logic;
              d : in std_logic_vector (n-1 downto 0);
              f : out std_logic_vector (n-1 downto 0));

         END COMPONENT;

	signal R0: std_logic_vector (31 downto 0);
	signal R1: std_logic_vector (31 downto 0);
	signal R2: std_logic_vector (31 downto 0);
	signal R3: std_logic_vector (31 downto 0);
	signal R4: std_logic_vector (31 downto 0);
	signal R5: std_logic_vector (31 downto 0);
	signal R6: std_logic_vector (31 downto 0);
	signal R7: std_logic_vector (31 downto 0);
	signal RsrsDecoderRead: std_logic_vector (7 downto 0):= "00000000" ;
	signal RdstDecoderRead: std_logic_vector (7 downto 0):= "00000000" ;
	signal RdstDecoderWrite: std_logic_vector (7 downto 0):= "00000000" ;
	signal WriteEnable : std_logic_vector (7 downto 0) := "00000000";



BEGIN
	RsrsDecoderRead <=  "00000000"  when Rst='1'
				Else "00000001" when SrcBitsRead = "000"
				Else "00000010"  when SrcBitsRead = "001"
				Else "00000100"  when SrcBitsRead = "010"
				Else "00001000"  when SrcBitsRead = "011"
				Else "00010000"  when SrcBitsRead = "100"
				Else "00100000"  when SrcBitsRead = "101"
				Else "01000000"  when SrcBitsRead = "110"
				Else "10000000"  when SrcBitsRead = "111";
	RdstDecoderRead <= "00000000"  when Rst='1'
				Else "00000001" when DstBitsRead = "000"
				Else "00000010"  when DstBitsRead = "001"
				Else "00000100"  when DstBitsRead = "010"
				Else "00001000"  when DstBitsRead = "011"
				Else "00010000"  when DstBitsRead = "100"
				Else "00100000"  when DstBitsRead = "101"
				Else "01000000"  when DstBitsRead = "110"
				Else "10000000"  when DstBitsRead = "111";
	RdstDecoderWrite <= "00000000"  when Rst='1'
				Else "00000001" when DstBitsWrite = "000"
				Else "00000010"  when DstBitsWrite = "001"
				Else "00000100"  when DstBitsWrite = "010"
				Else "00001000"  when DstBitsWrite = "011"
				Else "00010000"  when DstBitsWrite = "100"
				Else "00100000"  when DstBitsWrite = "101"
				Else "01000000"  when DstBitsWrite = "110"
				Else "10000000"  when DstBitsWrite = "111";			
	WriteEnable <= RdstDecoderWrite when ControlSignalWB = '1'
				else "00000000";		

	reg0: my_nDFF GENERIC MAP(32) port map(WriteEnable(0) ,Clk,Rst,WriteBackData,R0);
	reg1: my_nDFF GENERIC MAP(32) port map(WriteEnable(1) ,Clk,Rst,WriteBackData,R1);
	reg2: my_nDFF GENERIC MAP(32) port map(WriteEnable(2) ,Clk,Rst,WriteBackData,R2);
	reg3: my_nDFF GENERIC MAP(32) port map(WriteEnable(3) ,Clk,Rst,WriteBackData,R3);
	reg4: my_nDFF GENERIC MAP(32) port map(WriteEnable(4) ,Clk,Rst,WriteBackData,R4);
	reg5: my_nDFF GENERIC MAP(32) port map(WriteEnable(5) ,Clk,Rst,WriteBackData,R5);
	reg6: my_nDFF GENERIC MAP(32) port map(WriteEnable(6) ,Clk,Rst,WriteBackData,R6);
	reg7: my_nDFF GENERIC MAP(32) port map(WriteEnable(7) ,Clk,Rst,WriteBackData,R7);

	tri0: tri_state_buffer GENERIC MAP(32) port map(RdstDecoderRead(0),R0,Rdst);
	tri1: tri_state_buffer GENERIC MAP(32) port map(RdstDecoderRead(1),R1,Rdst);
	tri2: tri_state_buffer GENERIC MAP(32) port map(RdstDecoderRead(2),R2,Rdst);
	tri3: tri_state_buffer GENERIC MAP(32) port map(RdstDecoderRead(3),R3,Rdst);
	tri4: tri_state_buffer GENERIC MAP(32) port map(RdstDecoderRead(4),R4,Rdst);
	tri5: tri_state_buffer GENERIC MAP(32) port map(RdstDecoderRead(5),R5,Rdst);
	tri6: tri_state_buffer GENERIC MAP(32) port map(RdstDecoderRead(6),R6,Rdst);
	tri7: tri_state_buffer GENERIC MAP(32) port map(RdstDecoderRead(7),R7,Rdst);
	tri8: tri_state_buffer GENERIC MAP(32) port map(RsrsDecoderRead(0),R0,Rsrc);
	tri9: tri_state_buffer GENERIC MAP(32) port map(RsrsDecoderRead(1),R1,Rsrc);
	tri10: tri_state_buffer GENERIC MAP(32) port map(RsrsDecoderRead(2),R2,Rsrc);
	tri11: tri_state_buffer GENERIC MAP(32) port map(RsrsDecoderRead(3),R3,Rsrc);
	tri12: tri_state_buffer GENERIC MAP(32) port map(RsrsDecoderRead(4),R4,Rsrc);
	tri13: tri_state_buffer GENERIC MAP(32) port map(RsrsDecoderRead(5),R5,Rsrc);
	tri14: tri_state_buffer GENERIC MAP(32) port map(RsrsDecoderRead(6),R6,Rsrc);
	tri15: tri_state_buffer GENERIC MAP(32) port map(RsrsDecoderRead(7),R7,Rsrc);
END regFile;