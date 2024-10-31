exception Negative_Amount

let change amount =
  if amount < 0 then
    raise Negative_Amount
  else
    let denominations = [25; 10; 5; 1] in
    let rec aux remaining denominations =
      match denominations with
      | [] -> []
      | d :: ds -> (remaining / d) :: aux (remaining mod d) ds
    in
    aux amount denominations

(* Write your first then apply function here *)
let first_then_apply array predicate transformer = 
  match List.find_opt predicate array with
  | None -> None
  | Some x -> transformer x;;

(* Write your powers generator here *)
let powers_generator base = 
  let rec generate_from power () =
    Seq.Cons(power, generate_from (power * base))
  in
  generate_from 1;;

(* Write your line count function here *)
let meaningful_line_count file_path =
  let count_lines ic =
    let rec count acc =
      match In_channel.input_line ic with
      | None -> acc
      | Some line ->
        let trimmed = String.trim line in
        if trimmed = "" || String.get trimmed 0 = '#' then
          count acc
        else
          count (acc + 1)
    in
    count 0
  in
  In_channel.with_open_text file_path (fun ic ->
    Fun.protect
      ~finally:(fun () -> In_channel.close ic)
      (fun () -> count_lines ic)
  )

(* Write your shape type and associated functions here *)
type shape = 
  | Sphere of float
  | Box of float * float * float
  [@@deriving eq, show]

let surface_area = function 
  | Sphere r -> 4.0 *. Float.pi *. r ** 2.0
  | Box (w,h,d) -> 2.0 *. (d *. w +. w *. h +. h *. d)

let volume = function
  | Sphere r -> (4.0 /. 3.0) *. Float.pi *. r ** 3.0
  | Box (w,h,d) -> w *. h *. d

(* Write your binary search tree implementation here *)

type 'a binary_search_tree = 
  | Empty
  | Node of 'a binary_search_tree * 'a * 'a binary_search_tree

  let empty = Empty

  let rec insert target = function
    | Empty -> Node (Empty, target, Empty)
    | Node (left, item, right) as node ->
      if target < item then 
        Node (insert target left, item, right)
      else if target > item then 
        Node (left, item, insert target right)
      else node

  let rec contains target = function
    | Empty -> false
    | Node (left, item, right) ->
      if target < item then 
        contains target left
      else if target > item then 
        contains target right
      else true

  let rec size = function
    | Empty -> 0
    | Node (left, _, right) -> 1 + size left + size right

  let rec inorder = function
    | Empty -> []
    | Node (left, item, right) -> inorder left @ [item] @ inorder right
