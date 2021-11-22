;
; BinaryCalculator.asm
;
; Created: 15/11/2021 10:48:47
; Author : Frederik Bergmann Rasmussen
;
; Used Regs: 16-19,21-27,30

ldi r16, 0x00
out ddra, r16
out ddrb, r16
ldi r17, 0xff
out ddrc, r17
ldi r17, 0x00

main:
input1:
lds r16, pina
call delay
lds r17, pina
cpse r16, r17
rjmp input1

eor r18, r16
out portc, r18

lds r19, pinb
andi r19, 0b10000000;CONFIRM
brpl input1

mov r21, r18		;Input 1 stored in Reg21
ldi r16, 0x00
ldi r17, 0x00
ldi r18, 0x00
ldi r19, 0x00
out portc, r17

select_operator:
lds r16, pina
call delay
lds r17, pina
cpse r16, r17 ;DELAY?
rjmp select_operator

eor r18, r16
out portc, r18

lds r19, pinb
andi r19, 0b10000000;CONFIRM
brpl select_operator

mov r23, r18		;Operator stored in Reg23
ldi r16, 0x00
ldi r17, 0x00
ldi r18, 0x00
ldi r19, 0x00
out portc, r17

input2:
lds r16, pina
call delay
lds r17, pina
cpse r16, r17
rjmp input2

eor r18, r16
out portc, r18

lds r19, pinb
andi r19, 0b10000000;CONFIRM
brpl input2

mov r22, r18		;Input 2 stored in Reg22
ldi r16, 0x00
ldi r17, 0x00
ldi r18, 0x00
ldi r19, 0x00
out portc, r17

;---------CALCULATION----------

ldi r24, 0x01		;Add
ldi r25, 0x02		;Sub
ldi r26, 0x04		;Mul
ldi r27, 0x08		;Div

subi r21, 0b10000000
subi r22, 0b10000000 ;Remove the confirmation bit(MSB) from the calculation.
subi r23, 0b10000000

cp r23, r24
breq plus

cp r23, r25
breq minus

cp r23, r26
breq multi

cp r23, r27
breq div

plus:
add r21, r22
out portc, r21
jmp end

minus:
sub r21, r22
out portc, r21
jmp end

multi:
mul r21, r22
out portc, r0
jmp end

div:
;IMPLEMENTATION MISSING
jmp end

delay:
ldi r30, 100
l1:
dec r30
brne l1
ret

end: jmp end
