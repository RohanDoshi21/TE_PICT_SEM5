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
    "PRINT": "(IS,10)"
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


class AssemblerPass1:
    def __init__(self) -> None:
        self.symtab = []
        self.littab = []
        self.ic = ""
        self.pooltab = []
        self.lc = 0
        self.litIndex = 0
        self.poolIndex = 0

    def UpdateSymtab(self, pair):
        for i in self.symtab:
            if i[0] == pair[0]:
                i[1] = pair[1]
                break
        else:
            self.symtab.append(pair)

    def LCSymtab(self, word):
        for i in self.symtab:
            if i[0] == word:
                return i[1]
        else:
            return -1

    def PosSymtab(self, word):
        for pos, val in enumerate(self.symtab):
            if val[0] == word:
                return pos
        else:
            return -1

    def process(self):
        file = open(
            "/home/rohandoshi21/Development/LP1/Assembler/pass1LTROG.txt", "r")
        for lines in file:
            word = lines.replace("\n", "").replace(
                "'", "").replace(",", "").split("\t")
            if word[0] != '':
                pair = [word[0], self.lc]
                self.UpdateSymtab(pair)
            if word[1] == 'START':
                self.lc = int(word[2])
                self.ic += f"(AD,01)\t(C,{self.lc})\n"

            if word[1] == 'LTORG':
                for i in range(self.poolIndex, self.litIndex):
                    self.littab[i][1] = self.lc
                    self.lc += 1

                    value = self.littab[i][0].replace("=", "")
                    self.ic += f'(DL,01)\t(C,{value})\n'

                self.pooltab.append(self.poolIndex)
                self.poolIndex = self.litIndex

            elif word[1] == 'END':

                for i in range(self.poolIndex, self.litIndex):
                    self.littab[i][1] = self.lc
                    self.lc += 1

                    value = self.littab[i][0].replace("=", "")
                    self.ic += f'(DL,01)\t(C,{value})\n'

                self.pooltab.append(self.poolIndex)
                self.poolIndex = self.litIndex

                self.ic += f"(AD,02)\n"

            elif word[1] == "DC":
                self.ic += f"(DL,01)\t(C,{word[2]})\n"
                self.lc += 1

            elif word[1] == "DS":
                self.ic += f"(DL,02)\t(C,{word[2]})\n"
                self.lc += int(word[2])

            elif word[1] == 'ORIGIN':
                location = self.LCSymtab(word[2].partition('+')[0])
                addition = int(word[2].partition('+')[2])
                self.ic += f"(AD,03)\t(S,{self.PosSymtab(word[2].partition('+')[0]) + 1})+{addition}\n"
                self.lc = location + addition

            elif word[1] == 'EQU':
                location = self.LCSymtab(word[2].partition('+')[0])
                addition = int(word[2].partition('+')[2])
                self.ic += f"(AD,04)\t(S,{self.PosSymtab(word[2].partition('+')[0]) + 1})+{addition}\n"
                self.UpdateSymtab([word[0], location+addition])

            elif OPTAB.get(word[1]) != None:
                self.ic += OPTAB.get(word[1]) + "\t"

                for i in range(2, len(word)):
                    # IF IT IS A CONDITION CODE
                    if CC.get(word[i]) != None:
                        self.ic += CC.get(word[i]) + "\t"
                    elif REG.get(word[i]) != None:
                        self.ic += REG.get(word[i]) + "\t"
                    elif word[i].find('=') == -1:
                        if self.LCSymtab(word[i]) == -1:
                            self.UpdateSymtab([word[i], self.lc])

                        index = self.PosSymtab(word[i])
                        self.ic += f'(S,{index+1})\t'
                    else:
                        # it is as literal
                        self.littab.append([word[i], -1])
                        self.litIndex += 1
                        self.ic += f'(L, {self.litIndex})\t'

                self.lc += 1
                self.ic += "\n"

            else:
                pass

        file.close()

        ICFile = open(
            "/home/rohandoshi21/Development/LP1/Assembler/IC.txt", "w")
        ICFile.write(self.ic)
        ICFile.close()

        SYMTABFile = open(
            "/home/rohandoshi21/Development/LP1/Assembler/SYMTAB.txt", "w")
        for x, val in enumerate(self.symtab):
            str1 = str(x)+"\t"+str(val) + "\n"
            SYMTABFile.write(str1)
        SYMTABFile.close()

        LITTABFile = open(
            "/home/rohandoshi21/Development/LP1/Assembler/LITTAB.txt", "w")
        for x, val in enumerate(self.littab):
            str1 = str(x)+"\t"+str(val) + "\n"
            LITTABFile.write(str1)
        LITTABFile.close()

        print("*"*8 + "IC" + "*"*8)
        print(self.ic)
        print("*"*8 + "SYMTAB" + "*"*8)
        print(self.symtab)
        print("*"*8 + "LITTAB" + "*"*8)
        print(self.littab)
        print("*"*8 + "POOLTAB" + "*"*8)
        print(self.pooltab)


test = AssemblerPass1()
test.process()
