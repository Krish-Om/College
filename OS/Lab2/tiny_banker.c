#include <stdio.h>


#define MAX_RESOURCES 3
#define MAX_PROCESSES 5

int main()
{
    int need[MAX_PROCESSES][MAX_RESOURCES] = {
        {7, 4, 3}, 
        {1, 2, 2}, 
        {6, 0, 0}, 
        {0, 1, 1}, 
        {4, 3, 1}};

    int avail[MAX_RESOURCES] = {3, 3, 2};
    int done[MAX_PROCESSES] = {0};
    int count = 0;

    while (count < MAX_PROCESSES)
    {
        int found = 0;//true
        for (int i = 0; i < MAX_PROCESSES; i++)
        {
            if (!done[i])
            {
                int ok = 1;//true
                for (int j = 0; j < MAX_RESOURCES; j++)
                    if (need[i][j] > avail[j])
                        ok = 0;//false

                if (ok)
                {
                    avail[0] += 0;
                    avail[1] += 1;
                    avail[2] += 0; // P0 allocation
                    if (i == 1)
                    {
                        avail[0] += 2;
                        avail[1] += 0;
                        avail[2] += 0;
                    }
                    if (i == 2)
                    {
                        avail[0] += 3;
                        avail[1] += 0;
                        avail[2] += 2;
                    }
                    if (i == 3)
                    {
                        avail[0] += 2;
                        avail[1] += 1;
                        avail[2] += 1;
                    }
                    if (i == 4)
                    {
                        avail[0] += 0;
                        avail[1] += 0;
                        avail[2] += 2;
                    }

                    printf("P%d ", i);
                    done[i] = 1;
                    count++;
                    found = 1;
                }
            }
        }
        if (!found)
        {
            printf("UNSAFE!");
            return 0;
        }
    }
    printf("- SAFE!\n");
    return 0;
}
