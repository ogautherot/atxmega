

#include <avr/interrupt.h>


extern "C" void bl_bad_irq();


__asm__(
  "/* Dummy vector table - interrupts are not active in bootloader mode */\n"
  "        .section .vectors\n"
  ".global bl_vectors_table\n"
  "bl_vectors_table:\n"
  "        JMP bl_main\n"
  "        JMP bl_bad_irq\n"
  "\n"
  "        /* Resume compiled code */\n"
  "        .text\n"
);

volatile int counter = 1;

extern "C" int bl_main()
{
  while (1)
    counter++;
}

void bl_bad_irq()
{
  while (1);
}