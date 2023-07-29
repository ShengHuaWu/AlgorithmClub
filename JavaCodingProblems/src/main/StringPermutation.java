import java.util.Scanner;

class StringPermutation {
    static void printStringPermutation() {
        System.out.print("#34: Enter a text to see all the permutations: ");
        String text = new Scanner(System.in).nextLine();
        System.out.print("Results: \n");
        recursivelyPrintStringPermutation("", text);
    }

    private static void recursivelyPrintStringPermutation(String permutation, String text) {
        if (text.isEmpty()) {
            System.out.print(permutation + "\n");
        } else {
            for (int i = 0; i < text.length(); i ++) {
                String newPermutation = permutation + text.charAt(i);
                String newText = text.substring(0, i) + text.substring(i + 1, text.length());
                recursivelyPrintStringPermutation(newPermutation, newText);
            }
        }
    }
}
