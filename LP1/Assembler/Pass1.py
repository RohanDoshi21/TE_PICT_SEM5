OPTAB = {
    "STOP": "(IS,00)",
    "ADD": "(IS,01)",
    "SUB": "(IS,02)",
    "MUL": "(IS,03)",
    "MOVER": "(IS,04)",
    "MOVEM": "(IS,05)",
    "COMP": "(IS,06)",
    "BC": "(IS,07)",
    "DIV": "(IS,08)",
    "READ": "(IS,09)",
    "PRINT": "(IS,10)",
    # "DC": "DL,01",
    # "DS": "DL,02",
    # "START": "AD,01",
    # "STOP": "AD,02",
    # "ORIGIN": "AD,03",
    # "EQU": "AD,04",
    # "LTORG": "AD,05",
}

REG = {
    "AREG": "(1)",
    "BREG": "(2)",
    "CREG": "(3)",
    "DREG": "(4)",
}

CC = {
    "LT": "(1)",
    "LE": "(2)",
    "EQ": "(3)",
    "GT": "(4)",
    "GE": "(5)",
    "ANY": "(6)"
}


class Pass1:
    def __init__(self) -> None:
        self.symtab = []
        self.lc = 0
        self.literaltab = []
        self.litIndex = 0
        self.poolTab = [0]
        self.poolIndex = 0

    def updateSymtab(self, pair):
        for i in self.symtab:
            if i[0] == pair[0]:
                i[1] = pair[1]
                break
        else:
            self.symtab.append(pair)

    def getSymtabLC(self, symbol):
        for i in self.symtab:
            if i[0] == symbol:
                return i[1]
        else:
            return -1

    def getSymtabPos(self, symbol):
        for pos, val in enumerate(self.symtab):
            if val[0] == symbol:
                return pos
        else:
            return -1

    def process(self):
        with open("/home/rohandoshi21/Development/LP1/Assembler/Simple.txt", "r") as file:
            data = file.readlines()
            for line in data:
                word = line.replace('\n', '').split('\t')

                if word[0] != '':  # A label is present
                    pair = [word[0], self.lc]
                    self.updateSymtab(pair)

                if word[1] == 'START':
                    self.lc = int(word[2])
                    print(f"(AD,01)\t(C,{self.lc})")

                if word[1] == 'DC':
                    self.lc += 1
                    # Change -1 according to syntax of input '19' -> -1   '19  -> 0
                    constant = word[2][1:-1]
                    print(f"(DL, 01)\t(C,{constant})")

                if word[1] == 'LTORG':
                    for i in range(self.poolIndex, self.litIndex):
                        self.lc += 1
                        # Update literaltab
                        self.literaltab[i][1] = self.lc

                        # Get value of the literals
                        value = int(self.literaltab[i][0].replace(
                            '=', '').replace("'", ""))

                        print(f"(DL,01)\t(C, {value})")

                    # Update Pool
                    self.poolTab.append(self.litIndex)
                    self.poolIndex = self.litIndex

                if word[1] == 'DS':
                    constant = int(word[2])
                    self.lc += constant
                    print(f"(DL, 02)\t(C,{constant})")

                if word[1] == 'ORIGIN':
                    # TODO: CONSIDER LABELS IN ORIGIN
                    # Only considering numbers
                    self.lc = int(word[2])
                    print(f"(AD,05)\t(C,{self.lc})")

                if word[1] == 'EQU':
                    # TODO: Modify according to sign
                    Equation = word[2].split('+')
                    index = self.getSymtabLC(Equation[0]) + int(Equation[1])
                    self.updateSymtab([word[0], index])

                if OPTAB.get(word[1]) != None:
                    code = OPTAB.get(word[1]) + "\t"

                    j = 2
                    while j < len(word):
                        if REG.get(word[j]) != None:
                            code += REG.get(word[j]) + "\t"
                        elif CC.get(word[j]) != None:
                            code += CC.get(word[j]) + "\t"
                        elif word[j].find('=') != -1:
                            self.literaltab.append([word[j], -1])
                            word[j] = word[j].replace('=', '').replace("'", "")
                            self.litIndex += 1
                            code += f"(L, {self.litIndex})"
                            pass
                        else:
                            if self.getSymtabLC(word[j]) == -1:
                                pair = [word[j], -1]
                                self.updateSymtab(pair)

                            const = self.getSymtabPos(word[j])
                            code += f"(S, {const})"

                        j += 1

                    self.lc += 1
                    print(code)

                if word[1] == 'END':
                    # TODO: Process literal
                    for i in range(self.poolIndex, self.litIndex):
                        self.lc += 1
                        # Update literaltab
                        self.literaltab[i][1] = self.lc

                        # Get value of the literals
                        value = int(self.literaltab[i][0].replace(
                            '=', '').replace("'", ""))

                        print(f"(DL,01)\t(C, {value})")

                    # Update Pool
                    self.poolTab.append(self.litIndex)
                    self.poolIndex = self.litIndex

                    print('(AD, 02)')

            print("Symtab: ")
            print(self.symtab)

            print("Littab: ")
            print(self.literaltab)

            print("Pooltab :")
            print(self.poolTab)


test = Pass1()
test.process()
