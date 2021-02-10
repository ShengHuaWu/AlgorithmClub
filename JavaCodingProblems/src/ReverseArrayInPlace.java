import java.util.Arrays;

class ReverseArrayInPlace {
    static void printReversedArray() {
        System.out.print("#14: Reverse string array in place: \n");
        String[] names = {"John", "Jammy", "Luke"};
        System.out.println("original array: " + Arrays.toString(names) );
        reverseArrayInPlace(names);
        System.out.println("reversed array: " + Arrays.toString(names) );
    }

    private static void reverseArrayInPlace(String[] strings) {
        recursivelyReverseArrayInPlace(0, strings.length - 1, strings);
    }

    private static void recursivelyReverseArrayInPlace(int start, int end, String[] strings) {
        if (start >= end) {
            return;
        }

        String temp = strings[start];
        strings[start] = strings[end];
        strings[end] = temp;

        recursivelyReverseArrayInPlace(start + 1, end - 1, strings);
    }
}
