#You will write a MIPS program that reads a string of up to 8 characters from user input.
#If the string has only the characters from '0' to '9' and from 'a' to 'f' and from 'A' to 'F', the program prints out the unsigned decimal integer corresponding to the hexadecimal number in the string. 
#Otherwise,the program prints out the message of "Invalid hexadecimal number.". 
.data
   userInput: .space 9 
   errorMessage: .asciiz "Invalid hexadecimal number."

.text  
    main: 
	jal getInput
      	la $t0, userInput #current char address in t0
	li $t2, 0 #decimal equivalent intialized to 0
	li $t4, 1 #power of 16
	#go till end of end of input
   check:
	lb $t1, ($t0)
	beq $t1, '\n', end_check
	beq $t1, '\0', end_check
	add $t0, $t0, 1
	b check
  end_check:
	la $t5, userInput #start addresss of input
  loop:
	#go from last char to first, decrementing address
	sub $t0, $t0, 1
	blt $t0, $t5 , valid #if less than start address go to stop
	lb $t1, ($t0)
	#compare from highest ascii value
	bge $t1, 'a', lower
	bge $t1, 'A', upper
	bge $t1 , '0', digit
	#else invalid
   invalid:
	li $v0, 4
	la $a0, errorMessage
	syscall
	b exit
   valid:
   	addi $t1, $zero, 1
   	sll $t1, $t1, 31
   	and $s1, $t2, $t1 
   	bne $s1, $zero, bignegative
	li $v0, 1
	move $a0, $t2
	syscall
	b exit
   digit:
	bgt $t1, '9', invalid
	sub $t3, $t1, '0' #get numeric digit value
	mul $t3, $t3, $t4 #mulitply by the current power of 16
	add $t2, $t2, $t3
	mul $t4, $t4, 16 #next power of 16
	j loop
   lower:
	bgt $t1, 'f', invalid
	#get numeric digit value
	sub $t3, $t1, 'a'
	add $t3, $t3, 10
	mul $t3, $t3, $t4 #mulitply by the current power of 16
	add $t2, $t2, $t3
	mul $t4, $t4, 16 #next power of 16
	b loop
  upper:
	bgt $t1, 'F', invalid
	#get numeric digit value
	sub $t3, $t1, 'A'
	add $t3, $t3, 10
	mul $t3, $t3, $t4 #mulitply by the current power of 16
	add $t2, $t2, $t3 #add to decimal
	mul $t4, $t4, 16 #next power of 16
	b loop 
bignegative: 
	
	li $t7, 10
	divu $t2, $t7
	mflo $t1
	mfhi $t7
	
	add $a0, $t1, $zero
	li $v0, 1
	syscall
	
	add $a0, $t7, $zero
	li $v0, 1
	syscall
	
  exit: 	
  	#tell the system this is the end of main 
    	li $v0, 10
    	syscall
    
   
     getInput: 
     	#getting user input as text
        li $v0, 8
        la $a0, userInput
        li $a1, 9
        syscall
     	jr $ra
    
