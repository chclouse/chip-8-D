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
    ubyte _regSp;
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
                        assert(0, "Unrecognized syscall.");
                }
                break;
            default:
                assert(0, "Unrecognized instruction.");
        }
    }

    void step()
    {
        Instruction instruction = Instruction(_parent.memory[_regPc.._regPc+1]);
        _regPc += 2;
        runInstruction(instruction);
    }
}
