	.begin
	.org 2048

	! Explicacion:
	! Supongamos que queremos estar parados en la posicion 0xFF451200

	

	! 1111 1111 0100 0101 0001 0010 0000 0000
	!  F    F    4    5    1    2    0    0

	! Los menos significativos: 00 0101 0001 0010 0000 0000	 (0x051200)
	! Los mas significativos: 1111 1111 0100 0101 0001 00 	 (0x3FD144)

	! Entonces, por defecto, el sethi pone todo en los primeros 22, y el resto ceros.
    ! %r1 => 0001 0100 0100 1000 0000 00 y completa con ceros. 00 0000 0000
    ! %r2 => 1111 1111 0100 0101 0001 00 y completa con ceros  00 0000 0000
    ! shifteas 10 lugares r1
    ! %r1 => 0000 0000 0001 0100 0100 1000 0000 0000 0000
	! y despues ahora si, la suma or.

main:	
    sethi 0x051200, %r1
	sethi 0x3FD144, %r2

	srl %r1, 10, %r1 ! Shifteas 10 a la derecha
	or %r1, %r2, %r3
	    
	jmpl %r15 + 4, %r0

	.end
    
    ! Otra alternativa:
    ! sethi 0x3FD144, %r1
    ! y ahora, le tengo que sumar los 10 bits restantes (22 sethi, me faltan otros 10 para los 32)
    ! esos bits, son el 10 0000 0000, que se convierte en 0x200
    ! or %r1, 0x200, %3

    .end
