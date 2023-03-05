SetWorkingDir %A_ScriptDir%
;----------------GUI STARTUP----------------
global textcol := "cred"
Gui, Font, s10 bold
Gui, Color,black
;----------------CREATING THE GUI----------------
loop 9{
	iniRead,timer,data.ini,timers,timer%A_Index%
	IniRead,toggle,data.ini,toggles,toggle%A_Index%
	IniRead,key,data.ini,keys,key%A_Index%
	if (toggle){
		toggle := "Checked"
	}
	Gui, Add, Checkbox, x15 yp+34 %textcol% %toggle% vtoggle%A_Index%,Hotbar slot %A_Index%
	Gui, Add,Edit,number xp+120 yp-5 w100 vtimer%A_Index% ,%timer%
	Gui, Add,Edit,limit1 xp+120 yp w30 vkey%A_Index% ,%key%
	toggle%A_Index%timer := 0
}
Gui, Font, s11
Gui, Add,Text,y8 x145 cblue,Delays (ms)     Hotkeys
Gui, Add,Text,y300 x15 cwhite,START : F1     STOP : F2     PAUSE : F3
Gui, Show,,Hotbar Automator
;----------------MACRO HOTKEYS----------------
F2::
savedata()
reload
return
F3::Pause
return
GuiClose:
savedata()
ExitApp
F1::
savedata()
;----------------HOTKEY TIMERS----------------
loop{
	sleep 5
	loop 9{
		GuiControlGet,toggle%A_Index%
		GuiControlGet,timer%A_Index%
		GuiControlGet,key%A_Index%
		toggle := toggle%A_Index%
		timer := timer%A_Index%
		key := key%A_Index%
		if (toggle && A_TickCount - toggle%A_Index%timer > timer){
			toggle%A_Index%timer := A_TickCount
			Send %key%
		}
	}
}
;----------------FUNCTION FOR SAVING THE SETTINGS----------------
savedata(){
	loop 9{
		GuiControlGet,toggle%A_Index%
		GuiControlGet,timer%A_Index%
		GuiControlGet,key%A_Index%
		toggle := toggle%A_Index%
		timer := timer%A_Index%
		key := key%A_Index%
		IniWrite,%toggle%,data.ini,toggles,toggle%A_Index%
		IniWrite,%timer%,data.ini,timers,timer%A_Index%
		IniWrite,%key%,data.ini,keys,key%A_Index%
	}
}