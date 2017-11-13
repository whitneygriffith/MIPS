#Variables for the program
.data
	
	invalidMessage: .asciiz "Invalid hexadecimal number. "
	userInput: .space 8 #variable to hold string that user inputs

.text

	#Function declaration to get text from user
	main:
		li $v0, 8 #Tells system to prepare to read input
		la $a0, userInput #Stores user input into $a0
		li $a1, 8 #Tells system the maximum size of input
		syscall
		
		#Displays invalid message
		li $v0, 4
		la $a0, invalidMessage
		syscall
		
		#Displays input as the string
		li $v0, 4
		la $a0, userInput
		syscall
	
	
	li $v0, 10
	syscall #Tell the function this is the end of it
