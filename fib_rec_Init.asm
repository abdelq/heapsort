main: 
	add  $s0, $0, 9
     	sub  $sp, $sp, 4       	# Push 9
     	sw   $s0, ($sp)      
     	jal  fib               	# Call fib
     	add  $a0, $v0, $0	# Print return value
     	li   $v0, 1
     	syscall
     	add  $sp, $sp, 4       	# Free the parameters 
     	li   $v0, 10		# Terminate execution
     	syscall
    
fib: 
     	sub  $sp, $sp, 12      # Allocate the activation block
     	sw   $ra, 8($sp)       # Save the return address 
     	lw   $t0, 12($sp)      # Load N
     	slti $t0, $t0, 2       # n < 2
     	beq  $t0, $0, fibgt

fiblt:
     lw   $t0, 12($sp)      # return N
     j fibend

fibgt:
     lw   $t0, 12($sp)      # Load N
     sub  $t0, $t0, 1       # N-1
     sub  $sp, $sp, 4       # Push N-1
     sw   $t0, ($sp)
     jal  fib               # Call fib
     add  $sp, $sp, 4
     sw   $v0, 4($sp)       # temp1 <-- fib(n-1)

     lw   $t0, 12($sp)      # Load N
     sub  $t0, $t0, 2       # N-2
     sub  $sp, $sp, 4       # Push N-2
     sw   $t0, ($sp)      
     jal  fib               # Call fib
     add  $sp, $sp, 4
     sw   $v0, 0($sp)       # temp2 <-- fib(n-2)

     lw   $t0, 0($sp)       # Load temp2
     lw   $t1, 4($sp)       # Load temp1
     add  $t0, $t0, $t1     # return temp1 + temp2

fibend:
     add  $v0, $t0, $zero   # Move result into v0
     lw   $ra, 8($sp)       # Load the return address
     add  $sp, $sp, 12      # Free the activation block 
     jr   $ra               # Return to the caller 
