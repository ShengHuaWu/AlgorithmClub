import java.util.Scanner;

/*
Let' take an example of calculating GCD of 54 and 24 using Euclid's algorithm.
Here X = 54 and Y = 24 since Y is not zero we move to the logical part and assign X = Y, which means X becomes 24 and Y becomes 54%24 i.e 6.
Since Y is still not zero, we again apply the logic. This time X will become 6 and Y will become 24%6 i.e. Y=0.
Bingo, Y is now zero which means we have our answer and it's nothing but the value of X which is 6 (six).
 */

class FindGCD {
    static void printGCD() {
        System.out.print("#12: Enter the first number: ");
        int first = new Scanner(System.in).nextInt();

        System.out.print("Enter the second number: ");
        int second = new Scanner(System.in).nextInt();

        System.out.print("Result: " + recursivelyFindGDC(first, second));
    }

    static int recursivelyFindGDC(int first, int second) {
        if (second == 0) {
            return first;
        }

        return recursivelyFindGDC(second, first % second);
    }
}
