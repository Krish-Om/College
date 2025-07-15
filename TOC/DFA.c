#include<stdlib.h>
#include<stdio.h>
#include<unistd.h>

// DFA that accepts every string that starts with '0'
void processString(int* string){
    printf("Processing: %d\n",*string);
}
int main(){


    int input[] ={1,1,1,1,1,1,0};
    int lenOfInput = (sizeof(input)/sizeof(input[0]));
    int currState  =0;
    for(int i=0;i<lenOfInput;i++){
        switch (currState)
        {
        case 0:
            if(input[i] == 0){
                //moveToNext state
                processString(&input[i]);
                sleep(2);
                currState = 1; 
                printf("q0 --0--> q2 \n");
            }else if (input[0]==1)
            {
                processString(&input[i]);
                sleep(2);
                printf("q0 --1--> dead state\n");
                currState = 2;
            }
            break;
            case 1:
            if(input[i]==0 || input[i]== 1){
                processString(&input[i]);
                sleep(2);
                printf("q2 --1--> q2");
                currState=1;
            }
            break;
            case 2:
            if(input[i]==0 || input[i] == 1){
                processString(&input[i]);
                sleep(2);
                printf("dead state --0,1--> dead state\n");
                currState=2;
            }
        default:
            break;
        }

    }
    sleep(3);

    if (currState ==1){
        printf("\nAccepted");
    }else{
        printf("\nRejected");
    }
    return 0;
}
