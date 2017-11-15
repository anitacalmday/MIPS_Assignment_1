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
