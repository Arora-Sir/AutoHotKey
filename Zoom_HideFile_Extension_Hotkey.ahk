;Alt+F4
$!F4:: CLoseZoomIfNotInMeeting()
;Alt+Ctr+F4
$!^F4:: CLoseZoomIfInMeeting()

$!^E:: f_ToggleFileExt()
$!^H:: HideFiles()



;text box created see in f_ToggleFileExt
text(a,t:="",x:="",y:="") {
	c:=d:=e:=0, strReplace(a,"`n",,b), g:=strSplit(a,"`n","`r")[1], strReplace(g," ",,h)
	While !(f="" && a_index<>1) {
	f := subStr(g,a_index,1)
	(regExMatch(f, "[a-z]") ? c++ : f="@" ? e++ : d++)
	} SplashTextOn, % 150 + c*6.5 + d*12 + e*13 - h*8, % 30 + b*20, Yipiee..., % a
	If (x<>"" || y<>"")
	WinMove, Yipiee...,, x, y
	If (t<>"") {
	Sleep, t*1000
	WinClose, Yipiee...
}}


CLoseZoomIfNotInMeeting()
{
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
}

CLoseZoomIfInMeeting()
{
	if WinActive("ahk_exe Zoom.exe")
		{
		Run cmd.exe /c taskkill /F /IM zoom.exe,, hide
		}
	else
		{
		send !^{F4}
		}
	return
}

HideFiles()
	{	
		RegRead, ValorHidden, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
		if ValorHidden = 2
		{
			
			RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
			f_RefreshExplorer()
			text("Show Files",1)
			RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
			f_RefreshExplorer()
			
		} 
		else
		{
			
			RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
			f_RefreshExplorer()
			text("Hide Files",1)
			RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
			f_RefreshExplorer()
			
		}
		return 
	}
	
f_ToggleFileExt()
	{
		Global lang_ToggleFileExt, lang_ShowFileExt, lang_HideFileExt
		RootKey = HKEY_CURRENT_USER
		SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
		RegRead, HideFileExt    , % RootKey, % SubKey, HideFileExt
		if HideFileExt = 1
		{
		  ;MsgBox, Show Extentions
		  ;IfMsgBox Yes
			  ;{
				  RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 0
				  f_RefreshExplorer()
				  text("Show Extentions",1)
				  RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 0
				  f_RefreshExplorer()
			  ;}
		}
		else
		{
		  ;MsgBox, Hide Extentions
		  ;MsgBox, 4131,, Hide Extentions
		  ;IfMsgBox Yes
			  ;{
				  RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 1
				  f_RefreshExplorer()
				  text("Hide Extentions",1)
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