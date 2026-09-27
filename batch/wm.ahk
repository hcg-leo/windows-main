#Requires AutoHotkey v2.0
#SingleInstance Force

; close the active window
#q::WinClose("A")

; maximize the active window
#w::WinMaximize("A")

; move active window to the second monitor
#1::MoveToMonitor(2)

; snap active window to left half of the main
#2::SnapHalf("Left")

; nap active window to right half of the main
#3::SnapHalf("Right")

; open powershell
#Enter::Run("powershell.exe", A_Desktop)

SnapHalf(side) {
    win := "A"
    if WinGetMinMax(win) = 1
        WinRestore(win)

    mon := MonitorGetPrimary()
    MonitorGetWorkArea(mon, &L, &T, &R, &B)

    halfW := (R - L) // 2
    h := B - T
    x := (side = "Left") ? L : L + halfW

    WinMove(x, T, halfW, h, win)
}

MoveToMonitor(idx) {
    win := "A"
    if (MonitorGetCount() < idx)
        return

    if WinGetMinMax(win) = 1
        WinRestore(win)

    MonitorGetWorkArea(idx, &L, &T, &R, &B)
    WinGetPos(&x, &y, &w, &h, win)

    newX := L + ((R - L) - w) // 2
    newY := T + ((B - T) - h) // 2

    WinMove(newX, newY, w, h, win)
}
