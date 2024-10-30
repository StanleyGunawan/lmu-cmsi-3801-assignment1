import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int:Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int:Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = 
            remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}

// Write your first then lower case function here
func firstThenLowerCase(of strings: [String], satisfying predicate: (String) -> Bool) -> String? {
    return strings.first(where: predicate)?.lowercased()
}


// Write your say function here
struct Sayer {
    let phrase: String
    func and(_ word: String) -> Sayer {
        return Sayer(phrase:"\(phrase) \(word)")
    }
}

func say(_ word: String = "") -> Sayer {
    return Sayer(phrase: word)
}


// Write your meaningfulLineCount function here
func meaningfulLineCount(_ filename: String) async -> Result<Int, NoSuchFileError> {
    guard let contents = try? String(contentsOfFile: filename) else {
        return .failure(NoSuchFileError())
    }
    return .success(contents.split(separator: "\n").filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty && !$0.trimmingCharacters(in: .whitespaces).starts(with: "#") }.count)
}

// Write your Quaternion struct here
struct Quaternion: Equatable, CustomStringConvertible {
    let a, b, c, d: Double

    init(a: Double = 0, b: Double = 0, c: Double = 0, d: Double = 0) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }

    static let ZERO = Quaternion()
    static let I = Quaternion(b: 1)
    static let J = Quaternion(c: 1)
    static let K = Quaternion(d: 1)


    static func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(a: lhs.a + rhs.a, b: lhs.b + rhs.b, c: lhs.c + rhs.c, d: lhs.d + rhs.d)
    }

    static func * (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(
            a: lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d,
            b: lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c,
            c: lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b,
            d: lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        )
    }

    var conjugate: Quaternion {
        return Quaternion(a: a, b: -b, c: -c, d: -d)
    }

    var coefficients: [Double] {
        return [a, b, c, d]
    }

    var description: String {
        var string = ""
        let coefficients = [a,b,c,d]
        let elements = ["","i","j","k"]
        for i in 0..<4{
            let coefficient = coefficients[i]
            let element = elements[i]
            if coefficient == 0{
                continue
            }
            if !string.isEmpty && coefficient > 0{
                string += "+"
            }
            if abs(coefficient) == 1 && i>0{
                string += coefficient < 0 ? "-" : ""
                string += element
            }
            else{
                string += "\(coefficient)\(element)"
            }
        }
        return string.isEmpty ? "0" : string
    }


    static func == (lhs: Quaternion, rhs: Quaternion) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b && lhs.c == rhs.c && lhs.d == rhs.d
    }
}


// Write your Binary Search Tree enum here
enum BinarySearchTree: CustomStringConvertible{
    case empty
    indirect case node(String, BinarySearchTree, BinarySearchTree)

    var size: Int{
        switch self {
            case .empty: return 0
            case let .node(_, left, right):
                return 1 + left.size + right.size
        }
    }
    func insert(_ value: String) -> BinarySearchTree{
        switch self{
            case .empty:
                return .node(value, .empty, .empty)
            case let .node(nodeValue, left, right):
                if value < nodeValue{
                    return .node(nodeValue, left.insert(value), right)
                }
                else if value > nodeValue{
                    return .node(nodeValue, left, right.insert(value))
                }
                else{
                    return self
                }
        }
    }
    func contains(_ value: String) -> Bool{
        switch self{
            case.empty: return false
            case let .node(nodeValue, left, right):
                if value == nodeValue{
                    return true
                }
                else if value < nodeValue{
                    return left.contains(value)
                }
                else{
                    return right.contains(value)
                }
        }
    }

    var description: String{
        switch self{
            case .empty: return ""
            case let .node(value, left, right):
                return "(\(left)\(value)\(right))"
        }
    }
}
