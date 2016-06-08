immutable size_t screenWidth = 64;
immutable size_t screenHeight = 32;

class Display
{
private:
    bool[][] _screen;

public:
    this()
    {
        _screen = new bool[][](screenWidth, screenHeight);
    }

    void clear()
    {
        foreach (ref row; _screen)
        {
            foreach (ref pixel; row)
            {
                pixel = false;
            }
        }
    }
}
