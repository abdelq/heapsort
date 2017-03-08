main:
  li $v0, 5     # $v0 = 5
  syscall       # read integer
  move $a0, $v0 # n = $v0
  jal suite     # suite(n)
  move $a0, $v0 # $a0 = $v0
  li $v0, 1     # $v0 = 1
  syscall       # print integer
  li $v0, 10    # $v0 = 10
  syscall       # exit

suite:
  li $v0, 5     # test
  jr $ra        # return
