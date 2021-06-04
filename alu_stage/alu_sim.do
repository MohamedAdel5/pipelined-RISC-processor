vsim -gui work.n_alu
# vsim -gui work.n_alu 
# Start time: 20:25:42 on Jun 03,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.n_alu(a_alu)
add wave -position insertpoint  \
sim:/n_alu/CCR \
sim:/n_alu/ALU_OP \
sim:/n_alu/Source \
sim:/n_alu/Destination \
sim:/n_alu/Alu_Result \
sim:/n_alu/CCR_Out
force -freeze sim:/n_alu/CCR 000 0
force -freeze sim:/n_alu/Source 10#12 0
force -freeze sim:/n_alu/Destination 10#50 0
force -freeze sim:/n_alu/ALU_OP 00000 0
run
force -freeze sim:/n_alu/ALU_OP 00001 0
run
force -freeze sim:/n_alu/ALU_OP 00010 0
run
force -freeze sim:/n_alu/ALU_OP 00011 0
run
force -freeze sim:/n_alu/ALU_OP 00100 0
run
force -freeze sim:/n_alu/ALU_OP 00101 0
run
force -freeze sim:/n_alu/ALU_OP 00110 0
run
force -freeze sim:/n_alu/ALU_OP 00111 0
run
force -freeze sim:/n_alu/Destination 10#0 0
run
force -freeze sim:/n_alu/Destination 10#1 0
run
force -freeze sim:/n_alu/Destination 10#50 0
force -freeze sim:/n_alu/ALU_OP 01000 0
run
force -freeze sim:/n_alu/ALU_OP 01001 0
run
force -freeze sim:/n_alu/ALU_OP 01010 0
run
force -freeze sim:/n_alu/Source 10#50 0
force -freeze sim:/n_alu/Destination 10#5 0
run
force -freeze sim:/n_alu/Destination 10#50 0
run
force -freeze sim:/n_alu/Source 10#12 0
force -freeze sim:/n_alu/ALU_OP 01011 0
run
force -freeze sim:/n_alu/Source 00000000000000000000000000001101 0
force -freeze sim:/n_alu/Destination 00000000000000000000000000110011 0
run
force -freeze sim:/n_alu/ALU_OP 01100 0
run
force -freeze sim:/n_alu/ALU_OP 01101 0
run
force -freeze sim:/n_alu/ALU_OP 01110 0
run
force -freeze sim:/n_alu/Source 10#3 0
run
force -freeze sim:/n_alu/CCR 100 0
force -freeze sim:/n_alu/ALU_OP 01111 0
run
force -freeze sim:/n_alu/CCR 000 0
run
force -freeze sim:/n_alu/ALU_OP 10000 0
run
force -freeze sim:/n_alu/CCR 100 0
run
