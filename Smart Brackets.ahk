SetTitleMatchMode, 2
GroupAdd, WinTest, Modmail
GroupAdd, WinTest, Discord

#IfWinActive
^+2::
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
				SendRaw, "
				Send, ^v
				Sleep, 90
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
				Sleep, 100
				;Msgbox, Space at start of -%WorkString%-
				Send, {Space}
				SendRaw, ""
				Send, {Left}^v
				Sleep, 100
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
	Sleep, 100
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
				SendRaw, [
				Send, ^v
				Sleep, 90
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
				Sleep, 100
				;Msgbox, Space at start of -%WorkString%-
				Send, {Space}
				SendRaw, []
				Send, {Left}^v
				Sleep, 100
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
	Sleep, 30
	Send, ^x
	Clipwait, 0.5
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
	Sleep, 50
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
	Sleep, 50
	;MsgBox, pasting %clipboard%
	Send, ^v
	AutoTrim, on
	

	Sleep 200
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
	Sleep, 50
	Send, ^x
	Clipwait, 0.5
	If (ErrorLevel) 
	{
		;MsgBox, nothing selected
		Send, {**}{Left}
		Return
	}
	

	AutoTrim, off
	WorkString = %clipboard%
	Sleep, 50
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
	Sleep, 50
	;MsgBox, pasting %clipboard%
	Send, ^v
	AutoTrim, on
	

	Sleep 200
	Tooltip
	Clipboard = SavedClipboard
Return
}