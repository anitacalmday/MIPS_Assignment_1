.data
   message: .asciiz "Please enter a string using the characters '0' to '9' and/or 'a' to 'f' and/or 'A' to 'F': \n"
   userInput: .space 9 
.text 
    main: 
    	#displays prompt for input 
        li $v0, 4
        la $a0, message
        syscall
        
    	#getting user input as text
        li $v0, 8
        la $a0, userInput
        li $a1, 9
        syscall
        
        #displays user input 
        li $v0, 4
        la $a0, userInput 
        syscall
    
    
    #tell the system this is the end of main 
    li $v0, 10
    syscall