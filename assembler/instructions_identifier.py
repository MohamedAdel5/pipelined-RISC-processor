from instructions import instructions
from IO import memory


def instructions_identifier(line):

    segments = line.split(',')
    tmp = segments[0].split()
    instruction = tmp[0].strip()
    operand1 = None
    operand2 = None
    opcode = None
    instruction_type = None

    for inst_type in instructions:
        opcode = instructions[inst_type].get(instruction)
        if opcode is not None:
            instruction_type = inst_type
            break

    if len(tmp) > 1:
        operand1 = tmp[1].strip()
        if len(segments) > 1:
            operand2 = segments[1].strip()

    return instruction_type, opcode, operand1, operand2
