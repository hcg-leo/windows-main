#Requires AutoHotkey v2.0
#SingleInstance Force

; closes the active window.
#q::WinClose("A")

; toggles the active window between maximized and restored
#w:: {
    if WinGetMinMax("A") = 1
        WinRestore("A")
    else
        WinMaximize("A")
}

; toggles "always on top" for the active window
#f::WinSetAlwaysOnTop(-1, "A")

; snap the active window to the half of your main display
#1::SnapToMainHalf(0)

; snap the active window to the second half of your main display
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