    .begin
    .org 2048

NUMERO	.equ 0xFF451200

    sethi %hi(NUMERO),%r1
    or %r1, %lo(NUMERO), %r1

    jmpl %r15 + 4, %r0

    .end
