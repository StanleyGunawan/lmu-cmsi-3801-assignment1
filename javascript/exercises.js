import { open } from "node:fs/promises"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then lower case function here
export function firstThenLowerCase(arr, predicate) {
  const element = arr.find(predicate);
  return element?.toLowerCase();
}

// Write your powers generator here
export function* powersGenerator({ ofBase, upTo }) {
  let value = 1
  console.log(ofBase)
  console.log(upTo)
  while (value <= upTo) {
    yield value
    value *= ofBase
  }
}

// Write your say function here
export function say(word = null, words = []) {
  if (word !== null) {
    words.push(word);
    return function (a = null) {
      return say(a, words);
    };
  } else {
    return words.join(' ');
  }
}

// Write your line count function here

export async function* meaningfulLineCount(fileName){
  try {
    let lineNumber = 0
    const file = await open(fileName, "r")
    for await (const line of file.readLines()) {
      strippedLine = line.strip()
      if (strippedLine && strippedLine[0] !== '#') {
        lineNumber ++
      }
    }
    file.close()
    return lineNumber
  }
  catch (error) {
    throw new Error('File does not exist');
  }
}


// Write your Quaternion class here
export class Quaternion {
  constructor(a, b, c, d) {
      this.a = a;
      this.b = b;
      this.c = c;
      this.d = d;
      Object.freeze(this)
  }

  plus(other) {
      return new Quaternion(
          this.a + other.a,
          this.b + other.b,
          this.c + other.c,
          this.d + other.d
      );
  }

  times(other) {
      return new Quaternion(
          this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
          this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
          this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
          this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
      );
  }

  get coefficients() {
    return [this.a, this.b, this.c, this.d];
  }

  get conjugate() {
    return new Quaternion(this.a, -this.b, -this.c, -this.d);
  }

  equals(other) {
    return this.a === other.a && this.b === other.b && this.c === other.c && this.d === other.d;
  }

  toString() {
    let components, string
    function formatComponent(value, component){
      let sign, abs_val
      if (value == 0){
        return ""
      }
      if(value > 0){ sign = "+"}
      else{ sign = "-"}
      abs_val = Math.abs(value)
      if (component == 'w'){
        return `${value}`
      }
      else if (abs_val == 1){
        return `${sign}${component}`
      }
      else {
        return `${sign}${abs_val}${component}`
      }
    }
    
    components = [  
        formatComponent(this.a, 'w'),
        formatComponent(this.b, 'i'),
        formatComponent(this.c, 'j'),
        formatComponent(this.d, 'k')
    ]
    string = components.join('').replace(/(\+\-)/g, '-');

    if (string.charAt(0) == ('+')){
      string = string.substring(1)
    }
    else if (string == ""){
      string = '0'
    }
    return string
  }
}
