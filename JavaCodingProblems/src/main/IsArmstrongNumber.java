import java.util.Scanner;
/*
    A positive number is called armstrong number if it is equal to the sum of cubes of its digits for example 0, 1, 153, 370, 371, 407 etc.
    For instance, 153 = (1*1*1)+(5*5*5)+(3*3*3) and 371 = (3*3*3)+(7*7*7)+(1*1*1)
 */
class IsArmstrongNumber {
    static void printIsArmstrongNumber() {
        System.out.print("#5: Enter a number to check if it is an armstrong number: ");
        int number = new Scanner(System.in).nextInt();
        System.out.print("Result: " + isArmstrongNumber(number));
    }

    private static Boolean isArmstrongNumber(int number) {
        int copy = number;
        int reminder = 0;
        int sum = 0;

        while (number > 0) {
            reminder = number % 10;
            number = number / 10;
            sum += reminder * reminder * reminder;
        }

        return sum == copy;
    }
}
