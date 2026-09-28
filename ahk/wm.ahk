#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"
SetWinDelay -1

#q::WinClose("A")
#w::WinGetMinMax("A") = 1 ? WinRestore("A") : WinMaximize("A")
^1::MoveToMonitor(2)
^2::SnapHalf(0)
^3::SnapHalf(1)
#Enter::Run("powershell.exe", A_Desktop)

Loop 9
    Hotkey("#" A_Index, GoDesktop.Bind(A_Index))

GoDesktop(n, *) => Send("^#{Left 10}" (n > 1 ? "^#{Right " (n - 1) "}" : ""))

SnapHalf(half) {
    WinRestore("A")
    MonitorGetWorkArea(MonitorGetPrimary(), &L, &T, &R, &B)
    w := (R - L) // 2
    WinMove(L + half * w, T, w, B - T, "A")
}

MoveToMonitor(idx) {
    if MonitorGetCount() < idx
        return
    WinRestore("A")
    MonitorGetWorkArea(idx, &L, &T, &R, &B)
    WinGetPos(, , &w, &h, "A")
    WinMove(L + (R - L - w) // 2, T + (B - T - h) // 2, , , "A")
}
