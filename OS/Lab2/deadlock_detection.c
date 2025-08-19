#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>

#define MAX_PROCESSES 5
#define MAX_RESOURCES 3

// Data structures for deadlock detection
int available[MAX_RESOURCES];
int allocation[MAX_PROCESSES][MAX_RESOURCES];
int request[MAX_PROCESSES][MAX_RESOURCES];
bool finished[MAX_PROCESSES];

// Function to check if a process can finish
bool canProcessFinish(int process)
{
    for (int j = 0; j < MAX_RESOURCES; j++)
    {
        if (request[process][j] > available[j])
            return false;
    }
    return true;
}

// Function to detect deadlock
bool detectDeadlock()
{
    // Initialize finished array
    for (int i = 0; i < MAX_PROCESSES; i++)
    {
        finished[i] = false;
    }

    int work[MAX_RESOURCES];
    // Copy available resources to work
    for (int i = 0; i < MAX_RESOURCES; i++)
    {
        work[i] = available[i];
    }

    // Find a process that can finish
    bool found;
    do
    {
        found = false;
        for (int i = 0; i < MAX_PROCESSES; i++)
        {
            if (!finished[i])
            {
                bool can_finish = true;
                // Check if process can acquire needed resources
                for (int j = 0; j < MAX_RESOURCES; j++)
                {
                    if (request[i][j] > work[j])
                    {
                        can_finish = false;
                        break;
                    }
                }

                if (can_finish)
                {
                    // Process can finish, release its resources
                    for (int j = 0; j < MAX_RESOURCES; j++)
                    {
                        work[j] += allocation[i][j];
                    }
                    finished[i] = true;
                    found = true;
                }
            }
        }
    } while (found);

    // Check if all processes finished
    for (int i = 0; i < MAX_PROCESSES; i++)
    {
        if (!finished[i])
        {
            return true; // Deadlock exists
        }
    }
    return false; // No deadlock
}

int main()
{
    // Seed RNG
    srand((unsigned int)time(NULL));

    // Randomly initialize available resources (small values for demo)
    for (int j = 0; j < MAX_RESOURCES; j++)
    {
        available[j] = rand() % 4; // 0..3
    }

    // Randomly initialize allocation and request matrices
    for (int i = 0; i < MAX_PROCESSES; i++)
    {
        for (int j = 0; j < MAX_RESOURCES; j++)
        {
            allocation[i][j] = rand() % 4; // 0..3
            request[i][j] = rand() % 4;    // 0..3
        }
    }

    // Print the randomly generated state
    printf("Available: ");
    for (int j = 0; j < MAX_RESOURCES; j++)
        printf("%d ", available[j]);
    printf("\n\nAllocation matrix:\n");
    for (int i = 0; i < MAX_PROCESSES; i++)
    {
        for (int j = 0; j < MAX_RESOURCES; j++)
            printf("%d ", allocation[i][j]);
        printf("\n");
    }
    printf("\nRequest matrix:\n");
    for (int i = 0; i < MAX_PROCESSES; i++)
    {
        for (int j = 0; j < MAX_RESOURCES; j++)
            printf("%d ", request[i][j]);
        printf("\n");
    }

    // Detect deadlock
    if (detectDeadlock())
    {
        printf("\nSystem is in DEADLOCK state!\n");
        printf("Deadlocked processes: ");
        for (int i = 0; i < MAX_PROCESSES; i++)
        {
            if (!finished[i])
            {
                printf("P%d ", i);
            }
        }
        printf("\n");
    }
    else
    {
        printf("\nNo deadlock detected.\n");
    }

    return 0;
}
