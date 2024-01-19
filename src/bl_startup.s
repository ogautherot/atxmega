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
 
         /* Resume compiled code */
         .text
bl_reset:
        eor     r1, r1
        out     SREG, r1
        out     EIND, r1
        out     RAMPZ, r1
        out     RAMPY, r1
        out     RAMPX, r1
        out     RAMPD, r1
        ldi     r17, lo8(_stack_top)
        out     SPL, r17
        ldi     r18, hi8(_stack_top)
        out     SPH, r18


bl_api:

