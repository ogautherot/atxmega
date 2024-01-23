

#include <stdint.h>
#include <avr/io.h>
#include <avr/eeprom.h>

#include "atx_nvm.h"

extern uint8_t __eeprom_start__[], __eeprom_end__[];

uint8_t eeprom_array[2048] __attribute((section(".eeprom")));

uint8_t Nvm::getUint8(uint16_t addr)
{
    if (addr < sizeof(eeprom_array))     {
        return eeprom_array[addr];
    }
    return 0xff;
}

uint16_t Nvm::getUint16(uint16_t addr)
{
    if (addr < sizeof(eeprom_array))     {
        return *((uint16_t *) &eeprom_array[addr]);
    }
    return 0xffff;
}

uint32_t Nvm::getUint32(uint16_t addr)
{
    if (addr < sizeof(eeprom_array))     {
        return *((uint32_t *) &eeprom_array[addr]);
    }
    return 0xffffffff;
}

int16_t Nvm::getBuffer(uint8_t *dest, uint16_t addr, uint16_t len)
{
    if (addr < sizeof(eeprom_array) - len) {
        uint8_t *src = &eeprom_array[addr];
        uint16_t remaining = len;
        while (remaining-- > 0) {
            *dest++ = *src++;
        }
        return len;
    }
    return -1;
}



