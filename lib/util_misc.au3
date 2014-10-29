;; I modified this function to ignore @ + & ~ % at the start of the array function
;; It is handy when you need to find a member by name, and not rank+name
;; I'll make this proper later.

Func __ArraySearch(Const ByRef $avArray, $vWhat2Find, $iStart = 0, $iEnd = 0, $iCaseSense = 0, $fPartialSearch = False)
	Local $iCurrentPos, $iUBound, $iResult
	If Not IsArray($avArray) Then
		SetError(1)
		Return -1
	EndIf
	$iUBound = UBound($avArray) - 1
	If $iEnd = 0 Then $iEnd = $iUBound
	If $iStart > $iUBound Then
		SetError(2)
		Return -1
	EndIf
	If $iEnd > $iUBound Then
		SetError(3)
		Return -1
	EndIf
	If $iStart > $iEnd Then
		SetError(4)
		Return -1
	EndIf
	If Not ($iCaseSense = 0 Or $iCaseSense = 1) Then
		SetError(5)
		Return -1
	EndIf
	For $iCurrentPos = $iStart To $iEnd
		Select
			Case $iCaseSense = 0
				If $fPartialSearch = False Then
					If ($avArray[$iCurrentPos] = $vWhat2Find) Or ($avArray[$iCurrentPos] = "@" & $vWhat2Find) Or ($avArray[$iCurrentPos] = "+" & $vWhat2Find) Or ($avArray[$iCurrentPos] = "&" & $vWhat2Find) Or ($avArray[$iCurrentPos] = "~" & $vWhat2Find) Or ($avArray[$iCurrentPos] = "%" & $vWhat2Find) Then
						SetError(0)
						Return $iCurrentPos
					EndIf
				Else
					$iResult = StringInStr($avArray[$iCurrentPos], $vWhat2Find, $iCaseSense)
					If $iResult > 0 Then
						SetError(0)
						Return $iCurrentPos
					EndIf
				EndIf
			Case $iCaseSense = 1
				If $fPartialSearch = False Then
					If $avArray[$iCurrentPos] == $vWhat2Find Then
						SetError(0)
						Return $iCurrentPos
					EndIf
				Else
					$iResult = StringInStr($avArray[$iCurrentPos], $vWhat2Find, $iCaseSense)
					If $iResult > 0 Then
						SetError(0)
						Return $iCurrentPos
					EndIf
				EndIf
		EndSelect
	Next
	SetError(6)
	Return -1
EndFunc   ;==>__ArraySearch