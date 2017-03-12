.globl swap, getLeftChildIndex, getRightChildIndex

# $s0 = base
swap:
  sll $t0, $a0, 2        # $t0 = i * 4
  add $t0, $t0, $s0      # $t0 = &array[i]
  sll $t1, $a1, 2        # $t1 = j * 4
  add $t1, $t1, $s0      # $t1 = &array[j]
  lw $t2, ($t0)          # $t2 = array[i]
  lw $t3, ($t1)          # $t3 = array[j]
  sw $t3, ($t0)          # array[i] = $t3
  sw $t2, ($t1)          # array[j] = $t2
  jr $ra

getLeftChildIndex:
  sll $v0, $a0, 1        # $v0 = index * 2
  addi $v0, $v0, 1       # $v0 += 1
  jr $ra                 # return $v0

getRightChildIndex:
  sll $v0, $a0, 1        # $v0 = index * 2
  addi $v0, $v0, 2       # $v0 += 2
  jr $ra                 # return $v0
