vsim -gui work.int
mem load -i D:/SchoolWork/YearThree/Sem2/test3Out.mem /int/fetching/my_ram/ram
add wave -position insertpoint  \
sim:/int/rst \
sim:/int/mem_WB_DATA_OUT \
sim:/int/mem_SP_OUT \
sim:/int/mem_dstbits_OUT \
sim:/int/mem_CS_WB_OUT \
sim:/int/IO_PORT \
sim:/int/int_SrcBitsOut \
sim:/int/int_Rsrc \
sim:/int/int_Rdst \
sim:/int/int_ExtendedOffset \
sim:/int/int_DstBitsOut \
sim:/int/int_ControlSignalsWB \
sim:/int/int_ControlSignalsM \
sim:/int/int_ControlSignalsEX \
sim:/int/hazard_detected \
sim:/int/forward_source \
sim:/int/forward_destination \
sim:/int/fetch_SrcBits \
sim:/int/fetch_OpCode \
sim:/int/fetch_Offset \
sim:/int/fetch_DstBits \
sim:/int/ex_SP_OUT \
sim:/int/ex_Rsrc_OUT \
sim:/int/ex_Rdst_OUT \
sim:/int/ex_offset_OUT \
sim:/int/ex_DstBits_OUT \
sim:/int/ex_CS_WB_OUT \
sim:/int/ex_CS_MEM_OUT \
sim:/int/ex_ALU_RESULT \
sim:/int/dec_SrcBitsOut \
sim:/int/dec_Rsrc \
sim:/int/dec_Rdst \
sim:/int/dec_ExtendedOffset \
sim:/int/dec_DstBitsOut \
sim:/int/dec_ControlSignalsWB \
sim:/int/dec_ControlSignalsM \
sim:/int/dec_ControlSignalsEX \
sim:/int/clk
add wave -position insertpoint  \
sim:/int/fetching/PC
add wave -position insertpoint  \
sim:/int/fetching/OpCode
add wave -position insertpoint  \
sim:/int/decoding/RegFile/R7 \
sim:/int/decoding/RegFile/R6 \
sim:/int/decoding/RegFile/R5 \
sim:/int/decoding/RegFile/R4 \
sim:/int/decoding/RegFile/R3 \
sim:/int/decoding/RegFile/R2 \
sim:/int/decoding/RegFile/R1 \
sim:/int/decoding/RegFile/R0
add wave -position insertpoint  \
sim:/int/execution/flag_out_alu_in
add wave -position insertpoint  \
sim:/int/execution/u1/source \
sim:/int/execution/u1/destination
add wave -position insertpoint  \
sim:/int/execution/u1/u1/Source \
sim:/int/execution/u1/u1/Destination \
sim:/int/execution/u1/u1/Alu_Result \
sim:/int/execution/u1/u1/ALU_OP
force -freeze sim:/int/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/int/Rst 1 0
run
force -freeze sim:/int/Rst 0 0
run
run
run
force -deposit sim:/int/IO_PORT 16#5 0
run
force -deposit sim:/int/IO_PORT 16#19 0
run
force -deposit sim:/int/IO_PORT 16#FFFFFFFF 0
run
force -deposit sim:/int/IO_PORT 16#FFFFF320 0
run
run
run
run
run
run
run
run
run
run
run
run
