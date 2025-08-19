// Shortest Seek Time First (SSTF) Disk Scheduling - pre-initialized input
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

static int abs_i(int x) { return x < 0 ? -x : x; }

int main(void)
{
    // Predefined request queue and initial head position
    int req[] = {82, 170, 43, 140, 24, 16, 190};
    int n = (int)(sizeof(req) / sizeof(req[0]));
    int head = 50;

    bool done[n];
    for (int i = 0; i < n; i++)
        done[i] = false;

    int order[n];
    int total = 0;
    int cur = head;

    for (int k = 0; k < n; k++)
    {
        int best = -1;
        int bestDist = 0x7fffffff;
        for (int i = 0; i < n; i++)
        {
            if (!done[i])
            {
                int d = abs_i(req[i] - cur);
                if (d < bestDist)
                {
                    bestDist = d;
                    best = i;
                }
            }
        }
        total += bestDist;
        cur = req[best];
        done[best] = true;
        order[k] = cur;
    }

    printf("SSTF scheduling\n");
    printf("Initial head: %d\n", head);
    printf("Service order: ");
    for (int i = 0; i < n; i++)
    {
        printf("%d", order[i]);
        if (i < n - 1)
            printf(" -> ");
    }
    printf("\nTotal head movement: %d\n", total);
    return 0;
}
