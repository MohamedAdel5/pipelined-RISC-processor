vsim -gui work.hazard_detection
# vsim -gui work.hazard_detection 
# Start time: 01:14:16 on Jun 04,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.hazard_detection(a_hazard_detection)
add wave -position insertpoint  \
sim:/hazard_detection/IF_ID_src_bits \
sim:/hazard_detection/IF_ID_reads_src \
sim:/hazard_detection/IF_ID_reads_dst \
sim:/hazard_detection/IF_ID_OP_CODE \
sim:/hazard_detection/IF_ID_dst_bits \
sim:/hazard_detection/ID_EX_read_write \
sim:/hazard_detection/ID_EX_PORT_IO \
sim:/hazard_detection/ID_EX_MEM_IO \
sim:/hazard_detection/ID_EX_dst_bits \
sim:/hazard_detection/hazard_detected
force -freeze sim:/hazard_detection/IF_ID_src_bits 001 0
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0000011 0
force -freeze sim:/hazard_detection/IF_ID_dst_bits 010 0
force -freeze sim:/hazard_detection/ID_EX_read_write 0 0
force -freeze sim:/hazard_detection/ID_EX_PORT_IO 0 0
force -freeze sim:/hazard_detection/ID_EX_MEM_IO 1 0
force -freeze sim:/hazard_detection/ID_EX_dst_bits 000 0
run
force -freeze sim:/hazard_detection/ID_EX_dst_bits 001 0
run
force -freeze sim:/hazard_detection/ID_EX_dst_bits 010 0
run
force -freeze sim:/hazard_detection/ID_EX_MEM_IO 0 0
run
force -freeze sim:/hazard_detection/ID_EX_MEM_IO 1 0
force -freeze sim:/hazard_detection/ID_EX_read_write 1 0
run
force -freeze sim:/hazard_detection/ID_EX_read_write 0 0
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0010010 0
run
force -freeze sim:/hazard_detection/ID_EX_dst_bits 001 0
run
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0010000 0
run
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0010100 0
run
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0010101 0
run
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0100010 0
run
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0100011 0
run
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0100100 0
run
force -freeze sim:/hazard_detection/ID_EX_dst_bits 010 0
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0001000 0
run
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0000000 0
run
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0000001 0
run
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0000010 0
run
force -freeze sim:/hazard_detection/IF_ID_OP_CODE 0000011 0
run
