def BestFit(blockSize, processSize):
    allocation = []
    for i in processSize:
        try:
            res = min(x for x in blockSize if x >= i)
            index = blockSize.index(res)
            allocation.append(index+1)
            blockSize[index] -= i
        except:
            allocation.append('Not Allocated')

    return allocation


blockSize = [100, 500, 200, 300, 600]
processSize = [212, 417, 112, 426]

print(BestFit(blockSize, processSize))
