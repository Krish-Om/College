#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#define MAX 4

// Function to sort processes by priority (lower number = higher priority)
void sortByPriority(int BT[], int priority[], int process_id[])
{
    for (int i = 0; i < MAX - 1; i++)
    {
        for (int j = 0; j < MAX - i - 1; j++)
        {
            // If current priority is higher than next (lower number = higher priority)
            if (priority[j] > priority[j + 1])
            {
                // Swap priorities
                int temp = priority[j];
                priority[j] = priority[j + 1];
                priority[j + 1] = temp;

                // Swap burst times
                temp = BT[j];
                BT[j] = BT[j + 1];
                BT[j + 1] = temp;

                // Swap process IDs
                temp = process_id[j];
                process_id[j] = process_id[j + 1];
                process_id[j + 1] = temp;
            }
        }
    }
}

int main()
{
    // Process Burst Times
    int BT[MAX] = {5, 1, 6, 7};
    // Process Priorities (1 = highest priority, 4 = lowest priority)
    int priority[MAX] = {3, 1, 4, 2};
    // Process IDs to keep track of original process numbers
    int process_id[MAX] = {0, 1, 2, 3};

    // Arrays for scheduling calculations
    int WT[MAX] = {0};  // Waiting time
    int TAT[MAX] = {0}; // Turnaround time
    int CT[MAX] = {0};  // Completion time

    int totalWT = 0, totalTAT = 0;

    printf("Original Process Information:\n");
    printf("Process\tBurst Time\tPriority\n");
    for (int i = 0; i < MAX; i++)
    {
        printf("P%d\t%d\t\t%d\n", process_id[i], BT[i], priority[i]);
    }

    // Sort processes by priority (highest priority first)
    sortByPriority(BT, priority, process_id);

    printf("\nAfter sorting by priority (1=highest, 4=lowest):\n");
    printf("Process\tBurst Time\tPriority\n");
    for (int i = 0; i < MAX; i++)
    {
        printf("P%d\t%d\t\t%d\n", process_id[i], BT[i], priority[i]);
    }

    printf("\nExecution Order:\n");

    // Calculate completion, waiting, and turnaround times
    CT[0] = BT[0]; // First process completes at its burst time
    printf("P%d executes from 0 to %d\n", process_id[0], CT[0]);
    sleep(1);

    for (int i = 1; i < MAX; i++)
    {
        CT[i] = CT[i - 1] + BT[i]; // Each process completes after the previous one
        printf("P%d executes from %d to %d\n", process_id[i], CT[i - 1], CT[i]);
        sleep(1);
    }

    // Calculate Turnaround Time and Waiting Time
    for (int i = 0; i < MAX; i++)
    {
        TAT[i] = CT[i];         // Since arrival time is 0 for all
        WT[i] = TAT[i] - BT[i]; // Waiting time = Turnaround time - Burst time
        totalWT += WT[i];
        totalTAT += TAT[i];
    }

    printf("\nFinal Results:\n");
    printf("Process\tPriority\tBT\tCT\tTAT\tWT\n");
    for (int i = 0; i < MAX; i++)
    {
        printf("P%d\t%d\t\t%d\t%d\t%d\t%d\n",
               process_id[i], priority[i], BT[i], CT[i], TAT[i], WT[i]);
    }

    printf("\nTotal Waiting Time: %d\tAvg Waiting Time: %.2f\n",
           totalWT, (float)totalWT / MAX);
    printf("Total Turnaround Time: %d\tAvg Turnaround Time: %.2f\n",
           totalTAT, (float)totalTAT / MAX);

    return 0;
}
