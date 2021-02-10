import java.util.Scanner;

class IsIntegerPalindrome {
    static void printIsPalindrome() {
        System.out.print("#4: Enter an integer to check if it is palindrome: ");
        int number = new Scanner(System.in).nextInt();
        System.out.print("Result: " + isPalindrome(number));
    }

    private static Boolean isPalindrome(int number) {
        int copy = number;
        int reversed = 0;

        while (number > 0) {
            int reminder = number % 10;
            number = number / 10;
            reversed = reversed * 10 + reminder;
        }

        return reversed == copy;
    }
}
