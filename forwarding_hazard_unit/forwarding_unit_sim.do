vsim -gui work.forwarding_unit
# vsim -gui work.forwarding_unit 
# Start time: 01:40:27 on Jun 04,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.forwarding_unit(a_forwarding_unit)
add wave -position insertpoint  \
sim:/forwarding_unit/M_WB_WB \
sim:/forwarding_unit/M_WB_dst_bits \
sim:/forwarding_unit/ID_EX_src_bits \
sim:/forwarding_unit/ID_EX_dst_bits \
sim:/forwarding_unit/forward_source \
sim:/forwarding_unit/forward_destination \
sim:/forwarding_unit/EX_M_WB \
sim:/forwarding_unit/EX_M_dst_bits
force -freeze sim:/forwarding_unit/M_WB_WB 0 0
force -freeze sim:/forwarding_unit/M_WB_dst_bits 000 0
force -freeze sim:/forwarding_unit/ID_EX_src_bits 001 0
force -freeze sim:/forwarding_unit/ID_EX_dst_bits 010 0
force -freeze sim:/forwarding_unit/EX_M_WB 0 0
force -freeze sim:/forwarding_unit/EX_M_dst_bits 011 0
run
force -freeze sim:/forwarding_unit/ID_EX_src_bits 011 0
force -freeze sim:/forwarding_unit/EX_M_WB 1 0
run
force -freeze sim:/forwarding_unit/EX_M_WB 0 0
run
force -freeze sim:/forwarding_unit/EX_M_dst_bits 000 0
run
force -freeze sim:/forwarding_unit/EX_M_WB 1 0
run
force -freeze sim:/forwarding_unit/EX_M_dst_bits 010 0
run
force -freeze sim:/forwarding_unit/EX_M_WB 0 0
run
force -freeze sim:/forwarding_unit/ID_EX_src_bits 000 0
run
force -freeze sim:/forwarding_unit/M_WB_WB 1 0
run
force -freeze sim:/forwarding_unit/ID_EX_src_bits 010 0
force -freeze sim:/forwarding_unit/ID_EX_dst_bits 000 0
run
force -freeze sim:/forwarding_unit/M_WB_WB 0 0
run
