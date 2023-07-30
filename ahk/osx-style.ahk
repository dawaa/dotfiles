GroupAdd, DevWindows, ahk_exe WindowsTerminal.exe
GroupAdd, DevWindows, ahk_exe ApplicationFrameHost.exe

!h::Send {Left}
!j::Send {Down}
!k::Send {Up}
!l::Send {Right}

#IfWinActive ahk_group DevWindows
<^>!+8::Send {{}
<^>!+9::Send {}}
Capslock::Esc
#IfWinActive
