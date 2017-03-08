.globl initialiser

main:
  jal initialiser   # initialiser()
  li $v0, 10        # $v0 = 10
  syscall           # exit

# $s0 = base, $s1 = n
initialiser:
  lui $s0, 0x1004   # base = 0x10040000
  li $v0, 5         # $v0 = 5
  syscall           # read integer
  move $s1, $v0     # n = $v0
# $s2 = i
for:
  slt $t0, $s2, $s1 # $t0 = i < n
  beqz $t0, done    # if (i < n == false) done()
  sll $t0, $s2, 2   # $t0 = i * 4
  add $t0, $t0, $s0 # $t0 = &array[i]
  li $v0, 5         # $v0 = 5
  syscall           # read integer
  move $t1, $v0     # $t1 = $v0
  sw $t1, ($t0)     # array[i] = $t1
  addi $s2, $s2, 1  # i += 1
  j for
done:
  jr $ra            # return
