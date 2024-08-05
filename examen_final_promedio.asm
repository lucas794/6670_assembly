!Un programa declara un arreglo de 16 elementos de 32 bits no inicializados y guarda en la primera posición 
!de este arreglo la constante DB0321CCh. Luego invoca a una subrutina (cuyo código también se pide) a la cual 
!le pasa por stack la dirección de inicio del arreglo y su largo para que esta devuelva también por stack el 
!promedio de todos los valores contenidos en el arreglo. El programa principal copia este promedio en la 
!segunda posición del arreglo y termina.
!Programa principal y subrutina deben ser declarados en el mismo módulo
    
! Para hacerla mas facil, hago 3 elementos así no me vuelvo loco.

    .begin
    .org 2048

HIGH    .equ DB032h
LOW     .equ 1CCh

! %r1 => Inserto el elemento HIGH|LOW
! %r2 => Cabeza del arreglo
! %r3 => backup r15 antes de la rutina
! %r4 => largo del arreglo
! %r5 => pop largo
! %r6 => pop cabeza 
! %r7 => contador
! %r8 => temporal elemento en el indice que se recorre
array: 1337
       5
       12
       2

largo: 16

.macro push argumento
    add %r14, -4, %r14
    st argumento, %r14
.endmacro

.macro pop argumento
    ld %r14, argumento
    add %r14, 4, %r14
.endmacro


main:  sethi HIGH, %r1
       sll %r1, 2, %r1
       or %r1, LOW, %r1     ! Asigno HIGHLOW en r1
       add %r0, array, %r2
       ld [largo], %r4
       st %r1, %r2          ! Cargo en la memoria con la pos del arreglo el %r1
       add %r15, %r0, %r3
       push %r2             ! pusheo la cabeza del arreglo a r14
       push %r4             ! pusheo largo del arreglo
       
       call sumar_arreglo

       jmpl %r3+4, %r0

sumar_arreglo: 
       pop %r5          ! sale largo del arreglo
       pop %r6          ! sale la cabeza del arreglo
       add %r0, %r0, %r7 ! Arranco contador en 0
loop:  andcc %r5, %r5, %r0
       be finalizar

       add %r5, -4, %r5
       ld [%r6+%r5], %r8
	
       addcc %r8, %r7, %r7
       bvs overflow

       ba loop
       
finalizar:	srl %r7, 2, %r7 ! Divido por 4 (0100) necesito shiftear a derecha 2 veces.
		push %r7
		st %r7, %r2+4
		jmpl %r15+4, %r0

overflow: 
	st %r0, %r2+4
	jmpl %r15+4,%r0 !guardo un 0 en la segunda posicion dado que estoy dividiendo un numero
       .end

