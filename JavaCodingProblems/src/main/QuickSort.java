import java.util.Arrays;
import java.util.stream.Stream;

class QuickSort {
    static void printQuickSort() {
        System.out.print("#30: Quick sort: \n");
        Integer[] inputs = {3, 1, 0, 8, 9, 16, 5, 4, 3};
        Integer[] sorted = quickSorted(inputs);
        System.out.print("Result: " + Arrays.toString(sorted));
    }

    private static Integer[] quickSorted(Integer[] numbers) {
        if (numbers.length == 0) {
            return numbers;
        }

        // Note the conversions between stream and array
        int midIndex = numbers.length / 2;
        Integer mid = numbers[midIndex];
        Stream<Integer> largerThanMid = Arrays.stream(numbers).filter(n -> n > mid);
        Integer[] larger = quickSorted(largerThanMid.toArray(Integer[]::new));

        Stream<Integer> equalToMid = Arrays.stream(numbers).filter(n -> n.equals(mid));

        Stream<Integer> smallerToMid = Arrays.stream(numbers).filter(n -> n < mid);
        Integer[] smaller = quickSorted(smallerToMid.toArray(Integer[]::new));

        return Stream.concat(Stream.concat(Arrays.stream(larger), equalToMid), Arrays.stream(smaller)).toArray(Integer[]::new);
    }
}
