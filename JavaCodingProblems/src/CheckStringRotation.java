import java.util.Scanner;

/*
    A String is said to be a rotation of other string,
    if they contain same characters and the sequence is rotated across any character,
    e.g. "dabc" is a rotation of "abcd" but "dbac" is not.
 */
class CheckStringRotation {
    static void printIsStringRotation() {
        System.out.print("#48: Enter two strings to check rotation: \n");
        String first = new Scanner(System.in).nextLine();
        String second = new Scanner(System.in).nextLine();
        System.out.print("Result: " + isStringRotation(first, second));
    }

    private static Boolean isStringRotation(String first, String second) {
        if (first.isEmpty() || second.isEmpty()) {
            return false;
        }

        if (first.length() != second.length()) {
            return false;
        }

        Character firstCharOfFirst = first.charAt(0);
        Character lastCharOfSecond = second.charAt(second.length() - 1);
        if (!firstCharOfFirst.equals(lastCharOfSecond)) { // Use `equals` to compare two characters
            return false;
        }

        String reminderOfFirst = first.substring(1, first.length());
        String reminderOfSecond = second.substring(0, second.length() - 1);

        return reminderOfFirst.equals(reminderOfSecond); // Use `equals` to compare two strings
    }
}
