#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>
#define MAX 4
int main()
{
    int AT[MAX] = {0, 1, 2, 3};
    int BT[MAX] = {5, 3, 8, 6};
    int CT[MAX] = {0};
    int TAT[MAX] = {0};
    int WT[MAX] = {0};
    int RT[MAX] = {0};

    int totalTAT = 0;
    int totalWT = 0;

    int sum = AT[0];
    for (int i = 0; i < MAX; i++)
    {
        // printf("\nCalculating Computational Time:\n");
        sum = sum + BT[i];
        CT[i] = sum;

        TAT[i] = CT[i] - AT[i];
        totalTAT = totalTAT + TAT[i];

        WT[i] = TAT[i] - BT[i];
        totalWT = totalWT + WT[i];
    }
    printf("Result:\n\n");

    printf("P\tAT\tBT\tCT\tTAT\tWT\n");
    for (int i = 0; i < MAX; i++)
    {
        printf("P%d\t%d\t%d\t%d\t%d\t%d\n", i, AT[i], BT[i], CT[i], TAT[i], WT[i]);
        sleep(1);
    }

    printf("Total Waiting Time:%d\tAvg Wating Time:%.2f\n", totalWT, (float)totalWT / 4);
    printf("Total Turnaround Time:%d\tAvg Wating Time:%.2f\n", totalTAT, (float)totalTAT / 4);

    return 0;
}
