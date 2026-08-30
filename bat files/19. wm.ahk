#Requires AutoHotkey v2.0
#SingleInstance Force

; Win+Q closes the active window.
#q::WinClose("A")

; Win+W toggles the active window between maximized and restored.
#w:: {
    if WinGetMinMax("A") = 1
        WinRestore("A")
    else
        WinMaximize("A")
}

; Win+Enter opens a new Windows PowerShell window.
#Enter::Run("powershell.exe")

; Win+Shift+Q force-kills an unresponsive window.
#+q::WinKill("A")

; Win+F toggles "always on top" for the active window.
#f::WinSetAlwaysOnTop(-1, "A")

; Win+1 -- snap the active window to the LEFT half of your main
; (primary) monitor, regardless of which monitor it's currently on.
#1::SnapToMainHalf(0)

; Win+2 -- snap the active window to the RIGHT half of your main
; (primary) monitor.
#2::SnapToMainHalf(1)

SnapToMainHalf(side) {
    primary := MonitorGetPrimary()
    MonitorGetWorkArea(primary, &L, &T, &R, &B)
    w := (R - L) // 2
    h := B - T
    x := L + side * w
    WinRestore("A")
    WinMove(x, T, w, h, "A")
}

; Win+3 -- move the active window to your 2nd monitor, centered,
; keeping its current size. Assumes exactly two monitors.
#3::MoveToSecondMonitor()

MoveToSecondMonitor() {
    if MonitorGetCount() < 2 {
        ToolTip("Only one monitor detected.")
        SetTimer(() => ToolTip(), -1500)
        return
    }
    primary := MonitorGetPrimary()
    target := (primary = 1) ? 2 : 1
    MonitorGetWorkArea(target, &tL, &tT, &tR, &tB)
    WinGetPos(&wx, &wy, &ww, &wh, "A")
    newX := tL + ((tR - tL) - ww) // 2
    newY := tT + ((tB - tT) - wh) // 2
    WinMove(newX, newY, ww, wh, "A")
}
