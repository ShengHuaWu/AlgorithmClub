import java.util.LinkedList;
import java.util.List;

class RemoveDuplicatedFromList {
    // The input should be sorted first
    static List<Integer> removeDuplicated(List<Integer> numbers) {
        if (numbers.isEmpty()) {
            return List.of();
        }

        if (numbers.size() == 1) {
            return List.of(numbers.get(0));
        }

        Integer first = numbers.get(0);
        Integer second = numbers.get(1);
        if (first == second) {
            return removeDuplicated(numbers.subList(1, numbers.size()));
        } else {
            List<Integer> rest = removeDuplicated(removeDuplicated(numbers.subList(1, numbers.size())));
            List<Integer> result = new LinkedList(List.of(first)); // `List` doesn't support `addAll` or `remove`, use `LinkedList` instead
            result.addAll(rest);

            return result;
        }
    }
}
