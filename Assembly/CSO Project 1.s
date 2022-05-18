# SHMEIWSH : AN TO 3o PSIFIO EINAI 3 TOTE GINETAI 3+7=10 10MOD10=0 KAI PAEI STHN PRWTH THESH OPOTE TO APOTELESMA GINETAI 3PSIFIO. PX: TO 5638 THA GINEI 523 ANTI GIA 0523

.text
.globl main
main:
	# orismos statherwn
	lw $s1 , lowerLim # gia na checkaroume an einai valid 4psifios
	lw $s2 , upperLim # same as above
	li $s3 , 1 # xrisimopoieitai gia ton metriti (vhma)
	li $s4 , 4 # megethos leksis
	li $s5 , 2 # half megethos leksis
	li $s6 , 7 # gia tis prostheseis
	li $s7 , 10 # gia diaireseis klp

	# orismos metavlitwn
	lw $t0 , result # apotelesma
	li $t1 , 0 # prosorinos kataxwrhths
	li $t2 , 0 # same as above
	li $t3 , 0 # metrhths
	li $t4 , 100 # xrhsimopoieitai gia pollaplasiasmo sthn enallagh pshfiwn
	li $t5 , 1 # same as above



	la $a0 , inputMessage #ektypwsh mhnymatos pou zhtaei input arithmo apo ton user
	li $v0 , 4
	syscall

	lw $t1 , number # kanoume load ton arithmo se register
	li $v0 , 5
	syscall

	move $t1 , $v0 #apothikevoume ton arithmo
	sw $t1 , number
	lw $t1 , number

	bge $t1 , $s1 , secondcheck # prwtos elegxos, koitaei an einai megalytero tou lowerlimit kai an isxyei to stelnei sto secondcheck

	j WrongInput # an o elegxos apo panw den isxuei stelnei to programma sto wronginput pou vgazei minima lathous
	
	secondcheck :
		ble $t1 , $s2 , CorrectInput # elegxei an o arithmos einai mikroteros tou upperlimit kai an isxyei to stelnei sto kyriws programma
		j WrongInput # emfanizei mhnyma lathous an den isxyei to if

	WrongInput : # orismos mhnymatos lathous
		la $a0, errorMessage
		li $v0 , 4
		syscall

		j main # epanekinisi programmatos

	CorrectInput :
		Programma:
			bge $t3 , $s4 , FinalPart # ksekinaei to loop
			rem $t2 , $t1 , $s7 # vriskw to upoloipo dia tou 10 gia na vrw to teleutaio psifio
			add $t2 , $t2 , $s6 # prosthetw 7
			rem $t2 , $t2 , $s7 # vriskw upoloipo dia tou 10 tou teleutaiou psifiou+7
			div $t1 , $t1 , $s7 # diairw ton arithmo dia 10 gia na ginei to loop sto epomeno psifio meta
			bge $t3 , $s5 , SecondHalf # afou ektelestei to firsthalf 2 fores to t3 ginetai 2 kai isxyei h synthiki kai stelnei to programma sto secondhalf

			FirstHalf:

				mul $t2 , $t2 , $t4 # pollaplasiazoume to upoloipo tou psifiou+7 me to t4 (arxika 100)
				add $t0 , $t0 , $t2 # prosthetoume to apotelesma tou pollaplasiasmou sto result

				mul $t4 , $t4 , $s7 # to t4 pollaplasiazetai me to 10 gia thn epomenh epanalhpsh
				add $t3 , $t3 , $s3 # prosthetoume +1 ston metrhth

				j Programma

			SecondHalf:

				mul $t2 , $t2 , $t5 #pollaplasiazoume to upoloipo tou psifiou+7 me to t5 (arxika 1)
				add $t0 , $t0 , $t2 #prosthetoume to apotelesma sto result
            
				mul $t5, $t5, $s7 #pollaplasiazoume to t5 me 10
				add $t3 , $t3 , $s3 # +1 ston metrhth

				j Programma

		FinalPart:
			la $a0 , resultMessage # ektypwnoume to "encrypted number: "
			li $v0 , 4
			syscall

			move $a0 , $t0 # ektypwnoume apotelesma
			li $v0 , 1
			syscall

			la $a0 , lineSkip # afhnoume kenh grammh gia otan tha ksanaksekinhsei to programma
			li $v0 , 4
			syscall

			sw $t0 , result #apothikeush apotelesmatos sthn mnhmh kai telos programmatos
			li $v0 , 10
			syscall

	.data



inputMessage: .asciiz "Give a 4 digit number: "
errorMessage: .asciiz "Invalid input\n\n"
lineSkip: .asciiz "\n\n"
resultMessage: .asciiz "Encrypted Number: "

number: .word 0
lowerLim: .word 1000
upperLim: .word 9999
result: .word 0