vsim work.memory_stage_integration

add wave -position insertpoint  \
sim:/memory_stage_integration/clk \
sim:/memory_stage_integration/rst \
sim:/memory_stage_integration/CS_WB_IN \
sim:/memory_stage_integration/CS_MEM_IN \
sim:/memory_stage_integration/dstbits_IN \
sim:/memory_stage_integration/Rsrc_IN \
sim:/memory_stage_integration/offset_IN \
sim:/memory_stage_integration/ALU_RESULT \
sim:/memory_stage_integration/SP_BUFFERED_IN \
sim:/memory_stage_integration/CS_WB_OUT \
sim:/memory_stage_integration/WB_DATA_OUT \
sim:/memory_stage_integration/dstbits_OUT \
sim:/memory_stage_integration/SP_OUT \
sim:/memory_stage_integration/flag_out_alu_in \
sim:/memory_stage_integration/alu_out_flag_in \
sim:/memory_stage_integration/WB_DATA_IN \
sim:/memory_stage_integration/RAM_READ_DATA \
sim:/memory_stage_integration/RAM_ADDRESS \
sim:/memory_stage_integration/RAM_WE \
sim:/memory_stage_integration/SP_IN \
sim:/memory_stage_integration/BUS_IN \
sim:/memory_stage_integration/BUS_OUT \
sim:/memory_stage_integration/SP \
sim:/memory_stage_integration/SP_UPDATED
force -freeze sim:/memory_stage_integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/memory_stage_integration/rst 1 0
force -freeze sim:/memory_stage_integration/CS_WB_IN 1 0
force -freeze sim:/memory_stage_integration/dstbits_IN 001 0
force -freeze sim:/memory_stage_integration/ALU_RESULT 00000000000000000000000000001010 0
force -freeze sim:/memory_stage_integration/Rsrc_IN 00000000000000000000000000000000 0
force -freeze sim:/memory_stage_integration/offset_IN 00000000000000000000000000000000 0
force -freeze sim:/memory_stage_integration/CS_MEM_IN 101010 0

run

run

# write 1010 in loc 0 at ram
force -freeze sim:/memory_stage_integration/rst 0 0
force -freeze sim:/memory_stage_integration/RAM_WE 1 0

run

# write 1111 at data bus

force -freeze sim:/memory_stage_integration/RAM_WE 0 0
force -freeze sim:/memory_stage_integration/CS_MEM_IN 110010 0
force -freeze sim:/memory_stage_integration/ALU_RESULT 00000000000000000000000000001111 0

run

# read from data bus 0110


force -freeze sim:/memory_stage_integration/BUS_IN 00000000000000000000000000000110 0
force -freeze sim:/memory_stage_integration/CS_MEM_IN 010000 0

run