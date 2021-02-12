import java.util.Scanner;

class ReverseNumber {
    static void printReversedNumber() {
        System.out.print("#20: Enter a number to get the reversion: ");
        int number = new Scanner(System.in).nextInt();
        System.out.print("Result: " + reversed(number));
    }

    private static int reversed(int number) {
        int reminder = number;
        int result = 0;

        while (reminder > 0) {
            result = result * 10 + reminder % 10;
            reminder = reminder / 10;
        }

        return result;
    }
}
