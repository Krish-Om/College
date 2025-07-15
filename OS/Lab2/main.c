#include <stdio.h>
#include <stdbool.h>

#define MAX_PROCESSES 5
#define MAX_RESOURCES 3

// Global variables
int allocation[MAX_PROCESSES][MAX_RESOURCES];
int max[MAX_PROCESSES][MAX_RESOURCES];
int available[MAX_RESOURCES];
int need[MAX_PROCESSES][MAX_RESOURCES];

// Function to calculate the need matrix
void calculateNeed() {
    for (int i = 0; i < MAX_PROCESSES; i++) {
        for (int j = 0; j < MAX_RESOURCES; j++) {
            need[i][j] = max[i][j] - allocation[i][j];
        }
    }
}

// Function to check if the system is in a safe state
bool isSafeState() {
    int work[MAX_RESOURCES];
    bool finish[MAX_PROCESSES] = {false};
    int safeSequence[MAX_PROCESSES];
    int count = 0;
    
    // Initialize work with available resources
    for (int i = 0; i < MAX_RESOURCES; i++) {
        work[i] = available[i];
    }
    
    // Find a safe sequence
    while (count < MAX_PROCESSES) {
        bool found = false;
        
        for (int p = 0; p < MAX_PROCESSES; p++) {
            if (!finish[p]) {
                bool canAllocate = true;
                
                // Check if current process can be allocated
                for (int j = 0; j < MAX_RESOURCES; j++) {
                    if (need[p][j] > work[j]) {
                        canAllocate = false;
                        break;
                    }
                }
                
                if (canAllocate) {
                    // Add allocated resources back to work
                    for (int k = 0; k < MAX_RESOURCES; k++) {
                        work[k] += allocation[p][k];
                    }
                    
                    safeSequence[count++] = p;
                    finish[p] = true;
                    found = true;
                }
            }
        }
        
        if (!found) {
            printf("System is in unsafe state - deadlock may occur!\n");
            return false;
        }
    }
    
    printf("System is in safe state.\nSafe sequence: ");
    for (int i = 0; i < MAX_PROCESSES; i++) {
        printf("P%d ", safeSequence[i]);
    }
    printf("\t");
    return true;
}

// Function to request resources for a process
bool requestResources(int processId, int request[]) {
    printf("\nProcess P%d requesting resources: ", processId);
    for (int i = 0; i < MAX_RESOURCES; i++) {
        printf("%d ", request[i]);
    }
    printf("\n");
    
    // Check if request is valid (not exceeding need)
    for (int i = 0; i < MAX_RESOURCES; i++) {
        if (request[i] > need[processId][i]) {
            printf("Error: Request exceeds maximum need!\n");
            return false;
        }
    }
    
    // Check if request can be satisfied with available resources
    for (int i = 0; i < MAX_RESOURCES; i++) {
        if (request[i] > available[i]) {
            printf("Resources not available. Process must wait.\n");
            return false;
        }
    }
    
    // Try allocating resources temporarily
    for (int i = 0; i < MAX_RESOURCES; i++) {
        available[i] -= request[i];
        allocation[processId][i] += request[i];
        need[processId][i] -= request[i];
    }
    
    // Check if system remains in safe state
    if (isSafeState()) {
        printf("Request granted successfully!\n");
        return true;
    } else {
        // Rollback the allocation
        for (int i = 0; i < MAX_RESOURCES; i++) {
            available[i] += request[i];
            allocation[processId][i] -= request[i];
            need[processId][i] += request[i];
        }
        printf("Request denied - would lead to unsafe state!\n");
        return false;
    }
}

// Function to display current state
void displayState() {
    printf("\n--- Current System State ---\n");
    
    printf("Allocation Matrix:\n");
    for (int i = 0; i < MAX_PROCESSES; i++) {
        printf("P%d: ", i);
        for (int j = 0; j < MAX_RESOURCES; j++) {
            printf("%d ", allocation[i][j]);
        }
        printf("\n");
    }
    
    printf("\nMax Matrix:\n");
    for (int i = 0; i < MAX_PROCESSES; i++) {
        printf("P%d: ", i);
        for (int j = 0; j < MAX_RESOURCES; j++) {
            printf("%d ", max[i][j]);
        }
        printf("\n");
    }
    
    printf("\nNeed Matrix:\n");
    for (int i = 0; i < MAX_PROCESSES; i++) {
        printf("P%d: ", i);
        for (int j = 0; j < MAX_RESOURCES; j++) {
            printf("%d ", need[i][j]);
        }
        printf("\n");
    }
    
    printf("\nAvailable Resources: ");
    for (int i = 0; i < MAX_RESOURCES; i++) {
        printf("%d ", available[i]);
    }
    printf("\n");
}

int main() {
    printf("=== Banker's Algorithm Simulation ===\n");
    
    // Initialize allocation matrix
    int alloc[MAX_PROCESSES][MAX_RESOURCES] = {
        {0, 1, 0},  // P0
        {2, 0, 0},  // P1
        {3, 0, 2},  // P2
        {2, 1, 1},  // P3
        {0, 0, 2}   // P4
    };
    
    // Initialize max matrix
    int maximum[MAX_PROCESSES][MAX_RESOURCES] = {
        {7, 5, 3},  // P0
        {3, 2, 2},  // P1
        {9, 0, 2},  // P2
        {2, 2, 2},  // P3
        {4, 3, 3}   // P4
    };
    
    // Initialize available resources
    int avail[MAX_RESOURCES] = {3, 3, 2};  // A, B, C
    
    // Copy to global arrays
    for (int i = 0; i < MAX_PROCESSES; i++) {
        for (int j = 0; j < MAX_RESOURCES; j++) {
            allocation[i][j] = alloc[i][j];
            max[i][j] = maximum[i][j];
        }
    }
    
    for (int i = 0; i < MAX_RESOURCES; i++) {
        available[i] = avail[i];
    }
    
    // Calculate need matrix
    calculateNeed();
    
    // Display initial state
    displayState();
    
    // Check if initial state is safe
    printf("\nChecking initial state safety:\n");
    isSafeState();
    
    // Simulate some resource requests
    printf("\n=== Resource Request Simulation ===\n");
    
    // P1 requests (1, 0, 2)
    int request1[MAX_RESOURCES] = {1, 0, 2};
    requestResources(1, request1);
    
    // P4 requests (3, 3, 0)
    int request2[MAX_RESOURCES] = {3, 3, 0};
    requestResources(4, request2);
    
    // P0 requests (0, 2, 0)
    int request3[MAX_RESOURCES] = {0, 2, 0};
    requestResources(0, request3);
    
    // Display final state
    printf("\n=== Final State ===\n");
    displayState();
    
    return 0;
}