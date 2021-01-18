$!^H::
f_ToggleFileExt()


f_ToggleFileExt()
{
Global lang_ToggleFileExt, lang_ShowFileExt, lang_HideFileExt
RootKey = HKEY_CURRENT_USER
SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
RegRead, HideFileExt    , % RootKey, % SubKey, HideFileExt
if HideFileExt = 1
{
  MsgBox, 4131,, Show File Extentions?
  IfMsgBox Yes
  {
  RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 0
  f_RefreshExplorer()
  }
}
else
{
  MsgBox, 4131,, Hide File Extentions?
  IfMsgBox Yes
  {
  RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 1
  f_RefreshExplorer()
  }
}
return
}

f_RefreshExplorer()
{
WinGet, id, ID, ahk_class Progman
SendMessage, 0x111, 0x1A220,,, ahk_id %id%
WinGet, id, List, ahk_class CabinetWClass
Loop, %id%
{
  id := id%A_Index%
   SendMessage, 0x111, 0x1A220,,, ahk_id %id%
}
WinGet, id, List, ahk_class ExploreWClass
Loop, %id%
{
  id := id%A_Index%
  SendMessage, 0x111, 0x1A220,,, ahk_id %id%
}
WinGet, id, List, ahk_class #32770
Loop, %id%
{
  id := id%A_Index%
  ControlGet, w_CtrID, Hwnd,, SHELLDLL_DefView1, ahk_id %id%
  if w_CtrID !=
  SendMessage, 0x111, 0x1A220,,, ahk_id %w_CtrID%
}
return
}