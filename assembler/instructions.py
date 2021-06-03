instructions = {
    "2op": {
        "MOV": "0010000",
        "ADD": "0010001",
        "SUB": "0010010",
        "AND": "0010011",
        "OR": "0010100",
        "IADD": "0010101",
        "SHL": "0010110",
        "SHR": "0010111"
    },
    "1op": {
        "NOP": "0000000",
        "SETC": "0000001",
        "CLRC": "0000010",
        "CLR": "0000011",
        "NOT": "0000100",
        "INC": "0000101",
        "DEC": "0000110",
        "NEG": "0000111",
        "OUT": "0001000",
        "IN": "0001001",
        "RLC": "0001010",
        "RRC": "0001011"
    },
    "branch": {
        "JZ": "0110000",
        "JN": "0110001",
        "JC": "0110010",
        "JMP": "0110011",
        "CALL": "0110100",
        "RET": "0110101",
        "RTI": "0110110"
    },

    "memory": {
        "PUSH": "0100000",
        "POP": "0100001",
        "LDM": "0100010",
        "LDD": "0100011",
        "STD": "0100100"
    },
    "sgl":
    {
        "RST": "111000",
        "INT": "111001"
    }

}

two_words_instructions = ("IADD", "SHL", "SHR", "LDM", "LDD", "STD")