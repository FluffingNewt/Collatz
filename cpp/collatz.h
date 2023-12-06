#ifndef COLLATZ
#define COLLATZ

#include <string>
#include <iostream>
#include <algorithm>

/* 
    The Collatz class computes the Collatz sequence for a range of integers and stores the sequences
    along with their respective lengths. It sorts and prints these sequences based on their lengths
    and the integers involved.
*/
class Collatz {

private:

    long long num1;
    long long num2;
    std::pair<long long, long long> arr[10];

public:

    Collatz(long long n1, long long n2) : num1(n1), num2(n2) {}
    void run();
    long long getSequenceCount(long long i);
    void updateSequence(long long i, long long count);
    void printSequence(const std::string& message);

};

#endif
