import java.util.Scanner;

class FibonacciSeries {
    static void printFibonacciSeries() {
        System.out.print("#1: Fibonacci Series\nEnter number:");
        int number = new Scanner(System.in).nextInt();
        System.out.print("Fibonacci series to " + number + ":\n");
        for (int i = 1; i <= number; i++) {
            System.out.print(fibonacci(i) + "\n");
        }
    }

    private static int fibonacci(int number) {
        if (number == 1 || number == 2) {
            return 1;
        }

        return fibonacci(number - 1) + fibonacci(number - 2);
    }
}
