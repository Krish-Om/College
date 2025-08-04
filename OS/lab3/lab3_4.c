// C program to implement Page replacement Algorithm using FIFO Algorithm

#include <stdlib.h>
#include <stdio.h>

int main()
{
  int input_string[15];
  int no_of_frames = -1;
  printf("Enter the input string:\n");
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
  for (i = 0; i < no_of_frames; i++)
  {
    frames[i] = -1; // Initialize frames to -1 (empty)
  }
  for (i = 0; i < 15; i++)
  {
    int page_found = 0;
    for (j = 0; j < no_of_frames; j++)
    {
      if (frames[j] == input_string[i])
      {
        page_found = 1; // Page is already in frame
        break;
      }
    }
    if (!page_found)
    {
      // Page fault occurs
      page_faults++;
      // Find an empty frame or replace the first frame (FIFO)
      int replaced = 0;
      for (j = 0; j < no_of_frames; j++)
      {
        if (frames[j] == -1)
        {
          frames[j] = input_string[i];
          replaced = 1;
          break;
        }
      }
      if (!replaced)
      {
        for (j = 0; j < no_of_frames - 1; j++)
        {
          frames[j] = frames[j + 1];
        }
        frames[no_of_frames - 1] = input_string[i];
      }
    }
    printf("Current frames: ");
    for (j = 0; j < no_of_frames; j++)
    {
      printf("%d ", frames[j]);
    }
    printf("\n");
  }
  printf("Total page faults: %d\n", page_faults);
  printf("Total page hits: %d\n", 15 - page_faults);
  printf("Total number of pages: 15\n");
  printf("Total number of frames: %d\n", no_of_frames);
  printf("Total number of page replacements: %d\n", page_faults);
  return 0;
}
