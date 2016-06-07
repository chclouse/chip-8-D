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
        assert(ins.length == 2);
        instruction = (ins[0]<<8) | ins[1];
    }

    this(ushort ins)
    {
        instruction = ins;
    }
}

pure ubyte[] getBCDRepresentation(ubyte value)
out (result)
{
    assert(result.length == 3);
}
body
{
    ubyte hundreds = value / 100;
    ubyte tens = (value / 10) % 10;
    ubyte ones = value % 10;
    return [hundreds, tens, ones];
}
