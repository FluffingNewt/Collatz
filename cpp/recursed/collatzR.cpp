#include "collatzR.h"

// Recursively generates the Collatz Sequence for each integer in the range from num1 to num2 (inclusive)
// and adds a key-value pair of the integer and its total step count if applicable to an array of size 10.
void Collatz::run() {
    std::fill(std::begin(arr), std::end(arr), std::make_pair(-1, -1));

    for (long long i = num1; i <= num2; i++) {
        long long count = getSequenceCount(i, 0);
        updateSequence(i, count);
    }

    printSequence("Sorted based on sequence length");

    std::sort(std::begin(arr), std::end(arr), [](const auto& a, const auto& b) {
        return a.first > b.first;});

    printSequence("Sorted based on integer size");
}


// Calculates an integer's collatz sequence steps (recursively).
long long Collatz::getSequenceCount(long long curr, long long count) {
    if      (curr == 1)      { return count; }
    else if (curr % 2  == 0) { return getSequenceCount(curr / 2, count + 1); }

    return getSequenceCount(curr * 3 + 1, count + 1);
}


// Updates the array with the longest sequences found.
void Collatz::updateSequence(long long i, long long count) {
    if (count < arr[9].second) return;

    for (long long j = 0; j < 9; j++) {
        if (count > arr[j].second) {
            for (long long k = 9; k > j; k--) {
                arr[k] = arr[k - 1];
            }
            arr[j] = std::make_pair(i, count);
            return;

        } else if (count == arr[j].second) {
            if (i < arr[j].first) arr[j].first = i;
            return;
        }
    }
}


// Prints the top 10 integers in the range.
void Collatz::printSequence(const std::string& message) {
    std::cout << message << std::endl;
    for (const auto& pair : arr) {
        if (pair.first != -1) {
            std::cout << "         " << pair.first
                      << "         " << pair.second << std::endl;
        }
    }
    std::cout << std::endl;
}


// Main Method Calls
int main(int argc, char *argv[]) {
    long long num1 = (argc > 1) ? std::stoi(argv[1]) : 0;
    long long num2 = (argc > 2) ? std::stoi(argv[2]) : 0;

    Collatz game(num1, num2);
    game.run();

    return 0;
}