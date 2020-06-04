	.data
len:	.word 10
list:	.word 2, 1, 7, 10, 9, -5, 5, 4, -3, 5

	.text
main:	lw $t6, len		# $t6 = len
	la $t7, list		# $t7 = list
	addi $sp, $sp, -4
	sw $t6, 0($sp)		# push len to stack
	addi $sp, $sp, -4
	sw $t7, 0($sp)		# push array to stack
	
	jal get_min		# call get_min
	
	lw $v1, 0($sp)		# pop final result to $v1
	
	li $v0, 10		# end program
	syscall

get_min:lw $s0, 0($sp)		# load array to $s0
	addi $sp, $sp, 4
	lw $s1, 0($sp)		# load len to $s1
	addi $sp, $sp, -4
	
error:	bgtz $s1, base		# if len <= 0
	addi $s2, $zero, -1	# return -1
	addi $sp, $sp, -4
	sw $s2, 0($sp)		# push $s2 = -1 to stack
	jr $ra

base:	addi $s2, $zero, 1	# $s2 = 1
	bne $s1, $s2, rec	# if len != $s2, recursive step
	
	addi $s1, $s1, -1	# $s1 = $s1 - 1
	
	# get list[$s1]
	sll $s2, $s1, 2		# $s2 = $s1 * 4
	add $s3, $s0, $s2	# $s3 = addr(list[$s1])
	lw $s4, 0($s3)		# $s4 = list[$s1]
	
	addi $sp, $sp, -4
	sw $s4, 0($sp)		# push return value onto stack
	jr $ra
	
rec:	subi $s1, $s1, 1	# $s1 = $s1 - 1
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)		# push $ra onto stack
	addi $sp, $sp, -4
	sw $s1, 0($sp)		# push modified len onto stack
	addi $sp, $sp, -4
	sw $s0, 0($sp)		# push list onto stack
	
	jal get_min
	
	lw $t0, 0($sp)		# pop return value from stack to $t0
	addi $sp, $sp, 4
	lw $s6, 0($sp)		# pop array to $s6
	addi $sp, $sp, 4
	lw $s7, 0($sp)		# pop len to $s7
	addi $sp, $sp, 4
	lw $ra, 0($sp)		# pop $ra
	
	# get list[len]
	sll $t1, $s7, 2		# $t1 = $s7 * 4
	add $t2, $s6, $t1	# $t2 = addr(list[$s7])
	lw $t3, 0($t2)		# $t3 = list[$s7]
	
	sub $t4, $t0, $t3	# $t4 = $t0 - $t3
	
	bgtz $t4, A		# if $t0 <= $t3
	sw $t0, 0($sp)		# push $t0 onto stack
	jr $ra
	
A:	sw $t3, 0($sp)		# if $t3 < $t0; push $t3 as return value
	jr $ra
	
	
	
	
	
	
