    .begin
    .org 2048

    !r1 => largo del array
    !r2 => contador de la suma de los elementos

main:
    add %r0, largo, %r1  
    call loop
    add %r0, 0x1CC, %r1

loop:
    andcc %r1, %r1, %r0
    be endloop

    ld [array+%r1], %r3
    add %r2, %r3, %r2
    add %r1, -4, %r1
    ba loop

endloop:
    jmpl %r15 + 4, %r0
    
! Lo hago con 3 porque sino es larguísimo
array:  .dwb 3
largo   .equ  12

    .end

