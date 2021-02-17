import java.util.List;

class ReverseLinkedList {
    static void printReversedLinkedList() {
        System.out.print("#39: Print reversed linked list: \n");

        LinkedList list = new LinkedList("0");
        list.add( new LinkedList.Node("1"));
        list.add( new LinkedList.Node("2"));
        list.add( new LinkedList.Node("3"));
        list.add( new LinkedList.Node("4"));
        list.add( new LinkedList.Node("5"));
        list.add( new LinkedList.Node("6"));

        System.out.print("Before reversed: ");
        list.print();
        System.out.print("After reversed: ");
        reversed(list).print();
    }

    // Use three pointers to keep tracking the iteration
    private static LinkedList reversed(LinkedList list) {
        LinkedList.Node iterated = list.head();
        LinkedList.Node previous = null;
        LinkedList.Node current = null;

        while (iterated != null) {
            current = iterated;
            iterated = iterated.next();

            current.setNext(previous);
            previous = current;
            list.head = current;
        }

        return list;
    }
}
