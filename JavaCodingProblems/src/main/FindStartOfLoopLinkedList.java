import java.util.Scanner;

class FindStartOfLoopLinkedList {
    static void printStartNodeOfLoop() {
        System.out.print("#42: Find the starting node of looped linked list: \n");

        LinkedList list = new LinkedList("0");
        LinkedList.Node cycle = new LinkedList.Node("2");
        list.add( new LinkedList.Node("1"));
        list.add(cycle);
        list.add( new LinkedList.Node("3"));
        list.add( new LinkedList.Node("4"));
        list.add( new LinkedList.Node("5"));
        list.add(cycle);
        System.out.print("Result: \n" + findStartOfLoop(list).toString());
    }

    /*
    1. Find meeting point of slow pointer and fast pointer.
    2. Set slow pointer to head node of list.
    3. Move slow pointer and fast pointer together.
    4. The node at which slow pointer and fast pointer meets, will be the starting node of loop.
     */
    private static LinkedList.Node findStartOfLoop(LinkedList list) {
        LinkedList.Node fast = list.head;
        LinkedList.Node slow = list.head;
        Boolean hasLoop = false;

        while (fast != null && fast.next() != null) {
            fast = fast.next().next();
            slow = slow.next();

            if (fast.equals(slow)) {
                hasLoop = true;
                break;
            }
        }

        if (!hasLoop) return null;

        slow = list.head;
        while (!slow.equals(fast)) {
            fast = fast.next();
            slow = slow.next();
        }

        return slow;
    }
}
