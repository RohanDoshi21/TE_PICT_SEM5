def WorstFit(blockSize, processSize):
    allocation = []
    for i in processSize:
        res = max(blockSize)
        if res > i:
            index = blockSize.index(res)
            allocation.append(index + 1)
            blockSize[index] -= i
        else:
            allocation.append('Not Allocated')

    return allocation


blockSize = [100, 500, 200, 300, 600]
processSize = [212, 417, 112, 426]

print(WorstFit(blockSize, processSize))
