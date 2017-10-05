#Written by Josh Andrews
#ECE 473 LAB 4
#9/30/17
#Program to find and remove characters in a string, then print out the string with missing characters

.data
	str:	.asciiz "ECE 473 COOL"		#our unmodified string
	number:	.space	32			#32Bytes allocated memory for return string
	char:	.byte	'4'			#character were are looking to remove from string
.text 
 	main:	
			la $t0,str		#load address of string into t0
			la $t1,number		#load memory location for return string
			la $t4,($t1)		#store orignal start point of return string
			lb $t2,char		#set t2 to the remove character	
	compare:
			lb $t3, ($t0)		#load the current str byte into t3
			beq $t3,$t2,else	#if remove is equal to current str character, dont store into return string
			sb $t3, ($t1)		#store current str byte into return string
			addi $t1,$t1,1		#increment the return string
			beqz $t3, print		#if end of string (NULL char), p
	else:
			addi $t0,$t0,1		#look at next byte in str
			j compare		#go back until we hit NULL
	print:
			move $a0, $t4		#load starting return string address into a0
			li $v0, 4		#load 4 for print string
			syscall			#print it
	exit:
			li $v0, 10		#load 10 for exit
			syscall			#exit
