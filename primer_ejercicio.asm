        .begin
        .org 2048
main:   ld [x], %r1
        ld [y], %r2
        addcc %r15, %r0, %r27
        call sumador
        st %r3, [z]
        jmpl %r27 + 4, %r0

sumador:
        addcc %r1, %r2, %r3
        jmpl %r15 + 4, %r0

x:      15
y:      15
z:      0
        .end
