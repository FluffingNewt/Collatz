#!/usr/bin/sbcl --script

; The Pair struct is used to hold 64 bit integers together as a key-value pair.
(defstruct Pair
  key
  value
)


; The Collatz class computes the Collatz sequence for a range of integers and stores the sequences
; along with their respective lengths. It sorts and prints these sequences based on their lengths
; and the integers involved.
; *** Recursive ***
(defclass Collatz () 
    ((num1 :initarg :num1 :accessor num1)
     (num2 :initarg :num2 :accessor num2)
     (arr  :initarg :arr  :accessor arr))
)


; Initializes all the instance variables for the Collatz Sequence.
(defmethod initialize-instance :after ((c Collatz) &key)
  (let ((a (make-array 10 :element-type 'Pair :initial-element (make-Pair :key -1 :value -1)))
        (n1 (if (> (length sb-ext:*posix-argv*) 1) (parse-integer (elt sb-ext:*posix-argv* 1)) 0))
        (n2 (if (> (length sb-ext:*posix-argv*) 2) (parse-integer (elt sb-ext:*posix-argv* 2)) 0)))

        (setf (slot-value c 'num1) n1)
        (setf (slot-value c 'num2) n2)
        (setf (slot-value c 'arr)   a))
)


; Recursively generates the Collatz Sequence for each integer in the range from num1 to num2 (inclusive)
; and adds a key-value pair of the integer and its total step count if applicable to an array of size 10.
(defmethod run ((c Collatz))
    (loop for i from (num1 c) to (num2 c) do
        (let ((steps (getSequenceCount i 0)))
            (updateSequence c i steps)))
    
    (printSequence c "Sorted based on sequence length")

    (loop for j from 0 to 8 do
        (loop for i from 0 to 8 do
            (if (< (pair-key (elt (arr c) i)) (pair-key (elt (arr c) (1+ i))))
                    (rotatef (elt (arr c) i) (elt (arr c) (1+ i)))
            )
        )
    )

    (printSequence c "Sorted based on integer size")
)


; Calculates an integer's collatz sequence steps (recursively).
(defmethod getSequenceCount ((i integer) (steps integer))
  (cond ((= i 1) steps)
        ((evenp i) (getSequenceCount (/ i 2) (1+ steps)))
        (t (getSequenceCount (+ (* 3 i) 1) (1+ steps))))
)


; Updates the array with the longest sequences found.
(defmethod updateSequence ((c Collatz) (i integer) (steps integer))
    (if (< steps (pair-value (elt (arr c) 9))) (return-from updateSequence))

    (loop for j from 0 to 9 do

        (if (> steps (pair-value (elt (arr c) j)))

            (progn
                (loop for k from 9 downto (1+ j) do
                    (setf (elt (arr c) k) (elt (arr c) (- k 1))))

                (setf (elt (arr c) j) (make-Pair :key i :value steps))
                (return-from updateSequence))


            (if (= steps (pair-value (elt (arr c) j)))

                (if (< i (pair-key (elt (arr c) j)))

                    (setf (pair-key (elt (arr c) j)) i)

                    (return-from updateSequence)))
        )
    )
)


; Prints the top 10 integers in the range.
(defmethod printSequence ((c Collatz) (message string))
    (format t "~a~%" message)
    (dotimes (i (length (arr c)))
        (let ((pair (elt (arr c) i)))
            (when (not (= (pair-key pair) -1))
                (format t "         ~a         ~a~%" (pair-key pair) (pair-value pair)))))
    (format t "~%")
)


; Main Method Calls
(defvar game (make-instance 'Collatz))
(run game)