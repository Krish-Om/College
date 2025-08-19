// First Fit contiguous memory allocation simulation (pre-initialized input)
#include <stdio.h>
#include <stdbool.h>

#define NB 5
#define NP 4

int main()
{
    int blockSize[NB] = {100, 500, 200, 300, 600};
    int processSize[NP] = {212, 417, 112, 426};

    bool blockUsed[NB];
    for (int i = 0; i < NB; i++)
        blockUsed[i] = false;

    int allocation[NP];
    int internalFrag[NP];
    for (int i = 0; i < NP; i++)
    {
        allocation[i] = -1;
        internalFrag[i] = 0;
    }

    for (int i = 0; i < NP; i++)
    {
        for (int j = 0; j < NB; j++)
        {
            if (!blockUsed[j] && blockSize[j] >= processSize[i])
            {
                allocation[i] = j;
                internalFrag[i] = blockSize[j] - processSize[i];
                blockUsed[j] = true;
                break;
            }
        }
    }

    int totalIF = 0;
    printf("Blocks: ");
    for (int j = 0; j < NB; j++)
        printf("%d ", blockSize[j]);
    printf("\n");
    printf("Processes: ");
    for (int i = 0; i < NP; i++)
        printf("%d ", processSize[i]);
    printf("\n\n");
    printf("Allocation result (First Fit):\n");
    for (int i = 0; i < NP; i++)
    {
        if (allocation[i] != -1)
        {
            printf("Process %d (size %d) -> Block %d (size %d), IF=%d\n",
                   i + 1, processSize[i], allocation[i] + 1, blockSize[allocation[i]], internalFrag[i]);
            totalIF += internalFrag[i];
        }
        else
        {
            printf("Process %d (size %d) -> Not allocated\n", i + 1, processSize[i]);
        }
    }
    printf("Total internal fragmentation: %d\n", totalIF);
    return 0;
}
