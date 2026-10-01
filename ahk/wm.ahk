#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"
SetWinDelay -1

#q::WinClose("A")
#w::WinGetMinMax("A") = 1 ? WinRestore("A") : WinMaximize("A")
#f::Run '"C:\Users\Aran Thananjayan\AppData\Local\imput\Helium\Application\chrome.exe"'
#Enter::Run("powershell.exe", A_Desktop)

Loop 9
    Hotkey("#" A_Index, GoDesktop.Bind(A_Index))

GoDesktop(n, *) => Send("^#{Left 10}" (n > 1 ? "^#{Right " (n - 1) "}" : ""))
