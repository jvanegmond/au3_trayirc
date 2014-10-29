;===============================================================================
;
; Description:      Unicode support for TrayIRC
; Requirement(s):   Unicode version of AutoIt
; Return Value(s):  Encoded/Decoded String(s)
; Author(s):        Dhilip89
;
;===============================================================================

Func _Uni2Ansi($Unicode)
	$Binary = StringToBinary($Unicode, 4)
	$Hex = StringReplace($Binary, '0x', '', 1)
	$BinaryLength = StringLen($Hex)
	Local $ANSI
	For $i = 1 To $BinaryLength Step 2
		$Char = StringMid($Hex, $i, 2)
		$ANSI &= BinaryToString('0x' & $Char)
	Next
	Return $ANSI
EndFunc   ;==>_Uni2Ansi

Func _Ansi2Uni($ANSI)
	$Binary = StringToBinary($ANSI)
	$Unicode = BinaryToString($Binary, 4)
	Return $Unicode
EndFunc   ;==>_Ansi2Uni

;===============================================================================

;===============================================================================
;
; Function Name:    _HTMLEntityNumEncode()
; Description:      Encode the normal string into HTML Entity Number
; Parameter(s):     $String  - The string you want to encode.
;
; Requirement(s):   AutoIt v3.2.4.9 or higher (Unicode)
; Return Value(s):  On Success  - Returns HTML Entity Number
;                   On Failure  - Nothing
;
; Author(s):        Dhilip89
;
;===============================================================================

Func _HTMLEntityNumEncode($String)
	$StringLength = StringLen($String)
	Local $HTMLEntityNum
	If $StringLength = 0 Then Return ''
	For $i = 1 To $StringLength
		$StringChar = StringMid($String, $i, 1)
		$HTMLEntityNum &= '&#' & AscW($StringChar) & ';'
	Next
	Return $HTMLEntityNum
EndFunc   ;==>_HTMLEntityNumEncode

;===============================================================================
;
; Function Name:    _HTMLEntityNumDecode()
; Description:      Decode the HTML Entity Number into normal string
; Parameter(s):     $HTMLEntityNum  - The HTML Entity Number you want to decode.
;
; Requirement(s):   AutoIt v3.2.4.9 or higher (Unicode)
; Return Value(s):  On Success  - Returns decoded strings
;                   On Failure  - Nothing
;
; Author(s):        Dhilip89
;
;===============================================================================

Func _HTMLEntityNumDecode($HTMLEntityNum)
	If $HTMLEntityNum = '' Then Return ''
	$A = StringReplace($HTMLEntityNum, '&#', '')
	$B = StringSplit($A, ';')
	$C = $B[0]
	Local $String
	For $i = 1 To $C
		$String &= ChrW($B[$i])
	Next
	Return $String
EndFunc   ;==>_HTMLEntityNumDecode