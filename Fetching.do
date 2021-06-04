vsim -gui work.fetchingstage
add wave -position insertpoint  \
sim:/fetchingstage/HazardDetection \
sim:/fetchingstage/Clk \
sim:/fetchingstage/Rst \
sim:/fetchingstage/Offset \
sim:/fetchingstage/OpCode \
sim:/fetchingstage/SrcBits \
sim:/fetchingstage/DstBits \
sim:/fetchingstage/PC \
sim:/fetchingstage/IR \
sim:/fetchingstage/DataToWrite \
sim:/fetchingstage/DataToRead \
sim:/fetchingstage/E
mem load -i E:/2022/Arch/Project/pipelined-vonneumann-RISC-processor/Ram1.mem /fetchingstage/my_ram/ram
force -freeze sim:/fetchingstage/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/fetchingstage/Rst 1 0
run
force -freeze sim:/fetchingstage/Rst 0 0
force -freeze sim:/fetchingstage/HazardDetection 0 0
run
run
force -freeze sim:/fetchingstage/HazardDetection 1 0
run
run
force -freeze sim:/fetchingstage/HazardDetection 0 0
force -freeze sim:/fetchingstage/IR 00000000000010100010101111000010 0
run
force -freeze sim:/fetchingstage/IR 00000000000010100000010111000010 0
run
force -freeze sim:/fetchingstage/IR 00000000000010100010101111000010 0
run