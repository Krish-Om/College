# Operating System Laboratory Work Report

## Table of Contents
1. [Lab 1: CPU Scheduling Algorithms](#lab-1-cpu-scheduling-algorithms)
2. [Lab 2: Deadlock Avoidance (Banker's Algorithm)](#lab-2-deadlock-avoidance-bankers-algorithm)
3. [Lab 3: Page Replacement Algorithms](#lab-3-page-replacement-algorithms)
4. [Lab 4: Memory Allocation Algorithms](#lab-4-memory-allocation-algorithms)
5. [Summary and Conclusions](#summary-and-conclusions)

---

## Lab 1: CPU Scheduling Algorithms

### Objective
To implement and analyze different CPU scheduling algorithms and compare their performance in terms of waiting time and turnaround time.

### Programs Implemented

#### 1.1 First Come First Serve (FCFS) Scheduling
- **File**: `lab1.1.c`
- **Description**: Non-preemptive scheduling where processes are executed in the order they arrive
- **Input**: 4 processes with arrival times [0,1,2,3] and burst times [5,3,8,6]
- **Key Features**:
  - Simple implementation
  - No context switching overhead
  - May cause convoy effect

#### 1.2 Shortest Job First (SJF) Scheduling
- **File**: `lab1.2.c`
- **Description**: Non-preemptive scheduling where the process with shortest burst time is executed first
- **Input**: 3 processes with varying burst times
- **Key Features**:
  - Optimal average waiting time
  - Requires advance knowledge of burst times
  - May cause starvation for longer processes

#### 1.3 Round Robin (RR) Scheduling
- **File**: `Lab1.3.c`
- **Description**: Preemptive scheduling with fixed time quantum
- **Input**: 4 processes with burst times [5,3,1,4] and time quantum = 2
- **Key Features**:
  - Fair allocation of CPU time
  - Good response time for interactive systems
  - Performance depends on time quantum selection

#### 1.4 Priority Scheduling
- **File**: `Lab1.4.c`
- **Description**: Non-preemptive scheduling based on process priority
- **Input**: 4 processes with priorities [3,1,4,2] (1 = highest priority)
- **Key Features**:
  - Allows important processes to execute first
  - May cause priority inversion
  - Risk of starvation for low-priority processes

### Results Analysis
Each algorithm calculates:
- Completion Time (CT)
- Turnaround Time (TAT) = CT - AT
- Waiting Time (WT) = TAT - BT
- Average waiting time and turnaround time

---

## Lab 2: Deadlock Avoidance (Banker's Algorithm)

### Objective
To implement the Banker's Algorithm for deadlock avoidance and demonstrate safe/unsafe state detection.

### Programs Implemented

#### 2.1 Complete Banker's Algorithm
- **File**: `banker.c`
- **Description**: Full implementation with resource request handling
- **Features**:
  - 5 processes, 3 resource types
  - Need matrix calculation
  - Safety algorithm implementation
  - Resource request validation

#### 2.2 Simplified Banker's Algorithm
- **File**: `tiny_banker.c`
- **Description**: Simplified version focusing on safety sequence
- **Features**:
  - Hardcoded need matrix
  - Direct safety sequence calculation
  - Efficient implementation for demonstration

#### 2.3 Interactive Banker's Algorithm
- **File**: `main.c`
- **Description**: User-interactive version with menu system
- **Features**:
  - Dynamic input handling
  - Multiple test cases
  - Detailed output formatting

### Key Concepts Demonstrated
- **Safety Algorithm**: Determines if system is in safe state
- **Resource Request Algorithm**: Validates and processes resource requests
- **Deadlock Prevention**: Ensures system never enters unsafe state

---

## Lab 3: Page Replacement Algorithms

### Objective
To implement and compare different page replacement algorithms for virtual memory management.

### Programs Implemented

#### 3.1 FIFO Page Replacement
- **File**: `lab3_4.c`
- **Description**: First-In-First-Out page replacement
- **Features**:
  - Simple queue-based implementation
  - 15-page reference string
  - Configurable frame count
  - Belady's anomaly possible

#### 3.2 LRU Page Replacement
- **File**: `lru_page_replacement.c`
- **Description**: Least Recently Used page replacement
- **Features**:
  - Timestamp-based tracking
  - Optimal for temporal locality
  - More complex implementation
  - Better performance than FIFO

#### 3.3 Optimal Page Replacement
- **File**: `optimal_page_replacement.c`
- **Description**: Theoretical optimal algorithm
- **Features**:
  - Future reference knowledge required
  - Minimum possible page faults
  - Benchmark for other algorithms
  - Impractical for real systems

### Performance Metrics
- Page faults count
- Page hit ratio
- Page fault ratio
- Frame utilization

---

## Lab 4: Memory Allocation Algorithms

### Objective
To implement and analyze different memory allocation strategies for dynamic memory management.

### Programs Implemented

#### 4.1 First Fit Allocation
- **File**: `first_fit.c`
- **Description**: Allocates first available block that fits
- **Features**:
  - Fast allocation
  - Simple implementation
  - May cause external fragmentation
  - Memory blocks: [500, 200, 300, 600]

#### 4.2 Best Fit Allocation
- **File**: `best_fit.c`
- **Description**: Allocates smallest block that fits
- **Features**:
  - Minimizes wasted space
  - Reduces external fragmentation
  - Slower allocation (search overhead)
  - Better memory utilization

#### 4.3 Worst Fit Allocation
- **File**: `worst_fit.c`
- **Description**: Allocates largest available block
- **Features**:
  - Leaves larger holes
  - May reduce fragmentation in some cases
  - Generally poor performance
  - Simple to implement

### Analysis Parameters
- Internal fragmentation calculation
- Memory utilization efficiency
- Allocation success rate
- Block allocation tracking

---

## Summary and Conclusions

### Completed Implementations
✅ **4 CPU Scheduling Algorithms** (FCFS, SJF, RR, Priority)  
✅ **3 Banker's Algorithm Variants** (Complete, Simplified, Interactive)  
✅ **3 Page Replacement Algorithms** (FIFO, LRU, Optimal)  
✅ **3 Memory Allocation Algorithms** (First Fit, Best Fit, Worst Fit)  

### Key Learning Outcomes

1. **CPU Scheduling**: Understanding trade-offs between throughput, response time, and fairness
2. **Deadlock Avoidance**: Critical importance of resource allocation strategies
3. **Memory Management**: Virtual memory concepts and page replacement strategies
4. **Memory Allocation**: Dynamic memory management and fragmentation issues

### Performance Comparisons

#### CPU Scheduling
- **FCFS**: Simple but may cause convoy effect
- **SJF**: Optimal average waiting time but potential starvation
- **RR**: Fair but performance depends on quantum
- **Priority**: Flexible but needs careful priority management

#### Page Replacement
- **FIFO**: Simple but suffers from Belady's anomaly
- **LRU**: Good practical performance, exploits locality
- **Optimal**: Theoretical minimum, benchmark for others

#### Memory Allocation
- **First Fit**: Fast but may waste memory
- **Best Fit**: Memory efficient but slower
- **Worst Fit**: Generally poor performance

### Recommendations for Further Study
1. Implement disk scheduling algorithms (FCFS, SSTF, SCAN, C-SCAN)
2. Add preemptive versions of scheduling algorithms
3. Implement advanced page replacement (Clock, Second Chance)
4. Study real-world OS implementations

---

## Compilation and Execution Instructions

### For CPU Scheduling (Lab 1):
```bash
cd Lab1
gcc -g -Wall lab1.1.c -o bin/fcfs
gcc -g -Wall lab1.2.c -o bin/sjf
gcc -g -Wall Lab1.3.c -o bin/rr
gcc -g -Wall Lab1.4.c -o bin/priority
```

### For Banker's Algorithm (Lab 2):
```bash
cd Lab2
gcc -g -Wall banker.c -o bin/banker
gcc -g -Wall tiny_banker.c -o bin/tiny_banker
gcc -g -Wall main.c -o bin/main
```

### For Page Replacement (Lab 3):
```bash
cd lab3
gcc -g -Wall lab3_4.c -o bin/fifo
gcc -g -Wall lru_page_replacement.c -o bin/lru
gcc -g -Wall optimal_page_replacement.c -o bin/optimal
```

### For Memory Allocation (Lab 4):
```bash
cd lab4
gcc -g -Wall first_fit.c -o bin/first_fit
gcc -g -Wall best_fit.c -o bin/best_fit
gcc -g -Wall worst_fit.c -o bin/worst_fit
```

---

*Report prepared by: [Your Name]*  
*Date: August 15, 2025*  
*Course: Operating Systems Laboratory*
