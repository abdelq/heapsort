.data
msg: .asciiz "n : "
newline: .asciiz "\n"

.text
main:
  la $a0, msg       # $a0 = &msg
  li $v0, 4         # $v0 = 4
  syscall           # print string
  li $v0, 5         # $v0 = 5
  syscall           # read integer
  move $a0, $v0     # n = $v0
  jal suite         # suite(n)
  li $v0, 10        # $v0 = 10
  syscall           # exit

suite:
  subi $sp, $sp, 8  # alloc
  sw $a0, 4($sp)    # store n
  sw $ra, 0($sp)    # store $ra
  bnez $a0, else    # if (n != 0) else()  
  li $a0, 1         # $a0 = 1
  li $v0, 1         # $v0 = 1
  syscall           # print integer
  addi $sp, $sp, 8  # free
  jr $ra            # return
else:
  subi $a0, $a0, 1  # n -= 1
  jal suite         # suite(n)
  lw $ra, 0($sp)    # load $ra
  lw $a0, 4($sp)    # load n
  addi $sp, $sp, 8  # free
  sll $t0, $a0, 1   # $t0 = n * 2
  add $t0, $v0, $t0 # $t0 = suite(n - 1) + $t0
  rem $t0, $t0, 7   # $t0 %= 7
  move $a0, $t0     # $a0 = $t0
  li $v0, 1         # $v0 = 1
  syscall           # print integer
  la $a0, newline   # $a0 = &newline
  li $v0, 4         # $v0 = 4
  syscall           # print string
  move $v0, $t0     # $v0 = $t0
  jr $ra            # return
