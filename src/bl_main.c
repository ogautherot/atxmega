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
__asm__(
  "        .section .vectors\n"
  ".global bl_vectors_table\n"
  "bl_vectors_table:\n"
  "        JMP bl_main\n"
  "        JMP bl_api\n"
  "\n"
  "        /* Resume compiled code */\n"
  "        .text\n"
);

volatile int counter = 1;

int bl_main()
{
  while (1)
    counter++;
}

int bl_api()
{
  while (1);
}
