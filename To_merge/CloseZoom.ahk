;Alt + F4 (will close zoom if it is the selected window except during a meeting)

$!F4::
if WinActive("ahk_exe Zoom.exe")
    {
    if WinExist("Zoom Meeting")
        {
        return
        }
    else
        {
        Run cmd.exe /c taskkill /F /IM zoom.exe,, hide
        }
    }
else
    {
     send !{F4}
    }
return

;Alt + Ctrl + F4 (will close zoom if it is the selected window)

$!^F4::
if WinActive("ahk_exe Zoom.exe")
    {
    Run cmd.exe /c taskkill /F /IM zoom.exe,, hide
    }
else
    {
    send !^{F4}
    }
return