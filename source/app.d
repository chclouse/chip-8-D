import std.stdio;
import std.file;
import chip8;

void main(string[] args)
{
    string rom_filename = args[1];
    ubyte[] rom = cast(ubyte[])read(args[1]);
    auto chip8 = Chip8Device(rom);
}
