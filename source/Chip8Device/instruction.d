struct Instruction
{
    ushort instruction;

    ubyte regX()
    {
        return (instruction >> 8) & 0xF;
    }

    ubyte regY()
    {
        return (instruction >> 4) & 0xF;
    }

    ubyte immediate()
    {
        return instruction & 0xFF;
    }

    ushort addr()
    {
        return instruction & 0xFFF;
    }

    ubyte opcodeClass()
    {
        return (instruction >> 12) & 0xF;
    }

    this(ubyte[] ins)
    {
        instruction = (ins[0]<<8) | ins[1];
    }

    this(ushort ins)
    {
        instruction = ins;
    }
}
