vsim -gui work.registerfile
# vsim -gui work.registerfile 
# Start time: 23:05:52 on Jun 03,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.registerfile(regfile)
# Loading work.my_ndff(a_my_ndff)
# Loading work.tri_state_buffer(my_tri_state_buffer)
add wave -position insertpoint  \
sim:/registerfile/Clk \
sim:/registerfile/Rst \
sim:/registerfile/WriteBackData \
sim:/registerfile/SrcBitsRead \
sim:/registerfile/DstBitsRead \
sim:/registerfile/DstBitsWrite \
sim:/registerfile/ControlSignalWB \
sim:/registerfile/Rsrc \
sim:/registerfile/Rdst \
sim:/registerfile/R0 \
sim:/registerfile/R1 \
sim:/registerfile/R2 \
sim:/registerfile/R3 \
sim:/registerfile/R4 \
sim:/registerfile/R5 \
sim:/registerfile/R6 \
sim:/registerfile/R7 \
sim:/registerfile/RsrsDecoderRead \
sim:/registerfile/RdstDecoderRead \
sim:/registerfile/RdstDecoderWrite \
sim:/registerfile/WriteEnable
force -freeze sim:/registerfile/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/registerfile/Rst 1 0
run
force -freeze sim:/registerfile/Rst 0 0
force -freeze sim:/registerfile/WriteBackData 16'd20 0
force -freeze sim:/registerfile/DstBitsWrite 000 0
force -freeze sim:/registerfile/ControlSignalWB 1 0
run
force -freeze sim:/registerfile/WriteBackData 16'd30 0
force -freeze sim:/registerfile/DstBitsWrite 010 0
run
force -freeze sim:/registerfile/ControlSignalWB 0 0
force -freeze sim:/registerfile/SrcBitsRead 000 0
force -freeze sim:/registerfile/DstBitsRead 010 0
run
run
force -freeze sim:/registerfile/ControlSignalWB 1 0
force -freeze sim:/registerfile/WriteBackData 16'd40 0
force -freeze sim:/registerfile/DstBitsWrite 111 0
run
force -freeze sim:/registerfile/DstBitsWrite 101 0
force -freeze sim:/registerfile/SrcBitsRead 111 0
run