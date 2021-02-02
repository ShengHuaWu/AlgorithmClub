import java.util.Scanner;

class IsPrime {
    static void printIsPrime() {
        System.out.print("#2: Enter a number to check if it is a prime: ");
        int number = new Scanner(System.in).nextInt();
        System.out.print("Result: " + isPrime(number));
    }

    private static Boolean isPrime(int number) {
        if (number == 2 || number == 3) {
            return true;
        }

        if (number % 2 == 0) {
            return false;
        }

        // Check whether n is a multiple of any integer between 3 and sqrt{n}, but skip even numbers
        int sqrt = (int) Math.sqrt(number) + 1;
        for (int i = 3; i < sqrt; i += 2) {
            if (number % i == 0) {
                return false;
            }
        }

        return true;
    }
}
