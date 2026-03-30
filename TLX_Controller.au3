#include <GuiEdit.au3>

Const $hotkeyTerminate      = "+{ESC}"  ; Shift + Escape
Const $hotkeyNextImage      = "{RIGHT}" ; Right arrow
Const $hotkeyPrevImage      = "{LEFT}"  ; Left arrow
Const $hotkeyPicSelected    = "{DOWN}"  ; Down arrow
Const $hotkeyPicNotSelected = "{UP}"    ; Up arrow
Const $hotkeyShiftLeft      = "{PGUP}"  ; Page Up
Const $hotkeyShiftRight     = "{PGDN}"  ; Page Down

Const $shiftIncrementLarge  = 100 ; How much is a Large horizontal shift?
Const $shiftIncrementMedium =  50 ; How much is a Medium horizontal shift?
Const $shiftIncrementSmall  =  10 ; How much is a Small horizontal shift?

Const $titleTLX = "TLXClientDemo"

Const $idPrevButton = 1007
Const $idNextButton = 1006

Const $idPicNotSelectedRadio = 1060
Const $idPicSelectedRadio    = 1061
Const $idPicHiddenRadio      = 1062

Const $titleFraming = "Framing Adjustment"
Const $idFramingButton = 1064
Const $idFramingLeftEdit = 1069
Const $idFramingApplyButton = 1008
Const $idFramingOkButton = 1

; Adds $shiftIncrement to the current value of $idFramingLeftEdit.
Func shiftHorizontally($shiftIncrement)
   $currentValue = Number(ControlGetText($titleFraming, "", $idFramingLeftEdit))
   ControlSetText($titleFraming, "", $idFramingLeftEdit, String($currentValue + $shiftIncrement))
   ControlClick($titleFraming, "", $idFramingApplyButton, "primary")
EndFunc

HotKeySet($hotkeyTerminate, "Terminate") ; Press this key to terminate the controller.
Func Terminate()
    Exit
EndFunc

; Previous / Next image
; Left arrow: Previous
; Right arrow: Next
HotKeySet($hotkeyNextImage, "NextImage")
Func NextImage()
   ControlClick ($titleTLX, "", $idNextButton, "primary")
   closeFramingWindow()
   openFramingWindow()
EndFunc

HotKeySet($hotkeyPrevImage, "PrevImage")
Func PrevImage()
   ControlClick ($titleTLX, "", $idPrevButton, "primary")
   closeFramingWindow()
   openFramingWindow()
EndFunc

; Picture selection HotKeys
; Up arrow:   Selected
; Down arrow: Not selected
HotKeySet($hotkeyPicSelected, "PicSelected")
Func PicSelected()
   ControlClick($titleTLX, "", $idPicSelectedRadio, "primary")
EndFunc

HotKeySet($hotkeyPicNotSelected, "PicNotSelected")
Func PicNotSelected()
   ControlClick($titleTLX, "", $idPicNotSelectedRadio, "primary")
EndFunc

; Framing adjustment HotKeys.
; Left  : Page Up
; Right : Page Down
HotKeySet($hotkeyShiftLeft, "ShiftLeftLarge")
Func ShiftLeftLarge()
   shiftHorizontally($shiftIncrementLarge * -1)
EndFunc
HotKeySet("+" & $hotkeyShiftLeft, "ShiftLeftMedium")
Func ShiftLeftMedium()
   shiftHorizontally($shiftIncrementMedium * -1)
EndFunc
HotKeySet("^" & $hotkeyShiftLeft, "ShiftLeftSmall")
Func ShiftLeftSmall()
   shiftHorizontally($shiftIncrementSmall * -1)
EndFunc

HotKeySet($hotkeyShiftRight, "ShiftRightLarge")
Func ShiftRightLarge()
   shiftHorizontally($shiftIncrementLarge)
EndFunc
HotKeySet("+" & $hotkeyShiftRight, "ShiftRightMedium")
Func ShiftRightMedium()
   shiftHorizontally($shiftIncrementMedium)
EndFunc
HotKeySet("^" & $hotkeyShiftRight, "ShiftRightSmall")
Func ShiftRightSmall()
   shiftHorizontally($shiftIncrementSmall)
EndFunc

Func openFramingWindow()
   If Not WinExists($titleFraming) Then
	  ; Make TLX window active.
	  WinActivate($titleTLX)
	  ; Open the Framing Adjustment window.
	  ControlClick($titleTLX, "", $idFramingButton, "primary")
   Else
	  WinActivate($titleFraming)
   EndIf

   WinWaitActive($titleFraming)

   ; Move the Framing Adjustment window into the upper left corner.
   WinMove($titleFraming, "", 0, 0)
EndFunc

Func closeFramingWindow()
   If Not WinExists($titleFraming) Then
	  Return
   EndIf
   WinActivate($titleFraming)
   ControlClick($titleFraming, "OK", $idFramingOkButton, "primary")
EndFunc

openFramingWindow()

; main() where all the action happens until termination HotKey is pressed.
While 1
   Sleep(50)
WEnd
