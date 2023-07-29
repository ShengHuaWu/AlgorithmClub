class FindLinkedListLoop {
    static void printFindLinkedListLoop() {
        System.out.print("#41: Find cycle linked list: \n");

        LinkedList first = new LinkedList("0");
        first.add( new LinkedList.Node("1"));
        first.add( new LinkedList.Node("2"));
        first.add( new LinkedList.Node("3"));
        first.add( new LinkedList.Node("4"));
        first.add( new LinkedList.Node("5"));
        System.out.print("Is first list cycle: \n" + findLinkedListLoop(first).toString() + "\n");

        LinkedList second = new LinkedList("0");
        LinkedList.Node cycle = new LinkedList.Node("2");
        second.add( new LinkedList.Node("1"));
        second.add(cycle);
        second.add( new LinkedList.Node("3"));
        second.add( new LinkedList.Node("4"));
        second.add( new LinkedList.Node("5"));
        second.add(cycle);
        System.out.print("Is second list cycle: \n" + findLinkedListLoop(second).toString());
    }

    // Use two pointers: one fast and the other slow
    private static Boolean findLinkedListLoop(LinkedList list) {
        LinkedList.Node fast = list.head;
        LinkedList.Node slow = list.head;

        while (fast != null && fast.next() != null) {
            fast = fast.next().next();
            slow = slow.next();

            if (fast == slow) {
                return true;
            }
        }

        return false;
    }
}
