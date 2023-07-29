import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class BinarySearchTest {
    private static int[] numbers = {1, 3, 4, 5, 6, 7, 8, 9, 9, 10, 12, 14, 17};

    @Test
    void binarySearchArrayNotContainTarget() {
        int target = 99;
        int result = BinarySearch.binarySearch(target, numbers);
        assertEquals(-1, result);
    }

    @Test
    void binarySearchArrayIsEmpty() {
        int target = 1;
        int[] numbers = {};
        int result = BinarySearch.binarySearch(target, numbers);
        assertEquals(-1, result);
    }

    @Test
    void binarySearchTargetAtFirst() {
        int target = 1;
        int result = BinarySearch.binarySearch(target, numbers);
        assertEquals(0, result);
    }

    @Test
    void binarySearchTargetAtLast() {
        int target = 17;
        int result = BinarySearch.binarySearch(target, numbers);
        assertEquals(12, result);
    }

    @Test
    void binarySearchTargetAtMiddle() {
        int target = 8;
        int result = BinarySearch.binarySearch(target, numbers);
        assertEquals(6, result);
    }

    @Test
    void binarySearchDuplicatedTarget() {
        int target = 9;
        int result = BinarySearch.binarySearch(target, numbers);
        assertEquals(8, result);
    }
}