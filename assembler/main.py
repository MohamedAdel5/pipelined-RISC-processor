import argparse

from IO import read_assembly_lines, memory, writeOutput
from instructions_identifier import instructions_identifier
from operands_identifier import decode_operands

arg_parser = argparse.ArgumentParser(description='PDP-11 Like Assembler')
arg_parser.add_argument("assembly_file", help="Assembly Filename")
arg_parser.add_argument("output_file", help="Output Machine Code Filename")

args = arg_parser.parse_args()

assembly_lines = read_assembly_lines(args.assembly_file)

for line in assembly_lines:

    instruction_type, opcode, op1, op2 = instructions_identifier(
        line['content'])
    Rdst, Rsrc, immediate = decode_operands(op1, op2)

    if instruction_type is None:
        memory[line['range'][0]] = format(int(line['content'], 16), '016b')
        continue

    memory[line['range'][0]] = opcode + "000" + Rsrc + Rdst

    if line['range'][1] - line['range'][0] > 1:
        memory[line['range'][0] + 1] = immediate

writeOutput(args.output_file)
