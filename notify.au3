#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=notify.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include "StringSize.au3"

Opt("TrayIconHide", 1)

$nproc = ProcessList(@ScriptName)
$initnproc= $nproc[0][0]
If $initnproc > 1 Then
	While $nproc[0][0] >= $initnproc
		Sleep(1000)
		$nproc = ProcessList(@ScriptName)
	WEnd
	Sleep(2000)
EndIf

HotKeySet("{ESC}", "OntSnap")

$TitleText = "Notify 0.1.0"
$LabelText = '\nnotify.exe "title" "text" "timeout" "clickcommand" "closecommand" "timeoutcommand" "maxwidth"\n\n'
$LabelText = $LabelText & "    title - Title of your notification\n"
$LabelText = $LabelText & "    text- Text of your notification\n"
$LabelText = $LabelText & "    timeout [60]- timeout in seconds\n"
$LabelText = $LabelText & "    clickcommand [""]- launched when clicked\n"
$LabelText = $LabelText & "    closecommand [""]- launched when closed\n"
$LabelText = $LabelText & "    timeoutcommand [""]- launched when timeout\n"
$LabelText = $LabelText & "    minwidth [200]- minimum notification width in pixels\n"
$LabelText = $LabelText & "    maxwidth [600]- maximum notification width in pixels\n"
$LabelText = $LabelText & "____________________________________________________________________________________\n\n"
$LabelText = $LabelText & "  * Only 'title' and 'text' are required.\n"
$LabelText = $LabelText & "  * You should use double quotation marks for each parameter.\n"
$LabelText = $LabelText & "  * You can use '\ n' (without space) to insert a new line inside 'text'.\n"
$LabelText = $LabelText & "  * Width and height are calculated automatically.\n"
$LabelText = $LabelText & "  * If any word is longer than maxwidth, notify returns with error 1 (be careful with URLs).\n"
$LabelText = $LabelText & "  * Every command is lauched with hidden window.\n"
$LabelText = $LabelText & "  * If you want to show the window, launch command with 'cmd /c ""command""'.\n"
$LabelText = $LabelText & "  * The icon can be changed modifing 'notify.jpg'.\n"
$LabelText = $LabelText & "  * See the examples for use cases.\n\n"
$LabelText = $LabelText & "  Thanks to Melba23 for StringSize and to Jonathan Bennett and the AutoIt Team\n"
$timeout = 60
$ClickCommand = ""
$CloseCommand = ""
$TimeoutCommand = ""
$minwidth = 200
$maxwidth = 600

If $CmdLine[0] >= 2 Then
	$TitleText = $CmdLine[1]
	$LabelText = $CmdLine[2]
	If $CmdLine[0] >= 3 Then
		$timeout = Int($CmdLine[3])
	EndIf
	If $CmdLine[0] >= 4 Then
		$ClickCommand = $CmdLine[4]
	EndIf
	If $CmdLine[0] >= 5 Then
		$CloseCommand = $CmdLine[5]
	EndIf
	If $CmdLine[0] >= 6 Then
		$TimeoutCommand = $CmdLine[6]
	EndIf
	If $CmdLine[0] >= 7 Then
		$minwidth = Int($CmdLine[7])
	EndIf
	If $CmdLine[0] >= 8 Then
		$maxwidth = Int($CmdLine[8])
	EndIf
EndIf

$LabelText = StringRegExpReplace($LabelText, "\\n", @CRLF)
$labelWidth = $minwidth - 10
$aSize = _StringSize($LabelText, Default, Default, Default, "Tahoma", $labelWidth)
While ($labelWidth <= ($maxwidth - 10)) and ($aSize == 0)
	$labelWidth = $labelWidth + 20
	$aSize = _StringSize($LabelText, Default, Default, Default, "Tahoma", $labelWidth)
WEnd
If $aSize = 0 Then
	;MsgBox(1, "Error", @error)
	Exit 1
EndIf

$LabelText = $aSize[0]
$width = $labelWidth + 10
$left = @DesktopWidth - $width - 10
$height = $aSize[3] + 30
$top = @DesktopHeight - $height - 40

$Gui = GUICreate("tooltip", $width, $height, $left, $top, BitOR($WS_POPUP, $WS_BORDER), $WS_EX_TOPMOST)
GUISetBkColor(0xFFFFE1)
$Icon = GUICtrlCreatePic("notify.jpg", 2, 2, 26, 26, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
GUICtrlSetState(-1, $GUI_DISABLE)
$Close = GUICtrlCreateLabel("ý", $width - 14, 0, 12, 12)
GUICtrlSetFont($Close, 10, Default, Default, "Wingdings")
$Title = GUICtrlCreateLabel("  " & $TitleText & "                                                                                                             ", 28, 7, $width - 20, 15)
GUICtrlSetFont($Title, 10, 600, 4, "Tahoma")
$Close2 = GUICtrlCreateLabel("ý", $width - 14, 0, 12, 12)
GUICtrlSetFont($Close2, 10, Default, Default, "Wingdings")

$Label = GUICtrlCreateLabel($LabelText, 5, 30, $width - 10, $height - 30)
GUICtrlSetFont($Label, Default, Default, Default, "Tahoma")

$active = WinGetHandle("[ACTIVE]")
GUISetState()
WinActivate($active)

$started_at = TimerInit()
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit 0
		Case $Close
			Run($CloseCommand, "", @SW_HIDE)
			Exit 0
		Case $Label
			Run($ClickCommand, "", @SW_HIDE)
			Exit 0
	EndSwitch
	If (($timeout * 1000) < TimerDiff($started_at)) Then
		Run($TimeoutCommand, "", @SW_HIDE)
		Exit 0
	EndIf
	Sleep(100)
WEnd

Func OntSnap()
	GUIDelete()
	Exit 0
EndFunc   ;==>OntSnap