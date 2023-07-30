import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class FindDuplicatedCharactersTest {
    @Test
    void returnEmptyIfInputIsEmptyString() {
        Map<Character, Integer> result = FindDuplicatedCharacters.duplicatedCharacters("");
        assertTrue(result.isEmpty());
    }

    @Test
    void returnEmptyIfInputHasNoDuplication() {
        Map<Character, Integer> result = FindDuplicatedCharacters.duplicatedCharacters("abc");
        assertTrue(result.isEmpty());
    }

    @Test
    void returnCorrectResultIfInputHasDuplication() {
        Map<Character, Integer> result = FindDuplicatedCharacters.duplicatedCharacters("abbc cbba");
        assertEquals(Map.of('a', 2, 'b', 4, 'c', 2), result);
    }
}