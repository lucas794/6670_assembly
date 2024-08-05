! Un numero primo es cuando su bit menos significativo es un 0.
! Si no es primo, su digito menos signficativo es un 1.

    .begin
    .org 2048

main:   ld [array], %r1     ! cargo el puntero del array a r1   
        ld [largo], %r10    ! largo en r10
        xor %r20, %r20, %r20 ! Inicializo r20 con el contador de primos
        add %r0, %r15, %r31  ! backup r10

        call loop

        jmpl %r31, 4, %r0   ! jpml


loop:   andcc %r10, %r0, %r0
        be finalizar

        ld [%r10+%r1], %r5  ! valor del arreglo en r5
        sub %r10, 4, %r10
        ba loop     
        
finalizar: 
        jmpl %r15, 4, %r0

array:  2
        5
        10

largo:  12


    .end
