#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#define MAX 4

int main()
{
    // Process Burst Times
    int BT[MAX] = {5, 3, 1, 4};
    int remaining_BT[MAX]; // Remaining burst time for each process
    int WT[MAX] = {0};     // Waiting time
    int TAT[MAX] = {0};    // Turnaround time
    int CT[MAX] = {0};     // Completion time

    int totalWT = 0, totalTAT = 0;
    int time_quantum = 2; // Time quantum for Round Robin
    int current_time = 0; // Current time
    int completed = 0;    // Number of completed processes

    // Initialize remaining burst times
    for (int i = 0; i < MAX; i++)
    {
        remaining_BT[i] = BT[i];
    }

    printf("Round Robin Scheduling (Time Quantum = %d)\n", time_quantum);
    printf("Process execution order:\n");

    // Round Robin scheduling
    while (completed < MAX)
    {
        int process_executed = 0;

        for (int i = 0; i < MAX; i++)
        {
            if (remaining_BT[i] > 0)
            {
                process_executed = 1;

                if (remaining_BT[i] > time_quantum)
                {
                    // Process runs for time quantum
                    current_time += time_quantum;
                    remaining_BT[i] -= time_quantum;
                    printf("P%d runs from time %d to %d (remaining: %d)\n",
                           i, current_time - time_quantum, current_time, remaining_BT[i]);
                }
                else
                {
                    // Process completes
                    current_time += remaining_BT[i];
                    printf("P%d runs from time %d to %d (completed)\n",
                           i, current_time - remaining_BT[i], current_time);

                    CT[i] = current_time;
                    TAT[i] = CT[i]; // Since arrival time is 0 for all processes
                    WT[i] = TAT[i] - BT[i];

                    remaining_BT[i] = 0;
                    completed++;
                }
                sleep(1); // For visualization
            }
        }

        // If no process was executed, break to avoid infinite loop
        if (!process_executed)
        {
            break;
        }
    }

    // Calculate totals
    for (int i = 0; i < MAX; i++)
    {
        totalWT += WT[i];
        totalTAT += TAT[i];
    }

    printf("\nResult:\n\n");
    printf("P\tBT\tCT\tTAT\tWT\n");
    for (int i = 0; i < MAX; i++)
    {
        printf("P%d\t%d\t%d\t%d\t%d\n", i, BT[i], CT[i], TAT[i], WT[i]);
    }

    printf("\nTotal Waiting Time: %d\tAvg Waiting Time: %.2f\n",
           totalWT, (float)totalWT / MAX);
    printf("Total Turnaround Time: %d\tAvg Turnaround Time: %.2f\n",
           totalTAT, (float)totalTAT / MAX);

    return 0;
}
