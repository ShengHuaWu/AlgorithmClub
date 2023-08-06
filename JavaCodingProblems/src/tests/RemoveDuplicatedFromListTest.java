import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class RemoveDuplicatedFromListTest {
    @Test
    void givenEmptyInputThenReturnEmptyList() {
        List<Integer> result = RemoveDuplicatedFromList.removeDuplicated(List.of());
        assertTrue(result.isEmpty());
    }

    @Test
    void givenNoDuplicationInputThenReturnTheSameList() {
        List<Integer> input = List.of(1, 2, 3, 4, 6, 8, 9, 10);
        List<Integer> result = RemoveDuplicatedFromList.removeDuplicated(input);
        assertEquals(result, input);
    }

    @Test
    void givenHasDuplicationInputThenReturnCorrectList() {
        List<Integer> input = List.of(1, 1, 2, 2, 3, 4, 6, 6, 8, 9, 10, 10);
        List<Integer> result = RemoveDuplicatedFromList.removeDuplicated(input);
        List<Integer> expected = List.of(1, 2, 3, 4, 6, 8, 9, 10);
        assertEquals(result, expected);
    }
}