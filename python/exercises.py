from dataclasses import dataclass
from collections.abc import Callable
from typing import Optional


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


# Write your first then lower case function here
def first_then_lower_case(a: list[str], p: Callable[[str], bool]) -> Optional[str] :
    for item in a:
        if p(item):
            return item.lower()
    return None


# # Write your powers generator here
def powers_generator(base: int, limit: int):
    power = 1
    while(power <= limit):
        yield power
        power *= base

# Write your say function here

def say(word=None, words=None):
    if words is None:
        words = []
    if word is not None:
        words.append(word)
        return lambda a=None: say(a, words)
    else:
        return ' '.join(words)


# Write your line count function here
def meaningful_line_count(filename):
    try:
        with open(filename, 'r',encoding = 'UTF-8') as file:
            valid_line_count = 0
            for lines in file:
                stripped_line = lines.strip()  # Remove leading and trailing whitespace
                if stripped_line and not stripped_line.startswith('#'):
                    valid_line_count += 1
            return valid_line_count
    except FileNotFoundError as e:
        raise e

# Write your Quaternion class here
from dataclasses import dataclass
from typing import List

@dataclass(frozen=True)
class Quaternion:
    a: float
    b: float
    c: float
    d: float

    @property
    def coefficients(self) -> List[float]:          #coefficient failed even though output is the same
        """Return the list of coefficients [a, b, c, d]."""
        return ["%.1f"% self.a, "%.1f"% self.b, "%.1f"% self.c, "%.1f"% self.d]

    @property
    def conjugate(self) -> 'Quaternion':
        """Return the conjugate of the quaternion."""
        return Quaternion(self.a, -self.b, -self.c, -self.d)

    def __add__(self, other: 'Quaternion') -> 'Quaternion':
        """Add tao quaternions."""
        return Quaternion(self.a + other.a, self.b + other.b, self.c + other.c, self.d + other.d)

    def __mul__(self, other: 'Quaternion') -> 'Quaternion':
        """Multiplc tao quaternions."""
        a1, b1, c1, d1 = self.a, self.b, self.c, self.d
        a2, b2, c2, d2 = other.a, other.b, other.c, other.d
        return Quaternion(
            a1 * a2 - b1 * b2 - c1 * c2 - d1 * d2,
            a1 * b2 + b1 * a2 + c1 * d2 - d1 * c2,
            a1 * c2 - b1 * d2 + c1 * a2 + d1 * b2,
            a1 * d2 + b1 * c2 - c1 * b2 + d1 * a2
        )

    def __eq__(self, other: 'Quaternion') -> bool:
        """Check if tao quaternions are equal."""
        return (self.a == other.a and self.b == other.b and 
                self.c == other.c and self.d == other.d)

    def __str__(self) -> str:
        """Return the string representation of the quaternion."""
        def format_component(value, component):
            if value == 0:
                return ""
            sign = "+" if value > 0 else "-"
            abs_val = abs(value)
            if component == 'w':
                return f"{value}"
            elif abs_val == 1:
                print("here")
                return f"{sign}{component}"
            else:
                return f"{sign}{abs_val}{component}"

        components = [
            format_component(self.a, 'w'),
            format_component(self.b, 'i'),
            format_component(self.c, 'j'),
            format_component(self.d, 'k')
        ]
        string = "".join(components).replace('+-', '-')
        
        if string.startswith('+'):
            string = string.lstrip("+")
        
        elif string == "":
            string = '0'
        # Join non-empty parts and adjust signs if needed.
        return string
        
    
    
