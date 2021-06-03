vsim -gui work.n_alu_logic
# vsim -gui work.n_alu_logic 
# Start time: 21:29:31 on Jun 03,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.n_alu_logic(a_alu_logic)
# Loading work.n_alu(a_alu)
add wave -position insertpoint  \
sim:/n_alu_logic/CS_ALU_SOURCE \
sim:/n_alu_logic/CS_ALU_OPERATION \
sim:/n_alu_logic/Rsrc \
sim:/n_alu_logic/Rdst \
sim:/n_alu_logic/Offset \
sim:/n_alu_logic/Forward_Source \
sim:/n_alu_logic/Forward_Destination \
sim:/n_alu_logic/Rdst_MEM \
sim:/n_alu_logic/Rdst_WB \
sim:/n_alu_logic/CCR \
sim:/n_alu_logic/CCR_OUT \
sim:/n_alu_logic/ALU_RESULT \
sim:/n_alu_logic/first_source \
sim:/n_alu_logic/source \
sim:/n_alu_logic/destination
force -freeze sim:/n_alu_logic/CS_ALU_SOURCE 1 0
force -freeze sim:/n_alu_logic/CS_ALU_OPERATION 01001 0
force -freeze sim:/n_alu_logic/Rsrc 10#50 0
force -freeze sim:/n_alu_logic/Rdst 10#50 0
force -freeze sim:/n_alu_logic/Rdst 10#30 0
force -freeze sim:/n_alu_logic/Offset 10#80 0
force -freeze sim:/n_alu_logic/Forward_Source 00 0
force -freeze sim:/n_alu_logic/Forward_Destination 00 0
force -freeze sim:/n_alu_logic/Rdst_MEM 10#200 0
force -freeze sim:/n_alu_logic/Rdst_WB 10#60 0
force -freeze sim:/n_alu_logic/CCR 100 0
run
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /n_alu_logic/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /n_alu_logic/u1
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /n_alu_logic/u1
force -freeze sim:/n_alu_logic/CS_ALU_SOURCE 0 0
run
force -freeze sim:/n_alu_logic/Forward_Source 01 0
run
force -freeze sim:/n_alu_logic/Forward_Source 10 0
run
force -freeze sim:/n_alu_logic/Forward_Destination 01 0
run
force -freeze sim:/n_alu_logic/Forward_Destination 10 0
run
