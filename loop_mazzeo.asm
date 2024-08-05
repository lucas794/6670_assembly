!Un programa declara un arreglo de 16 elementos de 32 bits no inicializados y guarda en la primera posición 
!de este arreglo la constante DB0321CCh. Luego invoca a una subrutina (cuyo código también se pide) a la cual 
!le pasa por stack la dirección de inicio del arreglo y su largo para que esta devuelva también por stack el 
!promedio de todos los valores contenidos en el arreglo. El programa principal copia este promedio en la 
!segunda posición del arreglo y termina.
!Programa principal y subrutina deben ser declarados en el mismo módulo

    .begin
    .org 2048

XUPPER  .equ DB03h
XLOWER  .equ 21CCh

largo:   .equ 64

    sethi XUPPER, %r1
    sethi XLOWER, %r2
    srl %r2, 16, %r2
    
    or %r1, %r2, %r1

array: .dwb 5

    .end

