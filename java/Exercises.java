import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;

public class Exercises {
    static Map<Integer, Long> change(long amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative");
        }
        var counts = new HashMap<Integer, Long>();
        for (var denomination : List.of(25, 10, 5, 1)) {
            counts.put(denomination, amount / denomination);
            amount %= denomination;
        }
        return counts;
    }

    // Write your first then lower case function here
    public static Optional<String> firstThenLowerCase(List<String> input, Predicate<String> predicate) {
        return input.stream()
            .filter(predicate)
            .findFirst()
            .map(String::toLowerCase);
      }

    // Write your say function here
    static record Sayer(String phrase){
        Sayer and(String word){
            return new Sayer(phrase + " " + word);
        }
    }
    
    public static Sayer say(){
        return new Sayer("");
    }
    
    public static Sayer say(String word){
        return new Sayer(word);
    }

    // Write your line count function here
    public static int meaningfulLineCount(String filename) throws IOException {
        try (var reader = new BufferedReader(new FileReader(filename))) {
            return (int)reader.lines()
                .map(String::strip)
                .filter(line -> !line.isEmpty() && !line.startsWith("#"))
                .count();
        } catch (IOException e) {
            throw new FileNotFoundException("No such file");
        }
    }
}

// Write your Quaternion record class here
record Quaternion(double a, double b, double c, double d){
    public final static Quaternion ZERO = new Quaternion(0, 0, 0, 0);
    public final static Quaternion I = new Quaternion(0, 1, 0, 0);
    public final static Quaternion J = new Quaternion(0, 0, 1, 0);
    public final static Quaternion K = new Quaternion(0, 0, 0, 1);

    public Quaternion{
        if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
            throw new IllegalArgumentException("Coefficients cannot be NaN");
        }
    }

    public Quaternion plus(Quaternion other){
        return new Quaternion(a + other.a, b + other.b, c + other.c, d + other.d);
    }

    public Quaternion times(Quaternion other){
        return new Quaternion(
            a * other.a - b * other.b - c * other.c - d * other.d,
            a * other.b + b * other.a + c * other.d - d * other.c,
            a * other.c - b * other.d + c * other.a + d * other.b,
            a * other.d + b * other.c - c * other.b + d * other.a
        );
    }

    public List<Double> coefficients(){
        return List.of(a, b, c, d);
    }

    public Quaternion conjugate(){
        return new Quaternion(a, -b, -c, -d);
    }

    @Override
    public String toString() {
        var string = new StringBuilder();
        for (int i = 0; i < 4; i++) {
            var coefficient = List.of(a, b, c, d).get(i);
            var element = List.of("", "i", "j", "k").get(i);
            if (coefficient == 0) {
                continue;
            }
            if (string.length() > 0 && coefficient > 0) {
                string.append("+");
            }
            if (Math.abs(coefficient) == 1 && i > 0){
                string.append(coefficient < 0 ? "-" : "").append(element);
            }
            else{
                string.append(coefficient).append(element);
            }
        }
        return string.length() > 0? string.toString() : "0";
    }
   
}
// Write your BinarySearchTree sealed interface and its implementations here
sealed interface BinarySearchTree permits Empty, Node{
    int size();
    boolean contains(String value);
    BinarySearchTree insert(String value);
}

final record Empty() implements BinarySearchTree{
    @Override
    public int size(){
        return 0;
    }
    @Override
    public boolean contains(String value){
        return false;
    }
    public BinarySearchTree insert(String value){
        return new Node(value, this, this);
    }
    @Override
    public String toString(){
        return "";
    }
}

final class Node implements BinarySearchTree{
    private final String value;
    private final BinarySearchTree left;
    private final BinarySearchTree right;

    Node(String value, BinarySearchTree left, BinarySearchTree right) {
        this.value = value;
        this.left = left;
        this.right = right;
    }

    @Override
    public int size(){
        return 1 + left.size() + right.size();
    }
    @Override
    public boolean contains(String value){
        return this.value.equals(value) || left.contains(value) || right.contains(value);
    }
    public BinarySearchTree insert(String value){
        if (value.compareTo(this.value) < 0){
            return new Node(this.value, left.insert(value), right);
        }
        else{
            return new Node(this.value, left, right.insert(value));
        }
    }
    @Override
    public String toString(){
        return "(" + left + value + right + ")";
    }
}


