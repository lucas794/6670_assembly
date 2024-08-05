    .begin
    .org 2048

.macro clear pos
    sethi 0x000000, pos
.endmacro

    ! elemento CA006BCC
    sethi 0xCA006, %r2  
    sll %r2, 2, %r2
    or %r2, 0xBCC, %r2
   
    clear %r2

    ! elemento CA206BB8
    sethi 0xCA206, %r2 	!upper
    sll %r2, 2, %r2 	    
    or %r2, 0xBB8, %r2

    clear %r2

    ! 0x82206004
    
    sethi 0x82206, %r2  
    sll %r2, 2, %r2
    add %r2, 0x004, %r2

    clear %r2

    ! 0x02800003 
    
    ! Manera 1
    sethi 0x028000, %r2
    srl %r2, 2, %r2
    or %r2, 0x003, %r2

    ! Manera 2, Agarrar los 22 bits mas significativos y los menos significativos
    ! 0x02800003 = (0000)(0010)(1000)(0000)(0000)(0000)(0000)(0011)
    ! los mas significativos, los primeros 22, los menos significativos, los últimos 22
    ! y lectura de derecha a izquierda
    ! (0000)(0010)(1000)(0000)(0000)(00) => 0x00A000
    ! (00)(0000)(0000)(0000)(0000)(0011) => 0x000003
    ! Cargas 0x00A000 en %r2, 0x00003 en %r3,  y a r3 al ser lower, lo shifteas (32-22) => 10 lugares
    ! a la derecha, luego una suma entre las 2 registros
    ! ojo con este método, porque higher y lower tienen que ser MENORES que 0x3FFFFF (2^22 - 1)
    ! sino ARC tira error.
    sethi 0x00A000, %r2
    sethi 0x000003, %r3
    srl %r3, 10, %r3
    or %r2, %r3, %r2

    clear %r3
    clear %r2

    jmpl %r15 + 4, %r0
    .end


