.globl initialiser

.data
length: .asciiz "Taille du tableau : " 
content: .asciiz "Contenu du tableau :\n" 

.text
main:
  jal initialiser   # initialiser()
  li $v0, 10        # $v0 = 10
  syscall           # exit

# $s0 = base, $s1 = n
initialiser:
  lui $s0, 0x1004   # base = 0x10040000
  la $a0, length    # $a0 = &length
  li $v0, 4         # $v0 = 4
  syscall           # print string
  li $v0, 5         # $v0 = 5
  syscall           # read integer
  move $s1, $v0     # n = $v0
  la $a0, content   # $a0 = &content
  li $v0, 4         # $v0 = 4
  syscall           # print string
# $s2 = i
for:
  slt $t0, $s2, $s1 # $t0 = i < n
  beqz $t0, done    # if ($t0 == 0) done()
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
