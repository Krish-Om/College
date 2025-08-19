#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>
#define MAX 3

void sort(int *arr)
{
    for (int i = 0; i < MAX; i++)
    {
        for (int j = i + 1; j < MAX; j++)
        {
            if (arr[i] > arr[j])
            {
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
    }
    // return arr;
    // printf("Finished sorting in ascending\n\n");
}
int main()
{
    int AT[MAX] = {3, 2, 1};
    int BT[MAX] = {3, 2, 1};
    int CT[MAX] = {0};
    int TAT[MAX] = {0};
    int WT[MAX] = {0};
    int RT[MAX] = {0};

    int totalTAT = 0;
    int totalWT = 0;

    sort(AT);
    sort(BT);

    for (int i = 1; i < MAX; i++)
    {
        WT[i] = WT[i - 1] + BT[i - 1];
        CT[i] = CT[i - 1] + BT[i];
        TAT[i] = WT[i] + BT[i];
    }

    for (int i = 0; i < MAX; i++)
    {
        totalWT = totalWT + WT[i];
        totalTAT = totalTAT + TAT[i];
    }

    // Print process details
    printf("\nProcess\tAT\tBT\tCT\tTAT\tWT\n");
    for (int i = 0; i < MAX; i++)
    {
        printf("P%d\t%d\t%d\t%d\t%d\t%d\n", i+1, AT[i], BT[i], CT[i], TAT[i], WT[i]);
    }

    // Print averages
    printf("\nAverage Turnaround Time: %.2f\n", (float)totalTAT/MAX);
    printf("Average Waiting Time: %.2f\n", (float)totalWT/MAX);

    return 0;
}
