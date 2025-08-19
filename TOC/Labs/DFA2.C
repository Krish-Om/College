//DFA that accepts any string over {a,b} that contain the string aabb in it.
#include<stdio.h>
#include<unistd.h>
#include<string.h>

int delta(int currentState, char str){
    int Q = currentState;
    switch (Q)
    {
    case 0:// In initial state q0
        if (str== 'a')
        {
            //Next state
            sleep(1);
            printf("q%d --%c--> q%d\n",Q,str,Q+1);
            return Q+1;
        }else if(str == 'b'){
            // same state
            sleep(1);
            printf("q%d --%c--> q%d\n",Q,str,Q);
            return Q;
        }
        break;
    case 1://q1
        if(str == 'a'){
            sleep(1);
            printf("q%d --%c--> q%d\n",Q,str,Q+1);
            return Q+1;
        }else if(str == 'b'){
            //Go to previous State
            sleep(1);
            printf("q%d --%c--> q%d\n",Q,str,Q-1); 
            return Q-1;
        }
        break;
    case 2://q2
        if(str == 'a'){
            sleep(1);
            printf("q%d --%c--> q%d\n",Q,str,Q);
            return Q;
        }else if(str == 'b'){
            // Go to q4
            sleep(1);
            printf("q%d --%c--> q%d\n",Q,str,Q+1);
            return Q+1;
        }
        break;
    case 3://q3
        if(str == 'a'){
            // go back to the state where there was only one 'a'
            sleep(1);
            printf("q%d --%c--> q%d\n",Q,str,Q);
            return Q-2;
        }else if(str == 'b'){
            // go to next state
            sleep(1);
            printf("q%d --%c--> q%d\n",Q,str,Q+1);
            return Q+1;
            
        }
        break;
    case 4: //q4 final state
        if(str == 'b'|| str == 'a'){
            sleep(1);
            printf("q%d --%c--> q%d\n",Q,str,Q);
            return Q;
        }
        break;
    default:
        break;
    }
    return Q;
}

int main(int argc, char const *argv[])
{
    char input[100];
    printf("Enter a string over a set {a,b}:");
    fgets(input,sizeof(input),stdin);

    // int lenOfString = (sizeof(input)/sizeof(input[0])) - 1;

    int lenOfString = strlen(input)-1;
    int currentState = 0;
    
    printf("\nInput: %s\n", input);
    printf("Transitions:\n");
    
    for(int i = 0; i < lenOfString; i++){
        currentState = delta(currentState, input[i]);
        printf("After reading '%c', current state: q%d\n", input[i], currentState);
    }
    
    if(currentState == 4){
        printf("\nACCEPTED: String contains 'aabb'\n");
    } else {
        printf("\nREJECTED: String does not contain 'aabb'\n");
    }
    return 0;
}
