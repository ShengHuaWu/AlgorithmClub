import java.util.Scanner;

class PrintPyramid {
    static void printPyramid() {
        System.out.print("#10: Enter a number to print pyramid: ");
        int number = new Scanner(System.in).nextInt();
        System.out.print("Result:\n" + generatePyramid(number));
    }

    private static String generatePyramid(int number) {
        return recursivelyGeneratePyramid(number, "");
    }

    private static String recursivelyGeneratePyramid(int number, String result) {
        if (number == 0) {
            return result;
        }
        // Insert the `newResult` at the beginning of the entire string
        String newResult = "*".repeat(number) + "\n" + result;

        return recursivelyGeneratePyramid(number - 1, newResult);
    }
}
