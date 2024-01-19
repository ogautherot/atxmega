/* ***************************************************************************
 * Boot loader code. Keep it simple...
 ************************************************************************** */

#include <stdint.h>
#include <avr/interrupt.h>


/* 
 * Dummy vector table - interrupts are not active in bootloader mode so these
 * definitions are mostly for the fun. Only the reset vector is of interest,
 * as it may be invoked under certain circumstances.
 *
 * The second vector is for the API (the In-App Programming interface, for
 * instance).
 * *************************************************************************/

SREG = 0x3f
SPH = 0x3e
SPL = 0x3d
EIND = 0x3c
RAMPZ = 0x3b
RAMPY = 0x3a
RAMPX = 0x39
RAMPD = 0x38
CCP = 0x34

        .section .vectors
 .global bl_vectors_table
 bl_vectors_table:
         JMP bl_reset
         RJMP bl_api
 
         /*  Reset code section */
         .text
bl_reset:
        eor     r1, r1
        out     SREG, r1
        out     EIND, r1
        out     RAMPZ, r1
        out     RAMPY, r1
        out     RAMPX, r1
        out     RAMPD, r1
        ldi     r17, lo8(__stack_top)
        out     SPL, r17
        ldi     r18, hi8(__stack_top)
        out     SPH, r18

        /* Initialize RAM */
__bl_do_copy_data:
        ldi     r24, lo8(__bl_data_load_end)
        ldi     r25, hi8(__bl_data_load_end)
        ldi     r26, lo8(__bl_data_load_start)
        ldi     r27, hi8(__bl_data_load_start)
        ldi     r30, lo8(__bl_data_start)
        ldi     r31, hi8(__bl_data_start)
        ldi     r16, hh8(__bl_data_load_start)
        out     RAMPZ, r16
        rjmp    .+4
.L__bl_do_copy_data_loop:
        elpm    r0, Z+
        st      X+, r0
        cp      r26, r24
        cpc     r27, r25
        brne    .L__bl_do_copy_data_loop

_bl_do_clear_bss:
        ldi     r24, lo8(__bl_bss_end)
        ldi     r25, hi8(__bl_bss_end)
        ldi     r26, lo8(__bl_bss_start)
        ldi     r27, hi8(__bl_bss_start)
        rjmp    .+4
.L__bl_do_clear_bss_loop:
        st      X+, r1
        cp      r26, r24
        cpc     r27, R25
        brne    .L__bl_do_clear_bss_loop 

        call    bl_main
        jmp     _bl_exit

_bl_exit:
        rjmp    .-2
