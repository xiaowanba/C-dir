#Region ;**** 编译指令由 AutoIt3Wrapper 选项编译窗口创建 ****
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=0.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#EndRegion ;**** 编译指令由 AutoIt3Wrapper 选项编译窗口创建 ****

#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

	欢迎使用 AutoIt v3 中文版 !

	IT天空:		https://www.itiankong.com/
	Au3专区:	https://www.itiankong.net/forum-au3-1.html

	Au3版本:	3.3.14.2
	脚本作者:
	脚本功能:
	更新日志:
	联系方式:

#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

#include <File.au3>
#include <Array.au3>
#include <Constants.au3>
#include <FileConstants.au3>
#include <WinAPI.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

Global $Color_a = 0x3baa24
Global $Color_b = 0x888888

Global $Input1

$Form1 = GUICreate("自动创建文件夹", 400, 500, -1, -1, $WS_TILEDWINDOW)
GUISetBkColor(0xFFFFFF, $Form1)

$Radio1 = GUICtrlCreateCheckbox("替换空白符", 30, 420, 150, 17)
$Radio2 = GUICtrlCreateCheckbox("自动加入编号[自动补0]", 30, 420+22,150, 17)
$Radio3 = GUICtrlCreateCheckbox("预览文件夹", 30, 420+22*2, 150, 17)





$tBT_Add = GUICtrlCreateLabel("创建", 240, 410, 150, 80, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlSetBkColor(-1, $Color_a)
GUICtrlSetFont(-1, 11.5, 0, 0, "微软雅黑", 2 + 5)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetCursor(-1, 0)

$Input1 = GUICtrlCreateEdit("", 0, 0, 400, 400,  BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN,$WS_VSCROLL), 0)
GUICtrlSetBkColor(-1, 0xf2f2f2)
GUICtrlSetColor(-1, 0x666666)
GUISetState(@SW_SHOW)
GUICtrlSetState($Radio2, 1)


GUICtrlCreateLabel("请拖入文本闻嘉安", 120, 240, 160, 80)



GUIRegisterMsg($WM_DROPFILES, "_WM_DROPFILES")



;~ $aa = _GetInfoArray("J:\注龙大战PPT\02 文字与字体\原片\第2-3镜.MOV")
;~ _ArrayDisplay($aa)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd


; 分类文件夹 - 按拍摄日期
Func _desk_auto2($adir)
;~ 	MsgBox(1, @DesktopDir, "")Global $Color_a = 0x3baa24
	Global $Color_b = 0x888888
	Local $aFileList = _FileListToArray($adir, "*", 1)
	Local $aFiledata
	If @error = 1 Or @error = 4 Then
		MsgBox(0, 0, "错误")
		Return
	EndIf

	For $i = 1 To $aFileList[0]
		Local $sub_file = $adir & "\" & $aFileList[$i]

	Next

;~ 	ToolTip("")
	MsgBox(0, 0, "成功")
EndFunc   ;==>_desk_auto2




; 整理桌面文件 按创建日期
Func _desk_auto($adir)
;~ 	MsgBox(1, @DesktopDir, "")
	Local $aFileList = _FileListToArray($adir)
	Local $aFiledata

	If @error = 1 Or @error = 4 Then Return

	_ArrayDisplay($aFileList)

	For $i = 1 To $aFileList[0]
		;？ 排除快捷方式
		;？ 排除符合日期格式的文件夹
		If StringRegExp($aFileList[$i], "^\d\d\d\d\d\d\d\d$", $STR_REGEXPMATCH) Then
		Else
			$aFiledata = FileGetTime($adir & "\" & $aFileList[$i], 1, 1)
			$aFiledata = StringLeft($aFiledata, 8)

			;判断 文件夹 or 文件
			If IsDir($adir & "\" & $aFileList[$i]) Then
				DirMove($adir & "\" & $aFileList[$i], $adir & "\" & $aFiledata & "\" & $aFileList[$i], 8)
			Else
				FileMove($adir & "\" & $aFileList[$i], $adir & "\" & $aFiledata & "\" & $aFileList[$i], 8)
			EndIf
		EndIf
	Next
EndFunc   ;==>_desk_auto

; move file
Func _File_move_data()

EndFunc   ;==>_File_move_data


; 开机前整理提示临时文件夹
Func open_dir()
	;判断桌面是否为空文件夹（快捷方式排除）
	;弹出整理文件夹对话提示
EndFunc   ;==>open_dir

; 右键添加时间戳
Func _w_name()

EndFunc   ;==>_w_name



; 检查文件路径是否是目录/文件夹, 不验证其是否存在.
Func IsDir($sFilePath)
	Return StringInStr(FileGetAttrib($sFilePath), "D") > 0
EndFunc   ;==>IsDir



;移动文件夹
Func _DirMove($SourceDir, $Destdir)
	;说明：利用Shell对象来实现移动文件对话框
	;作者：Sanhen
	Local $Shell
	Local $FOF_CREATEPROGRESSDLG = 16
	If Not FileExists($Destdir) Then DirCreate($Destdir)
	$Shell = ObjCreate("Shell.Application")
	$Shell.NameSpace($Destdir).MoveHere($SourceDir, $FOF_CREATEPROGRESSDLG)
EndFunc   ;==>_DirMove


;# 事件 > 拖放
Func _evDroppedFiles(ByRef $dFiles)
	Local $x
	If UBound($dFiles) = 1 Then
;~ 		If IsDir($dFiles[0]) Then
		GUICtrlSetData($Input1, $dFiles[0])
;~ 		EndIf
	Else
		MsgBox(0, 0, "请拖入一个文件夹")
		Return
	EndIf
EndFunc   ;==>_evDroppedFiles


;# 消息 > 拖放
Func _WM_DROPFILES($hWnd, $Msg, $wParam, $lParam)
	Local $tDrop, $i, $aRet, $iCount ;
	;get file count
	$aRet = DllCall("shell32.dll", "int", "DragQueryFileW", "ptr", $wParam, "uint", -1, "ptr", 0, "uint", 0)
	$iCount = $aRet[0]
	;get file paths
	Local $aDraggedFiles[$iCount] ;
	For $i = 0 To $iCount - 1
		$aRet = DllCall("shell32.dll", "int", "DragQueryFileW", "ptr", $wParam, "uint", $i, "ptr", 0, "uint", 0)
		Local $tDrop = DllStructCreate("wchar[" & $aRet[0] + 1 & "]")
		$aRet = DllCall("shell32.dll", "int", "DragQueryFileW", "ptr", $wParam, "uint", $i, "ptr", DllStructGetPtr($tDrop), "uint", $aRet[0] + 1)
		$aDraggedFiles[$i] = DllStructGetData($tDrop, 1) ;
	Next

	;finalize
	DllCall("shell32.dll", "int", "DragFinish", "ptr", $wParam)
	Return _evDroppedFiles($aDraggedFiles) ;
EndFunc   ;==>_WM_DROPFILES
