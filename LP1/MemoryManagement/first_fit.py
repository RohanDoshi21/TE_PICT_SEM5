def FirstFit(blockSize, processSize):
    allocation = []
    for i in processSize:
        try:
            res = next(x for x, val in enumerate(blockSize) if val > i)
            allocation.append(res+1)
            blockSize[res] = blockSize[res] - i
        except:
            allocation.append('Not Allocated')
    return allocation


blockSize = [100, 500, 200, 300, 600]
processSize = [212, 417, 112, 426]

print(FirstFit(blockSize, processSize))
