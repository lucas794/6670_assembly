! Ejemplo con 0xDB0321CC
! una opcion de muchas que aprendí, esta es lenta, pero es la mas facil de aprender.
! Cargo 0xDB0 con sethi
! cuando cargo con sethi, cargo un imm22, esto queda (0000)(0000)(00)DB0
! necesito shiftearlo a izquierda 10 lugares así queda al principio, entonces me queda 0xDB0.
! Ahora intento cargar 0x32
! Me queda (00)(0000)(0000)(0000)32
! necesito shiftearlo a izquierda para realizar la suma, lo muevo 2 lugares (Porqué diras?)
! 0xDB0(0000)(0000)(00)
! si quiero sumarle 32
! 0x000  3     2    00 que es
! 0x000(0011)(0010)(00)
! Necesito cargar 0x32 y shiftear 2 a la izquierda.
! 0xDB000000
! 0x00032000
! __________
! 0xDB032000
! y a esto, simplemente le sumo 1CC
! 0xDB0321CC

    .begin
    .org 2048

    sethi 0xDB032, %r1  ! MANERA MAS PICANTE PERO SALE
    ! El único comentario que tengo con esto es que tenes que tener dominado
    ! Cual es el límite posible de asignar sin pasarte de 2²²

	sll %r1, 2, %r1     ! MANERA MAS PICANTE PERO SALE

	or %r1, 0x1CC, %r1  ! MANERA MAS PICANTE PERO SALE

	sethi 0xDB0, %r9    
	sll %r9, 10, %r9

	sethi 0x32, %r10
	sll %r10, 2, %r10
	
	or %r9, %r10, %r10

	add %r10, 0x1CC, %r10 ! Otra manera, ya que estás en el baile, es otro sethi si querés, y meterle un OR.

!! Ahora si arranco el ejercicio
    .org 810
A:  .equ 5
    
    st 5, %r2

	.end

