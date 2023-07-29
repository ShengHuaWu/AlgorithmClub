import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class MergeSort {
    static void printMergeSort() {
        System.out.print("#50: Merge sort: \n");
        int[] numbers = {5, 2, 4, 7, 8, 9, 0, 1, 3, 2, 5, 6, 4};
        System.out.println("Original array: " + Arrays.toString(numbers));
        int[] result = mergeSorted(numbers);
        System.out.println("Sorted array: " + Arrays.toString(result));
    }

    private static int[] mergeSorted(int[] numbers) {
        if (numbers.length < 2) {
            return numbers;
        }

        int middle = numbers.length / 2;
        int[] first = mergeSorted(Arrays.copyOfRange(numbers, 0, middle));
        int[] second = mergeSorted(Arrays.copyOfRange(numbers, middle, numbers.length));

        return merge(first, second);
    }

    private static int[] merge(int[] first, int[] second) {
        List<Integer> result = new ArrayList();

        while (first.length > 0 && second.length > 0) {
            int a = first[0];
            int b = second[0];
            if (a < b) {
                result.add(a);
                first = Arrays.copyOfRange(first, 1, first.length);
            } else {
                result.add(b);
                second = Arrays.copyOfRange(second, 1, second.length);
            }
        }

        while (first.length > 0) {
            int a = first[0];
            result.add(a);
            first = Arrays.copyOfRange(first, 1, first.length);
        }

        while (second.length > 0) {
            int b = second[0];
            result.add(b);
            second = Arrays.copyOfRange(second, 1, second.length);
        }

        return result.stream().mapToInt(n -> n).toArray();
    }
}
