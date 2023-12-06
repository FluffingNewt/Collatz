# Project 3 - The Collatz Conjecture

## Description
The Collatz Conjecture, also known as the 3x+1 problem or Collatz Problem, is a famous unsolved mathematical conjecture proposed by German mathematician Lothar Collatz in 1937. It revolves around a simple sequence generation rule applied to positive integers. According to the conjecture:

  1. Begin with any positive integer     
  2. If n is even, divide by 2 (n / 2)     
  3. If n is odd, multiply it by 3 and add 1 (3n+1)     
  4. Repeat the process with the obtained number, continuing until reaching the value 1     

The Collatz Conjecture states that, regardless of the initial value chosen for n, the sequence will always eventually reach the value 1, creating a loop of 4-2-1.


## C++
### Compile and Run
To compile all the .cpp files, type the following and press enter: 

* g++ collatz.f08 {num1} {num2}
* g++ collatzR.f08 {num1} {num2}

### Run
Now to run it, type the following and press enter:

* ./a.out {num1} {num2}

## Fortran
### Compile
To compile the .f08 files, type the following and press enter: 

* gfortran collatz.f08
* gfortran collatzR.f08

### Run
Now to run it, type the following and press enter:

* ./a.out {num1} {num2}

## Go
### Compile and Run
To compile and run the .go files, type the following and press enter: 

* go run collatz.go {num1} {num2}
* go run collatzR.go {num1} {num2}

## Julia
### Compile and Run
To compile and run the .jl files, type the following and press enter: 

* julia collatz.jl {num1} {num2}
* julia collatzR.jl {num1} {num2}

## Lisp
### Compile and Run
To compile and run all the .lisp files, type the following and press enter: 

* sbcl --script collatz.lisp {num1} {num2}
* sbcl --script collatzR.lisp {num1} {num2}

## Rust
### Compile and Run
To compile all the rust files, first cd into the "rust" directory. It is the one above the "src" directory. Now type the following and press enter:

* cargo run --bin normal {num1} {num2}
* cargo run --bin recursed {num1} {num2}

## Author
Davis Guest  
CSC 330