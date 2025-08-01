// C program to implement memory allocation technique using best fit

#include <stdio.h>
#include <stdlib.h>

#define BLOCK 4
#define N 4

int blocks[BLOCK] = {500, 200, 300, 600};
int allocated[BLOCK] = {0}; // 0 means free, 1 means allocated

int best_fit(int process_size)
{
    int best_index = -1;
    int min_waste = __INT_MAX__;

    // Search for the best fitting block (smallest waste)
    for (int i = 0; i < BLOCK; i++)
    {
        if (allocated[i] == 0 && blocks[i] >= process_size)
        {
            int waste = blocks[i] - process_size;
            if (waste < min_waste)
            {
                min_waste = waste;
                best_index = i;
            }
        }
    }

    // If a suitable block is found, allocate it
    if (best_index != -1)
    {
        allocated[best_index] = 1;
        return best_index;
    }

    return -1; // No suitable block found
}

int main()
{
    int fragment[N];
    int process[N] = {212, 417, 112, 426};
    int allocation[N];

    printf("BEST FIT MEMORY ALLOCATION\n");
    printf("==========================\n\n");
    printf("Process\tProcess Size\tBlock Allocated\tBlock Size\tFragment\n");
    printf("-------\t------------\t---------------\t----------\t--------\n");

    // Allocate each process using best fit
    for (int i = 0; i < N; i++)
    {
        int block_index = best_fit(process[i]);

        if (block_index != -1)
        {
            allocation[i] = block_index;
            fragment[i] = blocks[block_index] - process[i];
            printf("P%d\t%d\t\tBlock %d\t\t%d\t\t%d\n",
                   i + 1, process[i], block_index + 1, blocks[block_index], fragment[i]);
        }
        else
        {
            allocation[i] = -1;
            fragment[i] = 0;
            printf("P%d\t%d\t\tNot Allocated\t-\t\t-\n",
                   i + 1, process[i]);
        }
    }

    printf("\n--- Memory Status ---\n");
    printf("Block\tSize\tStatus\n");
    printf("-----\t----\t------\n");
    for (int i = 0; i < BLOCK; i++)
    {
        printf("%d\t%d\t%s\n", i + 1, blocks[i],
               allocated[i] ? "Allocated" : "Free");
    }

    // Calculate total fragmentation
    int total_fragment = 0;
    for (int i = 0; i < N; i++)
    {
        if (allocation[i] != -1)
        {
            total_fragment += fragment[i];
        }
    }
    printf("\nTotal Internal Fragmentation: %d\n", total_fragment);

    return 0;
}
