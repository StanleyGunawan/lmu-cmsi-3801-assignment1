import { FileHandle, open } from "node:fs/promises"

export function change(amount: bigint): Map<bigint, bigint> {
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let counts: Map<bigint, bigint> = new Map()
  let remaining = amount
  for (const denomination of [25n, 10n, 5n, 1n]) {
    counts.set(denomination, remaining / denomination)
    remaining %= denomination
  }
  return counts
}

export function firstThenApply<T, U>(items: T[], predicate: (item: T) => boolean, transformer: (item: T) => U): U | undefined {
  for (const item of items) {
    if (predicate(item)) {
      return transformer(item)
    }
  }
}

export function* powersGenerator(base: bigint): Generator<bigint> {
  let exponent: bigint = 0n
  while (true) {
    yield base ** exponent
    exponent++
  }
}

export async function meaningfulLineCount(path: string): Promise<number> {
  let count: number = 0
  const file: FileHandle = await open(path, 'r')
  if (file === undefined) {
    throw new Error(`File ${path} cannot be found.`)
  }
  for await (const line of file.readLines()) {
    if ((line !== "") && (line.trim() !== "") && (line.trim()[0] !== "#")) {
      count++
    }
  }
  file.close()
  return count
}

export type Shape = sphere | box
interface box {
  readonly kind: "Box"
  readonly width: number
  readonly length: number
  readonly depth: number
}

interface sphere {
  readonly kind: "Sphere"
  readonly radius: number
}

export function surfaceArea(shape: Shape): number {
  switch (shape.kind) {
    case "Box":
      return 2 * (shape.width * shape.length + shape.width * shape.depth + shape.length * shape.depth)
    case "Sphere":
      return 4 * Math.PI * shape.radius * shape.radius
  }
}

export function volume(shape: Shape): number {
  switch (shape.kind) {
    case "Box":
      return shape.width * shape.length * shape.depth
    case "Sphere":
      return 4 / 3 * Math.PI * shape.radius ** 3
  }
}

export function toString(shape: Shape): string {
  return '$(shape.kind)'
}

export function equals(shape1: Shape, shape2: Shape): boolean {
  if (shape1.kind === "Box" && shape2.kind === "Box") {
    return (
      shape1.width === shape2.width &&
      shape1.length === shape2.length &&
      shape1.depth === shape2.depth)
  }
  if (shape1.kind === "Sphere" && shape2.kind === "Sphere") {
    return shape1.radius === shape2.radius
  }
  return false
}

export interface BinarySearchTree<T> {
  size(): number
  contains(item: T): boolean
  insert(item: T): BinarySearchTree<T>
  inorder(): Generator<T>
}

class Node<T> implements BinarySearchTree<T> {
  private item: T
  private left: BinarySearchTree<T>
  private right: BinarySearchTree<T>

  public constructor(item: T, left: BinarySearchTree<T>, right: BinarySearchTree<T>) {
    this.item = item
    this.left = left
    this.right = right
  }

  public size(): number {
    return this.left.size() + 1 + this.right.size()
  }

  public contains(target: T): boolean {
    if (target === this.item) {
      return true
    }
    else if (target < this.item) {
      return this.left.contains(target)
    }
    else if (target > this.item) {
      return this.right.contains(target)
    }
    return false
  }

  public insert(item: T): BinarySearchTree<T> {
    if (item < this.item) {
      return new Node(this.item, this.left.insert(item), this.right);
    } else if (item > this.item) {
      return new Node(this.item, this.left, this.right.insert(item));
    } else {
      return this;
    }
  }

  public *inorder(): Generator<T> {
    yield* this.left.inorder()
    yield this.item
    yield* this.right.inorder()
  }

  public toString(): string {
    return `(${this.left.toString().replace("()", "")}${this.item}${this.right.toString().replace("()", "")})`;
  }
}

export class Empty<T> implements BinarySearchTree<T> {
  public size(): number {
    return 0
  }
  public contains(_: T): boolean {
    return false
  }
  public insert(item: T): BinarySearchTree<T> {
    return new Node(item, new Empty(), new Empty())
  }
  public *inorder(): Generator<T> { }
  public toString(): string {
    return "()"
  }
}