# The Pair struct is used to hold 64 bit integers together as a key-value pair.
mutable struct Pair
    key   :: Int64
    value :: Int64
end


# The Collatz struct computes the Collatz sequence for a range of integers and stores the sequences
# along with their respective lengths. It sorts and prints these sequences based on their lengths
# and the integers involved.
mutable struct Collatz
    num1  :: Int64
    num2  :: Int64
    arr  :: Vector{Pair}
end


# Initializes all the instance variables for the Collatz Sequence.
function initCollatz(n1::Int64, n2::Int64)
    arr = [Pair(-1, -1) for _ in 1:10]
    return Collatz(n1, n2, arr)
end


# Generates the Collatz Sequence for each integer in the range from num1 to num2 (inclusive)
# and adds a key-value pair of the integer and its total step count if applicable to an array of size 10.
function run(self::Collatz)
    for i in self.num1 : self.num2
        count = getSequenceCount(i)
        updateSequence(self, i, count)
    end

    printSequence(self, "Sorted based on sequence length")

    sort!(self.arr, by = x -> x.key, rev = true)

    printSequence(self, "Sorted based on integer size")
end


# Calculates an integer's collatz sequence steps.
function getSequenceCount(i::Int64)::Int64
    count = 0

    while i != 1
        if i % 2 == 0
            i ÷= 2
        else
            i = 3 * i + 1
        end
        count += 1
    end

    return count
end


# Updates the array with the longest sequences found.
function updateSequence(self::Collatz, i::Int64, count::Int64)
    if count < self.arr[10].value
        return
    end

    for j in 1:9
        if count > self.arr[j].value
            for k in 10:-1:j+1
                self.arr[k] = self.arr[k-1]
            end
            self.arr[j] = Pair(i, count)
            return

        elseif count == self.arr[j].value
            if i < self.arr[j].key
                self.arr[j].key = i
            end
            return
        end
    end
end


# Prints the top 10 integers in the range.
function printSequence(self::Collatz, message::String)
    println(message)
    for pair in self.arr
        if pair.key != -1
            println("         $(pair.key)         $(pair.value)")
        end
    end
    println()
end


# Main Method Calls
str1 = length(ARGS) > 0 ? ARGS[1] : ""
str2 = length(ARGS) > 1 ? ARGS[2] : ""

n1 = tryparse(Int64, str1, base = 10)
n2 = tryparse(Int64, str2, base = 10)

game = initCollatz(n1, n2)
run(game)