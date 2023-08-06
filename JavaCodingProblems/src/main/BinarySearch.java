import java.util.Scanner;

class BinarySearch {
    static int binarySearch(int value, int[] numbers) {
        return recursivelyBinarySearch(value, 0, numbers.length - 1, numbers);
    }

    private static int recursivelyBinarySearch(int value, int start, int end, int[] numbers) {
        if (start > end) {
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
