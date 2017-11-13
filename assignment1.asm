#Variables for the program
.data
	
	invalidMessage: .asciiz "Invalid hexadecimal number.s"
	userInput: .space 8 #variable to hold string that user inputs

.text

	#Function declaration
	main:
	
	
	li $v0, 10
	syscall #Tell the function this is the end of it
