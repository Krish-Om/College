#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>

#define P 5 // Number of processes
#define R 3 // Number of resources

int allocation[P][R];
int max[P][R];
int avail[R];
int need[P][R];

void calculateNeed()
{
    for (int i = 0; i < P; i++)
        for (int j = 0; j < R; j++)
            need[i][j] = max[i][j] - allocation[i][j];
}

bool isSafe()
{
    int work[R], finish[P] = {0}, sequence[P];
    int count = 0;

    // Copy available to work
    for (int i = 0; i < R; i++)
        work[i] = avail[i];

    while (count < P)
    {
        bool found = false;
        for (int p = 0; p < P; p++)
        {
            if (!finish[p])
            {
                bool canFinish = true;
                for (int j = 0; j < R; j++)
                {
                    if (need[p][j] > work[j])
                    {
                        canFinish = false;
                        break;
                    }
                }
                if (canFinish)
                {
                    for (int k = 0; k < R; k++)
                        work[k] += allocation[p][k];
                    sequence[count++] = p;
                    finish[p] = 1;
                    found = true;
                }
            }
        }
        if (!found)
            return false; // Unsafe
    }

    printf("Safe sequence: ");
    for (int i = 0; i < P; i++)
        printf("P%d ", sequence[i]);
    printf("\n");
    return true;
}

bool requestResource(int process, int request[])
{
    // Check if request <= need
    for (int i = 0; i < R; i++)
        if (request[i] > need[process][i])
            return false;

    // Check if request <= available
    for (int i = 0; i < R; i++)
        if (request[i] > avail[i])
            return false;

    // Try allocation
    for (int i = 0; i < R; i++)
    {
        avail[i] -= request[i];
        allocation[process][i] += request[i];
        need[process][i] -= request[i];
    }

    if (isSafe())
    {
        printf("Request granted!\n");
        return true;
    }
    else
    {
        // Rollback
        for (int i = 0; i < R; i++)
        {
            avail[i] += request[i];
            allocation[process][i] -= request[i];
            need[process][i] += request[i];
        }
        printf("Request denied - unsafe!\n");
        return false;
    }
}
int main()
{
    // Seed RNG
    srand((unsigned int)time(NULL));

    // Randomly initialize max and allocation ensuring allocation <= max
    for (int i = 0; i < P; i++)
    {
        for (int j = 0; j < R; j++)
        {
            max[i][j] = 1 + rand() % 6;                  // 1..6
            allocation[i][j] = rand() % (max[i][j] + 1); // 0..max
        }
    }

    // Randomly initialize available resources
    for (int j = 0; j < R; j++)
        avail[j] = rand() % 6; // 0..5

    calculateNeed();

    // Print initial state
    printf("Randomly generated system state (Banker's):\n\n");
    printf("Available: ");
    for (int j = 0; j < R; j++)
        printf("%d ", avail[j]);
    printf("\n\nMax matrix:\n");
    for (int i = 0; i < P; i++)
    {
        for (int j = 0; j < R; j++)
            printf("%d ", max[i][j]);
        printf("\n");
    }
    printf("\nAllocation matrix:\n");
    for (int i = 0; i < P; i++)
    {
        for (int j = 0; j < R; j++)
            printf("%d ", allocation[i][j]);
        printf("\n");
    }
    printf("\nNeed matrix:\n");
    for (int i = 0; i < P; i++)
    {
        for (int j = 0; j < R; j++)
            printf("%d ", need[i][j]);
        printf("\n");
    }

    printf("\nInitial state is %s\n", isSafe() ? "safe" : "unsafe");

    // Test a random resource request within need and available
    int proc = rand() % P;
    int request[R];
    for (int j = 0; j < R; j++)
    {
        int cap = need[proc][j] < avail[j] ? need[proc][j] : avail[j];
        request[j] = (cap == 0) ? 0 : rand() % (cap + 1); // 0..min(need,avail)
    }

    printf("\nTesting request from P%d: [", proc);
    for (int j = 0; j < R; j++)
    {
        printf("%d", request[j]);
        if (j < R - 1)
            printf(", ");
    }
    printf("]\n");
    requestResource(proc, request);

    return 0;
}