
.data

array: .word 1, 0, 1, 12, 0, 1, 4

.text

    la a0, array
    li a1, 7    # unsigned
    li a2, 1

# Since we are always looking for the last found element 
# in the array (in case of duplicates), it is better to start
# from the last element.
prog:

# Initial check for array lenght and loads the first address
# before starting the loop
find_last_backwards_with_pointers:
    beq  a1, zero, not_found # if array has no elements return not_found
    slli s0, a1, 2  		 # offset of 1 word past the end of the array (7 ^ 2 = 49)
    add  s0, s0, a0 		 # full address of the above

# Handles the loop logic
loop:
    addi s0, s0, -4   # moving the address to the previous word (s0--)
    lw   t1, 0(s0)	  # loads the value of the current word to t1
    beq  t1, a2, done # if t1 is equal to the element we are looking for (a2), end the program
    bne  s0, a0, loop # while the current address is different than the address of the first 
					  # element of the array, continue the loop

# Handle the case the element we are looking for was not found.
not_found:
    add  s0, zero, zero  # returns zero address

done:
    addi a7, zero, 10 
    ecall
