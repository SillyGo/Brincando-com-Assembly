#AVISO: os registradores não estão 'setados' conforme a norma para funções
#em assembly, logo que o propósito desse código é so ilustrar o algoritmo de 
#multiplicação.

addi x10, x10, 15			#	#multiplicado
addi x11, x11, 2			#	#multiplicador
addi x12, x12, 0	 		#	#armazenará o bit menos significativo, serve nos cálculos.
addi x13, x13, 0	 		#	#resultado de mult
					#
fast_mult:				#	
	andi x12, x11, 1		#	#determina o bit menos significativo através de uma máscara de AND com 1.
	addi x12, x12, -1		#	#se for 1, 1 - 1 = 0. Fiz isso logo que não existe função "SUBI"
	beq x12, x0, sum		#	#como explicado acima, se o resultado em x12 for 0, o bit é 1, então vamos para o sum. Caso contrário, o bit é 0.
	donothing:			#	#caso o bit menos significativo seja 0, apenas dê shift left no multiplicando, sem somar
		slli x10, x10, 1	#	
		srli x11, x11, 1	#
		bne x11, x0, fast_mult	#	#verifique se o multiplicador chegou ao fim, oque acontece quando não existirem mais bits para dar shift right, ou seja, quando ele for igual a 0.
		halt			#	#caso tiver chegado ao final, teremos chegado ao final da divisão, então dê halt. Caso isso fosse uma função, usaríamos JALR, para retornar.
	sum:				#	
		add x13, x13, x10	#	#some no resultado o multiplicando 'shiftado' para a esquerda n vezes.
		slli x10, x10, 1	#	#daqui para frente é igual ao donothing:
		srli x11, x11, 1	#
		bne x11, x0, fast_mult	#	
		halt
	
