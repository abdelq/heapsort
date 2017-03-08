main:
  jal initialiser        # initialiser()
  jal sort               # sort()
                         # print all values in heap sorted (forloop)
  li $v0, 10             # $v0 = 10
  syscall                # exit

# $s1 = arr.length, $s2 = n, $s3 = i
sort:
  subi $s2, $s1, 1       # n = arr.length - 1
  subi $s3, $s2, 1       # i = n - 1
  srl $s3, $s3, 1        # i /= 2
for:
  sge $t0, $s3, 0        # $t0 = i >= 0
  beqz $t0, while1       # if ($t0 == 0) while1()
  move $a0, $s3          # $a0 = i
  move $a1, $s2          # $a1 = n
  jal fixHeap            # fixHeap (i, n)
  subi $s3, $s3, 1       # i -= 1
  j for
while1:
  sgt $t0, $s2, 0        # $t0 = n > 0
  beqz $t0, done1        # if ($t0 == 0) done1()
  li $a0, 0              # $a0 = 0
  move $a1, $s2          # $a1 = n
  jal swap               # swap(0, n)
  subi $s2, $s2, 1       # n -= 1
  move $a1, $s2          # $a1 = n
  jal fixHeap            # fixHeap(0, n)
  j while1
done1:
  jr $ra                 # return

# $s0 = base, $s4 = index, $s5 = rootValue, $s6 = leftChildIndex, $s7 = rightChildIndex
fixHeap:
  move $s4, $a0          # index = rootIndex
  sll $t0, $s4, 2        # $t0 = index * 4
  add $t0, $t0, $s0      # $t0 = &arr[index]
  lw $s5, ($t0)          # rootValue = arr[index]
while2:
  move $a0, $s4          # $a0 = index
  jal getLeftChildIndex  # getLeftChildIndex(index)
  move $s6, $v0          # leftChildIndex = getLeftChildIndex(index)
if1:
  sle $t0, $s6, $a1      # $t0 = leftChildIndex <= lastIndex
  beqz $t0, done2        # if ($t0 == 0) done2()
  jal getRightChildIndex # getRightChildIndex(index)
  move $s7, $v0          # rightChildIndex = getRightChildIndex(index)
if2:
  sle $t0, $s7, $a1      # $t0 = rightChildIndex <= lastIndex
  sll $t1, $s7, 2        # $t1 = rightChildIndex * 4
  add $t1, $t1, $s0      # $t1 = &arr[rightChildIndex]
  lw $t1, ($t1)          # $t1 = arr[rightchildindex]
  sll $t2, $s6, 2        # $t2 = leftChildIndex * 4
  add $t2, $t2, $s0      # $t2 = &arr[leftChildIndex]
  lw $t2, ($t2)          # $t2 = arr[leftChildIndex]
  sgt $t1, $t1, $t2      # $t1 = $t1 > $t2
  and $t0, $t0, $t1      # $t0 = $t0 & $t1
  beqz $t0, if3          # if ($t0 == 0) if3()
  move $s6, $s7          # leftChildIndex = rightChildIndex
if3:
  sll $t0, $s6, 2        # $t0 = leftChildIndex * 4
  add $t0, $t0, $s0      # $t0 = &arr[leftChildIndex]
  lw $t0, ($t0)          # $t0 = arr[leftChildIndex]
  sgt $t1, $t0, $s5      # $t1 = arr[leftChildIndex] > rootValue
  beqz $t1, done2        # if ($t1 == 0) done2()
  sll $t2, $s4, 2        # $t2 = index * 4
  add $t2, $t2, $s0      # $t2 = &arr[index]
  sw $t0, ($t2)          # arr[index] = arr[leftChildIndex]
  move $s4, $s6          # index = leftChildIndex
  j while2
done2:
  sll $t0, $s4, 2        # $t0 = index * 4
  add $t0, $t0, $s0      # $t0 = &arr[index]
  sw $s5, ($t0)          # arr[index] = rootValue
  jr $ra                 # return
