	.data
len:	.word 5
list:	.word -4, 6, 7, -2, 1

	.text
main:	addi $t0, $zero, 2		# value for n = 2; call get_n(2)
	addi $sp, $sp, -4
	sw $t0, 0($sp)			# save to stack
	jal get_n			# jump to get_n
	
END:	lw $v1, 0($sp)			# read from stack to get final result
	
	li $v0, 10			# end program
	syscall
	
get_n:	lw $s6, len			# $s6 = len
	la $s7, list			# $s7 = list
	
	lw $a0, 0($sp)			# pop value of n
	sub $s0, $a0, $s6		# $s0 = $a0 - $s6
	blez $a0, OUT			# go to OUT if n is less than or equal to 0
	bgtz $s0, OUT			# go to OUT if n is n is greater than len
	
	subi $a0, $a0, 1		# $a0 = $a0 - 1 (get the index)

	sll $s1, $a0, 2			# $s1 = $a0 * 4
	add $s2, $s7, $s1		# $s2 = addr(list[$a0])
	lw $s3, 0($s2)			# $s3 = list[$a0]
	
	sw $s3, 0($sp)			# push $s3 to stack
	jr $ra

OUT:	addi $s3, $zero, -1		# $s3 = -1
	addi $sp, $sp, -4
	sw $s3, 0($sp)			# push $s3 to stock
	jr $ra
	
