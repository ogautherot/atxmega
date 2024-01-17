

__asm__(
  "/* Dummy vector table - interrupts are not active in bootloader mode */\n"
  "        .section .vectors\n"
  ".global bl_vectors_table\n"
  "bl_vectors_table:\n"
  "        JMP main\n"
  "        JMP bad_irq\n"
  "\n"
  "        /* Resume compiled code */\n"
  "        .text\n"
);

int main()
{
  while (1);
}

