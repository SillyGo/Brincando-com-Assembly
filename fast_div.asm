#AVISOS: além daquele mencionado no código da multiplicação, temos também o fato que, eu creio, não expliquei muito bem o funcionamento do algoritmo. Por enquanto,
#para entender melhor, me procure presencialmente ou me mande um email, mas irei posteriormente adicionar uma nota explicando o funcionamento desse algoritmo feioso.

addi x10, x10, 30			#	#dividendo, armazena também, ao fim das operações, o resto.
addi x11, x11, 15			#	#divisor
addi x12, x12, 0 			#	#quociente
add x13, x13, x11			#	#armazena o valor inicial do divisor
					#
div_value_set:				#	#aqui, setamos o valor do divisor, tal que ele seja o máximo possível sem exceder o dividendo
	slli x11, x11, 1		#	#caso o divisor seja menor que o dividendo, repita o loop
	blt x11, x10, div_value_set	#	#caso contrário, devemos também analizar se eles são iguais.
	beq x11, x10, div_loop		#	#caso nenhum desses dois casos sigam, temos que o divisor é maior que o dividendo, então damos um sr para diminuir seu valor.
	srli x11,  x11, 1		#	#aqui está o shift right mencionado acima.
					#
div_loop:				#	#loop principal da divisão.--------------------------------------------------
	blt x10, x11, ad_zero		#	#caso o dividendo seja menor que o divisor,  não adicionamos um 1 no quociente
	ad_one:				#	#quando quisermos adicionar 1 no quociente, ou seja, se o divisor seja menor que o dividendo, como é esperado
		slli x12, x12, 1	#	aqui, temos a inserção do 1 no quociente, que não é uma soma de 1, só uma inserção. Para isso, damos um shift left e somamos 1.
		addi x12, x12, 1	#
		sub x10, x10, x11	#	#subtraimos o dividendo do divisor atual.
		srli x11, x11, 1	#	#damos shift right no divisor para que seu valor caia.
					#
		blt x13, x11, div_loop	#	#caso o valor inicial do divisor seja menor ou igual ao divisor atual, repita o loop.
		beq x13, x11, div_loop	#
		halt			#	#caso contrário, a divisão acabou.
	ad_zero:			#	#caso o dividendo seja maior que o divisor, não subtraimos, logo que isso retornaria um negativo.--------------
		slli x12, x12, 1	#	#e adicionamos um 0 ao quociente, através de um shift left simples.
		srli x11, x11, 1	#	#damos shift right para reduzir o valor do divisor.
					#
		blt x13, x11, div_loop	#	#a mesma forma de tratar o fim ou a continuação do loop empregada acima é empregada aqui também.
		beq x13, x11, div_loop	#
		halt			#
