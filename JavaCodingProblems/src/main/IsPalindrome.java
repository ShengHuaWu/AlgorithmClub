import java.util.Scanner;

class IsPalindrome {
    static void printIsPalindrome() {
        System.out.print("#3: Enter a text to check if it is palindrome: ");
        String text = new Scanner(System.in).nextLine();
//        System.out.print("Result: " + isPalindrome_(text));
        System.out.print("Result: " + isPalindrome(text));
    }

    private static Boolean isPalindrome_(String text) {
        String reversed = new StringBuilder(text).reverse().toString();

        return text.equals(reversed);
    }

    static Boolean isPalindrome(String text) {
        return isPalindromeRecursively(text, 0, text.length() - 1);
    }

    private  static Boolean isPalindromeRecursively(String text, int start, int end) {
        if (start >= end) {
            return true;
        }

        String startChar = text.substring(start, start + 1);
        String endChar = text.substring(end, end + 1);
        if (startChar.equals(endChar)) {
            return isPalindromeRecursively(text, start + 1, end - 1);
        } else {
            return false;
        }
    }
}
