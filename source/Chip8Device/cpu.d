import chip8;

//TODO: Implement these types.
alias Timer = ubyte;
alias Display = ubyte;

class CPU
{
private:
    ushort _reg_pc;
    ubyte _reg_data[16];
    ushort _reg_addr;
    Timer _reg_buzzer;
    Timer _reg_delay;

    Chip8Device _parent;

public:
    this(Chip8Device parent)
    {
        _parent = parent;
        _reg_pc = progStart;
    }

    void step()
    {
    }
}
