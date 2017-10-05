#Program by Joshua Andrews
#ECE 473 Lab 4
#10/5/17
#Program to find the fix number recursively, see handout for function


.data 	#Use this to easily set int i and x 
	eye:	.word	10
 	ex:	.word	8
 	
.text 	
	lw 	$a0,eye
	lw 	$a1,ex
	
fix:	addi $sp, $sp, -16 	# Allocate 4 words on stack 
	sw $ra, 0($sp) 		# save return address on stack
	sw $a0, 4($sp) 		# save value of i on stack 
	sw $a1, 8($sp)		# save value of x on stack
	blt $a1, 3, else1	# if !(x>2) branch 
	j case1			# do recursion for that condition
else1:	blt $a1, 1, else2	# if !(x > 0) branch
	j case2			# do recursion for that condition
else2:	blt $a0, 1, bottom	# if !(i > 0) branch
	j case3			# do recursion for that condition
 
case1:	addi $a1, $a1, -1	# Set x to x-1 
	jal fix 
	
	add $s1, $zero, $v0	# $s1 = fix (i, x-1) 
	sw $s1, 12($sp)	
	addi $a1, $a1, -1 	# Set second arg to x-2 
	jal fix 
	
	lw $s1, 12($sp)
	add $v0, $v0, $s1	# $v0 = fix(i, x-1) + fix(i, x-2) 
	add $v0, $v0, 1		# Add 1 
	
calc:	lw $ra, 0($sp) 		# Restore ra 
	lw $a0, 4($sp) 		# restore last x
	lw $a1, 8($sp)		# restor last i
	addi $sp, $sp, 16	# Restore stack pointer 
	jr $ra
	
case2:	addi $a1, $a1, -1	# Set second argument to x-1 
	jal fix 
	
	add $v0, $v0, 2		# Return value $v0 = fix(i, x-1) + 2 
	j calc

case3:	addi $a0, $a0, -1	# Set first argument to i-1 
	addi $a1, $a1, -1	# Set second argument to x-1 
	jal fix 
	
	add $v0, $v0, 3		# Return value $v0 = fix(i-1, x-1) + 3 
	j calc 

bottom:	li $v0, 0		# Return 0 
	j calc