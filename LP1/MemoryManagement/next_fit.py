def NextFit(blockSize, processSize):
    allocation = []
    allocation_id = 0

    for i in range(len(processSize)):
        # Loop(start, end)
        for j in range(allocation_id, len(blockSize)):
            if blockSize[j] >= processSize[i]:
                allocation.append(j+1)
                blockSize[j] -= processSize[i]
                allocation_id = j
                break
        else:
            allocation.append("Not Allocated")

    return allocation


blockSize = [100, 500, 200, 450, 600]
processSize = [212, 417, 112, 426]

print(NextFit(blockSize, processSize))
