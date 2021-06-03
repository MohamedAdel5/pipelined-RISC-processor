def decode_operands(operand1, operand2):

    Rdst = "000"
    Rsrc = "000"
    immediate = None

    if operand1 is None:
        return Rdst, Rsrc, immediate

    if operand2 is not None:
        operand2_contents = operand2.replace(
            "(", " ").replace(")", "").strip().split()

        if len(operand2_contents) > 1:
            Rdst = format(int(operand1[1], 16), '03b')
            Rsrc = format(int(operand2_contents[1][1], 16), '03b')
            immediate = format(int(operand2_contents[0], 16), '016b')

        elif len(operand2_contents) > 0:
            if operand2_contents[0].startswith("R"):
                Rsrc = format(int(operand1[1], 16), '03b')
                Rdst = format(int(operand2_contents[0][1], 16), '03b')
            else:
                Rdst = format(int(operand1[1], 16), '03b')
                immediate = format(int(operand2_contents[0], 16), '016b')

    elif operand1 is not None and operand1.startswith("R"):
        Rdst = format(int(operand1[1], 16), '03b')

    return Rdst, Rsrc, immediate
