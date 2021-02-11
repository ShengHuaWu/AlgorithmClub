import java.util.Scanner;

class BinarySearch {
    static void printBinarySearch() {
        System.out.print("#18: Enter a number to do binary search: ");
        int value = new Scanner(System.in).nextInt();
        int[] numbers = {1, 3, 4, 5, 6, 7, 8, 9, 9, 10, 12, 14, 17};
        System.out.print("Result: " + binarySearch(value, numbers));
    }

    private static int binarySearch(int value, int[] numbers) {
        return recursivelyBinarySearch(value, 0, numbers.length - 1, numbers);
    }

    private static int recursivelyBinarySearch(int value, int start, int end, int[] numbers) {
        if (start >= end) {
            return -1;
        }

        int mid = (end - start) / 2 + start;
        int midNumber = numbers[mid];
        if (midNumber > value) {
            return recursivelyBinarySearch(value, start, mid, numbers);
        } else if (midNumber < value) {
            return recursivelyBinarySearch(value, mid + 1, end, numbers);
        } else {
            return mid;
        }
    }
}
