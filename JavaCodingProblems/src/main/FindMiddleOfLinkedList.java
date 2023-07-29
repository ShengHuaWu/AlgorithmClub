class FindMiddleOfLinkedList {
    static void printMiddleOfLinkedList() {
        System.out.print("#22: Find the middle of a linked list: \n");
        LinkedList list = new LinkedList("0");
        list.add( new LinkedList.Node("1"));
        list.add( new LinkedList.Node("2"));
        list.add( new LinkedList.Node("3"));
        list.add( new LinkedList.Node("4"));
        list.add( new LinkedList.Node("5"));
        list.add( new LinkedList.Node("6"));
        System.out.println("Result: " + findMiddle(list).toString());
    }

    // The first pointer traverses the list regularly,
    // and the second pointer traverses the list with a half speed of the first one
    private static LinkedList.Node findMiddle(LinkedList list) {
        LinkedList.Node current = list.head();
        LinkedList.Node middle = list.head();
        int count = 0;

        while (current.next() != null) {
            count += 1;
            if (count % 2 == 0) {
                middle = middle.next();
            }
            current = current.next();
        }

        if (count % 2 == 1) {
            middle = middle.next();
        }

        return middle;
    }
}
