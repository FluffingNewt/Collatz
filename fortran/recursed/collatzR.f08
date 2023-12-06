! The Collatz class computes the Collatz sequence for a range of integers and stores the sequences
! along with their respective lengths. It sorts and prints these sequences based on their lengths
! and the integers involved.
! *** Recursive ***
module class_Collatz

    implicit none
    private
    public :: Collatz, init_Collatz, run

    type Pair
        integer(kind=8) :: key = -1
        integer(kind=8) :: value = -1
    end type Pair

    type Collatz
        type(Pair), dimension(10) :: arr
        integer(kind=8) :: num1, num2

        contains

        procedure :: init_Collatz
        procedure :: run
        procedure :: getSequenceCount
        procedure :: printSequence
        procedure :: updateSequence
        
    end type Collatz

contains

    ! initializes all the instance variables for the Collatz Sequence.
    subroutine init_Collatz(this, n1, n2)
        class(Collatz) :: this
        integer(kind=8) :: n1, n2

        this%num1 = n1
        this%num2 = n2
    end subroutine init_Collatz
        

    ! Recursively generates the Collatz Sequence for each integer in the range from num1 to num2 (inclusive)
    ! and adds a key-value pair of the integer and its total step count if applicable to an array of size 10.
    subroutine run(this)
        class(Collatz) :: this
        integer(kind=8) :: i, j, count
        type(Pair) :: temp

        do i = this%num1, this%num2
            count = 0
            count = this%getSequenceCount(i, count)
            call this%updateSequence(i, count)
        end do

        call this%printSequence("Sorted based on sequence length")

        do i = 1, size(this%arr) - 1
            do j = i + 1, size(this%arr)
                if (this%arr(i)%key < this%arr(j)%key) then
                    temp = this%arr(i)
                    this%arr(i) = this%arr(j)
                    this%arr(j) = temp
                end if
            end do
        end do

        call this%printSequence("Sorted based on integer size")

    end subroutine run


    ! Calculates an integer's collatz sequence steps (recursively).
    recursive function getSequenceCount(this, curr, count) result(ret)
        class(Collatz) :: this
        integer(kind=8) :: curr, count, ret

        if (curr == 1) then
            ret = count
            return
        else if (mod(curr, 2) == 0) then
            ret = getSequenceCount(this, curr / 2, count + 1)
            return
        end if

        ret = getSequenceCount(this, curr * 3 + 1, count + 1)
    end function getSequenceCount


    ! Updates the array with the longest sequences found.
    subroutine updateSequence(this, i, count)
        class(Collatz) :: this
        integer(kind=8) :: i, j, k, count

        if (count < this%arr(10)%value) return

        do j = 1, 9
            if (count > this%arr(j)%value) then
                do k = 10, j + 1, -1
                    this%arr(k)%key = this%arr(k - 1)%key
                    this%arr(k)%value = this%arr(k - 1)%value
                end do
                this%arr(j)%key = i
                this%arr(j)%value = count
                return
            else if (count == this%arr(j)%value) then
                if (i < this%arr(j)%key) then
                    this%arr(j)%key = i
                end if
                return
            end if
        end do
    end subroutine updateSequence


    ! Prints the top 10 integers in the range.
    subroutine printSequence(this, message)
        class(Collatz) :: this
        character(len=*) :: message
        integer(kind=8) :: i
        
        print *, message
        
        do i = 1, 10
            if (this%arr(i)%key /= -1) then
                print *, ' ', this%arr(i)%key, ' ', this%arr(i)%value
            end if
        end do
        
        print *, char(1)
    end subroutine printSequence

end module class_Collatz


! Main method calls
program MainProgram
    use class_Collatz
    implicit none
    type(Collatz) :: game
    character(len=10) :: str
    integer(kind=8) :: n1, n2
    integer :: ioStatus

    call get_command_argument(1, str, status=ioStatus)
    read(str, *, IOSTAT=ioStatus) n1
    call get_command_argument(2, str, status=ioStatus)
    read(str, *, IOSTAT=ioStatus) n2

    call game%init_collatz(n1, n2)
    call game%run()

end program MainProgram
