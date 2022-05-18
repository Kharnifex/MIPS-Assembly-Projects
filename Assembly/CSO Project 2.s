.text
.globl main

main:
    li $t1, 0
	li $t2, 0 #counter=0 
    li $t3, 0 #sum
    li $t4, 0 #gia upologismo tou sum
    li $t5, 0 #gia upologismo tou sum
	la $t0, CodeWord	# $t0 = base register of array CodeWord[]
    li $s0, 2 #gia thn entolh rem
    
    
    la $a0 , intro_message #ektypwsh mhnymatos pou zhtaei input apo ton user
    li $v0 , 4
    syscall

    loop: #eisagwgh twn 12 psifiwn
        bge $t2, 12, prog	# while (counter < 12)
        
        li $v0, 12 #entolh gia input
        syscall

        move $t1, $v0

        addi $t1, $t1, -48 #metatropi se int

        sb $t1, ($t0)

        addi $t0, $t0, 1 #diefthinsi epomenou stoixeiou tou $t0
        add $t2, $t2, 1 #counter++
        j loop
        

    prog:
        li $t2, 1 #counter=1
        
        
        loop2:
        
            li $t3, 0 #sum=0
            
            la $t0, CodeWord #$t0 base register tou array codeword[]
            
            bge $t2, 5, end # teleiwnei to loop2 otan o counter ginei 4
            
            beq $t2, 1, yes1
            
            beq $t2, 2, yes2
            
            beq $t2, 3, yes3
            
            beq $t2, 4, yes4
            
            
            yes1:
                la $t1, PotitionsForDigit1
                j sumcalc
                
            yes2:
                la $t1, PotitionsForDigit2
                j sumcalc
            
            yes3:
                la $t1, PotitionsForDigit4
                j sumcalc
            
            yes4:
                la $t1,PotitionsForDigit8
                j sumcalc
            
            sumcalc: #upologismos tou sum
                la $t0, CodeWord #$t0 base register tou codeword
            
                lb $t4, ($t1)
                beq $t4, -1, exitloop #otan erthei to teleutaio stoixeio sto $t1 (pou einai panta -1) stamataei to sumcalc
                
                addi $t4, $t4, -1
                
                add $t0, $t0, $t4 # vazoume to p($t4) sto array $t0
                lb $t5, ($t0) # digit = (p)
                
                add $t3, $t3, $t5 # sum=sum+digit
            
                add $t1, $t1, 1 #to $t1 doulevei san metrhths kai tha paei na ksanakanei to loop gia positionsfordigitx+1 efoson den vgalei lathos sto digit x
                
                j sumcalc
            
            exitloop:
                rem $t3, $t3, $s0    #t3 == t3 % 2

                beqz $t3, correct # an den einai lathos to stelnei sto correct opou o counter auksanetai kai ksekinaei to loop gia to epomeno digit
                
                la $a0, not_ok_message # an einai lathos tote emfanizei mhnyma
                li $v0, 4
                syscall
                
                j exit
                
                correct:
                    add $t2, $t2, 1 # counter+=1
                    j loop2
        


    end:
        la $a0, ok_message # efoson den exei emfanistei to not_ok_message emfanizei to ok_message
        li $v0, 4
        syscall
        j exit
        
    exit:    #telos programmatos
        li $v0 , 10
        syscall
    
    .data

CodeWord:		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

PotitionsForDigit1: 	.byte 1, 3, 5, 7, 9, 11, -1
PotitionsForDigit2: 	.byte 2, 3, 6, 7, 10, 11, -1
PotitionsForDigit4: 	.byte 4, 5, 6, 7, 12, -1
PotitionsForDigit8: 	.byte 8, 9, 10, 11, 12, -1

not_ok_message:		.asciiz "\n \n - Error in CodeWord"

ok_message:		.asciiz "\n \n - No error in CodeWord"

intro_message: .asciiz "insert input by typing 12 characters (0 or 1) \n \n"