import java.util.Scanner;

class FindKthLastOfLinkedList {
    static void printKthLast() {
        System.out.print("#43: Input a non-negative number k to find kth last node of linked list: ");
        int number = new Scanner(System.in).nextInt();

        LinkedList list = new LinkedList("0");
        list.add( new LinkedList.Node("1"));
        list.add( new LinkedList.Node("2"));
        list.add( new LinkedList.Node("3"));
        list.add( new LinkedList.Node("4"));
        list.add( new LinkedList.Node("5"));
        System.out.print("Result: " + findKthLastNode(list, number).toString());
    }

    // Use two pointers fast and slow. The slow pointer starts when the fast pointer reaches to the k-th node.
    private static LinkedList.Node findKthLastNode(LinkedList list, int k) {
        LinkedList.Node fast = list.head;
        LinkedList.Node slow = list.head;
        int count = 0;

        while (fast.next() != null) {
            fast = fast.next();
            count += 1;
            if (count > k) {
                slow = slow.next();
            }
        }

        return slow;
    }
}
