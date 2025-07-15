#include<stdio.h>
#include<stdlib.h>
#include <stdbool.h>

#define MAX_PROCESSES 5
#define MAX_RESOURCES 3

int main(){
    int need[MAX_PROCESSES][MAX_RESOURCES] = {
        {7, 4, 3}, 
        {1, 2, 2}, 
        {6, 0, 0}, 
        {0, 1, 1}, 
        {4, 3, 1}};

    int avail[MAX_RESOURCES] = {3, 3, 2};
    int done[MAX_PROCESSES] = {0};
    int count = 0;

    
    while (count < MAX_PROCESSES)
    {
        bool found = false;

        for (int i = 0; i < MAX_PROCESSES; i++)
        {
            if(!done[i]){
                bool ok = true;
                for (int j = 0; j < MAX_RESOURCES; j++)
                {
                    if(need[i][j] > avail[j])
                        ok=false;
                }

                if(ok){
                    avail[0] += 0;
                    avail[1] += 1;
                    avail[2] += 0;

                    if(i==1){
                        avail[0]+=2;
                        avail[1]+=0;
                        avail[2]+=0;
                    }
                    if(i==2){
                        avail[0]+=3;
                        avail[1]+=0;
                        avail[2]+=2;
                    }
                    if(i==3){
                        avail[0]+=2;
                        avail[1]+=1;
                        avail[2]+=1;

                    }
                }
                
            }
        }
        

    }
    
return 0;
}