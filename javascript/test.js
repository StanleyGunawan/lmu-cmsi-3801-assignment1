import {
    change,
    firstThenLowerCase,
    // say,
    powersGenerator,
    meaningfulLineCount,
    Quaternion,
  } from "./exercises.js"

  const zero = new Quaternion(0, 0, 0, 0)
  const i = new Quaternion(0, 1, 0, 0)
  const j = new Quaternion(0, 0, 1, 0)
  const k = new Quaternion(0, 0, 0, 1)
  const q = new Quaternion(3.5, 2.25, -100, -1.25)
  const q1 = new Quaternion(1, 3, 5, 2)
  const q2 = new Quaternion(-2, 2, 8, -1)
  const q3 = new Quaternion(-1, 5, 13, 1)
  const q4 = new Quaternion(0, -1, 0, 2.25)
  console.log(`${q4.conjugate()}`)
  console.log(q4.conjugate())




//   deepEqual(`${zero}`, "0")
//   deepEqual(`${i}`, "i")
//   deepEqual(`${k.conjugate}`, "-k")
//   deepEqual(`${j.conjugate.times(new Quaternion(2, 0, 0, 0))}`, "-2j")
//   deepEqual(`${j.plus(k)}`, "j+k")
//   deepEqual(`${new Quaternion(0, -1, 0, 2.25)}`, "-i+2.25k")
//   deepEqual(`${new Quaternion(-20, -1.75, 13, -2.25)}`, "-20-1.75i+13j-2.25k")
//   deepEqual(`${new Quaternion(-1, -2, 0, 0)}`, "-1-2i")
//   deepEqual(`${new Quaternion(1, 0, -2, 5)}`, "1-2j+5k")