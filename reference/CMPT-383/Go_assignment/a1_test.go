package main
import "testing"

//simple stackslice test code
func TestPart1(t *testing.T){
	t.Log("StackSlice testing..")
	s := makeStackSlice()
	isEmpty := s.isEmpty()
	if isEmpty != true {
		t.Errorf("Expected result is true, but false is returned..")
	}
	t.Log("Three ints, 33, 6, 9, 12 will be push to the stack..")
	s.push(33)
	s.push(6)
	s.push(9)
	s.push(12)
	peek, _ := s.peek()
	if peek != 12 && s.size() == 4 {
		t.Errorf("Peek() should return 12 and the size of the stack is 4")
	}
	s.pop()
	t.Log(s)
	peek, _ = s.peek()
	if peek != 9 && s.size() == 3{
		t.Errorf("Peek() should return 9 and the size of the stack is now 3")
	}
	t.Log("popAll is called..")
	popAll(s)
	peek, _ = s.peek()
	if peek != 0 && s.size() == 0{
		t.Errorf("Peek() should return 0 and the size of the stack is now 0")
	}
}
// simple stacklinked test code
func TestPart2(t *testing.T){
	t.Log("StackLinked testing..")
	s := makeStackLinked()
	isEmpty := s.isEmpty()
	if isEmpty != true {
		t.Errorf("Expected result is true, but false is returned..")
	}
	t.Log("Three ints, 33, 6, 9, 12 will be push to the stack..")
	s.push(33)
	s.push(6)
	s.push(9)
	s.push(12)
	peek, _ := s.peek()
	if peek != 12 && s.size() == 4 {
		t.Errorf("Peek() should return 12 and the size of the stack is 4")
	}
	s.pop()
	t.Log(s)
	peek, _ = s.peek()
	if peek != 9 && s.size() == 3{
		t.Errorf("Peek() should return 9 and the size of the stack is now 3")
	}
	t.Log("popAll is called..")
	popAll(s)
	peek, _ = s.peek()
	if peek != 0 && s.size() == 0{
		t.Errorf("Peek() should return 0 and the size of the stack is now 0")
	}
}
// copy(), stackEquals() tests..
func TestPart3(t *testing.T){
	t.Log("stackEquals test..")
	t.Log("using copy() to create two identical stack that use slice")
	t.Log("s1 : 15, 12, 9, 6, 1")
	t.Log("s1_copy : 15, 12, 9, 6, 1")
	s1 := makeStackSlice()
	s1.push(1)
	s1.push(6)
	s1.push(9)
	s1.push(12)
	s1.push(15)
	t.Log(s1)
	s1_copy := s1.copy()
	if stackEquals(s1, s1_copy) != true {
		t.Errorf("stackEquals must return true, Something is wrong..")
	}
	t.Log("Now, s2 is a different stack that uses linked list")
	t.Log("s2 : 15, 12, 9, 6, 2")
	s2 := makeStackLinked()
	s2.push(2)
	s2.push(6)
	s2.push(9)
	s2.push(12)
	s2.push(15)
	t.Log(s2)
	if stackEquals(s1, s2) != false {
		t.Errorf("stackEquals must return false this time since s1 =/= s2, Something is wrong..")
	}
}
