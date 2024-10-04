import java.io.*

fun change(amount: Long): Map<Int, Long> {
    require(amount >= 0) { "Amount cannot be negative" }

    val counts = mutableMapOf<Int, Long>()
    var remaining = amount
    for (denomination in listOf(25, 10, 5, 1)) {
        counts[denomination] = remaining / denomination
        remaining %= denomination
    }
    return counts
}

// Write your first then lower case function here
fun firstThenLowerCase(strings: List<String>, predicate: (String) -> Boolean) : String? {
    return strings.firstOrNull(predicate)?.toLowerCase()
}

// Write your say function here
data class Say(val phrase: String = "") {
    fun and(nextPhrase: String): Say {
        return Say(phrase + " " + nextPhrase)
    }
}
fun say(phrase: String = ""): Say {
    return Say(phrase)
}

// Write your meaningfulLineCount function here

@Throws(IOException::class)
fun meaningfulLineCount(filename: String): Long {
    return try {
        BufferedReader(FileReader(filename)).use { reader ->
            reader.lines()
                .map { it.trim() }
                .filter { !it.isEmpty() && !it.startsWith("#") }
                .count()
        }
    } catch (e: FileNotFoundException) {
        throw FileNotFoundException("No such file")
    }
}

// Write your Quaternion data class here
data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {
    companion object{
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }

    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(a + other.a, b + other.b, c + other.c, d + other.d)
    }
    operator fun times(other: Quaternion): Quaternion {
        return Quaternion(
            a * other.a - b * other.b - c * other.c - d * other.d,
            a * other.b + b * other.a + c * other.d - d * other.c,
            a * other.c - b * other.d + c * other.a + d * other.b,
            a * other.d + b * other.c - c * other.b + d * other.a
        )
    }
    fun conjugate(): Quaternion = Quaternion(a, -b, -c, -d)

    fun coefficients(): List<Double> = listOf(a, b, c, d)

    override fun toString(): String {
        val string = StringBuilder();
        for (i in 0 until 4) {
            val coefficient = listOf(a, b, c, d)[i];
            val element = listOf("", "i", "j", "k")[i];
            if (coefficient == 0.0) {
                continue;
            }
            if (string.isNotEmpty() && coefficient > 0) {
                string.append("+");
            }
            if (kotlin.math.abs(coefficient) == 1.0 && i > 0){
                string.append(if (coefficient < 0) "-" else "").append(element)
            }
            else{
                string.append(coefficient).append(element);
            }
        }
        return if (string.isNotEmpty()) string.toString() else "0"
    }
}

// Write your Binary Search Tree interface and implementing classes here
sealed interface BinarySearchTree{
    fun size(): Int
    fun contains(value:String): Boolean
    fun insert(value:String): BinarySearchTree

    object Empty : BinarySearchTree{
        override fun size(): Int = 0
        override fun contains(value: String): Boolean = false
        override fun insert(value: String): BinarySearchTree = Node(value, Empty, Empty)
        override fun toString(): String = ""
    }

    data class Node(private val value : String, private val left: BinarySearchTree, private val right: BinarySearchTree) : BinarySearchTree{

        override fun size(): Int = 1 + left.size() + right.size()

        override fun contains(value: String): Boolean = when {
            this.value == value -> true
            this.value > value -> left.contains(value)
            else -> right.contains(value)
        }
        override fun insert(value: String): BinarySearchTree = when {
            this.value == value -> this
            this.value > value -> Node(this.value, left.insert(value), right)
            else -> Node(this.value, left, right.insert(value))
        }
        override fun toString(): String = "(" + left + value + right+ ")"
    }
}