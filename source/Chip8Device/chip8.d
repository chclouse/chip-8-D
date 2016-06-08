import cpu;
import display;

immutable size_t memSize = 4 * 1024;
immutable size_t progStart = 0x200;

struct Chip8Device
{
private:
    CPU _cpu;
    Display _display;

public:
    ubyte[] memory;

    this(ubyte[] rom)
    {
        memory = new ubyte[memSize];
        memory[progStart .. progStart+rom.length] = rom[];
        _cpu = new CPU(this);
    }

    void run(size_t len)
    {
        _cpu.run(len);
    }

    void clearDisplay()
    {
        _display.clear();
    }
}
