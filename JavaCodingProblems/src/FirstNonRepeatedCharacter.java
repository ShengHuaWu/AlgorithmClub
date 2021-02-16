import java.util.*;

class FirstNonRepeatedCharacter {
    static void printFirstNonRepeatedCharacter() {
        System.out.print("#21: Enter a text to find the first non-repeated character: ");
        String text = new Scanner(System.in).nextLine();
        System.out.print("Result: " + findFirstNonRepeatedCharacter(text));
    }

    private static Character findFirstNonRepeatedCharacter(String text) {
        if (text.isEmpty()) {
            return null; // Temporary solution
        }

        Set<Character> repeating = new HashSet<>();
        List<Character> nonRepeating = new ArrayList<>();
        for (Character letter : text.toCharArray()) {
            if (repeating.contains(letter)) {
                continue;
            }

            if (nonRepeating.contains(letter)) {
                nonRepeating.remove(letter);
                repeating.add(letter);
            } else {
                nonRepeating.add(letter);
            }
        }

        return nonRepeating.get(0);
    }
}
