#NoEnv
#SingleInstance Force
#Requires AutoHotkey v1.1.36.01+
SendMode Input
SetBatchLines -1
SetWorkingDir %A_ScriptDir%

Menu Tray, Icon, AmuletWeightCalculator.ico

Gui Main:Add, Button, x15 y173 w197 h20 gScan, Scan
Gui Main:Add, Button, x232 y173 w150 h20 gRefresh, Refresh Weight
Gui Main:Add, Tab3, x0 y0 w3900 h170 vAmulet -wrap, Star|Moon|King Beetle|Ant|Shell|Stick Bug|Cog|

Gui Main:Tab, Star

Gui Main:Tab, Moon
Gui Main:Font, Underline
Gui Main:Add, Text, x15 y35, Amulet Information
Gui Main:Font
Gui Main:Add, Text, y+9, *Capacity:
Increment := 25000
VarEdit := 25000
EditVar := "M_CAP"
Gui Main:Add, Edit, w55 x+5 y55 vM_CAP +ReadOnly, % VarEdit
Gui Main:Add, UpDown, -16 hp x+0 vVarEdit gVarEdit Range1-10, % VarEdit / Increment
Gui Main:Add, Text, x15 y+7, Ticket Chance:
Gui Main:Add, Edit, w35 x+5 y80 +ReadOnly, % M_TICKET
Gui Main:Add, UpDown, vM_TICKET Range0-5, 0
Gui Main:Add, Text, x15 y+7, Movement Collection:
Gui Main:Add, Edit, w35 x+5 y105 +ReadOnly, % M_MVC
Gui Main:Add, UpDown, vM_MVC Range0-3, 0

Gui Main:Font, Underline
Gui Main:Add, Text, x232 y35, Weight Information
Gui Main:Font
Gui Main:Add, Text, y+10, Overall:
Gui Main:Add, Text, x+2 w95 vM_O_W, 0
Gui Main:Add, Text, x232 y+7, White:
Gui Main:Add, Text, x+2 w95 vM_W_W, 0
Gui Main:Add, Text, x232 y+7, Blue:
Gui Main:Add, Text, x+2 w95 vM_B_W, 0
Gui Main:Add, Text, x232 y+7, Red:
Gui Main:Add, Text, x+2 w95 vM_R_W, 0

Gui Main:Tab, King Beetle
Gui Main:Font, Underline
Gui Main:Add, Text, x15 y35, Amulet Information
Gui Main:Font
Gui Main:Add, Text, y+9, *Convert Rate:
Gui Main:Add, Edit, w55 x+5 y55 +ReadOnly, % KB_CR
Gui Main:Add, UpDown, vKB_CR Range1-100, 1
Gui Main:Add, Text, x15 y+7, Attack:
Gui Main:Add, DDL, x+5 y80 w130 vKB_ATK, None|+1 Bee Attack|+1 Red Bee Attack|+1 Blue Bee Attack
Gui Main:Add, Text, x15 y+7, *Field Buff:
Gui Main:Add, Edit, w45 h20 x+5 y105 +ReadOnly, % KB_F1_V
Gui Main:Add, UpDown, vKB_F1_V Range1-100, 1
Gui Main:Add, DDL, x+5 w90 vKB_F1, Bamboo|Mushroom|Blue Flower|Clover|Strawberry
Gui Main:Add, Text, x15 y+5, *Field Buff:
Gui Main:Add, Edit, w45 h20 x+5 y127 +ReadOnly, % KB_F2_V
Gui Main:Add, UpDown, vKB_F2_V Range1-100, 1
Gui Main:Add, DDL, x+5 y128 w90 vKB_F2, Bamboo|Mushroom|Blue Flower|Clover|Strawberry

Gui Main:Font, Underline
Gui Main:Add, Text, x232 y35, Weight Information
Gui Main:Font
Gui Main:Add, Text, y+10, Overall:
Gui Main:Add, Text, x+2 w95 vKB_O_W, 0
Gui Main:Add, Text, x232 y+7, White:
Gui Main:Add, Text, x+2 w95 vKB_W_W, 0
Gui Main:Add, Text, x232 y+7, Blue:
Gui Main:Add, Text, x+2 w95 vKB_B_W, 0
Gui Main:Add, Text, x232 y+7, Red:
Gui Main:Add, Text, x+2 w95 vKB_R_W, 0

Gui Main:Tab, Ant

Gui Main:Tab, Shell

Gui Main:Tab, Stick Bug

Gui Main:Tab, Cog

Gui Main:Show, w390 h200, Amulet Weight Calculator

return

Refresh:
	Gui, Main:Submit, NoHide
	CurrentAmulet := StrReplace(Amulet, " ", "")
	GoTo, %CurrentAmulet%
return

Scan:
	getSelectionCoords(x_start, x_end, y_start, y_end)
	RunWait "%A_ScriptDir%\lib\Capture2Text\Capture2Text.exe" -s "%x_start% %y_start% %x_end% %y_end%" --output-file "%A_ScriptDir%\lib\Capture2Text\out.txt"

	FileRead Scanned, %A_ScriptDir%\lib\Capture2Text\out.txt
	ScannedSplit := StrSplit(Scanned, "+")
	ScannedSplit.RemoveAt(1)

	Gui Main:Submit, NoHide
	CurrentAmulet := RegExReplace(Amulet, "[a-z]+", "")
	CurrentAmulet := StrReplace(CurrentAmulet, " ", "")
	RegExReplace(Scanned, "\+\d+% [\w\s]+ Field \w+",, FieldCount)
	CurrentField := 1
	RegExReplace(Scanned, "\+1\s?\w* Bee \w+",, AttackCount)
	AttackCount := 1
	for k, buff in ScannedSplit
		if (RegExMatch(buff, "\d+% Convert") != "0") {
			buff := StrSplit(buff, " ", "%")
			buff := buff[1]
			GuiControl,, %CurrentAmulet%_CR, %buff%
		} else if (RegExMatch(buff, "1\s?\w* Bee") != "0") {
			buff := RegexReplace(buff, "^\s+|\s+$")
			buff = +%buff%
			if (AttackCount >= CurrentAttack)
			{
				GuiControl ChooseString, %CurrentAmulet%_ATK, %buff%
				CurrentAttack++
			}
		} else if (RegExMatch(buff, "\d+% [\w\s]+ Field") != "0") {
			buff := StrSplit(buff, " ", "%", 2)
			buff_V := buff[1]
			buff := buff[2]
			buff := RegexReplace(buff, " Field[\w\s]*")
			buff := RegexReplace(buff, "^\s+|\s+$")
			if (FieldCount >= CurrentField)
			{
				GuiControl Text, %CurrentAmulet%_F%CurrentField%_V, %buff_V%
				GuiControl ChooseString, %CurrentAmulet%_F%CurrentField%, %buff%
				CurrentField++
			}
		}
return

Star:
return

Moon:
	Gui, Main:Submit, NoHide
	if (M_CAP) {
		GoTo CalculateWeight
	}
return

KingBeetle:
	Gui, Main:Submit, NoHide
	if (KB_F1) AND (KB_F2) {
		GoTo CalculateWeight
	}
return

Ant:
return

Shell:
return

StickBug:
return

Cog:
return

CalculateWeight:
	Gui Main:Submit, NoHide
	CurrentAmulet := RegExReplace(Amulet, "[a-z]+", "")
	CurrentAmulet := StrReplace(CurrentAmulet, " ", "")

	if (%CurrentAmulet%_CR) {
		W_W += %CurrentAmulet%_CR * 13
		B_W += %CurrentAmulet%_CR * 13
		R_W += %CurrentAmulet%_CR * 13
	}

	if (%CurrentAmulet%_CAP) {
		W_W += Round((%CurrentAmulet%_CAP / 500) * 2)
		B_W += Round((%CurrentAmulet%_CAP / 500) * 2)
		R_W += Round((%CurrentAmulet%_CAP / 500) * 2)
	}

	if (%CurrentAmulet%_ATK) {
		Switch %CurrentAmulet%_ATK
		{
		Case "+1 Bee Attack":
			W_W += 250
			B_W += 250
			R_W += 250
		Case "+1 Red Bee Attack":
			W_W += 150
			B_W += 125
			R_W += 200
		Case "+1 Blue Bee Attack":
			W_W += 150
			B_W += 200
			R_W += 125
		}
	}

	Fields := {"Cactus":{}
		, "Pumpkin":{}
		, "Pineapple Patch":{}
		, "Stump":{}
		, "Spider":{}
		, "Strawberry":{}
		, "Bamboo":{}
		, "Dandelion":{}
		, "Sunflower":{}
		, "Clover":{}
		, "Mushroom":{}
		, "Blue Flower":{}}

	Fields.Cactus := {"White":{ "Triple":3, "Double":4 }
		, "Red":{ "Triple":25, "Double":18 }
		, "Blue":{ "Triple":28, "Double":22 }}
	Fields.Pumpkin := {"White":{ "Triple":43, "Double":14 }
		, "Red":{ "Triple":16, "Double":5 }
		, "Blue":{ "Triple":17, "Double":5 }}
	Fields["Pineapple Patch"] := {"White":{ "Triple":27, "Double":45, "Single":17 }
		, "Red":{ "Triple":2, "Double":3, "Single":1 }
		, "Blue":{ "Triple":2, "Double":2, "Single":1 }}
	Fields.Stump := {"White":{ "Triple":19 }
		, "Red":{ "Triple":6 }
		, "Blue":{ "Triple":75 }}
	Fields.Spider := {"White":{ "Triple":10, "Double":80, "Single":10 }}
	Fields.Strawberry := {"White":{ "Triple":1, "Double":23, "Single":7 }
		, "Red":{ "Triple":3, "Double":52, "Single":14 }}
	Fields.Bamboo := {"White":{ "Triple":1.25, "Double":18.75, "Single":5 }
		, "Blue":{ "Triple":3.75, "Double":56.25, "Single":15 }}
	Fields.Dandelion := {"White":{ "Double":10.6, "Single":74.1 }
		, "Red":{ "Double":0.8, "Single":4.8 }
		, "Blue":{ "Double":1.5, "Single":8.2 }}
	Fields.Sunflower := {"White":{ "Double":6.4, "Single":61.9 }
		, "Red":{ "Double":1.7, "Single":15 }
		, "Blue":{ "Double":2.1, "Single":12.9 }}
	Fields.Clover := {"White":{ "Double":16, "Single":16 }
		, "Red":{ "Double":16, "Single":18 }
		, "Blue":{ "Double":17, "Single":17 }}
	Fields.Mushroom := {"White":{ "Double":2.8, "Single":27.8 }
		, "Red":{ "Double":6.9, "Single":61.5 }}
	Fields["Blue Flower"] := {"White":{ "Double":3, "Single":28 }
		, "Blue":{ "Double":8, "Single":61 }}

	FieldDivisor := 30
	if (%CurrentAmulet%_F1) {
		F := 1
		Loop
		{
			C := 1
			Loop 3
			{
				Switch C
				{
				Case 1: ColorType := "White"
				Case 2: ColorType := "Red"
				Case 3: ColorType := "Blue"
				}
				CurrentField := [%CurrentAmulet%_F%F%, ColorType]
				Single_V := Fields[CurrentField*].Single
				Double_V := Fields[CurrentField*].Double
				Triple_V := Fields[CurrentField*].Triple
				Weight := Round((Single_V + (Double_V * 3) + (Triple_V * 5)) / FieldDivisor)
				if (Weight = 0) {
					Weight++
				}
				CurrentColor := RegExReplace(ColorType, "[a-z]+", "")
				%CurrentColor%_W += %CurrentAmulet%_F%F%_V * Weight
				C++
			}
			F++
			if (%CurrentAmulet%_F%F%_V = "") {
				break
			}
		}
	}

	O_W := W_W + B_W + R_W

	GuiControl Text, %CurrentAmulet%_O_W, %O_W%
	GuiControl Text, %CurrentAmulet%_W_W, %W_W%
	GuiControl Text, %CurrentAmulet%_B_W, %B_W%
	GuiControl Text, %CurrentAmulet%_R_W, %R_W%

	W_W := 0
	B_W := 0
	R_W := 0
return

VarEdit:
	GuiControl Text, %EditVar%, % VarEdit * Increment
return

GuiClose:
ExitApp

getSelectionCoords(ByRef x_start, ByRef x_end, ByRef y_start, ByRef y_end) {
	Gui Scan:Color, FFFFFF
	Gui Scan:+LastFound
	WinSet Transparent, 50
	Gui Scan:-Caption
	Gui Scan:+AlwaysOnTop
	Gui Scan:Show, x0 y0 h%A_ScreenHeight% w%A_ScreenWidth%,"AutoHotkeySnapshotApp"

	CoordMode Mouse, Screen
	CoordMode Tooltip, Screen
	WinGet hw_frame_m,ID,"AutoHotkeySnapshotApp"
	hdc_frame_m := DllCall( "GetDC", "uint", hw_frame_m)
	KeyWait LButton, D
	MouseGetPos scan_x_start, scan_y_start
	Loop
	{
		Sleep 10
		KeyIsDown := GetKeyState("LButton")
		if (KeyIsDown = 1) {
			MouseGetPos, scan_x, scan_y
			DllCall( "gdi32.dll\Rectangle", "uint", hdc_frame_m, "int", 0,"int",0,"int", A_ScreenWidth,"int",A_ScreenWidth)
			DllCall( "gdi32.dll\Rectangle", "uint", hdc_frame_m, "int", scan_x_start,"int",scan_y_start,"int", scan_x,"int",scan_y)
		} else {
			break
		}
	}

	MouseGetPos scan_x_end, scan_y_end
	Gui Scan:Destroy

	if (scan_x_start < scan_x_end) {
		x_start := scan_x_start
		x_end := scan_x_end
	} else {
		x_start := scan_x_end
		x_end := scan_x_start
	}

	if (scan_y_start < scan_y_end) {
		y_start := scan_y_start
		y_end := scan_y_end
	} else {
		y_start := scan_y_end
		y_end := scan_y_start
	}
}
return