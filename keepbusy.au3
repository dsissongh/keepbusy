#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\..\Icons\Orbz death.ico
#AutoIt3Wrapper_outfile=Keep Busy.exe
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Keep Busy
#AutoIt3Wrapper_Res_Description=by dsisson
#AutoIt3Wrapper_Res_Fileversion=1.2
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
$s_version = "v1.2"
#cs
12-2010		dsisson	v1.2
	-Added additional icon for moving the mouse
	-Changed all icons
	-Set traymenumode so script doesnt pause
#ce

Opt("TrayMenuMode",1)
HotKeySet("^q", "_Exit")
TraySetToolTip("Keep Busy " & $s_version & " [ctrl-q to quit]")
Dim $a_lastmouseposition ; timer functions
Dim $a_newmouseposition ; timer functions
Dim $i_inactivecounter ; timer functions
Dim $i_inactivecounternumber = 0
Dim $b_automove = False

;Setup the timer and watch for inactivity
$i_inactivecounter = TimerInit()
$a_lastmouseposition = MouseGetPos()

FileInstall("..\..\..\..\Icons\greenlight.ico", @TempDir & "\kbonline.ico", 1)
FileInstall("..\..\..\..\Icons\redlight.ico", @TempDir & "\kbaway.ico", 1)
FileInstall("..\..\..\..\Icons\yellowlight.ico", @TempDir & "\kbmove.ico", 1)

TraySetIcon(@TempDir & "\kbonline.ico")
While 1

	Sleep(1000)


	;Inactivity section
	$a_newmouseposition = MouseGetPos()
	If ($a_lastmouseposition[0] = $a_newmouseposition[0]) Then
		$i_inactivecounter += 1
		$i_inactivecounternumber += 1
		ConsoleWrite($i_inactivecounter & @CRLF)
		ConsoleWrite(TimerDiff($i_inactivecounter)/1500 & @CRLF)
		TraySetIcon(@TempDir & "\kbaway.ico")
		if($i_inactivecounternumber > 10) Then
			TraySetIcon(@TempDir & "\kbmove.ico")
			MouseMove(Random(0,800),Random(0,800),15)
			$a_newmouseposition = MouseGetPos()
			$b_automove = True
			TraySetIcon(@TempDir & "\kbaway.ico")
		EndIf
	Else
		$a_lastmouseposition = $a_newmouseposition
		$i_inactivecounter = TimerInit()
		$i_inactivecounternumber = 0
		if Not($b_automove) Then
			TraySetIcon(@TempDir & "\kbonline.ico")
		Else
			TraySetIcon(@TempDir & "\kbaway.ico")
			$b_automove = False
		EndIf
	EndIf
WEnd

Func _Exit()
	Exit
EndFunc