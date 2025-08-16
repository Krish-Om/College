// C program to implement Page Replacement Algorithm using Optimal Algorithm

#include <stdio.h>
#include <stdlib.h>

// Function to find the optimal page to replace
int findOptimal(int input_string[], int frames[], int no_of_frames, int current_index)
{
    int farthest = current_index;
    int replace_index = -1;

    for (int i = 0; i < no_of_frames; i++)
    {
        int j;
        // Find when this frame's page will be used next
        for (j = current_index + 1; j < 15; j++)
        {
            if (frames[i] == input_string[j])
                break;
        }

        // If this page is never used again, replace it
        if (j == 15)
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

    // Initialize frames to -1 (empty)
    for (i = 0; i < no_of_frames; i++)
    {
        frames[i] = -1;
    }

    printf("\nOptimal Page Replacement Algorithm\n");
    printf("===================================\n");
    printf("Page\tFrames\t\tPage Fault\n");
    printf("----\t------\t\t----------\n");

    for (i = 0; i < 15; i++)
    {
        int page_found = 0;

        // Check if page is already in frames
        for (j = 0; j < no_of_frames; j++)
        {
            if (frames[j] == input_string[i])
            {
                page_found = 1;
                break;
            }
        }

        if (page_found)
        {
            // Page hit
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
            }
            else
            {
                // Find optimal frame to replace
                int optimal_index = findOptimal(input_string, frames, no_of_frames, i);
                frames[optimal_index] = input_string[i];
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
