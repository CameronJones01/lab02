part2.s  

ONES:                   // function label: calculates longest consecutive 1s
    MOV r0, #0          // initialize result counter r0 = 0
    MOV r2, #0          // temporary register r2 = 0 

loop_ones:              // start of the loop
    CMP r1, #0          // compare input number r1 to 0 (check if done)
    BEQ done_ones       // if r1 = 0, branch to done_ones (exit function)
    
    LSR r2, r1, #1      // shift r1 right by 1 bit and store in r2
    AND r1, r1, r2      // r1 = r1 AND r2 → shrinks consecutive 1s by 1
    ADD r0, r0, #1      // increment result counter r0 (count of streaks)
    B loop_ones         // repeat the loop

done_ones:              // loop finished, r1 = 0
    BX lr               // return to the caller function
