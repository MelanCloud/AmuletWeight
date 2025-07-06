#SingleInstance Force
#Requires AutoHotkey v2.0
KeyHistory(0),
ListLines(false),
SendMode("Input"),
SetWorkingDir(A_ScriptDir),
TraySetIcon("./assets/Melan Amulets.ico")

#Include "./assets/data.ahk"
#Include "./assets/uis.ahk"

Main := Gui(, "Melan Amulets v0.1.2"),
tabMain := Main.Add("Tab3", "x0 y0 w400 h180 -wrap", ["Calculator", "Automatic", "More"]),

tabMain.UseTab("Calculator"),
Main.Add("GroupBox", "x9 y30 w125 h145", "Weight Information"),
Main.Add("Text", "x15 y50", "Overall:"), endWeights["Overall"] := Main.Add("Text", "x+2 w80", "0"),
Main.Add("Text", "x15 y+9", "White:"), endWeights["White"] := Main.Add("Text", "x+2 w80", "0"),
Main.Add("Text", "x15 y+9", "Blue:"), endWeights["Blue"] := Main.Add("Text", "x+2 w80", "0"),
Main.Add("Text", "x15 y+9", "Red:"), endWeights["Red"] := Main.Add("Text", "x+2 w80", "0"),
buttonRefresh := Main.Add("Button", "x15 y+18 w115 h20", "Refresh"), buttonRefresh.OnEvent("Click", buffProcessing),
Main.Add("GroupBox", "x137 y30 w250 h108", "Amulet Information"),
selectedAmulet := Main.Add("DropDownList", "x143 y50 w237 Choose1", ["Star", "Moon", "KingBeetle", "Ant", "Shell", "StickBug", "Cog"]), selectedAmulet.OnEvent("Change", resetWeights),
buttonBuffs := Main.Add("Button", "y+9 w237 h20", "Select Buffs"), buttonBuffs.OnEvent("Click", buffGUI),
buttonScan := Main.Add("Button", "y+9 w237 h20", "Scan [F6]"), buttonScan.OnEvent("Click", buffScan),
Main.Add("GroupBox", "x137 y135 w250 h40"),
buttonScanInGame := Main.Add("Button", "x143 y147 w237 h20", "In-Game Scan [F7]"), buttonScanInGame.OnEvent("Click", buffScanInGame),

tabMain.UseTab("Automatic"),
Main.SetFont("Underline"), Main.Add("Text", "x9 y30", "Automatically k/r your amulets!"), Main.SetFont(),
automatic := Map(
    "Toggle",0,
    "General",Map(),
    "Optimize",Map(),
    "Passives",Map()
),
Main.Add("Text", "x+9", "Mode: "), automatic["Mode"] := Main.Add("DropDownList", "x+2 y26 w110 Choose1", ["General", "Optimize Star", "Star Passives"]),
Main.Add("Text", "x+9 y30", "Toggle -> [F8]"),
Main.Add("GroupBox", "x9 y50 w150 h125", "General"),
automatic["General"]["Amulets"] := Map(
    "Star",Main.Add("CheckBox", "x16 y67", "Star"),
    "Moon",Main.Add("CheckBox", "x88 y67", "Moon"),
    "KingBeetle",Main.Add("CheckBox", "x16 y87", "K. Beetle"),
    "Ant",Main.Add("CheckBox", "x88 y87", "Ant"),
    "Shell",Main.Add("CheckBox", "x16 y107", "Shell"),
    "StickBug",Main.Add("CheckBox", "x88 y107", "S. Bug"),
    "Cog",Main.Add("CheckBox", "x16 y127", "Cog")
),
Main.Add("Text", "x16 y151", "Select Bias:"),
automatic["General"]["Bias"] := Main.Add("DropDownList", "x+5 y147 w75 Choose1", ["Overall", "White", "Blue", "Red"]),
Main.Add("GroupBox", "x163 y50 w230 h45", "Optimize Star"),
Main.Add("Text", "x168 y70", "Refresh Amount: "),
Main.Add("Edit", "x+2 y67 w58 +ReadOnly"), automatic["Optimize"]["Refreshes"] := Main.Add("UpDown", "Range0-1000"),
automatic["Optimize"]["Infinite"] := Main.Add("CheckBox", "x315 y70", "Infinite"),
Main.Add("GroupBox", "x163 y95 w230 h80", "Star Passives"),
Main.Add("Text", "x168 y115", "Refresh Amount: "),
Main.Add("Edit", "x+2 y112 w58 +ReadOnly"), automatic["Passives"]["Refreshes"] := Main.Add("UpDown", "Range0-1000"),
automatic["Passives"]["Infinite"] := Main.Add("CheckBox", "x315 y115", "Infinite"),
automatic["Passives"].Set(
    "Passive 1",Main.Add("DropDownList", "x168 y147 w70 Choose1", ["Pop Star", "Guiding Star", "Star Shower", "Gummy Star", "Scorching Star", "Star Saw"]),
    "Passive 2",Main.Add("DropDownList", "x+3 w70 Choose1", ["None", "Pop Star", "Guiding Star", "Star Shower", "Gummy Star", "Scorching Star", "Star Saw"]),
),
automatic["Passives"]["Double"] := Main.Add("CheckBox", "x315 y151", "Buy Double"),

tabMain.UseTab("More"),
Main.Add("GroupBox", "x9 y30 w135 h145", "Learn More"),
Main.SetFont("Bold"), Main.Add("Text", "x15 y50 c7baaff", "Swarm Simplfied: "), Main.SetFont("norm"),
Main.Add("Edit", "x16 y+7 w120 h20 -wrap +ReadOnly", "discord.gg/ysYQ7JdKfE"),
Main.SetFont("Bold"), Main.Add("Text", "x15 y+12 c2f343d", "Natro Macro: "), Main.SetFont("norm"),
Main.Add("Edit", "x16 y+7 w120 h20 +ReadOnly", "discord.gg/natromacro"),
Main.Add("GroupBox", "x147 y30 w240 h145", "Credits"),
Main.Add("Text", "x153 y50", "Developed solely by MelanCloud#8300"),

Main.OnEvent("Close", Main_Close)
Main_Close(*) {
    for Amulet in Amulets
        %Amulet%.Hide()
}
Main.Show("w400 h180"),

/* Hotkeys */

Hotkey(Config["Hotkey"]["buffScan"], buffScan),
Hotkey(Config["Hotkey"]["buffScanInGame"], buffScanInGame),
Hotkey(Config["Hotkey"]["autoSelectToggle"], toggleAutoSelectEnDis),
Hotkey(Config["Hotkey"]["autoSelectOnOff"], toggleAutoSelectOnOff)

Esc:: {
    if (WinActive(Scan.Hwnd)) {
        Scan.Hide(),
        Main.Show()
    }

    if (automatic["Toggle"]) {
        automatic["Toggle"] := 0,
        Msgbox("Auto selection toggle disabled."),
        Scan.Hide()
    }
}
^Esc::ExitApp

toggleAutoSelectEnDis(*) {
    if (!automatic["Toggle"] && automatic["Mode"].Text == "General") {
        inc := 0
        for Amulet in Amulets {
            if (automatic["General"]["Amulets"][Amulet].Value)
                inc++
        }
        if (!inc) {
            MsgBox("You must select an amulet type to automatically select before you can toggle this!")
            return
        }
    }

    automatic["Toggle"] := !automatic["Toggle"]
    MsgBox("Automatic toggle " . (automatic["Toggle"] ? "enabled.`n[F9] : Turn On" : "disabled."))
    if (!automatic["Toggle"])
        Main.Show()
}
toggleAutoSelectOnOff(*) {
    if (!automatic["Toggle"]) {
        Msgbox("You must enable 'Automatic' using [F8] before you can turn this on!")
        return
    }
 
    for Amulet in Amulets
        %selectedAmulet.Text%.Hide()
    Main.Hide()

    Sleep(1000)
    if (!WinWaitActive("Roblox ahk_exe RobloxPlayerBeta.exe",, 3)) {
        Msgbox("You must have Bee Swarm Simulator open while using 'Auto Selection'! To disable 'Auto Selection', use [F8] to toggle it off.", "Error", 262144)
        Main.Show()
        return
    }

    MsgBox("Note: Press [F8] at any time to toggle off automatic...")
    WinActivate "Roblox ahk_exe RobloxPlayerBeta.exe"
    while automatic["Toggle"] {
        if (!WinActive("Roblox ahk_exe RobloxPlayerBeta.exe")) {
            Msgbox("You must have Bee Swarm Simulator open while using 'Automatic'! To disable 'Automatic', use [F8] to toggle it off.", "Error", 262144)
            Main.Show()
            return
        }

        if (automatic["Mode"].Text == "Star Passives") && (automatic["Passives"]["Passive 1"].Text == automatic["Passives"]["Passive 2"].Text) {
            MsgBox("Your goal passives cannot be the same!")
            break
        }
        getGeneralAmuletPos(&xi, &yi, &ww, &wh)
        amuletTitle := getAmuletTitle(xi, wh)
        for Amulet in Amulets {
            if (automatic["Mode"].Text == "General") && (!automatic["General"]["Amulets"][Amulet].Value)
                continue
            if (amuletTitle !== Amulet)
                continue

            Switch automatic["Mode"].Text {
                Case "General":
                    windowAmuletProcessor(xi, wh, 1)
                    break
                Case "Optimize Star", "Star Passives":
                    if (Amulet !== "Star")
                        break
        
                    windowAmuletProcessor(xi, wh, 1)
                    automatic[(automatic["Mode"].Text == "Optimize Star" ? "Optimize" : "Passives")]["Refreshes"].Value--

                    if (automatic[(automatic["Mode"].Text == "Optimize Star" ? "Optimize" : "Passives")]["Infinite"].Value)
                        break
                    if (!automatic[(automatic["Mode"].Text == "Optimize Star" ? "Optimize" : "Passives")]["Refreshes"].Value) {
                        MsgBox("Refreshes finished!")
                        break 2
                    }
        
                    Send "e"
                    if (!automatic["Mode"].Text == "Star Passives")
                        break
                    if (ImageSearch(&amX, &amY, xi, yi, ww, wh, "*30 " . ".\assets\prompt\" . (automatic["Passives"]["Double"].Value ? "Yes" : "No") . ".png")) {
                        MouseMove(amX, amY),
                        Send("{Click}")
                    }
            }
        }
        if (automatic["Mode"].Text == "General")
            Sleep(5000)
        else
            Sleep(2000)
    }
}

/* Main Functions */

/**
 * Activates manual buff scanning
 */
buffScan(*) {
    if (automatic["Toggle"])
        return

    Main.Hide(),
    %selectedAmulet.Text%.Hide(),

    getSelectionCoords(&xStart, &xEnd, &yStart, &yEnd),
    buffScanPlacement(xStart, yStart, xEnd, yEnd),
    Main.Show()
}

/**
 * Activates automatic buff scanning
 */
buffScanInGame(*) {
    if (automatic["Toggle"])
        return

    if (!WinActive("Roblox ahk_exe RobloxPlayerBeta.exe")) {
        Msgbox("You must have Bee Swarm Simulator open while using this!", "Error", 262144)
        return
    }

    getGeneralAmuletPos(&xi, &yi, &ww, &wh),
    windowAmuletProcessor(xi, wh)
}

/**
 * Processes retrieved OCR data within a selection
 */
buffScanPlacement(xStart, yStart, xEnd, yEnd, auto := 0) {
    RunWait(".\libs\Capture2Text\Capture2Text.exe -s `"" xStart " " yStart " " xEnd " " yEnd "`" --output-file `".\libs\Capture2Text\out.txt`""),
    validateScanned(&scanned, &scannedSplit)

    for Buff in Amulets[selectedAmulet.Text]["Buffs"] {
        if (auto) {
            Amulets[selectedAmulet.Text]["Buffs"][Buff] := 0
        } else {
            if (Amulets[selectedAmulet.Text]["Checks"].Has(Buff))
                Amulets[selectedAmulet.Text]["Checks"][Buff].Value := 0
        }
    }

    RegExReplace(scanned, "\+\d+% [\w\s]+ [Field|Patch]{5} \w+",, &fieldCount),
    currentField := 1
    for extract in scannedSplit {
        if (RegExMatch(extract, "\d+% [\w\s]+ [Field|Patch]{5}")) {
            extract := StrSplit(extract, " ", "%", 2),
            extractValue := RegExReplace(extract[1], "[-+x%]", ""),
            extract := extract[2],
            extract := RegExReplace(extract, " [Field|Patch]{5} [\w\s]*")
            if (fieldCount >= currentField) {
                if (!Amulets[selectedAmulet.Text]["Values"].Has("F" . currentField . "_Value") && (!Amulets[selectedAmulet.Text]["Values"].Has("F" . currentField)))
                    continue
                if (auto) {
                    Amulets[selectedAmulet.Text]["Buffs"]["F" . currentField . "_Value"] := extractValue,
                    Amulets[selectedAmulet.Text]["Buffs"]["F" . currentField] := extract
                } else {
                    if (Amulets[selectedAmulet.Text]["Checks"].Has("F" . currentField))
                        Amulets[selectedAmulet.Text]["Checks"]["F" . currentField].Value := 1
                    Amulets[selectedAmulet.Text]["Values"]["F" . currentField . "_Value"].Value := extractValue,
                    Amulets[selectedAmulet.Text]["Values"]["F" . currentField].Choose(extract)
                }
                currentField++
                continue
            }
        }
        for Buff in Buffs {
            if (!RegExMatch(extract, Buffs[Buff]["Regex"]))
                continue
            if (!Amulets[selectedAmulet.Text]["Values"].Has(Buff))
                continue
            extract := StrSplit(extract, " "),
            extract := RegExReplace(extract[1], "[-+x%]", "")
            if (auto) {
                Amulets[selectedAmulet.Text]["Buffs"][Buff] := extract
            } else {
                if (Amulets[selectedAmulet.Text]["Checks"].Has(Buff))
                    Amulets[selectedAmulet.Text]["Checks"][Buff].Value := 1
                Amulets[selectedAmulet.Text]["Values"][Buff].Value := extract
            }
            continue 2
        }

        if (selectedAmulet.Text !== "Star")
            continue
        for StarType in Stars {
            if (!RegExMatch(extract, Stars[StarType]["Regex"]))
                continue
            extract := StrSplit(extract, " ",, 2),
            extract := StrReplace(extract[2], " ")
            if (!auto) {
                Amulets[selectedAmulet.Text]["Checks"][extract].Value := 1
                continue 2
            }

            Stars[StarType]["Has"] := 1
            continue 2
        }
    }
}

/**
 * Processes and validates all buffs and passives to make sure all information is correct and pushes it to the main calculator
 */
buffProcessing(*) {
    ; TODO: Buff range limiters

    ; Processes inputted GUI values and pushes checked buff values into their proper data position
    for Buff in Amulets[selectedAmulet.Text]["Buffs"] {
        if (RegexMatch(Buff, "_Value"))
            continue
        Amulets[selectedAmulet.Text]["Buffs"][Buff] := 0
        if (Amulets[selectedAmulet.Text]["Checks"].Has(Buff)) {
            if (Amulets[selectedAmulet.Text]["Checks"][Buff].Value) {
                Amulets[selectedAmulet.Text]["Buffs"][Buff] := Amulets[selectedAmulet.Text]["Values"][Buff].Value
                if (Amulets[selectedAmulet.Text]["Buffs"].Has(Buff . "_Value"))
                    Amulets[selectedAmulet.Text]["Buffs"][Buff . "_Value"] := Amulets[selectedAmulet.Text]["Values"][Buff . "_Value"].Value
            }
        }
    }

    ; Processes star passives and pushes checked passives into their proper data position
    if (selectedAmulet.Text == "Star") {
        for StarType in Stars
            Stars[StarType]["Has"] := Amulets[selectedAmulet.Text]["Checks"][StarType].Value
    }

    ; Processes 'Required' buffs and makes sure there are no missing fields
    for requiredBuff in Amulets[selectedAmulet.Text]["Validation"]["Required"] {
        Amulets[selectedAmulet.Text]["Buffs"][requiredBuff] := Amulets[selectedAmulet.Text]["Values"][requiredBuff].Value

        if (Amulets[selectedAmulet.Text]["Buffs"].Has(requiredBuff . "_Value") && Amulets[selectedAmulet.Text]["Values"][requiredBuff].Value == 0) {
            endWeights["Overall"].Text := 0
            for ColorType in Colors {
                endWeights[ColorType].SetFont("norm"),
                endWeights[ColorType].Text := 0
            }
            MsgBox("You must set your field buffs.", "Buff Validation Failure", 262144)
            return
        }
    }

    ; Processes 'Varying' buffs to make sure no buffs are missing in any amulets tabs
    if (Amulets[selectedAmulet.Text]["Validation"].Has("Varying")) {
        currVarying := 1
        While (currVarying !== Amulets[selectedAmulet.Text]["Validation"]["Varying"].Length + 1) {
            for varyingBuff in Amulets[selectedAmulet.Text]["Validation"]["Varying"][currVarying] {
                if (Amulets[selectedAmulet.Text]["Buffs"][varyingBuff] && !RegexMatch(varyingBuff, "_Value")) {
                    currVarying++
                    continue 2
                }

                if (A_Index == Amulets[selectedAmulet.Text]["Validation"]["Varying"][currVarying].Length) {
                    endWeights["Overall"].Text := 0
                    for ColorType in Colors {
                        endWeights[ColorType].SetFont("norm"),
                        endWeights[ColorType].Text := 0
                    }
                    MsgBox("You have missing 'Varying " . currVarying . "' buffs.", "Buff Validation Failure", 262144)
                    return
                }
            }
            currVarying++
        } 
    }

    ; Makes sure there are no duplicate field buffs within the same amulet
    fieldMap := Map(),
    fieldCounter := 0
    for Buff in Amulets[selectedAmulet.Text]["Buffs"] {
        if (!Amulets[selectedAmulet.Text]["Buffs"].Has(Buff . "_Value"))
            continue
        if (Amulets[selectedAmulet.Text]["Buffs"][Buff]) {
            fieldMap[Amulets[selectedAmulet.Text]["Buffs"][Buff]] := 0,
            fieldCounter++
        }
    }

    if (fieldMap.Count !== fieldCounter) {
        MsgBox("You have duplicate field buffs.", "Buff Validation Failure", 262144)
        return
    }

    calculateWeight()
}

/**
 * Calculates buff or passive data
 */
calculateWeight() {
    Weights := Map()
    for ColorType in Colors
        Weights.Set(ColorType, 0)

    fieldCount := 0
    for Buff in Amulets[selectedAmulet.Text]["Buffs"]
        if (Amulets[selectedAmulet.Text]["Buffs"].Has(Buff . "_Value"))
            fieldCount++

    F := 1
    Loop fieldCount {
        if (!Amulets[selectedAmulet.Text]["Buffs"]["F" . F])
            continue
        Field := Amulets[selectedAmulet.Text]["Values"]["F" . F].Text
        for ColorType in Colors {
            for Flower in Flowers {
                if (!Fields[Field].Has(ColorType))
                    continue
                if (Fields[Field][ColorType].Has(Flower))
                    FieldData["Types"][Flower]["Value"] := Fields[Field][ColorType][Flower]
            }
            Weight := Round(
                ((FieldData["Types"]["Single"]["Value"] * FieldData["Types"]["Single"]["Factor"]) +
                (FieldData["Types"]["Double"]["Value"] * FieldData["Types"]["Double"]["Factor"]) +
                (FieldData["Types"]["Triple"]["Value"] * FieldData["Types"]["Triple"]["Factor"])) /
                FieldData["Divisor"])
            if (!Weight)
                Weight++
            Weights[ColorType] += Amulets[selectedAmulet.Text]["Buffs"]["F" . F . "_Value"] * Weight
        }
        F++
    }

    for Buff in Buffs {
        if (!Amulets[selectedAmulet.Text]["Buffs"].Has(Buff))
            continue
        for ColorType in Colors
            Weights[ColorType] += ((Buffs[Buff].Has("Weight") ? Amulets[selectedAmulet.Text]["Buffs"][Buff] * Buffs[Buff]["Weight"] : Amulets[selectedAmulet.Text]["Buffs"][Buff] * Buffs[Buff]["Weights"][ColorType]))
    }

    if (selectedAmulet.Text == "Star") {
        for StarType in Stars {
            if (Stars[StarType]) && (Stars[StarType]["Has"])
                for ColorType in Colors
                    Weights[ColorType] += Stars[StarType]["Weights"][ColorType]
        }
    }

    Weights["Overall"] := Round(Weights["White"] + Weights["Blue"] + Weights["Red"]),
    endWeights["Overall"].Text := Weights["Overall"],
    ColorType_2 := False,
    Colors_2 := []

    for ColorType in Colors {
        endWeights[ColorType].SetFont("norm"),
        endWeights[ColorType].Text := Round(Weights[ColorType])
    
        if (Weights[ColorType] > (IsSet(%ColorType_2%_Weight) ? %ColorType_2%_Weight : 0)) {
            Colors_2 := [ColorType],
            ColorType_2 := ColorType
        } else if (Weights[ColorType] == %ColorType_2%_Weight) {
            Colors_2.Push(ColorType)
        }
    }
    
    for ColorType in Colors_2 {
        endWeights[ColorType].SetFont("Bold"),
        endWeights[ColorType].Text := Round(Weights[ColorType])
    }
    return [Weights["Overall"], Weights["White"], Weights["Blue"], Weights["Red"]]
}

/**
 * Finds amulet popup within Roblox window and handles K/R
 */
windowAmuletProcessor(xi, wh, auto := 0) {
    amuletPopupColor := 0xFFE85D
    amuletBorderColor := 0x615833

    xStart := findPixelGetColor(0, xi, wh * 2/3, amuletPopupColor, 10, 30),
    xStart := findPixelGetColor(0, xStart, wh * 2/3, amuletBorderColor, -1, 20),
    xStart++,

    yStart := findPixelGetColor(1, xStart, 200, amuletPopupColor, 20, 20),
    yStart := findPixelGetColor(1, xStart, yStart, amuletPopupColor, 15, 10, 1),
    yStart := findPixelGetColor(1, xStart, yStart, amuletPopupColor, 1, 30),

    yEnd := findPixelGetColor(1, xStart, yStart, amuletPopupColor, 30, 20, 1),
    yEnd := findPixelGetColor(1, xStart, yEnd, amuletPopupColor, -1, 30),
    yEnd--,

    xEnd := findPixelGetColor(0, xStart, yEnd, amuletPopupColor, 30, 20, 1),
    xEnd := findPixelGetColor(0, xEnd, yEnd, amuletPopupColor, -1, 20),
    xEnd--,

    padding := 0
    if (automatic["Toggle"]) && (automatic["Mode"].Text == "Star Passives") {
        if (!Stars[automatic["Passives"]["Passive 1"].Text]["Has"])
            newWeight := 0, oldWeight := 1
        if (automatic["Passives"]["Passive 2"].Text !== "None")
            if (!Stars[automatic["Passives"]["Passive 2"].Text]["Has"])
                newWeight := 0, oldWeight := 1
        newWeight := 1, oldWeight := 0
    } else {
        buffScanPlacement(xStart, yStart, Round(((xEnd - xStart)/2) + xStart), yEnd, 1),
        oldWeight := (calculateWeight())[automatic["General"]["Bias"].Value],
    
        buffScanPlacement(Round(((xEnd - xStart)/2) + xStart), yStart, xEnd, yEnd, 1)
        newWeight := (calculateWeight())[automatic["General"]["Bias"].Value],
        padding := oldWeight/100
    }

    if (auto) {
        xMouse := (newWeight > oldWeight + padding ? ((xEnd - xStart) * 3/4) + xStart : ((xEnd - xStart)/4) + xStart)
        yMouse := findPixelGetColor(1, xMouse, yEnd, amuletPopupColor, -5, 20, 1)
        yMouse -= 10,
        BlockInput("Mouse"),
        MouseMove(xMouse, yMouse),
        MouseMove(xMouse, yMouse + 1),
        Send("{Click}"),
        Sleep(100)
    } else {
        Msgbox("Recommendation: " . (newWeight > oldWeight + padding ? "Replace" : "Keep Old") . " (" . oldWeight . "/" . newWeight . ")", "In-Game Calulcation", 262144)
    }
}

/* Auxiliary Functions */

/**
 * Returns the title of an amulet UI
 */
getAmuletTitle(xi, wh) {
    amuletPopupColor := 0xFFE85D
    amuletBorderColor := 0x615833

    xStart := findPixelGetColor(0, xi, wh * 2/3, amuletPopupColor, 10, 30)
    if (xStart == False)
        return
    xStart := findPixelGetColor(0, xStart, wh * 2/3, amuletBorderColor, -1, 20),
    xStart++,
    
    yStart := findPixelGetColor(1, xStart, 200, amuletPopupColor, 20, 20),
    yStart := findPixelGetColor(1, xStart, yStart, amuletPopupColor, -2, 10, 1)
    yStart := findPixelGetColor(1, xStart, yStart, amuletPopupColor, 1, 10)

    yEnd := findPixelGetColor(1, xStart, yStart, amuletPopupColor, 5, 15, 1),
    yEnd := findPixelGetColor(1, xStart, yEnd, amuletPopupColor, -1, 10)

    xEnd := findPixelGetColor(0, xStart, yEnd, amuletPopupColor, 30, 20, 1),
    xEnd := findPixelGetColor(0, xEnd, yEnd, amuletPopupColor, -1, 20),

    RunWait(".\libs\Capture2Text\Capture2Text.exe -s `"" xStart " " yStart " " xEnd " " yEnd "`" --output-file `".\libs\Capture2Text\out.txt`""),
    scanned := Fileread(".\libs\Capture2Text\out.txt")

    for Amulet in Amulets {
        if (!RegExMatch(scanned, Amulets[Amulet]["Regex"]))
            continue

        return Amulet
    }
}

/**
 * Retrieves click-and-drag selection coords
 */
getSelectionCoords(&xStart, &xEnd, &yStart, &yEnd) {
    WinSetTransparent(50, Scan.Hwnd),
    Scan.Show("x0 y0 h" . A_ScreenHeight . " w" . A_ScreenWidth),

    CoordMode("Mouse", "Screen"),
    CoordMode("Tooltip", "Screen"),
    hwFrameM := WinGetID("AutoHotkeySnapshotApp"),
    hdcFrameM := DllCall("GetDC", "uint", hwFrameM),
    KeyWait("LButton", "D"),
    MouseGetPos(&xScanStart, &yScanStart)
    While (GetKeyState("LButton")) {
        MouseGetPos(&xScan, &yScan),
        DllCall("gdi32.dll\Rectangle", "uint", hdcFrameM, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenWidth),
        DllCall("gdi32.dll\Rectangle", "uint", hdcFrameM, "int", xScanStart, "int", yScanStart, "int", xScan, "int", yScan),
        Sleep(10)
    }

    MouseGetPos(&xScanEnd, &yScanEnd),
    Scan.Hide(),

    xArr := (xScanStart < xScanEnd ? [xScanStart, xScanEnd] : [xScanEnd, xScanStart]),
    xStart := xArr[1],
    xEnd := xArr[2],
    yArr := (yScanStart < yScanEnd ? [yScanStart, yScanEnd] : [yScanEnd, yScanStart]),
    yStart := yArr[1],
    yEnd := yArr[2]
}

/**
 * Resets all weights
 */
resetWeights(*) {
    endWeights["Overall"].Text := 0
    for ColorType in Colors {
        endWeights[ColorType].SetFont("norm"),
        endWeights[ColorType].Text := 0
    }
}

/**
 * Loops vertically/horizontally with conditions relating to PixelGetColor.
 */
findPixelGetColor(find, x, y, color, increment, toleranceCap, equals := 0) {
    tolerance := 0
    while (equals ? PixelGetColor(x, y) == color : PixelGetColor(x, y) !== color) {
        (find ? y += increment : x += increment),
        tolerance++
        if (tolerance > toleranceCap) {
            if (automatic["Toggle"]) {
                Switch automatic["Mode"].Text {
                    Case "General": MsgBox("Error: Amulet not found or an error occured... [F8] <Off>")
                    Case "Star Passives", "Optimize Star": MsgBox("Error: Star Amulet not found. Please create a new Star Amulet for this to run properly. Otherwise, an error has occured... [F8] <Off>")
                }
            } else {
                MsgBox("Error: Amulet not found or an error occured... [F8]")
            }
            
            return False
        }
    }
    Sleep(100)
    return (find ? y : x)
}

/**
 * Validates OCR scanned items for further processing
 */
validateScanned(&scanned, &scannedSplit) {
    scanned := Fileread(".\libs\Capture2Text\out.txt"),
    scanned := StrReplace(scanned, "°/o", "%"),
    scanned := StrReplace(scanned, "PoUen", "Pollen"),
    scanned := StrReplace(scanned, "Wh ite", "White"),
    scanned := StrReplace(scanned, "+23% Critical Chance", "+3% Critical Chance"),
    scanned := RegExReplace(scanned, "(,)|Â", ""),
    scanned := RegExReplace(scanned, "\s+", " "),
    scanned := RegExReplace(scanned, " (?=[+\-x])", Chr(23)),
    scannedSplit := StrSplit(scanned, Chr(23), " ")
}

/**
 * Gets the general amulet popups position on-screen.
 */
getGeneralAmuletPos(&xi, &yi, &ww, &wh) {
    WinGetPos(&xi, &yi, &ww, &wh, "Roblox ahk_exe RobloxPlayerBeta.exe"),
    xi := Round(ww / 3),
    yi := Round(wh / 6),
    ww := Round(ww * 2 / 3),
    wh := Round(wh * 4 / 5)
}
