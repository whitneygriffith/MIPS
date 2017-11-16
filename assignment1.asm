.data

	userInput: .space 9
	invalidMessage: .asciiz "Invalid hexadecimal number."
	#userInput: .space 9 #variable to hold string that user inputs
	lengthOfString: .word 0 #variable to store the length of the string
	decimal: .word 0 #variable to store the final decimal
	emptyOutput: .asciiz ""


.text
	#Function declaration to get text from user
	main:
	 li $v0,8 #take in input
         la $a0, userInput #load byte space into address
         li $a1, 9 # allot the byte space for string
         syscall 
    
	#Gets the length of the string the user inputed
	li $t1,0
	la $t0, userInput
	
	loop:   
		lb $a0,0($t0)
		beqz $a0, out
		addi $t0,$t0,1
		addi $t1,$t1,1
		j loop
	out:    
		#length has an extra 1 for the space
		sw $t1, lengthOfString #Save length into lengthOfString 


		#Displays length of input
		#li $v0, 1
		#lw $a0, lengthOfString
		#syscall	
		
       lw $s0, lengthOfString
   
       li $v0,1
       la $a0, ($s0)   


       la $s1, userInput 
       li $s3, 0 #holds the chars
       
       
	lw $s2, decimal
	addi $s5,$zero,16 
	lw $s4, lengthOfString #counter that is being subtracted,
	
	#handle each character  
	char:
		lb $s3, 0($s1)
		addi $s1, $s1, 1
		beqz $s3,end
    
    
    		beq $s3, 10, end
   
    		#subtract counter
   		sub $s4, $s4, 1
   
    
  		#checking for the character range

    blt $s3, 48, error
    blt $s3, 58, handleNum
    blt $s3, 65, error
    blt $s3, 71, uppercase
    blt $s3, 97, error
    blt $s3, 103, lowercase
   
    bgt $s3, 102, error 
  	  	j char #continue loop

	#This is the end of the loop. Outputs final decimal
	end:
		li $v0, 1
		la $a0, ($s2) 
		syscall 
		li $v0, 10 #end program
		syscall
	#outputs invalid string
	error:
		li $v0, 4 
		la $a0, invalidMessage
		syscall
		#end program here
		li $v0, 10
		syscall
	
	handleNum:
		sub $t0, $s3, 48 
		ori $t4,$zero,1 
		ori $t5,$zero,0
		beqz $s4, addDec
		
	addDec: 
		mult $t0,$t4
		mflo $t0
		add $s2,$s2,$t0
		j char

	uppercase:
		sub $t0, $s3, 55 
		ori $t4,$zero,1 
		ori $t5,$zero,0
		beqz $s4, next
	next: 
		mult $t0,$t4
		mflo $t0
		add $s2,$s2,$t0
		j char


	while:
		mult $t4,$s5
		mflo $t4
		addi $t5,$t5,1
		bne $t5,$s4,while


	while2:
		mult $t4,$s5
		mflo $t4
		addi $t5, $t5, 1
		bne $t5, $s4, while2

	lowercase:
		sub $t0, $s3, 87 
		ori $t4,$zero,1
		ori $t5,$zero,0
		beqz $s4, skip3
	while3:
		mult $t4, $s5
		mflo $t4
		addi $t5, $t5, 1
		bne $t5, $s4, while3
	skip3: 
		mult $t0,$t4
		mflo $t0
		add $s2,$s2,$t0
		j char

	#end program
	exit:
		li $v0, 10
		syscall