import os
from instructions import two_words_instructions


def compute_words(line):
    words = 1
    tmp = line.split()
    if(tmp[0].startswith(two_words_instructions)):
        words += 1

    return words


variables_table = {}
labels_table = {}
memory = []


def read_assembly_lines(asmFilePath):
    current_memory_location = 0
    memory_size = 0
    lines = []
    file = open(asmFilePath)
    for idx, line in enumerate(file):
        line = line.split('#')[0].upper().strip()

        if line != '':

            if line.startswith('.ORG'):
                current_memory_location = int(line.split('.ORG')[1], 16)
                continue

            first_memory_location = current_memory_location
            current_memory_location += compute_words(line)
            memory_size = max(memory_size, current_memory_location)
            lines.append({'content': line, 'number': idx + 1,
                          'range': (first_memory_location, current_memory_location)})

    for i in range(memory_size):
        memory.append("0"*16)
    return lines


def writeOutput(filename="out.txt"):

    # mem = ["0" * 16] * 2048
    # mem[:len(memory)-1] = memory[1:]
    # mem[-1] = memory[0]
    with open(filename, 'w') as filehandle:
        filehandle.write('// memory data file (do not edit the following line - required for mem load use)\n// instance=/cpu/spr_alu_ram_modules/u1/ram\n// format=mti addressradix=d dataradix=b version=1.0 wordsperline=1 noaddress\n')
        for listitem in memory:
            filehandle.write('%s\n' % listitem)
