vsim -gui work.decodingstage
add wave -position insertpoint  \
sim:/decodingstage/Clk \
sim:/decodingstage/ControlSignalsAfterHazard \
sim:/decodingstage/Rst \
sim:/decodingstage/Offset \
sim:/decodingstage/OpCode \
sim:/decodingstage/SrcBitsIn \
sim:/decodingstage/DstBitsIn \
sim:/decodingstage/DstBitsWrite \
sim:/decodingstage/HazardDetection \
sim:/decodingstage/WriteBackData \
sim:/decodingstage/ExtendedOffset \
sim:/decodingstage/Rsrc \
sim:/decodingstage/Rdst \
sim:/decodingstage/DstBitsOut \
sim:/decodingstage/ControlSignalsEX \
sim:/decodingstage/ControlSignalsWB \
sim:/decodingstage/ControlSignalsM \
sim:/decodingstage/DataToWrite \
sim:/decodingstage/DataToRead \
sim:/decodingstage/ControlSignals \
sim:/decodingstage/ExOffset \
sim:/decodingstage/RsrcDec \
sim:/decodingstage/RdstDec
force -freeze sim:/decodingstage/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/decodingstage/Rst 1 0
run
force -freeze sim:/decodingstage/Rst 0 0
force -freeze sim:/decodingstage/Offset 16'd20 0
force -freeze sim:/decodingstage/OpCode 0000101 0
force -freeze sim:/decodingstage/SrcBitsIn 000 0
force -freeze sim:/decodingstage/DstBitsIn 001 0
force -freeze sim:/decodingstage/DstBitsWrite 000 0
force -freeze sim:/decodingstage/WriteBackData 16'd30 0
run
run
force -freeze sim:/decodingstage/DstBitsWrite 001 0
force -freeze sim:/decodingstage/OpCode 0000111 0
run
run
force -freeze sim:/decodingstage/HazardDetection 1 0
run
run