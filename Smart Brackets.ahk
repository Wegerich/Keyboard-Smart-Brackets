SetTitleMatchMode, 2
GroupAdd, WinTest, Modmail
GroupAdd, WinTest, Discord


~RControl Up::
~LControl Up::
	Tooltip %A_PriorKey%
	If ( A_TimeSincePriorKey < 1300 and InStr(A_PriorKey,"Control") )
		   ;SendRaw, % InStr(A_ThisHotkey,"LShift") ? "(" : ")" 
	Tooltip %A_PriorKey%
	Sleep 1000
	Tooltip
Return

~RShift::
~LShift::
	;Configuration
	AcceptableMouseMovementPixels := 30 ;Normally around 70. Set to 10000 to disable mouse checking. Can be set very low because mouse should barely move while typing.
	LongestAcceptableShiftTapTime := 1500 ;Normally around 1500. Set to 10000 to type bracket no matter how long shift is held
	
	
	;Mouse clicks are ignored by A_PriorKey when shift is pressed
	;Therefore an alternative method must be used to detect shift-click select as no "keys" are pressed
	;This will be done by checking mouse position before and after {Shift Up} to see if something might be highlighted
	;Tooltip %A_PriorKey%
	MouseGetPos, startingXpos, startingYpos 
	KeyWait Shift
	;Tooltip "Shift Released"
	;Sleep 100
	MouseGetPos, endingXpos, endingYpos 
	xPosChange := Abs(startingXpos - endingXpos)
	yPosChange := Abs(startingYpos - endingYpos)
	MousePosChangeOverall := xPosChange + yPosChange
	;Tooltip %MousePosChangeOverall%
	;Sleep 100	
	

	
	If ( A_TimeSincePriorHotkey < LongestAcceptableShiftTapTime and InStr(A_PriorKey,"Shift") and MousePosChangeOverall < AcceptableMouseMovementPixels  )
		   SendRaw, % InStr(A_ThisHotkey,"LShift") ? "(" : ")" 
	
Return	
	;Debugging
	ShiftWasLastKey := InStr(A_PriorKey,"Shift")
	IsTapTimeAcceptable := A_TimeSincePriorHotkey < LongestAcceptableShiftTapTime
	IsMouseMoveAcceptable := MousePosChangeOverall < AcceptableMouseMovementPixels
	Tooltip,
	(LTrim 
		"Taptime" %IsTapTimeAcceptable% 
		"Shiftpressed" %ShiftWasLastKey% 
		"Prior" %A_PriorKey% & %A_TimeSincePriorHotkey%
		"Mouse" %IsMouseMoveAcceptable% 
	)
	Sleep 1500	
	Tooltip
Return

#IfWinActive
^+2::
{	
	AutoTrim, off
	SavedClipboard = %Clipboard%
	Clipboard = 
	Sleep, 10
	;MsgBox, After clipboard clear: -%clipboard%-
	Send, ^x
	Clipwait, 0.1
	;MsgBox, "After first clipwait" -%Clipboard%-
	
	;Simplified version
	;SendRaw, ""
	;Send, {Left}
	;MsgBox, Before paste: -%clipboard%-
	;Send, ^v
	;Sleep, 100
	;Clipboard = %SavedClipboard%
	;Return

	if (!ErrorLevel)    ; if NOT ErrorLevel clipwait found data on the clipboard
		{
		;Check if two spaces are left behind
		WorkString = %clipboard%
		clipboard = 
		Sleep, 10
		;MsgBox, After clipboard clear: %clipboard%
		Send, {Right}
		Send, {Shift Down}{Left}{Left}{Shift Up}
		Send, ^x
		Clipwait, 0.1
		TwoCharString = %clipboard%
		;MsgBox, Two Char String -%TwoCharString%-
		Send, ^v 
		Sleep, 10
		Send, {Left}
		clipboard:=WorkString
		Sleep, 10
		;If two spaces aren't left then the WorkString probably has them. Move cursor after quotation mark placement accordingly

		;If the two char string that was either side of the Workstring is not spaces, detect and fix appropriately
		If (TwoCharString<>"  ")
			{
			StringRight, WorkStringEnd, Workstring, 1	
			If (WorkStringEnd=" ")
				{
				;MsgBox, Space at end of -%WorkString%-
				SendRaw, "
				Send, ^v
				Sleep, 10
				Send, {Left}
				SendRaw, "
				clipboard = %SavedClipboard%
				Return
				}
			StringLeft, WorkStringStart, Workstring, 1
			If  (WorkStringStart=" ")
				{
				AutoTrim, on ;Easiest to remove space and readd manually
				clipboard= %clipboard%
				AutoTrim, off
				Sleep, 10
				;Msgbox, Space at start of -%WorkString%-
				Send, {Space}
				SendRaw, ""
				Send, {Left}^v
				Sleep, 10
				clipboard = %SavedClipboard%
				Return
				}
			}
		}
	;Else
	;	{
	;	MsgBox, No text selected
	;	}
		
	;Msgbox, No spaces in -%clipboard%-
	Sendraw, ""
	Send, {Left}
	Send, ^v
	Sleep, 500
	clipboard = %SavedClipboard%
	Return
}
^+9::
{
	AutoTrim, off
	SavedClipboard = %Clipboard%
	Clipboard = 
	Sleep, 10
	;MsgBox, After clipboard clear: -%clipboard%-
	Send, ^x
	Clipwait, 0.5
	;MsgBox, "After first clipwait" -%Clipboard%-
	
	;Simplified version
	;SendRaw, ""
	;Send, {Left}
	;MsgBox, Before paste: -%clipboard%-
	;Send, ^v
	;Sleep, 100
	;Clipboard = %SavedClipboard%
	;Return

	if (!ErrorLevel)    ; if NOT ErrorLevel clipwait found data on the clipboard
		{
		;Check if two spaces are left behind
		WorkString = %clipboard%
		clipboard = 
		Sleep, 10
		;MsgBox, After clipboard clear: %clipboard%
		Send, {Right}
		Send, {Shift Down}{Left}{Left}{Shift Up}
		Send, ^x
		Clipwait, 0.5
		TwoCharString = %clipboard%
		;MsgBox, Two Char String -%TwoCharString%-
		Send, ^v 
		Sleep, 100
		Send, {Left}
		clipboard:=WorkString
		Sleep, 100
		;If two spaces aren't left then the WorkString probably has them. Move cursor after quotation mark placement accordingly

		;If the two char string that was either side of the Workstring is not spaces, detect and fix appropriately
		If (TwoCharString<>"  ")
			{
			StringRight, WorkStringEnd, Workstring, 1	
			If (WorkStringEnd=" ")
				{
				;MsgBox, Space at end of -%WorkString%-
				SendRaw, (
				Send, ^v
				Sleep, 90
				Send, {Left}
				SendRaw, )
				clipboard = %SavedClipboard%
				Return
				}
			StringLeft, WorkStringStart, Workstring, 1
			If  (WorkStringStart=" ")
				{
				AutoTrim, on ;Easiest to remove space and readd manually
				clipboard= %clipboard%
				AutoTrim, off
				Sleep, 100
				;Msgbox, Space at start of -%WorkString%-
				Send, {Space}
				SendRaw, ()
				Send, {Left}^v
				Sleep, 100
				clipboard = %SavedClipboard%
				Return
				}
			
			}
		}
		
	;Msgbox, No spaces in -%clipboard%-
	Sendraw, ()
	Send, {Left}
	Send, ^v
	Sleep, 100
	clipboard = %SavedClipboard%
	Return
}
^[::
	{
	AutoTrim, off
	SavedClipboard = %Clipboard%
	Clipboard = 
	Sleep, 10
	;MsgBox, After clipboard clear: -%clipboard%-
	Send, ^x
	Clipwait, 0.5
	;MsgBox, "After first clipwait" -%Clipboard%-
	
	;Simplified version
	;SendRaw, ""
	;Send, {Left}
	;MsgBox, Before paste: -%clipboard%-
	;Send, ^v
	;Sleep, 100
	;Clipboard = %SavedClipboard%
	;Return
	
	if (!ErrorLevel)    ; if NOT ErrorLevel clipwait found data on the clipboard
		{
		;Check if two spaces are left behind
		WorkString = %clipboard%
		clipboard = 
		Sleep, 10
		;MsgBox, After clipboard clear: %clipboard%
		Send, {Right}
		Send, {Shift Down}{Left}{Left}{Shift Up}
		Send, ^x
		Clipwait, 0.5
		TwoCharString = %clipboard%
		;MsgBox, Two Char String -%TwoCharString%-
		Send, ^v 
		Sleep, 10
		Send, {Left}
		clipboard:=WorkString
		Sleep, 10
		;If two spaces aren't left then the WorkString probably has them. Move cursor after quotation mark placement accordingly

		;If the two char string that was either side of the Workstring is not spaces, detect and fix appropriately
		If (TwoCharString<>"  ")
			{
			StringRight, WorkStringEnd, Workstring, 1	
			If (WorkStringEnd=" ")
				{
				;MsgBox, Space at end of -%WorkString%-
				SendRaw, [
				Send, ^v
				Sleep, 10
				Send, {Left}
				SendRaw, ]
				clipboard = %SavedClipboard%
				Return
				}
			StringLeft, WorkStringStart, Workstring, 1
			If  (WorkStringStart=" ")
				{
				AutoTrim, on ;Easiest to remove space and readd manually
				clipboard= %clipboard%
				AutoTrim, off
				Sleep, 10
				;Msgbox, Space at start of -%WorkString%-
				Send, {Space}
				SendRaw, []
				Send, {Left}^v
				Sleep, 10
				clipboard = %SavedClipboard%
				Return
				}
			}
		}
		
	;Msgbox, No spaces in -%clipboard%-
	Sendraw, []
	Send, {Left}
	Send, ^v
	Sleep, 100
	clipboard = %SavedClipboard%
	Return
}


#IfWinActive, ahk_group WinTest
;Italics in discord
^i::
{
    ;MsgBox, triggered
	SavedClipboard = Clipboard

	;MsgBox one is active
	clipboard =
	Tooltip Italics
	Sleep, 10
	Send, ^x
	Clipwait, 0.1
	If (ErrorLevel) 
	{
		;MsgBox, nothing selected
		Send, {NumpadMult}{NumpadMult}
		Send, {Left}
		Tooltip
		Return
	}
	

	AutoTrim, off
	WorkString = %clipboard%
	Sleep, 10
	StringLeft, WorkStringStart, WorkString, 1
	StringRight, WorkStringEnd, WorkString, 1
	varPrefix = *
	varSuffix = *
	;MsgBox, -%WorkString%- start -%WorkStringStart%- end -%WorkStringEnd%-
	
	If (WorkStringEnd=" ")
		{
		;MsgBox, string at end
		ClipLenMinus := StrLen(WorkString)-1
		StringLeft, WorkString, WorkString, ClipLenMinus
		varSuffix := "* "
		}
	
	If (WorkStringStart=" ")
		{
		;MsgBox, string at start
		ClipLenMinus := StrLen(WorkString)-1
		StringRight, WorkString, WorkString, ClipLenMinus
		varPrefix := " *"
		}
	Sleep, 10
	clipboard = %varPrefix%%WorkString%%varSuffix%
	;MsgBox, -%varPrefix%-%WorkString%-%varSuffix%-
	Sleep, 10
	;MsgBox, pasting %clipboard%
	Send, ^v
	AutoTrim, on
	

	Sleep 20
	Tooltip
	Clipboard = SavedClipboard
Return
}

;Bold in discord
^b::
{
    ;MsgBox, triggered
	SavedClipboard = Clipboard
	
	Tooltip Italics

	;MsgBox one is active
	clipboard =
	Sleep, 10
	Send, ^x
	Clipwait, 0.5
	If (ErrorLevel) 
	{
		;MsgBox, nothing selected
		Send, {**}{Left}
		Return
	}
	Tooltip

	AutoTrim, off
	WorkString = %clipboard%
	Sleep, 10
	StringLeft, WorkStringStart, WorkString, 1
	StringRight, WorkStringEnd, WorkString, 1
	varPrefix = **
	varSuffix = **
	;MsgBox, -%WorkString%- start -%WorkStringStart%- end -%WorkStringEnd%-
	
	If (WorkStringEnd=" ")
		{
		;MsgBox, string at end
		ClipLenMinus := StrLen(WorkString)-1
		StringLeft, WorkString, WorkString, ClipLenMinus
		varSuffix := "** "
		}
	
	If (WorkStringStart=" ")
		{
		;MsgBox, string at start
		ClipLenMinus := StrLen(WorkString)-1
		StringRight, WorkString, WorkString, ClipLenMinus
		varPrefix := " **"
		}
	Sleep, 10
	clipboard = %varPrefix%%WorkString%%varSuffix%
	;MsgBox, -%varPrefix%-%WorkString%-%varSuffix%-
	Sleep, 10
	;MsgBox, pasting %clipboard%
	Send, ^v
	AutoTrim, on
	

	Sleep 100
	Tooltip
	Clipboard = SavedClipboard
Return
}
