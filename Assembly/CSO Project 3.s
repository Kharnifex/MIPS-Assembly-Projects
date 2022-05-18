.text
.globl main
main:

	li $t0, 1 #counter

	la $t2 , array #fortwnei tin diefthinsi tou array

    read_5_integers: #diavazei tous 5 arithmous tou array
		bgt $t0 , 5 , read_limits #synthiki eksodou loop

		la $a0, initial_message1 #ektyposi (proto meros minimatos)
		li $v0 , 4
		syscall

		move $a0 , $t0 #ektyposi counter
		li $v0 , 1
		syscall		

		la $a0, initial_message2 #ektyposi (deftero meros minimatos)
		li $v0 , 4
		syscall

		li $v0 , 5 #diabasma akeraiou
		syscall

		sw $v0 , ($t2) #apothikefsi sto array
        addi $t2 , $t2 , 4 #proxorame tin prospelasi

        add $t0, $t0, 1 #auxisi counter
		j read_5_integers

	read_limits:
		la $a0, limit_message1 #for first limit
		li $v0 , 4 
		syscall

		li $v0 , 5 #diavasma
		syscall

		sw $v0 , b1 #apothikefsi

		la $a0, limit_message2 #for second limit
		li $v0 , 4
		syscall

		li $v0 , 5 #diavasma
		syscall

		sw $v0 , b2 #apothikefsi

	check_limits:
			lw $t1 , b1 #load word
			lw $t2 , b2

    	    bgt $t1 , 5 , error #condition that  b1>=1 && b1<=5
			blt $t1 , 1 , error

            bgt $t2, 5, error #condition that  b2>=1 && b2<=5
            blt $t2, 1, error

			bgt $t1 , $t2, error #condition that b1<=b2
    
    
    compare:

			la $a0 , array #fortosi array
			move $a1 , $t1 #metafora arguements
			move $a2 , $t2 #metafora arguements

			jal max #klhsh ypoprogrammatos

			j exit

	exit:
		move $t0 , $v0

		la $a0, exit_message1 #ektyposi (proto meros minimatos)
		li $v0 , 4
		syscall

		lw $a0 , b1 #anw orio
		li $v0 , 1
		syscall

		la $a0, exit_message2 #ektyposi (deftero meros minimatos)
		li $v0 , 4
		syscall

		lw $a0 , b2 #katw orio
		li $v0 , 1
		syscall

		la $a0, exit_message3 #ektyposi (trito meros minimatos)
		li $v0 , 4
		syscall

		move $a0, $t0 #max
		li $v0 , 1
		syscall

		la $a0, gaps #kena gia epomeni ektelesi
		li $v0 , 4
		syscall

		li $v0 , 10 #kleisimo programmatos
		syscall

    error:
		la $a0, error_message #minima lathous
		li $v0 , 4
		syscall

		j main #epanenarksi programmatos


####################################################################################

max:
	#	max = array[b1]
	#	for( c = b1; c < b2; c++)
	#	greater(array[c], max)

    add $sp,$sp,-4 #orthi epistrofi stin main
    sw $ra,0($sp)
    

	#fortosi protou max
    la $a0 , array #fortosi array
	
	mul $a1 , $a1 , 4  #oi grammes autes ginontai gia na kanoume access tin swsti thesi mnimis
	addi $a1 , $a1 , -4
	add $a0 , $a0 , $a1

	div $a1, $a1 , 4 #epistrefoume to $a1 stin prohgoumenh tou timh
	addi $a1 , $a1 , 1


	lw $v0 , ($a0) #proto max

	loop:
        lw $a3, ($a0) #fortosi stoixeiou
        jal greater #kalesi ypoprogrammatos
        
		addi $a1 , $a1 , 1 #auksisi counter
        addi $a0 , $a0 , 4 #pame stin epomeni thesi mnimis

        ble $a1 , $a2, loop #conditional
        
        
exit_max: #orthi epistrofi stin main
    lw $ra,0($sp)
    add $sp,$sp,4
    jr $ra

####################################################################################

greater:

    add $sp,$sp,-4 #orthi epistrofi stin main
    sw $ra,0($sp)
    
    bgt $a3 , $v0 , result2 #conditional

    result1: #to $a3 einai mikrotero tou max
        lw $ra,0($sp)
        add $sp,$sp,4
        jr $ra
    result2: #to $a3 einai megalytero tou max
        move $v0 , $a3
        
        lw $ra,0($sp) #orthi epistrofi stin main
        add $sp,$sp,4
        jr $ra

####################################################################################

.data
	array: .word 0 , 0 , 0 , 0 , 0
	b1: .word 0
	b2: .word 0

	initial_message1: .asciiz "Enter element no." 
	initial_message2: .asciiz " of the array :\n"
	
	limit_message1: .asciiz "Enter lower limit:\n"
	limit_message2: .asciiz "Enter upper limit:\n"

	error_message: .asciiz "ERROR\n\n"

	exit_message1: .asciiz "Max["
	exit_message2: .asciiz "-"
	exit_message3: .asciiz "]: "
	gaps: .asciiz "\n\n"