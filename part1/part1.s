/* program that counts consecutive 1's */

          .text                   // executable code follows
          .global _start                  
_start:                             
          ldr     r1, test_num    // load the data word into r1

          mov     r0, #0          // r0 will hold the result
loop:     cmp     r1, #0          // loop until the data contains no more 1's
          beq     end             
          lsr     r2, r1, #1      // perform shift, followed by and
          and     r1, r1, r2      
          add     r0, #1          // count the string length so far
          b       loop            

end:      b       end             

test_num: .word   0x103fe00f  

          .end                            
