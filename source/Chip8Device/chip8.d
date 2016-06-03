alias Memory = ubyte*;

//TODO: Implement these types.
alias Timer = ubyte;
alias Display = ubyte;

struct Chip8Device
{
private:
    CPU cpu;
    Memory memory;

public:
    this(ubyte[] rom)
    {
        // TODO
    }
}

struct CPU
{
private:
    // Program Counter
    ushort reg_pc;
    ubyte reg_data[16];
    ushort reg_addr;
    Timer reg_buzzer;
    Timer reg_delay;
    Display disp;
}
