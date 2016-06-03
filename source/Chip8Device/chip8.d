import cpu;

immutable size_t memSize = 4 * 1024;
immutable size_t progStart = 0x200;

struct Chip8Device
{
private:
    CPU _cpu;
    Display _display;

public:
    ubyte[] _memory;

    this(ubyte[] rom)
    {
        _memory = new ubyte[memSize];
        _memory[progStart .. progStart+rom.length] = rom[];
        _cpu = new CPU(this);
    }
}
