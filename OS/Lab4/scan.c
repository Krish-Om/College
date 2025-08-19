// SCAN (Elevator) Disk Scheduling - pre-initialized input
#include <stdio.h>
#include <stdlib.h>

static int cmp(const void *a, const void *b) { return (*(const int *)a) - (*(const int *)b); }

int main(void)
{
    int req[] = {82, 170, 43, 140, 24, 16, 190};
    int n = (int)(sizeof(req) / sizeof(req[0]));
    int head = 50;
    int direction = 1;  // 1: towards higher tracks, -1: towards lower
    int disk_max = 199; // end cylinder

    // Sort requests
    qsort(req, n, sizeof(int), cmp);

    // Find split index
    int idx = 0;
    while (idx < n && req[idx] < head)
        idx++;

    int order[2 * n + 2];
    int k = 0;
    int total = 0, cur = head;

    if (direction == 1)
    {
        // Go up to end
        for (int i = idx; i < n; i++)
        {
            total += abs(req[i] - cur);
            cur = req[i];
            order[k++] = cur;
        }
        // go to end cylinder
        if (cur != disk_max)
        {
            total += disk_max - cur;
            cur = disk_max;
        }
        // then go down serving remaining
        for (int i = idx - 1; i >= 0; i--)
        {
            total += abs(req[i] - cur);
            cur = req[i];
            order[k++] = cur;
        }
    }
    else
    {
        // Go down to 0
        for (int i = idx - 1; i >= 0; i--)
        {
            total += abs(req[i] - cur);
            cur = req[i];
            order[k++] = cur;
        }
        if (cur != 0)
        {
            total += cur;
            cur = 0;
        }
        for (int i = idx; i < n; i++)
        {
            total += abs(req[i] - cur);
            cur = req[i];
            order[k++] = cur;
        }
    }

    printf("SCAN scheduling (dir=%s)\n", direction == 1 ? "up" : "down");
    printf("Initial head: %d, disk_end=%d\n", head, disk_max);
    printf("Service order: ");
    for (int i = 0; i < k; i++)
    {
        printf("%d", order[i]);
        if (i < k - 1)
            printf(" -> ");
    }
    printf("\nTotal head movement: %d\n", total);
    return 0;
}
