import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

class IsPalindromeTest {
    @Test
    void givenEmptyInputThenReturnTrue() {
        Boolean result = IsPalindrome.isPalindrome("");
        assertTrue(result);
    }

    @Test
    void givenOneCharacterThenReturnTrue() {
        Boolean result = IsPalindrome.isPalindrome("a");
        assertTrue(result);
    }

    @Test
    void givenNotPalindromeThenReturnFalse() {
        Boolean result = IsPalindrome.isPalindrome("this is a fake input text");
        assertFalse(result);
    }

    @Test
    void givenPalindromeWithEvenCharactersThenReturnTrue() {
        Boolean result = IsPalindrome.isPalindrome("abccba");
        assertTrue(result);
    }

    @Test
    void givenPalindromeWithOddCharactersThenReturnTrue() {
        Boolean result = IsPalindrome.isPalindrome("abcba");
        assertTrue(result);
    }
}