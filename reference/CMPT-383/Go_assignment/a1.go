package main
import "fmt"

type Stacker interface {
    // Pre-condition:
    //    none
    // Post-condition:
    //    returns true if this stack has no elements, and false otherwise
    // Performance:
    //    runs in O(1) time
    isEmpty() bool

    // Pre-condition:
    //    none
    // Post-condition:
    //    returns the number of elements in this stack
    // Performance:
    //    runs in O(1) time
    size() int

    // puts x on the top of the stack (increasing size by 1)
    // Pre-condition:
    //    none
    // Post-condition:
    //    puts a copy of x on top of the stack (and the size of the stack
    //    increases by 1)
    // Performance:
    //    runs in O(1) time most of the time; can occasionally run in O(n)
    //    time if memory re-organization is needed
	push(x int)

    // Pre-condition:
    //    none
    // Post-condition:
    //    If the stack is empty, returns 0 and a non-nil error value (with a
    //    helpful error message).
    //    If the stack is not empty, returns a copy of the top element of the
    //    stack, and a nil value for the error.
    //    In both cases, the stack has the same value after calling peek() as
    //    before.
    // Performance:
    //    runs in O(1) time
    peek() (int, error)

    // Pre-condition:
    //    none
    // Post-condition:
    //    If the stack is empty, returns 0 and a non-nil error value (with a
    //    helpful error message). The stack remains empty.
    //    If the stack is not empty, returns, and removes, the top element of
    //    the stack, and a nil value for the error. In this case, the size of
    //    the stack decreases by 1.
    // Performance:
    //    runs in O(1) time
    pop() (int, error)

    // Pre-condition:
    //    none
    // Post-condition:
    //    Returns a copy of this stack.
    // Performance:
    //    runs in O(n) time, where n is the size of the stack
    copy() Stacker
} // Stacker

// StackSlice struct
type StackSlice struct {
	elementCount int
	slice []int
}
// -----Method Set of StackSlice----- //
func (s StackSlice) isEmpty() bool{
	var empty bool = false
	if s.elementCount == 0{
		empty = true
	}
	return empty
}
func (s StackSlice) size() int{
	return s.elementCount
}
func (s *StackSlice) push(x int){
	s.elementCount = s.elementCount + 1
	s.slice =  s.slice[0 : s.elementCount]
	s.slice[s.elementCount - 1] = x
}
func (s StackSlice) peek() (int, error){
	if s.elementCount == 0 {
		return 0, fmt.Errorf("Error peek(). Stack is empty.")
	} else {
		return s.slice[s.elementCount - 1], nil
	}
}
func (s *StackSlice) pop() (int, error){
	if s.elementCount == 0 {
		return 0, fmt.Errorf("Error pop(). Stack is already empty.")
	} else {
		result := s.slice[s.elementCount - 1]
		s.elementCount = s.elementCount - 1
		s.slice = s.slice[0:s.elementCount]
		return result, nil
	}
}
func (s StackSlice) copy() Stacker{
	size := len(s.slice)
	sliceCopied := make([]int, size, size)
	for i:=0; i < size; i++{
		sliceCopied[i] = s.slice[i]
	}
	c := &StackSlice{slice: sliceCopied, elementCount: size}
	return c
}
// return a concatenated string in a form to display the stack's contents
// from top to bottom
//-----Question 3-----//
func (s StackSlice) String() string{
	var output string = "Top of the stack\n"
	for i := len(s.slice); i > 0; i--{
		output = output + fmt.Sprint(s.slice[i-1]) + "\n"
	}
	output = output + "Bottom of the stack\n"

	return fmt.Sprintf(output)
}
//-----Method set of StackSlice end-----//

// Node structure for StackLinked
type Node struct{
	next *Node
	element int
}
//-----StackLinked struct and its method set-----//
type StackLinked struct{
	head *Node
	elementCount int
}
func (s StackLinked) isEmpty() bool {
	var empty bool = false
	if s.elementCount == 0{
		empty = true
	}
	return empty
}
func (s StackLinked) size() int {
	return s.elementCount
}
func (s *StackLinked) push(x int) {
	newNode := Node{next: nil, element: x}
	if s.elementCount == 0{
		s.head = &newNode
	} else {
		newNode.next = s.head
		s.head = &newNode
	}
	s.elementCount = s.elementCount + 1
}
func (s StackLinked) peek() (int, error) {
	if s.elementCount == 0 {
		return 0, fmt.Errorf("Error peek(). Stack is empty.")
	} else {
		return s.head.element, nil
	}

}
func (s *StackLinked) pop() (int, error) {
	if s.elementCount == 0 {
		return 0, fmt.Errorf("Error pop(). Stack is already empty.")
	} else {
		el := s.head.element
		current := s.head
		s.head = s.head.next
		current.next = nil
		s.elementCount = s.elementCount - 1
		return el, nil
	}
}
func (s StackLinked) copy() Stacker {
	copiedCount := s.elementCount
	current := s.head
	newNode := &Node{ next: nil, element: s.head.element}
	copiedHead := newNode
	for current.next != nil{
		current = current.next
		newNode.next = &Node{ next: nil, element: current.element}
		newNode = newNode.next
	}
	c := &StackLinked{head: copiedHead, elementCount: copiedCount}
	return c
}
// return a concatenated string in a form to display the stack's contents
// from top to bottom
//-----Question 3-----//
func (s StackLinked) String() string{
	var output string = "Top of the stack\n"
	current := s.head
	for current != nil{
		output = output + fmt.Sprint(current.element) + "\n"
		current = current.next
	}
	output = output + "Bottom of the stack\n"
	return fmt.Sprintf(output)
}
//-----Method set of StackLinked end-----//

//-----Question 1-----//
// returns a new empty stack using an int slice representation
func makeStackSlice() Stacker {
	s := &StackSlice{ slice: make([]int, 0, 100), elementCount: 0}
	return s
}
//-----Question 2-----//
// returns a new empty stack using a linked list representation
func makeStackLinked() Stacker {
	s := &StackLinked{ head: nil, elementCount: 0}
	return s
}
// s is assumed to be empty
//-----Question 4-----//
// implement some simple testing code
func stackerTest(s Stacker) {
	fmt.Printf("is empty?: %v\n", s.isEmpty())
	fmt.Printf("Push 99, 2, 3, 99, and 110\n\n")
	s.push(99)
	s.push(2)
	s.push(3)										// push 99, 2, 3, 99 ,110
	s.push(99)
	s.push(110)
	fmt.Println(s)									// top:110 , bottom: 99
	c := s.copy()									// c is the copy of s
	fmt.Println("\nCopied stack: ")
	fmt.Println(c)
	fmt.Printf("\nis empty?: %v\n", s.isEmpty())	// false
	el, _ := s.peek()								// peek: 110
	fmt.Printf("Peek: %v \n", el)
	fmt.Printf("Size: %v\n", s.size())				// size: 5
	popAll(s)
	fmt.Printf("\nAfter popAll()...\n")				// popAll remove all elements
	el, _ = s.peek()								// in the stack
	fmt.Printf("Peek: %v \n", el)
	fmt.Printf("Size: %v\n", s.size())
	fmt.Println(s)
}
// slice test function
func stackSliceTest() {
    s := makeStackSlice()
    stackerTest(s)
    fmt.Println("all StackSlice tests passed")
}
// linked test function
func stackLinkedTest() {
    s := makeStackLinked()
    stackerTest(s)
    fmt.Println("all StackLinked tests passed")
}
//-----Question 5-----//
// Pre-condition:
//    none
// Post-condition:
//    s.isEmpty()
func popAll(s Stacker) {
	var size int = s.size()
	for i := 0; i < size; i++{
		s.pop()
	}
	//-----error handling code-----//
	// if s.isEmpty() == true{
	// 	fmt.Println("Successfully popped all elements in the stack.")
	// } else {
	// 	fmt.Println("Error: Something Wrong")
	// 	panic("popAll error...")
	// }
}
//-----Question 6-----//
// Pre-condition:
//    none
// Post-condition:
//    returns true if s and t have the same elements in the same order;
//    both s and t have the same value after calling stackEquals as before
// Annoying constraint:
//    Use only Stackers in the body of this functions: don't use arrays,
//    slices, or any container other than a Stacker.
func stackEquals(s, t Stacker) bool {
	var isEqual bool = true
	copy_s := s.copy()				// tried not to modify the original stack
	copy_t := t.copy()				// used copied stack of each s, t
	var el_1 int
	var el_2 int
	if s.size() == t.size() {
		for i:= 0; i < s.size(); i++{
			el_1, _ = copy_s.pop()
			el_2, _ = copy_t.pop()
			if el_1 == el_2{
				continue
			}else{
				isEqual = false
				return isEqual
			}
		}
	}
	return isEqual
}

func makeAdder1() func() int {
  i := 0
  return func() int {
      i += 1 // i is defined outside of this function
      return i
  }
}

func main(){

	stackSliceTest()
	stackLinkedTest()

	// staackEquals function test
	s := makeStackSlice()
	s.push(1)
	s.push(6)
	s.push(9)
	s.push(12)
	s.push(15)
	fmt.Println(s)
	t := makeStackLinked()
	t.push(1)
	t.push(6)
	t.push(9)
	t.push(12)
	t.push(15)
	fmt.Println(t)
	isEqual := stackEquals(s,t)
	fmt.Printf("\nIs equal?   %v\n", isEqual)

  add := makeAdder1()
  fmt.Println(add())


}
