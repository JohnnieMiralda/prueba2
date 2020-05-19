; #exec "/home/johnnie/Documents/orga2/Prueba2_P2_2020/move_sprite.asm"

 main:
li $a0, 20
li $a1, 20

jal move_sprite 
#stop




move_sprite:
addi $sp, $sp, -4
sw $ra, 0($sp)

;li $t0, 10 ; Row
;li $t1, 10 ; Column
move $t0, $a0; Row
move $t1, $a1; Column
li $s0, 0xffff0000
li $s1, 0xb800
li $a2, 0x1e02
li $a3, 0x1e20
li $t4, 0b01000000
li $t6,0xb800

loop:
    sll $t2, $t0, 6
    sll $t3, $t0, 4
    add $t2, $t2, $t3
    add $t2, $t2, $t1
    sll $t2, $t2, 1
    add $s2, $t2, $s1
    lh $t6, 0($s2)
    sh $a2, 0($s2)
    
test_keys:
    jal delay







    lbu $v0, 4($s0)
    andi $v1, $v0, 0x1
    beq $v1, $zero, test_right
;wait_left:
;    lbu $v0, 4($s0)
;    andi $v0, $v0, 0x1
;    bne $v0, $zero, wait_left
    lbu $v0, 4($s0)
    andi $v1, $v0, 0x40
    beq $v1, $zero, nol
    sh $t6, 0($s2)
    j sil
    nol:
    sh $a3, 0($s2)
    sil:
        addi $t1, $t1, -1
        j loop
    
test_right:
    andi $v1, $v0, 0x2
    beq $v1, $zero, test_down
;wait_right:
;    lbu $v0, 4($s0)
;    andi $v0, $v0, 0x2
;    bne $v0, $zero, wait_right
    lbu $v0, 4($s0)
    andi $v1, $v0, 0x40
    beq $v1, $zero, nor
    sh $t6, 0($s2)
    j sir
    nor:
    sh $a3, 0($s2)
    sir:
    addi $t1, $t1, 1
    j loop

test_down:
    andi $v1, $v0, 0x4
    beq $v1, $zero, test_up
;wait_down:
;    lbu $v0, 4($s0)
;    andi $v0, $v0, 0x4
;    bne $v0, $zero, wait_down
    lbu $v0, 4($s0)
    andi $v1, $v0, 0x40
    beq $v1, $zero, nodo
    sh $t6, 0($s2)
    j sido
    nodo:
    sh $a3, 0($s2)
    sido:
    addi $t0, $t0, 1
    j loop
test_up:
    andi $v1, $v0, 0x8
    beq $v1, $zero, test_q
;wait_up:
;    lbu $v0, 4($s0)
;    andi $v0, $v0, 0x8
;    bne $v0, $zero, wait_up
    lbu $v0, 4($s0)
    andi $v1, $v0, 0x40
    beq $v1, $zero, noup
    sh $t6, 0($s2)
    j siup
    noup:
    sh $a3, 0($s2)
    siup:
    addi $t0, $t0, -1
    j loop
test_q:
    andi $v1, $v0, 0x10
    bne $v1, $zero, end_loop
    j test_keys
    
end_loop:
    #show $v0 binary
    lw $ra, 0($sp)
    jr $ra




delay:
    lw $t7, 8($s0)          ; timer
    addi $t8, $t7, 100   ; end = timer + 500
loopw:
    lw $t7, 8($s0)          ; timer
bne $t7, $t8, loopw
jr $ra