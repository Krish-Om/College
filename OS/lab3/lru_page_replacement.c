// C program to implement Page Replacement Algorithm using LRU (Least Recently Used) Algorithm

#include <stdio.h>
#include <stdlib.h>

int main()
{
    int input_string[15];
    int no_of_frames = -1;

    printf("Enter the input string (15 pages):\n");
    for (int i = 0; i < 15; i++)
    {
        scanf("%d", &input_string[i]);
    }
    printf("\n");
    printf("Enter the number of frames:\n");
    scanf("%d", &no_of_frames);

    int i, j;
    int page_faults = 0;
    int frames[no_of_frames];
    int last_used[no_of_frames]; // To track when each frame was last used

    // Initialize frames to -1 (empty) and last_used to -1
    for (i = 0; i < no_of_frames; i++)
    {
        frames[i] = -1;
        last_used[i] = -1;
    }

    printf("\nLRU Page Replacement Algorithm\n");
    printf("===============================\n");
    printf("Page\tFrames\t\tPage Fault\n");
    printf("----\t------\t\t----------\n");

    for (i = 0; i < 15; i++)
    {
        int page_found = 0;
        int page_index = -1;

        // Check if page is already in frames
        for (j = 0; j < no_of_frames; j++)
        {
            if (frames[j] == input_string[i])
            {
                page_found = 1;
                page_index = j;
                break;
            }
        }

        if (page_found)
        {
            // Page hit - update last used time
            last_used[page_index] = i;
            printf("%d\t", input_string[i]);
            for (j = 0; j < no_of_frames; j++)
            {
                if (frames[j] != -1)
                    printf("%d ", frames[j]);
                else
                    printf("- ");
            }
            printf("\t\tNo\n");
        }
        else
        {
            // Page fault occurs
            page_faults++;

            // Find an empty frame first
            int empty_frame = -1;
            for (j = 0; j < no_of_frames; j++)
            {
                if (frames[j] == -1)
                {
                    empty_frame = j;
                    break;
                }
            }

            if (empty_frame != -1)
            {
                // Use empty frame
                frames[empty_frame] = input_string[i];
                last_used[empty_frame] = i;
            }
            else
            {
                // Find LRU frame (frame with minimum last_used time)
                int lru_index = 0;
                for (j = 1; j < no_of_frames; j++)
                {
                    if (last_used[j] < last_used[lru_index])
                    {
                        lru_index = j;
                    }
                }

                // Replace LRU frame
                frames[lru_index] = input_string[i];
                last_used[lru_index] = i;
            }

            printf("%d\t", input_string[i]);
            for (j = 0; j < no_of_frames; j++)
            {
                if (frames[j] != -1)
                    printf("%d ", frames[j]);
                else
                    printf("- ");
            }
            printf("\t\tYes\n");
        }
    }

    printf("\n--- Results ---\n");
    printf("Total page faults: %d\n", page_faults);
    printf("Total page hits: %d\n", 15 - page_faults);
    printf("Page fault ratio: %.2f%%\n", (float)page_faults / 15 * 100);
    printf("Page hit ratio: %.2f%%\n", (float)(15 - page_faults) / 15 * 100);

    return 0;
}
