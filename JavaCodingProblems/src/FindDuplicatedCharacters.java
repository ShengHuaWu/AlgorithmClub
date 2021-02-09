import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.stream.Collectors;

class FindDuplicatedCharacters {
    static void printDuplicatedCharacters() {
        System.out.print("#11: Enter a text to find duplicated characters: ");
        String text = new Scanner(System.in).nextLine();
        System.out.print("Result: " + duplicatedCharacters(text));
    }

    private static Map<Character, Integer> duplicatedCharacters(String text) {
        Map<Character, Integer> charMap = new HashMap<>(Map.of());
        for (int i = 0; i < text.length(); i++) {
            Character c = text.charAt(i);
            if (charMap.containsKey(c)) {
                charMap.put(c, charMap.get(c) + 1);
            } else {
                charMap.put(c, 1);
            }
        }

        // Only return duplicated characters
        return charMap
                .entrySet()
                .stream()
                .filter(pair -> pair.getValue() > 1)
                .collect(Collectors.toMap(Map.Entry<Character, Integer>::getKey, Map.Entry<Character,Integer>::getValue));
    }
}
