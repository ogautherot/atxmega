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

void bl_sys_init()
{
}

int bl_main()
{
  bl_sys_init();
  while (1);
}

int bl_api(uint8_t cmd)
{
  switch(cmd)   {
  case 0:
    return 0;
  default:
    return -1;
  }
}

