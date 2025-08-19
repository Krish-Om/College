// C program to implement LRU Page Replacement (pre-initialized input)

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    // Predefined reference string and frames
    int input_string[] = {7, 0, 1, 2, 0, 3, 0, 4, 2, 3, 0, 3, 2};
    int n = (int)(sizeof(input_string) / sizeof(input_string[0]));
    int no_of_frames = 3;

    int *frames = (int *)malloc(sizeof(int) * no_of_frames);
    int *last_used = (int *)malloc(sizeof(int) * no_of_frames); // To track when each frame was last used

    int page_faults = 0;
    for (int i = 0; i < no_of_frames; i++)
    {
        frames[i] = -1;
        last_used[i] = -1;
    }

    for (int i = 0; i < n; i++)
    {
        int page_found = 0;
        int page_index = -1;

        // Check if page is already in frames
        for (int j = 0; j < no_of_frames; j++)
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
        }
        else
        {
            // Page fault occurs
            page_faults++;

            // Find an empty frame first
            int empty_frame = -1;
            for (int j = 0; j < no_of_frames; j++)
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
                for (int j = 1; j < no_of_frames; j++)
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
        }

        printf("Frames after %d: ", input_string[i]);
        for (int j = 0; j < no_of_frames; j++)
            printf("%d ", frames[j]);
        printf("\n");
    }

    printf("\n--- Results ---\n");
    printf("Total pages: %d\n", n);
    printf("Total frames: %d\n", no_of_frames);
    printf("Total page faults: %d\n", page_faults);
    printf("Total page hits: %d\n", n - page_faults);

    free(frames);
    free(last_used);
    return 0;
}
