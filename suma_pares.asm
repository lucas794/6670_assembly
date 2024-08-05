! Un numero primo es cuando su bit menos significativo es un 0.
! Suma de numeros pares en %r20, suma total de numeros pares en %r21
! r1 => Puntero array
! r10 => largo
! r31 => %15 backup

    .begin
    .org 2048

main:	add %r0, array, %r1     ! cargo el puntero del array a r1   
	ld [largo], %r10    	! largo en r10
	xor %r20, %r20, %r20    ! Inicializo r20 con el contador de pares
	xor %r5, %r5, %r5       ! Inicializo r5 en 0
	xor %r21,%r21, %r21     ! inicializo %r21 en 0
	add %r15, %r0, %r31
	call sumar_pares

sumar_pares: 
loop:   andcc %r10, %r10, %r0
        be finalizar

	sub %r10, 4, %r10

        ld %r1, %r10, %r5  ! valor del arreglo en r5
	add %r0, %r5, %r22 ! copia de temp valor
	sll %r5, 31, %r5   !Shifteo 31 lugares a la izquierda
	andcc %r5, 0xFFFFFFFF, %r0
	be sumarpar

        ba loop     

finalizar: 
	sethi 0x000000, %r5
        jmpl %r31+4, %r0

sumarpar:
	add %r20, 1, %r20
	add %r21, %r22, %r21
	jmpl %r15+4, %r0

array:	2
        5
        10

largo:  12


    .end
