# Cocher : Settings -> Assemble all files in directory

# $s0 = adresse de base, $s1 = n, $s2 = i
main:
  jal initialiser       # initialiser()
  jal sort              # sort()
  li $v0, 10            # $v0 = 10
  syscall               # halt

# $s1 = n, $s2 = i
sort:
  subi $s1, $s1, 1      # n -= 1
  subi $s2, $s1, 1      # i = n - 1
  srl $s2, $s2, 1       # i /= 2

for:
  sge $t0, $s2, 0       # i >= 0 ?
  beqz $t0, while       # if false then while
  move $a0, $s2         # $a0 = i
  move $a1, $s1         # $a1 = n
  jal fixHeap           # fixHeap (i, n)
  subi $s2, $s2, 1      # i -= 1
  j for

while:
  sgt $t0, $s1, 0       # n > 0 ?
  beqz $t0, done        # if false then done
  li $a0, 0             # $a0 = 0
  move $a1, $s1         # $a1 = n
  jal swap              # swap(0, n)
  subi $s1, $s1, 1      # n -= 1
  move $a1, $s1         # $a1 = n
  jal fixHeap           # fixHeap(0, n)
  j while

done: jr $ra            # return

# $s0 = adresse de base
fixHeap:
  move $t0, $a0         # index = rootIndex
  sll $t1, $t0, 2       # $t1 = index * 4
  add $t1, $t1, $s0     # $t1 = &array[index]
  lw $t1, ($t1)         # rootValue = array[index]
  li $t2, 1             # more = true

while2:
  move $a0, $t0         # $a0 = index
  jal getLeftChildIndex # getLeftChildIndex(index)
  move $t3, $v0         # childIndex = getLeftChildIndex(index)
  sle $t4, $t3, $a1     # childIndex <= lastIndex ?
  beqz $t4, done2        # if false then done2
  jal getRightChildIndex # getRightChildIndex(index)
  move $t4, $v0          # rightChildIndex = getRightChildIndex(index)
  j while2

done2:
  # array[index] = rootValue
  jr $ra             # return
