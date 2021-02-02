import java.util.Scanner;

public class Main {
    public static void main(String [] args) {
//        printFibonacciSeries();
        printIsPrime();
    }

    static void printFibonacciSeries() {
        System.out.print("#1: Fibonacci Series\nEnter number:");
        int number = new Scanner(System.in).nextInt();
        System.out.print("Fibonacci series to " + number + ":\n");
        for (int i = 1; i <= number; i++) {
            System.out.print(fibonacci(i) + "\n");
        }
    }

    static int fibonacci(int number) {
        if (number == 1 || number == 2) {
            return 1;
        }

        return fibonacci(number - 1) + fibonacci(number - 2);
    }

    static void printIsPrime() {
        System.out.print("#2: Enter a number to check if it is a prime: ");
        int number = new Scanner(System.in).nextInt();
        System.out.print("Result: " + isPrime(number));
    }

    static Boolean isPrime(int number) {
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