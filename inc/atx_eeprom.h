

extern uint8_t eeprom_array[];

class Eeprom {
    public:
        Eeprom() { }

    private:
        uint8_t getUint8(uint16_t addr);
        uint16_t getUint16(uint16_t addr);
        uint32_t getUint32(uint16_t addr);
        int16_t getBuffer(uint8_t *dest, uint16_t src, uint16_t len);
};
