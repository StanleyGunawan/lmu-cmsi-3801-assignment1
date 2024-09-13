from exercises import Quaternion

q = Quaternion(3.5, 2.25, -100.0, -1.25)
# print(q.coefficients)

q1 = Quaternion(1.0, 3.0, 5.0, 2.0)
q2 = Quaternion(-2.0, 2.0, 8.0, -1.0)
q3 = Quaternion(-1.0, 5.0, 13.0, 1.0)
q4 = Quaternion(-46.0, -25.0, 5.0, 9.0)

zero = Quaternion(0, 0, 0, 0)
i = Quaternion(0, 1, 0, 0)
j = Quaternion(0, 0, 1, 0)
k = Quaternion(0, 0, 0, 1)
l = j + k

print(q2.coefficients)