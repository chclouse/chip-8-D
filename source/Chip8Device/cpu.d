import std.stdio;
import std.string;
import chip8;
import instruction;

//TODO: Implement these types.
alias Timer = ubyte;

class CPU
{
private:
    ushort _regPc;
    ubyte _regData[16];
    ushort _regAddr;
    ushort _callStack[16];
    byte _regSp = -1;
    Timer _regBuzzer;
    Timer _regDelay;

    Chip8Device _parent;

public:
    this(Chip8Device parent)
    {
        _parent = parent;
        _regPc = progStart;
    }

    void runInstruction(Instruction instruction)
    {
        switch (instruction.opcodeClass)
        {
            case 0x0:
                // Syscall
                switch (instruction.instruction)
                {
                    case 0x00E0:
                        // Clear screen
                        //_parent.clearScreen(); //TODO: Implement.
                        break;
                    case 0x0EE0:
                        // Return from function
                        if (_regSp > 0)
                        {
                            _regPc = _callStack[_regSp];
                            _regSp--;
                        }
                        break;
                    default:
                        assert(0, format("Unrecognized syscall: %04x",
                            instruction.instruction));
                }
                break;
            case 0x1:
                // Unconditional jump
                _regPc = instruction.addr;
                break;
            case 0x2:
                // Call
                if (_regSp < 16)
                {
                    _regSp++;
                    _callStack[_regSp] = _regPc;
                    _regPc = instruction.addr;
                }
                break;
            case 0x6:
                // LD Vx, imm
                _regData[instruction.regX] = instruction.immediate;
                break;
            case 0xA:
                // LD I, addr
                _regAddr = instruction.addr;
                break;
            case 0xF:
                // IO/Multiload
                switch (instruction.immediate)
                {
                    case 0x33:
                        // LD B, Vx
                        ubyte[] bcd = getBCDRepresentation(_regData[instruction.regX]);
                        _parent.memory[_regAddr .. _regAddr+3] = bcd;
                        break;
                    case 0x55:
                        // LD [I], Vx
                        _parent.memory[_regAddr .. _regAddr+instruction.regX+1] =
                            _regData[0 .. instruction.regX+1];
                        break;
                    default:
                        assert(0, format("Unrecognized instruction: %04x",
                            instruction.instruction));
                }
                break;
            default:
                assert(0, format("Unrecognized instruction: %04x",
                    instruction.instruction));
        }
    }

    void step()
    {
        Instruction instruction = Instruction(_parent.memory[_regPc.._regPc+2]);
        writefln("0x%04x: %04x", _regPc, instruction.instruction);
        _regPc += 2;
        runInstruction(instruction);
    }

    void run(size_t len)
    {
        while (progStart <= _regPc && _regPc <= (progStart+len))
        {
            step();
        }
    }
}
