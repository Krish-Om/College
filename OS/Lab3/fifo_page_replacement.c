// C program to implement FIFO Page Replacement (pre-initialized input)

#include <stdlib.h>
#include <stdio.h>

int main()
{
    // Predefined reference string and frames
    int input_string[] = {7, 0, 1, 2, 0, 3, 0, 4, 2, 3, 0, 3, 2};
    int n = (int)(sizeof(input_string) / sizeof(input_string[0]));
    int no_of_frames = 3;

    int *frames = (int *)malloc(sizeof(int) * no_of_frames);
    int front = 0; // index to replace next (FIFO queue)

    int page_faults = 0;
    for (int i = 0; i < no_of_frames; i++)
        frames[i] = -1;

    for (int i = 0; i < n; i++)
    {
        int page = input_string[i];
        int page_found = 0;
        for (int j = 0; j < no_of_frames; j++)
        {
            if (frames[j] == page)
            {
                page_found = 1; // Page hit
                break;
            }
        }
        if (!page_found)
        {
            // Page fault occurs
            page_faults++;
            // Replace at FIFO front position
            frames[front] = page;
            front = (front + 1) % no_of_frames;
        }
        printf("Frames after %d: ", page);
        for (int j = 0; j < no_of_frames; j++)
            printf("%d ", frames[j]);
        printf("\n");
    }
    printf("Total pages: %d\n", n);
    printf("Total frames: %d\n", no_of_frames);
    printf("Total page faults: %d\n", page_faults);
    printf("Total page hits: %d\n", n - page_faults);
    printf("Total replacements (approx): %d\n", page_faults);

    free(frames);
    return 0;
}
