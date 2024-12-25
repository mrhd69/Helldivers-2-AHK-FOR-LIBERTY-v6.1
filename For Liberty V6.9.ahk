#SingleInstance force
#Persistent
#include Lib\AutoHotInterception.ahk
SendMode Input
SetKeyDelay 30, 30

global AHI := new AutoHotInterception()

global keyboardId := ""
if FileExist("KeyboardID.ini")
    IniRead, keyboardId, KeyboardID.ini, Settings, KeyboardID

if (keyboardId = "")
    MsgBox, 48, Error, Failed to retrieve the keyboard ID from the configuration file.


global mouseId := ""
if FileExist("MouseID.ini")
    IniRead, mouseId, MouseID.ini, Settings, MouseID

if (mouseId = "")
    MsgBox, 48, Error, Failed to retrieve the mouse ID from the configuration file.


; -- Global variables used by the GUI and logic --
global ControlKey
global Hotkey1 := ""
global Hotkey2 := ""
global Hotkey3 := ""
global Hotkey4 := ""
global Hotkey5 := ""
global Resupply := ""
global Renforce := ""
global Rearm := ""
global Hellbomb := ""
global SEAF := ""
global SelectedAction1 := ""
global SelectedAction2 := ""
global SelectedAction3 := ""
global SelectedAction4 := ""
global SelectedAction5 := ""
global SelectedGuns := ""
global UnsafeRailgun := ""

; -- For the background image you already have --
backgroundImagePath := "helldiver.jpg"

; -- Prepare the profile file list if needed --
profileFile := "profiles.txt"
if FileExist(profileFile) {
    FileRead, profileList, %profileFile%
    if (profileList = "") {
        profileList := "Profile 1|Profile 2|Profile 3|Profile 4|Profile 5"
    }
} else {
    profileList := "Profile 1|Profile 2|Profile 3|Profile 4|Profile 5"
}

; ---------------------------------------------------
;                  BUILD THE GUI
; ---------------------------------------------------
Gui, Color, 0x151515
Gui, Font, s12, Opensans
Gui, Margin, 10, 10
Gui, Add, Button, x430 y10 w90 h25 gUpdateButton, Start
Gui, Add, Text, x20 y295 cYellow, For Liberty - V6.9 Developed By HD

; -- Add a picture in top-right corner --
Gui, Add, Picture, x520 y330 w10 h10 vBGPic, %backgroundImagePath%

TabColors_Tab1=FF0000
TabColors_Tab2=0x00FFFF
TabColors_Tab3=00FF00
TabColors_Tab4=0000FF
TabColors_Tab5=FF69B4

Gui, Add, Tab2, w520 x10 y10 h310 AltSubmit cRed gTab vTab
	, Keybinds|Stratagems|Weapons|Profiles/Extra|Help
    Gosub, Tab


; ***********************
;       TAB: Keybinds
; ***********************
Gui, Tab, Keybinds

; Group: Keybinds
Gui, Add, GroupBox, x10 y35 w280 h255 cRed, KeyBinds
    ; Slot 1
    Gui, Add, Text, x20 y55 cFFB000, Stratagem 1:
    Gui, Add, DropDownList, x20 y75 w215 vAction1, ::EAGLES::| |---Airstrikes---|Eagle Airstrike|Eagle Napalm Airstrike| |---Bombs---|Eagle 500kg Bomb|Eagle Cluster Bomb| |---Tactical---|Eagle 110MM Rocket Pods|Eagle Air-to-Air Missiles|Eagle Smoke Strike|Eagle Strafing Run|   |::ORBITALS::| |---Team Hazards---|Orbital 120MM HE Barrage|Orbital 380MM HE Barrage|Orbital Gatling Barrage|Orbital Napalm Barrage|Orbital Walking Barrage| |---Orbital Strikes---|Orbital Airburst Strike|Orbital EMS Strike|Orbital Gas Strike|Orbital Smoke Strike|Orbital Precision Strike|Orbital Lasers|Orbital Railcannon Strike|   |::SENTRYS::| |---Mines---|Anti-Personnel Minefield|Gas Mines|Anti Tank Mines|Incendiary Mines| |---Turrets---|Autocannon Sentry|Gatling Sentry|Flame Sentry|Machine Gun Sentry|EMS Mortar Sentry|Mortar Sentry|Rocket Sentry|Missile Silo|Tesla Tower| |---Emplacements---|Anti Tank Emplacement|HMG Emplacement|  |::SUPPORT::| |---Backpacks---|Ballistic Shield Backpack|Displacer Pack|Shield Generator Pack|Supply Pack|Jump Pack| |---Dogos---|Guard Dog|Guard Dog Rover|Guard Dog Dog Breath| |---Tactical Cover---|Defense Wall|Grenadier Battlement|Directional Shield|Shield Generation Relay| |---Meds---|Medical Supplies|   |::VEHICLES::| |---TitanFall---|Emancipator Exosuit|Patriot Exosuit| |---Transport---|Light Armmored Vehicle|Fast Recon Vehicle|   |::WEAPONS::| |---Cannons---|Laser Cannon|Autocannon|Quasar Cannon| |---Launchers---|StA-X3 W.A.S.P. Launcher|AirBurst Rocket Launcher|Grenade Launcher| |---Anti Tank---|Expendable Anti-Tank|Railgun|Spear|Stinger| |---Machine Guns---|Machine Gun|Heavy Machine Gun|Stalwart| |---Rifles---|Anti-Material Rifle|Recoiled Rifle| |---Throwers---|Arc Thrower|Flamethrower|Sterilizer
    Gui, Add, Text, x325 y105 w130 h21 +0x200 cFFB000,Stratagemkey1:
    Gui, Add, Hotkey, x440 y102 w50 h25 vHotkey1, %Hotkey1%

    ; Slot 2
    Gui, Add, Text, x20 y105 cFFB000, Stratagem 2:
    Gui, Add, DropDownList, x20 y125 w215 vAction2, ::EAGLES::| |---Airstrikes---|Eagle Airstrike|Eagle Napalm Airstrike| |---Bombs---|Eagle 500kg Bomb|Eagle Cluster Bomb| |---Tactical---|Eagle 110MM Rocket Pods|Eagle Air-to-Air Missiles|Eagle Smoke Strike|Eagle Strafing Run|   |::ORBITALS::| |---Team Hazards---|Orbital 120MM HE Barrage|Orbital 380MM HE Barrage|Orbital Gatling Barrage|Orbital Napalm Barrage|Orbital Walking Barrage| |---Orbital Strikes---|Orbital Airburst Strike|Orbital EMS Strike|Orbital Gas Strike|Orbital Smoke Strike|Orbital Precision Strike|Orbital Lasers|Orbital Railcannon Strike|   |::SENTRYS::| |---Mines---|Anti-Personnel Minefield|Gas Mines|Anti Tank Mines|Incendiary Mines| |---Turrets---|Autocannon Sentry|Gatling Sentry|Flame Sentry|Machine Gun Sentry|EMS Mortar Sentry|Mortar Sentry|Rocket Sentry|Missile Silo|Tesla Tower| |---Emplacements---|Anti Tank Emplacement|HMG Emplacement|  |::SUPPORT::| |---Backpacks---|Ballistic Shield Backpack|Displacer Pack|Shield Generator Pack|Supply Pack|Jump Pack| |---Dogos---|Guard Dog|Guard Dog Rover|Guard Dog Dog Breath| |---Tactical Cover---|Defense Wall|Grenadier Battlement|Directional Shield|Shield Generation Relay| |---Meds---|Medical Supplies|   |::VEHICLES::| |---TitanFall---|Emancipator Exosuit|Patriot Exosuit| |---Transport---|Light Armmored Vehicle|Fast Recon Vehicle|   |::WEAPONS::| |---Cannons---|Laser Cannon|Autocannon|Quasar Cannon| |---Launchers---|StA-X3 W.A.S.P. Launcher|AirBurst Rocket Launcher|Grenade Launcher| |---Anti Tank---|Expendable Anti-Tank|Railgun|Spear|Stinger| |---Machine Guns---|Machine Gun|Heavy Machine Gun|Stalwart| |---Rifles---|Anti-Material Rifle|Recoiled Rifle| |---Throwers---|Arc Thrower|Flamethrower|Sterilizer
    Gui, Add, Text, x325 y130 w130 h21 +0x200 cFFB000, Stratagemkey2:
    Gui, Add, Hotkey, x440 y128 w50 h25 vHotkey2, %Hotkey2%


    ; Slot 3
    Gui, Add, Text, x20 y155 cFFB000, Stratagem 3:
    Gui, Add, DropDownList, x20 y175 w215 vAction3, ::EAGLES::| |---Airstrikes---|Eagle Airstrike|Eagle Napalm Airstrike| |---Bombs---|Eagle 500kg Bomb|Eagle Cluster Bomb| |---Tactical---|Eagle 110MM Rocket Pods|Eagle Air-to-Air Missiles|Eagle Smoke Strike|Eagle Strafing Run|   |::ORBITALS::| |---Team Hazards---|Orbital 120MM HE Barrage|Orbital 380MM HE Barrage|Orbital Gatling Barrage|Orbital Napalm Barrage|Orbital Walking Barrage| |---Orbital Strikes---|Orbital Airburst Strike|Orbital EMS Strike|Orbital Gas Strike|Orbital Smoke Strike|Orbital Precision Strike|Orbital Lasers|Orbital Railcannon Strike|   |::SENTRYS::| |---Mines---|Anti-Personnel Minefield|Gas Mines|Anti Tank Mines|Incendiary Mines| |---Turrets---|Autocannon Sentry|Gatling Sentry|Flame Sentry|Machine Gun Sentry|EMS Mortar Sentry|Mortar Sentry|Rocket Sentry|Missile Silo|Tesla Tower| |---Emplacements---|Anti Tank Emplacement|HMG Emplacement|  |::SUPPORT::| |---Backpacks---|Ballistic Shield Backpack|Displacer Pack|Shield Generator Pack|Supply Pack|Jump Pack| |---Dogos---|Guard Dog|Guard Dog Rover|Guard Dog Dog Breath| |---Tactical Cover---|Defense Wall|Grenadier Battlement|Directional Shield|Shield Generation Relay| |---Meds---|Medical Supplies|   |::VEHICLES::| |---TitanFall---|Emancipator Exosuit|Patriot Exosuit| |---Transport---|Light Armmored Vehicle|Fast Recon Vehicle|   |::WEAPONS::| |---Cannons---|Laser Cannon|Autocannon|Quasar Cannon| |---Launchers---|StA-X3 W.A.S.P. Launcher|AirBurst Rocket Launcher|Grenade Launcher| |---Anti Tank---|Expendable Anti-Tank|Railgun|Spear|Stinger| |---Machine Guns---|Machine Gun|Heavy Machine Gun|Stalwart| |---Rifles---|Anti-Material Rifle|Recoiled Rifle| |---Throwers---|Arc Thrower|Flamethrower|Sterilizer
    Gui, Add, Text, x325 y155 w130 h21 +0x200 cFFB000, Stratagemkey3:
    Gui, Add, Hotkey, x440 y154 w50 h25 vHotkey3, %Hotkey3%

    ; Slot 4
    Gui, Add, Text, x20 y205 cFFB000, Stratagem 4:
    Gui, Add, DropDownList, x20 y225 w215 vAction4, ::EAGLES::| |---Airstrikes---|Eagle Airstrike|Eagle Napalm Airstrike| |---Bombs---|Eagle 500kg Bomb|Eagle Cluster Bomb| |---Tactical---|Eagle 110MM Rocket Pods|Eagle Air-to-Air Missiles|Eagle Smoke Strike|Eagle Strafing Run|   |::ORBITALS::| |---Team Hazards---|Orbital 120MM HE Barrage|Orbital 380MM HE Barrage|Orbital Gatling Barrage|Orbital Napalm Barrage|Orbital Walking Barrage| |---Orbital Strikes---|Orbital Airburst Strike|Orbital EMS Strike|Orbital Gas Strike|Orbital Smoke Strike|Orbital Precision Strike|Orbital Lasers|Orbital Railcannon Strike|   |::SENTRYS::| |---Mines---|Anti-Personnel Minefield|Gas Mines|Anti Tank Mines|Incendiary Mines| |---Turrets---|Autocannon Sentry|Gatling Sentry|Flame Sentry|Machine Gun Sentry|EMS Mortar Sentry|Mortar Sentry|Rocket Sentry|Missile Silo|Tesla Tower| |---Emplacements---|Anti Tank Emplacement|HMG Emplacement|  |::SUPPORT::| |---Backpacks---|Ballistic Shield Backpack|Displacer Pack|Shield Generator Pack|Supply Pack|Jump Pack| |---Dogos---|Guard Dog|Guard Dog Rover|Guard Dog Dog Breath| |---Tactical Cover---|Defense Wall|Grenadier Battlement|Directional Shield|Shield Generation Relay| |---Meds---|Medical Supplies|   |::VEHICLES::| |---TitanFall---|Emancipator Exosuit|Patriot Exosuit| |---Transport---|Light Armmored Vehicle|Fast Recon Vehicle|   |::WEAPONS::| |---Cannons---|Laser Cannon|Autocannon|Quasar Cannon| |---Launchers---|StA-X3 W.A.S.P. Launcher|AirBurst Rocket Launcher|Grenade Launcher| |---Anti Tank---|Expendable Anti-Tank|Railgun|Spear|Stinger| |---Machine Guns---|Machine Gun|Heavy Machine Gun|Stalwart| |---Rifles---|Anti-Material Rifle|Recoiled Rifle| |---Throwers---|Arc Thrower|Flamethrower|Sterilizer
    Gui, Add, Text, x325 y180 w130 h21 +0x200 cFFB000, Stratagemkey4:
    Gui, Add, Hotkey, x440 y180 w50 h25 vHotkey4, %Hotkey4%

Gui, Add, GroupBox, x317 y89 w185 h120 cRed
; Additional Key
Gui, Add, GroupBox, x317 y40 w185 h60 cred, StratMenu Key
    Gui, Add, Edit, x373 y62 w80 h30 vControlKeyEdit, %ControlKey%

; Additional Slot
Gui, Add, GroupBox, x295 y230 w225 h60 cff00ff, Additional Stratagem
    Gui, Add, DropDownList, x300 y253 w215 vAction5, ::EAGLES::| |---Airstrikes---|Eagle Airstrike|Eagle Napalm Airstrike| |---Bombs---|Eagle 500kg Bomb|Eagle Cluster Bomb| |---Tactical---|Eagle 110MM Rocket Pods|Eagle Air-to-Air Missiles|Eagle Smoke Strike|Eagle Strafing Run|   |::ORBITALS::| |---Team Hazards---|Orbital 120MM HE Barrage|Orbital 380MM HE Barrage|Orbital Gatling Barrage|Orbital Napalm Barrage|Orbital Walking Barrage| |---Orbital Strikes---|Orbital Airburst Strike|Orbital EMS Strike|Orbital Gas Strike|Orbital Smoke Strike|Orbital Precision Strike|Orbital Lasers|Orbital Railcannon Strike|   |::SENTRYS::| |---Mines---|Anti-Personnel Minefield|Gas Mines|Anti Tank Mines|Incendiary Mines| |---Turrets---|Autocannon Sentry|Gatling Sentry|Flame Sentry|Machine Gun Sentry|EMS Mortar Sentry|Mortar Sentry|Rocket Sentry|Missile Silo|Tesla Tower| |---Emplacements---|Anti Tank Emplacement|HMG Emplacement|  |::SUPPORT::| |---Backpacks---|Ballistic Shield Backpack|Displacer Pack|Shield Generator Pack|Supply Pack|Jump Pack| |---Dogos---|Guard Dog|Guard Dog Rover|Guard Dog Dog Breath| |---Tactical Cover---|Defense Wall|Grenadier Battlement|Directional Shield|Shield Generation Relay| |---Meds---|Medical Supplies|   |::VEHICLES::| |---TitanFall---|Emancipator Exosuit|Patriot Exosuit| |---Transport---|Light Armmored Vehicle|Fast Recon Vehicle|   |::WEAPONS::| |---Cannons---|Laser Cannon|Autocannon|Quasar Cannon| |---Launchers---|StA-X3 W.A.S.P. Launcher|AirBurst Rocket Launcher|Grenade Launcher| |---Anti Tank---|Expendable Anti-Tank|Railgun|Spear|Stinger| |---Machine Guns---|Machine Gun|Heavy Machine Gun|Stalwart| |---Rifles---|Anti-Material Rifle|Recoiled Rifle| |---Throwers---|Arc Thrower|Flamethrower|Sterilizer
    Gui, Add, Text, x325 y210 w120 cff00ff, AddStrat Key:
    Gui, Add, Hotkey, x440 y209 w50 h25 vHotkey5, %Hotkey5%

; ***********************
;      TAB: Stratagems
; ***********************
Gui, Tab, Stratagems

; Group: Stratagems
Gui, Add, GroupBox, x12 y40 w290 h100 cb3d7ff, Support Stratagems
Gui, Add, GroupBox, x12 y160 w290 h100 cb3d7ff, Mission Stratagems
    Gui, Add, GroupBox, x20 y60 w85 h60 c0x00FFFF, Resupply
    Gui, Add, Hotkey, x37 y82 w50 h30 vResupply1, %Resupply%

    Gui, Add, GroupBox, x200 y60 w65 h60 c0x00FFFF, Rearm
    Gui, Add, Hotkey, x207 y82 w50 h30 vRearm1, %Rearm%

    Gui, Add, GroupBox, x110 y60 w85 h60 c0x00FFFF, Renforce
    Gui, Add, Hotkey, x127 y82 w50 h30 vRenforce1, %Renforce%

    Gui, Add, GroupBox, x30 y185 w85 h60 c0x00FFFF, Hellbomb
    Gui, Add, Hotkey, x47  y207 w50 h30 vHellbomb1, %Hellbomb%

    Gui, Add, GroupBox, x130 y185 w115 h60 c0x00FFFF, SEAF Artillery
    Gui, Add, Hotkey, x160 y207 w50 h30 vSEAF1, %SEAF%


; ***********************
;      TAB: Weapons
; ***********************
Gui, Tab, Weapons

Gui, Add, GroupBox, x10 y45 w180 h60 cGreen, Weapon Modes
    Gui, Add, DropDownList, x20 y67 w160 vGuns, ::RAILGUN::|Safe|Unsafe|   |::ArcThrower::|Rapid Arc|Full Arc|

Gui, Add, GroupBox, x200 y45 w115 h60 cGreen, Weapons Key
    Gui, Add, Edit, x210 y67 w95 h30 vUnsafeRailgun1, %UnsafeRailgun%

; ***********************
;   TAB: Profiles/Extra
; ***********************
Gui, Tab, Profiles/Extra

; Profiles box
Gui, Add, GroupBox, x11 y45 w160 h80 cRed, Profiles
    Gui, Add, DropDownList, x20 y65 w140 vProfile, %profileList%
    Gui, Add, Button, x20 y95 w140 h25 gRenameProfileButton, Rename

Gui, Add, GroupBox, x180 y45 w145 h80 cRed, Save/Load
    Gui, Add, Button, x190 y65 w125 h25 gSaveButton, Save
    Gui, Add, Button, x190 y93 w125 h25 gLoadButton, Load

; Restart Box
Gui, Add, GroupBox, x350 y45 w130 h80 cFF69B4, Restart
    Gui, Add, Button, x360 y65 w110 h25 gRestartButton, Restart Script

; ***********************
;        TAB: Help
; ***********************
Gui, Tab, Help

Gui, Add, GroupBox, x10 y45 w120 h80 cFF69B4, Read Me
    Gui, Add, Button, x20 y65 w100 h25 gReadMeButton, Help?


; End the tab control
Gui, Tab
Gui, Show, w540 h330, For LIBERTY!

Tab:
GuiControlGet, Tab
GuiControl, % "+c" TabColors_Tab%Tab%, Tab
return

; ---------------------------------------------------
;   CHANGE TAB COLORS (BACKGROUND & TEXT)
; ---------------------------------------------------
; These messages work on standard SysTabControl32 controls.

; Retrieve the HWND of the tab control.
; The ClassNN "SysTabControl321" is the default for the first tab control in the GUI.
Gui +LastFound
ControlGet, hTab, Hwnd,, SysTabControl321, For LIBERTY!

; Set the tab background color to a dark gray (0x222222). Must be in BGR format.
; 0x00222222 in hex = 2236962 decimal.
SendMessage, %TCM_SETBKCOLOR%, 0, 0x00222222,, ahk_id %hTab%

; Set the tab text color to white (0xFFFFFF). (In BGR or standard is the same for white.)
SendMessage, %TCM_SETTEXTCOLOR%, 0, 0x00FFFFFF,, ahk_id %hTab%

return

; ---------------------------------------------------
;            BUTTON / HOTKEY HANDLERS
; ---------------------------------------------------
ReadMeButton:
    Run, notepad.exe HELP.txt
return

UpdateButton:
{
    GuiControlGet, NewResupplyHotkey,, Resupply1
    if (NewResupplyHotkey = "") {
        MsgBox, 48, Missing Field, Please specify a hotkey for Resupply.
        return
    }

    GuiControlGet, NewRenforceHotkey,, Renforce1
    if (NewRenforceHotkey = "") {
        MsgBox, 48, Missing Field, Please specify a hotkey for Renforce.
        return
    }

    GuiControlGet, NewRearmHotkey,, Rearm1
    if (NewRearmHotkey = "") {
        MsgBox, 48, Missing Field, Please specify a hotkey for Rearm.
        return
    }

    GuiControlGet, NewHellbombHotkey,, Hellbomb1
    if (NewHellbombHotkey = "") {
        MsgBox, 48, Missing Field, Please specify a hotkey for Hellbomb.
        return
    }

    GuiControlGet, NewSEAFHotkey,, SEAF1
    if (NewSEAFHotkey = "") {
        MsgBox, 48, Missing Field, Please specify a hotkey for SEAF.
        return
    }

    GuiControlGet, ControlKey,, ControlKeyEdit
    ControlKey := (InStr(ControlKey, "Control") || InStr(ControlKey, "Ctrl")) ? "Ctrl" : ControlKey

    if (OldResupplyHotkey != "")
        Hotkey, %OldResupplyHotkey%, Off
    if (OldRenforceHotkey != "")
        Hotkey, %OldRenforceHotkey%, Off
    if (OldRearmHotkey != "")
        Hotkey, %OldRearmHotkey%, Off
    if (OldHellbombHotkey != "")
        Hotkey, %OldHellbombHotkey%, Off
    if (OldSEAFHotkey != "")
        Hotkey, %OldSEAFHotkey%, Off

    Hotkey, %NewResupplyHotkey%, Resupply1, On
    Hotkey, %NewRenforceHotkey%, Renforce1, On
    Hotkey, %NewRearmHotkey%, Rearm1, On
    Hotkey, %NewHellbombHotkey%, Hellbomb1, On
    Hotkey, %NewSEAFHotkey%, SEAF1, On

    OldResupplyHotkey := NewResupplyHotkey
    OldRenforceHotkey := NewRenforceHotkey
    OldRearmHotkey := NewRearmHotkey
    OldHellbombHotkey := NewHellbombHotkey
    OldSEAFHotkey := NewSEAFHotkey
    OldUnsafeRailgunHotkey := NewUnsafeRailgunHotkey

    GuiControlGet, NewHotkey1,, Hotkey1
    GuiControlGet, NewHotkey2,, Hotkey2
    GuiControlGet, NewHotkey3,, Hotkey3
    GuiControlGet, NewHotkey4,, Hotkey4
    GuiControlGet, NewHotkey5,, Hotkey5
    GuiControlGet, NewUnsafeRailgunHotkey,, UnsafeRailgun1

    ToggleHotkey(OldHotkey1, NewHotkey1, "ActionHandler1")
    ToggleHotkey(OldHotkey2, NewHotkey2, "ActionHandler2")
    ToggleHotkey(OldHotkey3, NewHotkey3, "ActionHandler3")
    ToggleHotkey(OldHotkey4, NewHotkey4, "ActionHandler4")
    ToggleHotkey(OldHotkey5, NewHotkey5, "ActionHandler5")
    ToggleHotkey(OldUnsafeRailgunHotkey, NewUnsafeRailgunHotkey, "ActionHandler6")

    OldHotkey1 := NewHotkey1
    OldHotkey2 := NewHotkey2
    OldHotkey3 := NewHotkey3
    OldHotkey4 := NewHotkey4
    OldHotkey5 := NewHotkey5
    OldUnsafeRailgunHotkey := NewUnsafeRailgunHotkey

    GuiControlGet, Guns,, Guns
    GuiControlGet, Action1,, Action1
    GuiControlGet, Action2,, Action2
    GuiControlGet, Action3,, Action3
    GuiControlGet, Action4,, Action4
    GuiControlGet, Action5,, Action5
}
return

SaveButton:
{
    Gui, Submit, NoHide
    profile := Profile
    fileName := profile ".txt"
    FileDelete, %fileName%
    File := FileOpen(fileName, "w")
    if !File
        return

    ; Write each line in the same order as loaded
    File.WriteLine(NewHotkey1)
    File.WriteLine(NewHotkey2)
    File.WriteLine(NewHotkey3)
    File.WriteLine(NewHotkey4)
    File.WriteLine(NewHotkey5)
    File.WriteLine(NewResupplyHotkey)
    File.WriteLine(NewRenforceHotkey)
    File.WriteLine(NewRearmHotkey)
    File.WriteLine(NewHellbombHotkey)
    File.WriteLine(NewSEAFHotkey)
    File.WriteLine(ControlKey)
    if (NewUnsafeRailgunHotkey != "")
        File.WriteLine(NewUnsafeRailgunHotkey)

    File.WriteLine(SelectedGuns)
    File.WriteLine(SelectedAction1)
    File.WriteLine(SelectedAction2)
    File.WriteLine(SelectedAction3)
    File.WriteLine(SelectedAction4)
    File.WriteLine(SelectedAction5)
    File.Close()

    MsgBox, 64, Saved, Keybinds saved successfully.
}
return

LoadButton:
{
    Gui, Submit, NoHide
    profile := Profile
    fileName := profile ".txt"
    FileRead, Keybinds, %fileName%
    if ErrorLevel {
        MsgBox, 48, Error, Could not load keybinds from file.
        return
    }

    StringSplit, KeybindArray, Keybinds, `n
    Hotkey1       := KeybindArray1
    Hotkey2       := KeybindArray2
    Hotkey3       := KeybindArray3
    Hotkey4       := KeybindArray4
    Hotkey5       := KeybindArray5
    Resupply      := KeybindArray6
    Renforce      := KeybindArray7
    Rearm         := KeybindArray8
    Hellbomb      := KeybindArray9
    SEAF          := KeybindArray10
    ControlKey    := KeybindArray11
    UnsafeRailgun := KeybindArray12

    Guns          := KeybindArray13
    Action1       := KeybindArray14
    Action2       := KeybindArray15
    Action3       := KeybindArray16
    Action4       := KeybindArray17
    Action5       := KeybindArray18

    MsgBox, 64, Loaded, Loaded Profile

    GuiControl,, Hotkey1, %Hotkey1%
    GuiControl,, Hotkey2, %Hotkey2%
    GuiControl,, Hotkey3, %Hotkey3%
    GuiControl,, Hotkey4, %Hotkey4%
    GuiControl,, Hotkey5, %Hotkey5%
    GuiControl,, Resupply1, %Resupply%
    GuiControl,, Renforce1, %Renforce%
    GuiControl,, Rearm1, %Rearm%
    GuiControl,, Hellbomb1, %Hellbomb%
    GuiControl,, SEAF1, %SEAF%
    GuiControl,, ControlKeyEdit, %ControlKey%
    GuiControl,, UnsafeRailgun1, %UnsafeRailgun%

    GuiControl,, Guns,
    GuiControl,, Action1,
    GuiControl,, Action2,
    GuiControl,, Action3,
    GuiControl,, Action4,
    GuiControl,, Action5,

    GuiControl,, Guns, %Guns%
    GuiControl,, Action1, %Action1%
    GuiControl,, Action2, %Action2%
    GuiControl,, Action3, %Action3%
    GuiControl,, Action4, %Action4%
    GuiControl,, Action5, %Action5%

    GuiControl, ChooseString, Guns, %Guns%
    GuiControl, ChooseString, Action1, %Action1%
    GuiControl, ChooseString, Action2, %Action2%
    GuiControl, ChooseString, Action3, %Action3%
    GuiControl, ChooseString, Action4, %Action4%
    GuiControl, ChooseString, Action5, %Action5%

    Gui, Show
}
return

RestartButton:
    Run, %A_ScriptFullPath%
    ExitApp
return

RenameProfileButton:
{
    Gui, Submit, NoHide
    GuiControlGet, selectedProfile, , Profile

    InputBox, newProfile, Rename Profile, Enter the new profile name:
    if ErrorLevel {
        MsgBox, 48, Cancelled, Rename cancelled.
        return
    }

    profilesArray := StrSplit(profileList, "|")
    for index, value in profilesArray {
        if (value = selectedProfile) {
            profilesArray[index] := newProfile
            break
        }
    }

    newProfileList := ""
    for index, value in profilesArray {
        newProfileList .= value "|"
    }
    StringTrimRight, newProfileList, newProfileList, 1

    FileDelete, %profileFile%
    FileAppend, %newProfileList%, %profileFile%

    GuiControl,, Profile, |%newProfileList%
    GuiControl, ChooseString, Profile, %newProfile%

    profileList := newProfileList
    MsgBox, 64, Success, Profile renamed successfully.
}
return

; ---------------------------------------------------
;                 HOTKEY HANDLERS
; ---------------------------------------------------
Send1(key) {
    AHI.SendKeyEvent(keyboardId, GetKeySC(key), 1)
}

Send2(key) {
    AHI.SendKeyEvent(keyboardId, GetKeySC(key), 0)
}
SendMouse1(button) {
    AHI.SendMouseButtonEvent(mouseId, GetKeySC(button), 1)
}

SendMouse2(button) {
    AHI.SendMouseButtonEvent(mouseId, GetKeySC(button), 0)
}

Resupply1() {
    Resupply()
}

Renforce1() {
    Renforce()
}
Rearm1() {
    Rearm()
}
Hellbomb1() {
    Hellbomb()
}
SEAF1() {
    SEAF()
}

Resupply() {

    Send1(ControlKey)
    Sleep 50


    if (GetKeyState(ControlKey, "P")) {

        Send1("Down")
        Sleep 50
        Send2("Down")
        Sleep 50
        Send1("Down")
        Sleep 50
        Send2("Down")
        Sleep 50
        Send1("Up")
        Sleep 50
        Send2("Up")
        Sleep 50
        Send1("Right")
        Sleep 50
        Send2("Right")
    }


    Sleep 50


    Send2(ControlKey)
}
Renforce() {

    Send1(ControlKey)
    Sleep 50


    if (GetKeyState(ControlKey, "P")) {

        Send1("Up")
        Sleep 50
        Send2("Up")
        Sleep 50
        Send1("Down")
        Sleep 50
        Send2("Down")
        Sleep 50
        Send1("Right")
        Sleep 50
        Send2("Right")
        Sleep 50
        Send1("Left")
        Sleep 50
        Send2("Left")
        Sleep 50
        Send1("Up")
        Sleep 50
        Send2("Up")
    }


    Sleep 50


    Send2(ControlKey)
}
Rearm() {

    Send1(ControlKey)
    Sleep 50

    if (GetKeyState(ControlKey, "P")) {

        Send1("Up")
        Sleep 50
        Send2("Up")
        Sleep 50
        Send1("Up")
        Sleep 50
        Send2("Up")
        Sleep 50
        Send1("Left")
        Sleep 50
        Send2("Left")
        Sleep 50
        Send1("Up")
        Sleep 50
        Send2("Up")
        Sleep 50
        Send1("Right")
        Sleep 50
        Send2("Right")
    }


    Sleep 50


    Send2(ControlKey)
}
Hellbomb() {

    Send1(ControlKey)
    Sleep 50


    if (GetKeyState(ControlKey, "P")) {

        Send1("Down")
        Sleep 50
        Send2("Down")
        Sleep 50
        Send1("Up")
        Sleep 50
        Send2("Up")
        Sleep 50
        Send1("Left")
        Sleep 50
        Send2("Left")
        Sleep 50
        Send1("Down")
        Sleep 50
        Send2("Down")
        Sleep 50
        Send1("Up")
        Sleep 50
        Send2("Up")
        Sleep 50
        Send1("Right")
        Sleep 50
        Send2("Right")
        Sleep 50
        Send1("Down")
        Sleep 50
        Send2("Down")
        Sleep 50
        Send1("Up")
        Sleep 50
        Send2("Up")
    }


    Sleep 50


    Send2(ControlKey)
}
SEAF() {

    Send1(ControlKey)
    Sleep 50


    if (GetKeyState(ControlKey, "P")) {

        Send1("Right")
        Sleep 50
        Send2("Right")
        Sleep 50
        Send1("Up")
        Sleep 50
        Send2("Up")
        Sleep 50
        Send1("Up")
        Sleep 50
        Send2("Up")
        Sleep 50
        Send1("Down")
        Sleep 50
        Send2("Down")
    }


    Sleep 50


    Send2(ControlKey)
}


ActionHandler6:
    GuiControlGet, SelectedGuns, , Guns
    if (SelectedGuns == "Safe" || SelectedGuns == "Unsafe" || SelectedGuns == "Rapid Arc" || SelectedGuns == "Full Arc" || SelectedGuns == "Rapid Safe" || SelectedGuns == "Rapid Unsafe"){
        SendGuns(SelectedGuns)
    }
return

SendGuns(action) {

    switch (action) {
        case "Safe":
            SendMouse1("Lbutton")
            Sleep, 700
            SendMouse2("Lbutton")
            Sleep, 50
            Send1("r")
            Sleep, 50
            Send2("r")

        case "Unsafe":
            SendMouse1("Lbutton")
            Sleep, 2400
            SendMouse2("Lbutton")
            Sleep, 50
            Send1("r")
            Sleep, 50
            Send2("r")

        case "Rapid Arc":

            SendMouse1("Lbutton")
            ButtonHeld := true


            while(ButtonHeld) {

                Sleep, 50


                SendMouse1("Lbutton")
                Sleep, 800
                SendMouse2("Lbutton")

                if (!GetKeyState("Lbutton", "P"))
                    ButtonHeld := false
            }

            SendMouse2("Lbutton")

        case "Full Arc":

            SendMouse1("Lbutton")
            ButtonHeld := true


            while(ButtonHeld) {

                Sleep, 50


                SendMouse1("Lbutton")
                Sleep, 1100
                SendMouse2("Lbutton")

                if (!GetKeyState("Lbutton", "P"))
                    ButtonHeld := false
            }

            SendMouse2("Lbutton")

        case "Rapid Safe":

            while (!ButtonHeld) {

                ButtonHeld := true


            while (ButtonHeld && GetKeyState("Lbutton", "P")) {

                Sleep, 100


                SendMouse1("Lbutton")
                Sleep, 1100
                SendMouse2("Lbutton")
                Sleep, 50
                Send1("r")
                Sleep, 50
                Send2("r")

                if (!GetKeyState("Lbutton", "P") || GetKeyState("Escape", "P")) {
                    ButtonHeld := false
                    break
                }
            }
        }
        case "Rapid Unsafe":

            SendMouse1("Lbutton")
            ButtonHeld := true


            while(ButtonHeld) {

                Sleep, 150


                SendMouse1("Lbutton")
                Sleep, 2400
                SendMouse2("Lbutton")
                Sleep, 50
                Send1("r")
                Sleep, 50
                Send2("r")

                if (!GetKeyState("Lbutton", "P"))
                    ButtonHeld := false
            }

            SendMouse2("Lbutton")
    }

}

ActionHandler1:

    GuiControlGet, SelectedAction1, , Action1

    if (SelectedAction1 == "Orbital Precision Strike" || SelectedAction1 == "Eagle Airstrike" || SelectedAction1 == "Eagle Napalm Airstrike" || SelectedAction1 == "Incendiary Mines" || SelectedAction1 == "Machine Gun" || SelectedAction1 == "Anti-Material Rifle" || SelectedAction1 == "Stalwart" || SelectedAction1 == "Expendable Anti-Tank" || SelectedAction1 == "Recoiled Rifle" || SelectedAction1 == "Flamethrower" || SelectedAction1 == "Autocannon" || SelectedAction1 == "Railgun" || SelectedAction1 == "Spear" || SelectedAction1 == "Orbital Gatling Barrage" || SelectedAction1 == "Orbital Airburst Strike" || SelectedAction1 == "Orbital 120MM HE Barrage" || SelectedAction1 == "Orbital 380MM HE Barrage" || SelectedAction1 == "Orbital Walking Barrage" || SelectedAction1 == "Orbital Lasers" || SelectedAction1 == "Orbital Railcannon Strike" || SelectedAction1 == "Eagle Strafing Run" || SelectedAction1 == "Eagle Cluster Bomb" || SelectedAction1 == "Jump Pack" || SelectedAction1 == "Eagle Smoke Strike" || SelectedAction1 == "Eagle 110MM Rocket Pods" || SelectedAction1 == "Eagle 500kg Bomb" || SelectedAction1 == "Orbital Gas Strike" || SelectedAction1 == "Orbital EMS Strike" || SelectedAction1 == "Orbital Smoke Strike" || SelectedAction1 == "HMG Emplacement" || SelectedAction1 == "Shield Generation Relay" || SelectedAction1 == "Tesla Tower" || SelectedAction1 == "Anti-Personnel Minefield" || SelectedAction1 == "Supply Pack" || SelectedAction1 == "Grenade Launcher" || SelectedAction1 == "Laser Cannon" || SelectedAction1 == "Guard Dog Rover" || SelectedAction1 == "Ballistic Shield Backpack" || SelectedAction1 == "Arc thrower" || SelectedAction1 == "Shield Generator Pack" || SelectedAction1 == "Machine Gun Sentry" || SelectedAction1 == "Gatling Sentry" || SelectedAction1 == "Mortar Sentry" || SelectedAction1 == "Guard Dog" || SelectedAction1 == "Autocannon Sentry" || SelectedAction1 == "Rocket Sentry" || SelectedAction1 == "EMS Mortar Sentry" || SelectedAction1 == "Patriot Exosuit" || SelectedAction1 == "Fast Recon Vehicle" || SelectedAction1 == "Light Armmored Vehicle"|| SelectedAction1 == "Emancipator Exosuit" || SelectedAction1 == "Displacer Pack" || SelectedAction1 == "Commando" || SelectedAction1 == "Heavy Machine Gun" || SelectedAction1 == "Stinger" || SelectedAction1 == "Medical Supplies" || SelectedAction1 == "Eagle Air-to-Air Missiles" || SelectedAction1 == "Missile Silo" || SelectedAction1 == "Quasar Cannon" || SelectedAction1 == "Grenadier Battlement" || SelectedAction1 == "Defense Wall" || SelectedAction1 == "Guard Dog Dog Breath" || SelectedAction1 == "Anti Tank Mines" || SelectedAction1 == "Flame Sentry" || SelectedAction1 == "Gas Mines" || SelectedAction1 == "Anti Tank Emplacement" || SelectedAction1 == "Orbital Napalm Barrage" || SelectedAction1 == "AirBurst Rocket Launcher" || SelectedAction1 == "StA-X3 W.A.S.P. Launcher" || SelectedAction1 == "Directional Shield" || SelectedAction1 == "Sterilizer") {
        SendAction(SelectedAction1)
    }

return
ActionHandler2:

    GuiControlGet, SelectedAction2, , Action2
    if (SelectedAction2 == "Orbital Precision Strike" || SelectedAction2 == "Eagle Airstrike" || SelectedAction2 == "Eagle Napalm Airstrike" || SelectedAction2 == "Incendiary Mines" || SelectedAction2 == "Machine Gun" || SelectedAction2 == "Anti-Material Rifle" || SelectedAction2 == "Stalwart" || SelectedAction2 == "Expendable Anti-Tank" || SelectedAction2 == "Recoiled Rifle" || SelectedAction2 == "Flamethrower" || SelectedAction2 == "Autocannon" || SelectedAction2 == "Railgun" || SelectedAction2 == "Spear" || SelectedAction2 == "Orbital Gatling Barrage" || SelectedAction2 == "Orbital Airburst Strike" || SelectedAction2 == "Orbital 120MM HE Barrage" || SelectedAction2 == "Orbital 380MM HE Barrage" || SelectedAction2 == "Orbital Walking Barrage" || SelectedAction2 == "Orbital Lasers" || SelectedAction2 == "Orbital Railcannon Strike" || SelectedAction2 == "Eagle Strafing Run" || SelectedAction2 == "Eagle Cluster Bomb" || SelectedAction2 == "Jump Pack" || SelectedAction2 == "Eagle Smoke Strike" || SelectedAction2 == "Eagle 110MM Rocket Pods" || SelectedAction2 == "Eagle 500kg Bomb" || SelectedAction2 == "Orbital Gas Strike" || SelectedAction2 == "Orbital EMS Strike" || SelectedAction2 == "Orbital Smoke Strike" || SelectedAction2 == "HMG Emplacement" || SelectedAction2 == "Shield Generation Relay" || SelectedAction2 == "Tesla Tower" || SelectedAction2 == "Anti-Personnel Minefield" || SelectedAction2 == "Supply Pack" || SelectedAction2 == "Grenade Launcher" || SelectedAction2 == "Laser Cannon" || SelectedAction2 == "Guard Dog Rover" || SelectedAction2 == "Ballistic Shield Backpack" || SelectedAction2 == "Arc thrower" || SelectedAction2 == "Shield Generator Pack" || SelectedAction2 == "Machine Gun Sentry" || SelectedAction2 == "Gatling Sentry" || SelectedAction2 == "Mortar Sentry" || SelectedAction2 == "Guard Dog" || SelectedAction2 == "Autocannon Sentry" || SelectedAction2 == "Rocket Sentry" || SelectedAction2 == "EMS Mortar Sentry" || SelectedAction2 == "Patriot Exosuit" || SelectedAction2 == "Fast Recon Vehicle" || SelectedAction2 == "Light Armmored Vehicle"|| SelectedAction2 == "Emancipator Exosuit" || SelectedAction2 == "Displacer Pack" || SelectedAction2 == "Commando" || SelectedAction2 == "Heavy Machine Gun" || SelectedAction2 == "Stinger" || SelectedAction2 == "Medical Supplies" || SelectedAction2 == "Eagle Air-to-Air Missiles" || SelectedAction2 == "Missile Silo" || SelectedAction2 == "Quasar Cannon" || SelectedAction2 == "Grenadier Battlement" || SelectedAction2 == "Defense Wall" || SelectedAction2 == "Guard Dog Dog Breath" || SelectedAction2 == "Anti Tank Mines" || SelectedAction2 == "Flame Sentry" || SelectedAction2 == "Gas Mines" || SelectedAction2 == "Anti Tank Emplacement" || SelectedAction2 == "Orbital Napalm Barrage" || SelectedAction2 == "AirBurst Rocket Launcher" || SelectedAction2 == "StA-X3 W.A.S.P. Launcher" || SelectedAction2 == "Directional Shield" || SelectedAction2 == "Sterilizer") {
        SendAction(SelectedAction2)
    }


return
ActionHandler3:

    GuiControlGet, SelectedAction3, , Action3
    if (SelectedAction3 == "Orbital Precision Strike" || SelectedAction3 == "Eagle Airstrike" || SelectedAction3 == "Eagle Napalm Airstrike" || SelectedAction3 == "Incendiary Mines" || SelectedAction3 == "Machine Gun" || SelectedAction3 == "Anti-Material Rifle" || SelectedAction3 == "Stalwart" || SelectedAction3 == "Expendable Anti-Tank" || SelectedAction3 == "Recoiled Rifle" || SelectedAction3 == "Flamethrower" || SelectedAction3 == "Autocannon" || SelectedAction3 == "Railgun" || SelectedAction3 == "Spear" || SelectedAction3 == "Orbital Gatling Barrage" || SelectedAction3 == "Orbital Airburst Strike" || SelectedAction3 == "Orbital 120MM HE Barrage" || SelectedAction3 == "Orbital 380MM HE Barrage" || SelectedAction3 == "Orbital Walking Barrage" || SelectedAction3 == "Orbital Lasers" || SelectedAction3 == "Orbital Railcannon Strike" || SelectedAction3 == "Eagle Strafing Run" || SelectedAction3 == "Eagle Cluster Bomb" || SelectedAction3 == "Jump Pack" || SelectedAction3 == "Eagle Smoke Strike" || SelectedAction3 == "Eagle 110MM Rocket Pods" || SelectedAction3 == "Eagle 500kg Bomb" || SelectedAction3 == "Orbital Gas Strike" || SelectedAction3 == "Orbital EMS Strike" || SelectedAction3 == "Orbital Smoke Strike" || SelectedAction3 == "HMG Emplacement" || SelectedAction3 == "Shield Generation Relay" || SelectedAction3 == "Tesla Tower" || SelectedAction3 == "Anti-Personnel Minefield" || SelectedAction3 == "Supply Pack" || SelectedAction3 == "Grenade Launcher" || SelectedAction3 == "Laser Cannon" || SelectedAction3 == "Guard Dog Rover" || SelectedAction3 == "Ballistic Shield Backpack" || SelectedAction3 == "Arc thrower" || SelectedAction3 == "Shield Generator Pack" || SelectedAction3 == "Machine Gun Sentry" || SelectedAction3 == "Gatling Sentry" || SelectedAction3 == "Mortar Sentry" || SelectedAction3 == "Guard Dog" || SelectedAction3 == "Autocannon Sentry" || SelectedAction3 == "Rocket Sentry" || SelectedAction3 == "EMS Mortar Sentry" || SelectedAction3 == "Patriot Exosuit" || SelectedAction3 == "Fast Recon Vehicle" || SelectedAction3 == "Light Armmored Vehicle"|| SelectedAction3 == "Emancipator Exosuit" || SelectedAction3 == "Displacer Pack" || SelectedAction3 == "Commando" || SelectedAction3 == "Heavy Machine Gun" || SelectedAction3 == "Stinger" || SelectedAction3 == "Medical Supplies" || SelectedAction3 == "Eagle Air-to-Air Missiles" || SelectedAction3 == "Missile Silo" || SelectedAction3 == "Quasar Cannon" || SelectedAction3 == "Grenadier Battlement" || SelectedAction3 == "Defense Wall" || SelectedAction3 == "Guard Dog Dog Breath" || SelectedAction3 == "Anti Tank Mines" || SelectedAction3 == "Flame Sentry" || SelectedAction3 == "Gas Mines" || SelectedAction3 == "Anti Tank Emplacement" || SelectedAction3 == "Orbital Napalm Barrage" || SelectedAction3 == "AirBurst Rocket Launcher" || SelectedAction3 == "StA-X3 W.A.S.P. Launcher" || SelectedAction3 == "Directional Shield" || SelectedAction3 == "Sterilizer") {
        SendAction(SelectedAction3)
    }


return
ActionHandler4:

    GuiControlGet, SelectedAction4, , Action4
    if (SelectedAction4 == "Orbital Precision Strike" || SelectedAction4 == "Eagle Airstrike" || SelectedAction4 == "Eagle Napalm Airstrike" || SelectedAction4 == "Incendiary Mines" || SelectedAction4 == "Machine Gun" || SelectedAction4 == "Anti-Material Rifle" || SelectedAction4 == "Stalwart" || SelectedAction4 == "Expendable Anti-Tank" || SelectedAction4 == "Recoiled Rifle" || SelectedAction4 == "Flamethrower" || SelectedAction4 == "Autocannon" || SelectedAction4 == "Railgun" || SelectedAction4 == "Spear" || SelectedAction4 == "Orbital Gatling Barrage" || SelectedAction4 == "Orbital Airburst Strike" || SelectedAction4 == "Orbital 120MM HE Barrage" || SelectedAction4 == "Orbital 380MM HE Barrage" || SelectedAction4 == "Orbital Walking Barrage" || SelectedAction4 == "Orbital Lasers" || SelectedAction4 == "Orbital Railcannon Strike" || SelectedAction4 == "Eagle Strafing Run" || SelectedAction4 == "Eagle Cluster Bomb" || SelectedAction4 == "Jump Pack" || SelectedAction4 == "Eagle Smoke Strike" || SelectedAction4 == "Eagle 110MM Rocket Pods" || SelectedAction4 == "Eagle 500kg Bomb" || SelectedAction4 == "Orbital Gas Strike" || SelectedAction4 == "Orbital EMS Strike" || SelectedAction4 == "Orbital Smoke Strike" || SelectedAction4 == "HMG Emplacement" || SelectedAction4 == "Shield Generation Relay" || SelectedAction4 == "Tesla Tower" || SelectedAction4 == "Anti-Personnel Minefield" || SelectedAction4 == "Supply Pack" || SelectedAction4 == "Grenade Launcher" || SelectedAction4 == "Laser Cannon" || SelectedAction4 == "Guard Dog Rover" || SelectedAction4 == "Ballistic Shield Backpack" || SelectedAction4 == "Arc thrower" || SelectedAction4 == "Shield Generator Pack" || SelectedAction4 == "Machine Gun Sentry" || SelectedAction4 == "Gatling Sentry" || SelectedAction4 == "Mortar Sentry" || SelectedAction4 == "Guard Dog" || SelectedAction4 == "Autocannon Sentry" || SelectedAction4 == "Rocket Sentry" || SelectedAction4 == "EMS Mortar Sentry" || SelectedAction4 == "Patriot Exosuit" || SelectedAction4 == "Fast Recon Vehicle" || SelectedAction4 == "Light Armmored Vehicle"|| SelectedAction4 == "Emancipator Exosuit" || SelectedAction4 == "Displacer Pack" || SelectedAction4 == "Commando" || SelectedAction4 == "Heavy Machine Gun" || SelectedAction4 == "Stinger" || SelectedAction4 == "Medical Supplies" || SelectedAction4 == "Eagle Air-to-Air Missiles" || SelectedAction4 == "Missile Silo" || SelectedAction4 == "Quasar Cannon" || SelectedAction4 == "Grenadier Battlement" || SelectedAction4 == "Defense Wall" || SelectedAction4 == "Guard Dog Dog Breath" || SelectedAction4 == "Anti Tank Mines" || SelectedAction4 == "Flame Sentry" || SelectedAction4 == "Gas Mines" || SelectedAction4 == "Anti Tank Emplacement" || SelectedAction4 == "Orbital Napalm Barrage" || SelectedAction4 == "AirBurst Rocket Launcher" || SelectedAction4 == "StA-X3 W.A.S.P. Launcher" || SelectedAction4 == "Directional Shield" || SelectedAction4 == "Sterilizer") {
        SendAction(SelectedAction4)
    }


return
ActionHandler5:

    GuiControlGet, SelectedAction5, , Action5
    if (SelectedAction5 == "Orbital Precision Strike" || SelectedAction5 == "Eagle Airstrike" || SelectedAction5 == "Eagle Napalm Airstrike" || SelectedAction5 == "Incendiary Mines" || SelectedAction5 == "Machine Gun" || SelectedAction5 == "Anti-Material Rifle" || SelectedAction5 == "Stalwart" || SelectedAction5 == "Expendable Anti-Tank" || SelectedAction5 == "Recoiled Rifle" || SelectedAction5 == "Flamethrower" || SelectedAction5 == "Autocannon" || SelectedAction5 == "Railgun" || SelectedAction5 == "Spear" || SelectedAction5 == "Orbital Gatling Barrage" || SelectedAction5 == "Orbital Airburst Strike" || SelectedAction5 == "Orbital 120MM HE Barrage" || SelectedAction5 == "Orbital 380MM HE Barrage" || SelectedAction5 == "Orbital Walking Barrage" || SelectedAction5 == "Orbital Lasers" || SelectedAction5 == "Orbital Railcannon Strike" || SelectedAction5 == "Eagle Strafing Run" || SelectedAction5 == "Eagle Cluster Bomb" || SelectedAction5 == "Jump Pack" || SelectedAction5 == "Eagle Smoke Strike" || SelectedAction5 == "Eagle 110MM Rocket Pods" || SelectedAction5 == "Eagle 500kg Bomb" || SelectedAction5 == "Orbital Gas Strike" || SelectedAction5 == "Orbital EMS Strike" || SelectedAction5 == "Orbital Smoke Strike" || SelectedAction5 == "HMG Emplacement" || SelectedAction5 == "Shield Generation Relay" || SelectedAction5 == "Tesla Tower" || SelectedAction5 == "Anti-Personnel Minefield" || SelectedAction5 == "Supply Pack" || SelectedAction5 == "Grenade Launcher" || SelectedAction5 == "Laser Cannon" || SelectedAction5 == "Guard Dog Rover" || SelectedAction5 == "Ballistic Shield Backpack" || SelectedAction5 == "Arc thrower" || SelectedAction5 == "Shield Generator Pack" || SelectedAction5 == "Machine Gun Sentry" || SelectedAction5 == "Gatling Sentry" || SelectedAction5 == "Mortar Sentry" || SelectedAction5 == "Guard Dog" || SelectedAction5 == "Autocannon Sentry" || SelectedAction5 == "Rocket Sentry" || SelectedAction5 == "EMS Mortar Sentry" || SelectedAction5 == "Patriot Exosuit" || SelectedAction5 == "Fast Recon Vehicle" || SelectedAction5 == "Light Armmored Vehicle"|| SelectedAction5 == "Emancipator Exosuit" || SelectedAction5 == "Displacer Pack" || SelectedAction5 == "Commando" || SelectedAction5 == "Heavy Machine Gun" || SelectedAction5 == "Stinger" || SelectedAction5 == "Medical Supplies" || SelectedAction5 == "Eagle Air-to-Air Missiles" || SelectedAction5 == "Missile Silo" || SelectedAction5 == "Quasar Cannon" || SelectedAction5 == "Grenadier Battlement" || SelectedAction5 == "Defense Wall" || SelectedAction5 == "Guard Dog Dog Breath" || SelectedAction5 == "Anti Tank Mines" || SelectedAction5 == "Flame Sentry" || SelectedAction5 == "Gas Mines" || SelectedAction5 == "Anti Tank Emplacement" || SelectedAction5 == "Orbital Napalm Barrage" || SelectedAction5 == "AirBurst Rocket Launcher" || SelectedAction5 == "StA-X3 W.A.S.P. Launcher" || SelectedAction5 == "Directional Shield" || SelectedAction5 == "Sterilizer") {
        SendAction(SelectedAction5)
    }

return
GuiClose:
    ExitApp
return

ToggleHotkey(oldHotkey, newHotkey, actionHandler) {
    global
    if (oldHotkey != newHotkey) {
        if (oldHotkey != "") {
            Hotkey, %oldHotkey%, Off
        }
        Hotkey, %newHotkey%, %actionHandler%
    }
}


SendAction(action) {

    Send1(ControlKey)
    Sleep 50


    switch (action) {
        case "Orbital Precision Strike":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Eagle Airstrike":
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Eagle Napalm Airstrike":
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            send1("Up")
            Sleep 50
            send2("Up")

        case "Incendiary Mines":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            send1("Down")
            Sleep 50
            send2("Down")

        case "Machine Gun":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Anti-Material Rifle":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Stalwart":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")

        case "Expendable Anti-Tank":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Recoiled Rifle":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")

        case "Flamethrower":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Autocannon":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Railgun":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Spear":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Orbital Gatling Barrage":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Orbital Airburst Strike":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Orbital 120MM HE Barrage":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Orbital 380MM HE Barrage":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Orbital Walking Barrage":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Orbital Lasers":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50

        case "Orbital Railcannon Strike":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Eagle Strafing Run":
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Eagle Cluster Bomb":
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Jump Pack":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Eagle Smoke Strike":
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Eagle 110MM Rocket Pods":
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")

        case "Eagle 500kg Bomb":
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Orbital Gas Strike":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Orbital EMS Strike":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Orbital Smoke Strike":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "HMG Emplacement":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")

        case "Shield Generation Relay":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Tesla Tower":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Anti-Personnel Minefield":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Supply Pack":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Grenade Launcher":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Laser Cannon":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")

        case "Guard Dog Rover":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Ballistic Shield Backpack":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")

        case "Arc thrower":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")

        case "Shield Generator Pack":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Machine Gun Sentry":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Gatling Sentry":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")

        case "Mortar Sentry":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Guard Dog":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Autocannon Sentry":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Rocket Sentry":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")

        case "EMS Mortar Sentry":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Patriot Exosuit": ;fix later
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Fast Recon Vehicle":
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Light Armmored Vehicle":
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Emancipator Exosuit":
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Displacer Pack":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Commando":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Heavy Machine Gun":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Stinger":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Medical Supplies":
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")

        case "Eagle Air-to-Air Missiles":
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Missile Silo":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")

        case "Quasar Cannon":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Grenadier Battlement":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Defense Wall":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Guard Dog Dog Breath":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Anti Tank Mines":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Flame Sentry":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Gas Mines":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Anti Tank Emplacement":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Orbital Napalm Barrage":
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "AirBurst Rocket Launcher":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
             Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "StA-X3 W.A.S.P. Launcher":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")

        case "Directional Shield":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Right")
            Sleep 50
            Send2("Right")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")

        case "Sterilizer":
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
            Sleep 50
            Send1("Up")
            Sleep 50
            Send2("Up")
            Sleep 50
            Send1("Down")
            Sleep 50
            Send2("Down")
            Sleep 50
            Send1("Left")
            Sleep 50
            Send2("Left")
    }


    Sleep 100


    Send2(ControlKey)
}

