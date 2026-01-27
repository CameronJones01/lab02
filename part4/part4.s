/* subroutine to convert the digits from 0 to 9 to be shown on a hex display.
 * 	parameters: r0 = the decimal value of the digit to be displayed
 * 	returns: r0 = bit patterm to be written to the hex display
 */

seg7_code:  ldr     r1, =bit_codes  
            ldrb    r0, [r1, r0]    
            bx      lr              

bit_codes:  .byte   0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110
            .byte   0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01100111
            .skip   2      // pad with 2 bytes to maintain word alignment

/* code for part iii (not shown) */

/* display r5 on hex1-0, r6 on hex3-2 and r7 on hex5-4 */
display:    ldr     r8, =0xff200020 // base address of hex3-hex0
            mov     r0, r5          // display r5 on hex1-0
            bl      divide          // ones digit will be in r0; tens
                                    // digit in r1
            mov     r9, r1          // save the tens digit
            bl      seg7_code       
            mov     r4, r0          // save bit code
            mov     r0, r9          // retrieve the tens digit, get bit
                                    // code
            bl      seg7_code       
            orr     r4, r4, r0, lsl # 8
            ...
            code for r6 (not shown)
            ...
            code for r7 (not shown)
            ...
