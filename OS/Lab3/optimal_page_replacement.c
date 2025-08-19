// Optimal Page Replacement (pre-initialized input)
#include <stdio.h>
#include <stdlib.h>

static int findOptimal(int input_string[], int frames[], int no_of_frames, int current_index, int total)
{
    int farthest = current_index;
    int replace_index = -1;
    for (int i = 0; i < no_of_frames; i++)
    {
        int j;
        // Find when this frame's page will be used next
        for (j = current_index + 1; j < total; j++)
        {
            if (frames[i] == input_string[j])
                break;
        }
        // If this page is never used again, replace it
        if (j == total)
            return i;
        // If this page is used farthest in future, mark it for replacement
        if (j > farthest)
        {
            farthest = j;
            replace_index = i;
        }
    }
    // If all pages are used in future, replace the one used farthest
    return (replace_index == -1) ? 0 : replace_index;
}

int main()
{
    // Predefined reference string and frames
    int input_string[] = {7, 0, 1, 2, 0, 3, 0, 4, 2, 3, 0, 3, 2};
    int n = sizeof(input_string) / sizeof(input_string[0]);
    int no_of_frames = 3;

    int *frames = (int *)malloc(sizeof(int) * no_of_frames);
    for (int i = 0; i < no_of_frames; i++)
        frames[i] = -1;

    int page_faults = 0;
    for (int i = 0; i < n; i++)
    {
        int page_found = 0;
        // Check if page is already in frames
        for (int j = 0; j < no_of_frames; j++)
        {
            if (frames[j] == input_string[i])
            {
                page_found = 1;
                break;
            }
        }

        if (!page_found)
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
            }
            else
            {
                // Find optimal frame to replace
                int optimal_index = findOptimal(input_string, frames, no_of_frames, i, n);
                frames[optimal_index] = input_string[i];
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
    return 0;
}
