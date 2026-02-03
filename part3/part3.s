part3.s
.global _start
.text


// Functions

ones:
    MOV r5, #0      // r5 = count
    MOV r2, #0      // temporary

loop_ones:
    CMP r1, #0
    BEQ done_ones
    LSR r2, r1, #1
    AND r1, r1, r2
    ADD r5, r5, #1
    B loop_ones

done_ones:
    BX lr

zeros:
    MVN r1, r1      // invert bits: 0 → 1, 1 → 0
    MOV r6, #0
    MOV r2, #0

loop_zeros:
    CMP r1, #0
    BEQ done_zeros
    LSR r2, r1, #1
    AND r1, r1, r2
    ADD r6, r6, #1
    B loop_zeros

done_zeros:
    BX lr

alternate:
    LSR r2, r1, #1      // shift r1 right by 1
    EOR r1, r1, r2      // XOR to highlight alternating bits
    MOV r7, #0
    MOV r2, #0

loop_alt:
    CMP r1, #0
    BEQ done_alt
    LSR r2, r1, #1
    AND r1, r1, r2
    ADD r7, r7, #1
    B loop_alt

done_alt:
    BX lr


// Main program

_start:
    LDR r4, =TEST_NUM   // pointer to array
    MOV r8, #0          // max ones
    MOV r9, #0          // max zeros
    MOV r10, #0         // max alternating

next_num:
    LDR r1, [r4], #4    // load next number
    CMP r1, #0
    BEQ done            // stop at 0

    // call ones()
    BL ones
    CMP r5, r8
    MOVGT r8, r5

    // call zeros()
    MOV r1, r1          // reload original number
    BL zeros
    CMP r6, r9
    MOVGT r9, r6

    // call alternate()
    MOV r1, r1          // reload original number
    BL alternate
    CMP r7, r10
    MOVGT r10, r7

    B next_num

done:
    B done              // infinite loop


// Data

TEST_NUM:
    .word 0x103fe00f
    .word 0xFFFFFFFF
    .word 0x0000000F
    .word 0xF0F0F0F0
    .word 0x00FF00FF
    .word 0
