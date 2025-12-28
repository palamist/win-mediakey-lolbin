using System.Runtime.InteropServices;
using System.Threading;

class P
{
    [DllImport("user32.dll")]
    static extern void keybd_event(byte bVk, byte bScan, int f, int e);

    static void Main(string[] a)
    {
        if (a.Length == 0)
            return;
        byte k = 0;
        switch (a[0].ToLowerInvariant())
        {
            case "playpause":
                k = 0xB3;
                break;
            case "next":
                k = 0xB0;
                break;
            case "prev":
                k = 0xB1;
                break;
            default:
                return;
        }

        keybd_event(k, 0, 1, 0);
        Thread.Sleep(10);
        keybd_event(k, 0, 3, 0);
        Thread.Sleep(50);
    }
}
