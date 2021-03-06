class LinkedList{
    Node head;
    private Node tail;

    LinkedList(String text){
        this.head = new Node(text);
        tail = head;
    }

    Node head(){
        return head;
    }

    void add(Node node){
        tail.next = node;
        tail = node;
    }

    public void print() {
        Node node = head;
        while (node != null) {
            System.out.print(node.data() + " ");
            node = node.next();
        }
        System.out.println("");
    }

    static class Node{
        private Node next;
        private String data;

        Node(String data){
            this.data = data;
        }

        String data() {
            return data;
        }

        void setData(String data) {
            this.data = data;
        }

        Node next() {
            return next;
        }

        void setNext(Node next) {
            this.next = next;
        }

        public String toString(){
            return this.data;
        }
    }
}
