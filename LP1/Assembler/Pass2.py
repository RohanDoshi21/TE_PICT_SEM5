class Pass2:
    def __init__(self) -> None:
        self.symtab = []
        self.littab = []
        pass

    def readFiles(self):
        # Paste the output here
        self.symtab = [
            ['A', 100],
            ['L1', 103],
            ['B', 118],
            ['C', 119],
            ['D', 101],
            ['L2', 106]
        ]
        self.littab = [
            ["='34'", 109],
            ["='14'", 110],
            ["='143'", 114],
            ["='134'", 115],
            ["='143'", 120],
            ["='134'", 121]
        ]

    def LiteralORSymbol(self, word):
        index = int(word[3:-1])
        if word.find('L') != -1:
            return (self.littab[index-1][1])
        else:
            return (self.symtab[index][1])

    def process(self):
        with open("IC.txt", "r") as file:
            data = file.readlines()
            for line in data:
                word = line.replace("\n", "").strip().split()
                if word[0].find('AD') != -1 or word[0].find('DL,02') != -1:
                    print()
                elif word[0].find("DL,01") != -1:
                    print(f"00\t0\t{word[1][3:-1]}")
                    pass
                elif word[0].find('IS,00') != -1:
                    print("00\t0\t000")
                elif word[0].find('IS,10') != -1:
                    code = self.LiteralORSymbol(word[1])
                    print(f"10\t0\t{code}")
                elif word[0].find('IS') != -1:
                    code1 = word[0][4:6]
                    code2 = word[1][1]
                    code3 = self.LiteralORSymbol(word[2])
                    print(f"{code1}\t{code2}\t{code3}")
                else:
                    print()

            file.close()


test = Pass2()
test.readFiles()
test.process()
