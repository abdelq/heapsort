main:
  li $v0, 5         # $v0 = 5
  syscall           # read integer
  move $a0, $v0     # n = $v0
  jal suite         # suite(n)
  move $a0, $v0     # $a0 = $v0
  li $v0, 1         # $v0 = 1
  syscall           # print integer
  li $v0, 10        # $v0 = 10
  syscall           # exit

suite:
  subi $sp, $sp, 8  # alloc
  sw $a0, 4($sp)    # store n
  sw $ra, 0($sp)    # store $ra
  bnez $a0, else    # if (n != 0) else()
  li $v0, 1         # $v0 = 1
  addi $sp, $sp, 8  # free
  jr $ra            # return
else:
  subi $a0, $a0, 1  # n -= 1
  jal suite         # suite(n)
  lw $ra, 0($sp)    # load $ra
  lw $a0, 4($sp)    # load n
  addi $sp, $sp, 8  # free
  sll $t0, $a0, 1   # $t0 = n * 2
  add $v0, $v0, $t0 # $v0 = suite(n - 1) + $t2
  rem $v0, $v0, 7   # $v0 = $v0 % 7
  jr $ra            # return
