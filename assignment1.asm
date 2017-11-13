#Variables for the program
.data
	
	invalidMessage: .asciiz "Invalid hexadecimal number. "
	userInput: .space 9 #variable to hold string that user inputs

.text

	#Function declaration to get text from user
	main:
		li $v0, 8 #Tells system to prepare to read input
		la $a0, userInput #Stores user input into $a0
		li $a1, 9 #Tells system the maximum size of input, which is 8 
		syscall
		
		#Displays invalid message
		li $v0, 4
		la $a0, invalidMessage
		syscall
	
		
		#Displays input as the string
		li $v0, 4
		la $a0, userInput
		syscall
		
		#Test to print first bit of input
		la $t0, userInput
		lb $a0, 0($t0) #Increment the number in front of the bracket to access the different chars
		li $v0, 11
		syscall 
	
	
	li $v0, 10
	syscall #Tell the function this is the end of it
