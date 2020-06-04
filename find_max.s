	.data 
len: 	.word 5
list: 	.word -4, 6, 7, -2, 1

	.text
main:	lw $t8, len		# $t8 = 5
	la $t9, list		# $t9 = list
	
	blez $t8, ERROR		# go to error if len <= 0
	
	add $t0, $zero, $zero	# $t0 = 0
	sll $t1, $t0, 2		# $t1 = $t0 * 4
	add $t2, $t9, $t1	# $t2 = addr(list[$t1])
	lw $t7, 0($t2)		# $t7 = list[0]
	
LOOP:	beq $t0, $t8, END	# if $t0 == 5
	sll $t1, $t0, 2		# $t1 = $t0 * 4
	add $t2, $t9, $t1	# $t2 = addr(list[$t1])
	lw $t3, 0($t2)		# $t3 = list[$t0]
	sub $t4, $t3, $t7	# $t4 = $t3 - $v0
	blez $t4, UPDATE 	# if $t4 <= 0
	lw $t7, 0($t2)		# $t7 = currently the maximum
	
UPDATE:	addi $t0, $t0, 1	# $t0 ++
	j LOOP
	
END:	add $v1, $zero, $t7	# $v1 = $t7
	
	li $v0, 10		# end program
	syscall

ERROR: 	addi $t7, $t7, -1	# return -1 if len <= 0
	add $v1, $zero, $t7
	
	li $v0, 10		# end program
	syscall

