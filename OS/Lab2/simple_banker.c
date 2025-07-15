#include <stdio.h>

int main()
{
    // 5 processes, 3 resources (A, B, C)
    int allocation[5][3] = {{0, 1, 0}, {2, 0, 0}, {3, 0, 2}, {2, 1, 1}, {0, 0, 2}};
    int max[5][3] = {{7, 5, 3}, {3, 2, 2}, {9, 0, 2}, {2, 2, 2}, {4, 3, 3}};
    int available[3] = {3, 3, 2};

    // Calculate need = max - allocation
    int need[5][3];
    for (int i = 0; i < 5; i++)
        for (int j = 0; j < 3; j++)
            need[i][j] = max[i][j] - allocation[i][j];

    // Safety algorithm
    int work[3] = {3, 3, 2}; // Copy of available
    int finished[5] = {0};   // Track completed processes
    int safe_sequence[5];
    int count = 0;

    printf("Checking safety...\n");

    while (count < 5)
    {
        int found = 0;

        for (int i = 0; i < 5; i++)
        {
            if (!finished[i])
            {
                // Can this process finish?
                int can_finish = 1;
                for (int j = 0; j < 3; j++)
                {
                    if (need[i][j] > work[j])
                    {
                        can_finish = 0;
                        break;
                    }
                }

                if (can_finish)
                {
                    // Process can finish - add its resources back
                    for (int j = 0; j < 3; j++)
                        work[j] += allocation[i][j];

                    safe_sequence[count++] = i;
                    finished[i] = 1;
                    found = 1;
                    printf("Process P%d can finish\n", i);
                }
            }
        }

        if (!found)
        {
            printf("System is UNSAFE - Deadlock possible!\n");
            return 0;
        }
    }

    printf("\nSystem is SAFE!\n");
    printf("Safe sequence: ");
    for (int i = 0; i < 5; i++)
        printf("P%d ", safe_sequence[i]);
    printf("\n");

    return 0;
}
