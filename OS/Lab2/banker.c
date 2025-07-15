#include <stdio.h>
#include <stdbool.h>

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

void printState()
{
    printf("\nAllocation:\n");
    for (int i = 0; i < P; i++)
    {
        printf("P%d: ", i);
        for (int j = 0; j < R; j++)
            printf("%d ", allocation[i][j]);
        printf("\n");
    }

    printf("\nNeed:\n");
    for (int i = 0; i < P; i++)
    {
        printf("P%d: ", i);
        for (int j = 0; j < R; j++)
            printf("%d ", need[i][j]);
        printf("\n");
    }

    printf("\nAvailable: ");
    for (int i = 0; i < R; i++)
        printf("%d ", avail[i]);
    printf("\n");
}

int main()
{
    // Sample data
    int alloc[P][R] = {{0, 1, 0}, {2, 0, 0}, {3, 0, 2}, {2, 1, 1}, {0, 0, 2}};
    int maximum[P][R] = {{7, 5, 3}, {3, 2, 2}, {9, 0, 2}, {2, 2, 2}, {4, 3, 3}};
    int available[R] = {3, 3, 2};

    // Initialize
    for (int i = 0; i < P; i++)
        for (int j = 0; j < R; j++)
        {
            allocation[i][j] = alloc[i][j];
            max[i][j] = maximum[i][j];
        }

    for (int i = 0; i < R; i++)
        avail[i] = available[i];

    calculateNeed();
    printState();

    printf("\nInitial safety check:\n");
    isSafe();

    // Test request: P1 wants (1,0,2)
    printf("\nP1 requests (1,0,2):\n");
    int req1[] = {1, 0, 2};
    requestResource(1, req1);

    return 0;
}