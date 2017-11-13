#Variables for the program
.data
	#variable to hold string that user inputs
	input1: .asciiz ""

.text

	#Function declaration
	main:
	
	
	li $v0, 10
	syscall #Tell the function this is the end of it
