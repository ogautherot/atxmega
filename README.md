# atxmega

This code base is a template for new ATXMega128a3-based projects. It includes 
the necessary hooks to take profit of the MCU features, as well as language
features.


1. GCC features
It has been tested with versions as early as GCC 5.4 and validated with GCC 12.
Both C and C++ are supported, with minimum intrusion into the standard boot code.

The included linker script is based on the standard script, although the memory
mapping is fixed and the boot loader flash has been added.

2. Boot loader section
The ATXMega128 supports a boot loader above the 128KB limit. This boot loader
section can be used to reprogram the application flash, with a few caveats:
  - The boot loader section permits CPU execution while reprogramming the
    application flash. It is not necessary to execute from RAM (which is not
    supported on the AVR)
  - Interrupts are disabled while executing from boot loader flash. A basic API
    can be implemented in the boot loader flash but execution has its corner
    cases.
  - The boot loader is best programmed in C. Global C++ variables are not
    supported here.
  - Note however that PROGMEM constants may not be supported properly.
  - A small segment of RAM has been assigned to the boot loader. It may be
    necessary to extend this section if more variables must be supported.
  - The boot loader uses the same stack as the application.

