use std::env;

// The Pair struct holds 64-bit integers as a key-value pair.
#[derive(Debug, Copy, Clone)]
struct Pair {
    key   : i64,
    value : i64,
}


// The Collatz struct computes the Collatz sequence for a range of integers and stores the sequences.
struct Collatz {
    num1 : i64,
    num2 : i64,
    arr  : Vec<Pair>,
}


impl Collatz {

    // Initializes instance variables for the Collatz Sequence.
    fn init_collatz(n1: i64, n2: i64) -> Collatz {
        let new_array = vec![Pair { key: -1, value: -1 }; 10];

        Collatz {
            num1 : n1,
            num2 : n2,
            arr  : new_array,
        }
    }


    // Generates the Collatz Sequence for each integer in the range from num1 to num2 (inclusive)
    // and adds a key-value pair of the integer and its total step count if applicable to an array of size 10.
    fn run(&mut self) {
        for i in self.num1..=self.num2 {
            let count = self.get_sequence_count(i, 0);
            self.update_sequence(i, count);
        }

        self.print_sequence("Sorted based on sequence length");

        self.arr.sort_by(|a, b| b.key.cmp(&a.key));

        self.print_sequence("\nSorted based on integer size");
    }


    // Calculates an integer's Collatz sequence steps.
    fn get_sequence_count(&self, curr: i64, count: i64) -> i64 {
        if curr == 1 { count }
        else if curr % 2 == 0 { self.get_sequence_count(curr / 2, count + 1) }
        else { self.get_sequence_count(curr * 3 + 1, count + 1) }
    }


    // Updates the array with the longest sequences found.
    fn update_sequence(&mut self, i: i64, count: i64) {
        if count < self.arr[9].value { return; }

        for j in 0..9 {
            if count > self.arr[j].value {
                for k in (j + 1..=9).rev() {
                    self.arr[k] = self.arr[k - 1];
                }
                self.arr[j] = Pair { key: i, value: count };
                return;

            } else if count == self.arr[j].value {
                if i < self.arr[j].key {
                    self.arr[j].key = i;
                }
                return;
            }
        }
    }


    // Prints the top 10 integers in the range.
    fn print_sequence(&self, message: &str) {
        println!("{}", message);
        for pair in &self.arr {
            if pair.key != -1 {
                println!("         {}         {}", pair.key, pair.value);
            }
        }
        println!()
    }
}


// Main Method Calls
fn main() {
    let args: Vec<String> = env::args().collect();
    let mut str1 = String::new();
    let mut str2 = String::new();
    

    if args.len() > 1 { str1 = args[1].clone(); }
    if args.len() > 1 { str2 = args[2].clone(); }

    let n1 = str1.parse::<i64>().unwrap_or(0);
    let n2 = str2.parse::<i64>().unwrap_or(0);

    let mut c = Collatz::init_collatz(n1, n2);
    c.run();
}