        .begin
        .org 2048

main:   addcc %r14, -4, %r14    !! backup r15
        st %r15, %r14 

        ld [x], %r1             ! cargo X en r1
        ld [y], %r2             ! cargo Y en r2

        addcc %r14, -4, %r14    ! Acá reservo espacio para el primer elemento
        st  %r1, %r14           ! push el 20
        addcc %r14, -4, %r14    ! acá reservo espacio para el segundo elemento
        st  %r2, %r14           ! push el 50
	
        call add_by_stack

        st %r30, [z]            ! storeo r30 (salida del programa) en Z

        st %r14, %r22
        addcc %r14, 4, %r14     ! dejo el stack como estaba
        jmpl %r22 + 4, %r0

add_by_stack:
        ld %r14, %r8             ! cargo el primero en r8
        addcc %r14, 4, %r14      !libero
        ld %r14, %r9             ! cargo el segundo
        addcc %r14, 4, %r14      ! libero
        addcc %r8, %r9, %r30     ! agrego la suma a r12
        jmpl %r15 + 4, %r0

x: 20
y: 50
z: 0
        .end

