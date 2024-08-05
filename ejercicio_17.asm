    ! Un programa recibe a través de %r20 una palabra de 32 bits que representa dos números en
    ! complemetno a 2 en sus dos bytes mas significativos y en sus dos bytes menos significativos 
    ! respectivamente. Proponer un código para que ese programa tal que devuelva por %r20, la
    ! suma de ambos valores recibidos.
 

    ! Cargo 0x00020005 en r20 antes de iniciar el programa.

    .begin
    .org 2048

mascara_high:   FFFF0000h
mascara_low:    0000FFFFh

!Aclaración, cargo algo en r20 para probar, habría que borrarlo o cargarlo en ARC directamente.
numeros:        00020005h   ! 0010 + 0101 => 0111 => 0007.

main:
    ld [mascara_high], %r30
    ld [mascara_low],  %r31
    ld [numeros], %r20
    and %r20, %r30, %r1	    !Mandamos lo filtrado por mascara high a r1
    and %r20, %r31, %r20	!Mandamos lo filtrado por mascara low al mismo espacio
    ! faltaria shiftearlo a izquierda porque así como está tenemos
    ! 0002 0000
    ! 0000 0005
    ! necesitamos que nos quede
    ! 0005 0000
    sll %r20, 16, %r2
	
    ! Llegados acá, tenemos en r1 0002, y en r2, tenemos 0005
    addcc %r1, %r2, %r3     ! Guardamos el resultado en %r3
    
    !solo porque el enunciado no lo dice, lo dejamos en la primera parte de r20 (Osea, en la parte de 0002)
    or %r3, %r20, %r20 

    ! Tambien podes guardarlo en la parte baja, que es la misma operacion + srl %r20, 16, %r20
    
    !jmpl %r15, 4, %r0

main_alt:       ! Alternativa
    ld [numeros], %r20
    add %r0, %r21, %r21 ! Copio el valor de r20 en r21.
    srl %r20, 16, %r20  ! Paso shifteo los 2 primeros bytes 16 lugares.

    sll %r21, 16, %r21  ! shifteo left 16 %r21
    srl %r21, 16, %r21  ! shifteo right 16 %r21

    or %r20, %r21, %r21

    .end

