.globl initialiser

main:
  jal initialiser   # initialiser()
  li $v0, 10        # $v0 = 10
  syscall           # halt

# $s0 = adresse de base, $s1 = n, $s2 = i
initialiser:
  lui $s0, 0x1004   # $s0 = 0x10040000
  li $v0, 5         # $v0 = 5
  syscall           # stdin
  move $s1, $v0     # $s1 = $v0

loop:
  slt $t0, $s2, $s1 # i < n ?
  beqz $t0, done    # if false then done
  sll $t0, $s2, 2   # $t0 = i * 4
  add $t0, $t0, $s0 # $t0 = &array[i]
  li $v0, 5         # $v0 = 5
  syscall           # stdin
  move $t1, $v0     # $t1 = $v0
  sw $t1, ($t0)     # array[i] = $t1
  addi $s2, $s2, 1  # i += 1
  j loop

done: jr $ra        # return
