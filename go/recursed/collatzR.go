package main
import (
	"fmt"
	"strconv"
	"os"
	"sort"
)


// The Pair struct is used to hold 64 bit integers together as a key-value pair.
type Pair struct {
    key   int64
    value int64
}


// The Collatz class computes the Collatz sequence for a range of integers and stores the sequences
// along with their respective lengths. It sorts and prints these sequences based on their lengths
// and the integers involved.
// *** Recursive ***
type Collatz struct {
	num1 int64
    num2 int64
    arr []Pair
}


// Initializes all the instance variables for the Collatz Sequence.
func initCollatz(n1 int64, n2 int64) *Collatz {
	var newArray = make([]Pair, 10)
	for i := range newArray { newArray[i] = Pair{-1, -1} }

	return &Collatz {
		num1            : n1,
		num2            : n2,
		arr             : newArray,
	}
}


// Recursively generates the Collatz Sequence for each integer in the range from num1 to num2 (inclusive)
// and adds a key-value pair of the integer and its total step count if applicable to an array of size 10.
func (c *Collatz) run() {
	for i := c.num1; i <= c.num2; i++ {
		count := getSequenceCount(i, 0)
		c.updateSequence(i, count)
	}

	c.printSequence("Sorted based on sequence length")

	sort.Slice(c.arr[:], func(i, j int) bool {
		return c.arr[i].key > c.arr[j].key
	})

	c.printSequence("Sorted based on integer size")
}


// Calculates an integer's collatz sequence steps (recursively).
func getSequenceCount(i, count int64) int64 {
	if i == 1 { return count
    } else if i % 2 == 0 {  return getSequenceCount(i / 2, count + 1) }
    return getSequenceCount(i * 3 + 1, count + 1)
}


// Updates the array with the longest sequences found.
func (c *Collatz) updateSequence(i int64, count int64) {
	if count < c.arr[9].value { return }

	for j := 0; j < 9; j++ {
		if count > c.arr[j].value {
			for k := 9; k > j; k-- {
				c.arr[k] = c.arr[k-1]
			}
			c.arr[j].key = i
			c.arr[j].value = count
			return

		} else if count == c.arr[j].value {
			if i < c.arr[j].key { c.arr[j].key = i }
			return
		}
	}
}


// Prints the top 10 integers in the range.
func (c *Collatz) printSequence(message string) {
	fmt.Println(message)
	for _, pair := range c.arr {
		if pair.key != -1 {
			fmt.Printf("         %d         %d\n", pair.key, pair.value)
		}
	}
	fmt.Println()
}


// Main Method Calls
func main() {
	str1 := "" ; if (len(os.Args) > 1) { str1 = os.Args[1] }
	str2 := "" ; if (len(os.Args) > 2) { str2 = os.Args[2] }


	n1, err1 := strconv.ParseInt(str1, 10, 32)
	n2, err2 := strconv.ParseInt(str2, 10, 32)
	if err1 != nil {
        fmt.Println("Error:", err1)
        return
    }
	if err2 != nil {
        fmt.Println("Error:", err2)
        return
    }

	c := initCollatz(n1, n2)
	c.run()
}