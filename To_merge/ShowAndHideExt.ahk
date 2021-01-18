$!^H::
f_ToggleFileExt()

;text box created
text(a,t:="",x:="",y:="") {
c:=d:=e:=0, strReplace(a,"`n",,b), g:=strSplit(a,"`n","`r")[1], strReplace(g," ",,h)
While !(f="" && a_index<>1) {
f := subStr(g,a_index,1)
(regExMatch(f, "[a-z]") ? c++ : f="@" ? e++ : d++)
} SplashTextOn, % 100 + c*6.5 + d*12 + e*13 - h*8, % 23 + b*20, ::*::, % a
If (x<>"" || y<>"")
WinMove, ::*::,, x, y
If (t<>"") {
Sleep, t*1000
WinClose, ::*::
}}

f_ToggleFileExt()
	{
		Global lang_ToggleFileExt, lang_ShowFileExt, lang_HideFileExt
		RootKey = HKEY_CURRENT_USER
		SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
		RegRead, HideFileExt    , % RootKey, % SubKey, HideFileExt
		if HideFileExt = 1
		{
		  ;MsgBox, Show Extentions
		  text("Show Extentions",1)
		  ;IfMsgBox Yes
			  ;{
				  RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 0
				  f_RefreshExplorer()
				  RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 0
				  f_RefreshExplorer()
			  ;}
		}
		if HideFileExt = 0
		{
		  text("Hide Extentions",1)
		  ;MsgBox, Hide Extentions
		  ;MsgBox, 4131,, Hide Extentions
		  ;IfMsgBox Yes
			  ;{
				  RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 1
				  f_RefreshExplorer()
				  RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 1
				  f_RefreshExplorer()
				  
			  ;}
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