class Q:
    def __init__(self, size):
        self.rear = -1
        self.front = -1
        self.size = size
        self.queue = [0] * self.size

    def enqueue(self, item):
        if self.rear == self.size - 1:
            print("OverflowError")
        else:
            if self.front == -1:
                self.front = 0
            self.rear += 1
            self.queue[self.rear] = item
            print(f"Items enqueued:{item}")
        return

    def dequeue(self):
        if (self.rear == -1 or self.front == -1) or self.front > self.rear:
            print(f"Queue is empty")
        else:
            if self.front > self.rear:
                self.rear = self.front = -1
            removed = self.queue[self.front]
            self.queue[self.front] = 0
            print(f"{removed} is dequeued from queue")
            self.front += 1

        return

    def peek(self):
        if (self.rear == -1 or self.front == -1) or self.front > self.rear:
            print(f"Queue is empty")
        else:
            print(f"{self.queue[self.front]} is the first value present")

        return

    def display(self):
        if (self.rear == -1 or self.front == -1) or self.front > self.rear:
            print(f"Queue is empty")
        else:
            print("Items present in queue:\n")
            for i in self.queue:
                print(f"{i}", end=" ")
                print()
        return

    def sum_even_item_in_q(self):
        sum = 0
        for x in self.queue:
            if x % 2 == 0:
                sum += x

        print(f"{sum} is the required sum of even numbers")
        return


if __name__ == "__main__":
    size = int(input("enter the size of the queue: "))
    q = Q(size)

    while True:
        print(f' {"*" * 5}\n')
        print(
            f"\n1.enqueue\n 2.dequeu\n 3.peek\n 4.display\n 5.sum of even item\n 6.exit\n"
        )
        choice = int(input("Enter the choice to perform:"))

        match choice:
            case 1:
                x = int(input("Enter a value to enqueue:"))
                q.enqueue(x)
                # break
            case 2:
                q.dequeue()
                # break
            case 3:
                q.peek()
                # break
            case 4:
                q.display()
                # break
            case 5:
                q.sum_even_item_in_q()
            case 6:
                exit(0)
            case _:
                print("Invalid choices")
                # break
