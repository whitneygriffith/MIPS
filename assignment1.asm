#Variables for the program
.data
	invalidMessage: .asciiz "Invalid hexadecimal number."
	userInput: .space 9 #variable to hold string that user inputs
	lengthOfString: .word 0 #variable to store the length of the string
	decimal: .word 0 #variable to store the final decimal
	emptyOutput: .asciiz ""

.text

	#Function declaration to get text from user
	main:
	 li $v0,8 #take in input
         la $a0, userInput #load byte space into address
         li $a1, 9 # allot the byte space for string
         move $t0,$a0 #save string to t0
         syscall
         
         la $a0, userInput #reload byte space to primary address
         move $a0,$t0 # primary address = t0 address (load pointer)
	 #User input stored in $t0 and usersInput
         
   
	#Gets the length of the string the user inputed
	li $s1,0
	la $s0, userInput
	
	loop:   
		lb $a0,0($s0)
		beqz $a0, out
		addi $s0,$s0,1
		addi $s1,$s1,1
		j loop
	out:    
		#length has an extra 1 for the space
		#subtract 1 from $s1
		
		sub $s1, $s1, 1
		sw $s1, lengthOfString #Save length into lengthOfString 


		#Displays length of input
		li $v0, 1
		lw $a0, lengthOfString
		syscall	
	
	

	
	lw $s4, decimal #stores final answer
	lw $s2, lengthOfString
	sub $s2, $s2, 1 #counter that is being subtracted, ends when counter == 0, subtracts 1 because of indexing
	#la $s0, userInput #holds the user string
	li $s3, 0 #holds the chars

	#handle each character  
	char:
		lb $s3, 0($s0)
		addi $s0, $s0, 1
		
		li $v0, 4
		addi $a0, $s3, 0 
		beq $s2, 1, sys
		
		
		beq $s2, $zero, end
		sub $s2, $s2, 1
		#beqz $s2, emptyString #this is for the case of an empty string
		
		j char
	
		sys:
		sw $s3, decimal
		
		li $v0, 1
		lw $a0, decimal
		syscall
			
	emptyString:
	
		bge $s4, 1, finalDec #this says that the string had itemts before so go to final decimal output
		li $v0, 4
		la $a0, emptyOutput
		syscall
	
	finalDec:
		li $v0, 1
		lw $a0, decimal
		syscall
			
	invalid:
		li $v0, 4
		la $a0, invalidMessage
		syscall
	
		


	 end:
         li $v0,10 #end program
         syscall
