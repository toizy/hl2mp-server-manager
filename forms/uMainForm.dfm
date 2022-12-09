object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 392
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object splitter: TSplitter
    Left = 466
    Top = 0
    Width = 5
    Height = 371
    Align = alRight
    ExplicitLeft = 395
    ExplicitHeight = 296
  end
  object mServerOutput: TMemo
    Left = 0
    Top = 0
    Width = 466
    Height = 371
    Align = alClient
    Font.Charset = OEM_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    HideSelection = False
    ParentFont = False
    PopupMenu = pmMemo
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WantTabs = True
    ExplicitWidth = 464
    ExplicitHeight = 367
  end
  object pBottom: TPanel
    Left = 0
    Top = 371
    Width = 698
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 1
    ExplicitTop = 367
    ExplicitWidth = 696
    object cbCommand: TComboBox
      Tag = -1
      Left = 0
      Top = 0
      Width = 698
      Height = 23
      Align = alClient
      AutoCompleteDelay = 1200
      DropDownCount = 21
      Sorted = True
      TabOrder = 0
      ExplicitWidth = 696
    end
  end
  object sbRight: TScrollBox
    Left = 471
    Top = 0
    Width = 227
    Height = 371
    Align = alRight
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    ParentBackground = True
    ParentColor = False
    TabOrder = 2
    ExplicitLeft = 469
    ExplicitHeight = 367
    object tvCommands: TTreeView
      Left = 0
      Top = 22
      Width = 227
      Height = 349
      Align = alClient
      HideSelection = False
      Indent = 19
      PopupMenu = pmTreeView
      ReadOnly = True
      RightClickSelect = True
      TabOrder = 0
      ExplicitHeight = 345
    end
    object cbFindCommand: TComboBox
      Left = 0
      Top = 0
      Width = 227
      Height = 22
      Align = alTop
      Style = csSimple
      TabOrder = 1
    end
  end
  object MainMenu: TMainMenu
    Left = 352
    Top = 16
    object Server: TMenuItem
      Caption = 'Server'
      object Manage: TMenuItem
        Caption = 'Manage'
        ShortCut = 16461
        OnClick = ManageClick
      end
    end
    object View: TMenuItem
      Caption = 'View'
      object ServerOutput: TMenuItem
        Caption = 'Server output'
        object IncreaseFontSize: TMenuItem
          Caption = 'Increase font size'
          ShortCut = 49225
        end
        object DecreaseFontSize: TMenuItem
          Caption = 'Decrease font size'
          ShortCut = 49220
        end
      end
    end
    object MenuUtils: TMenuItem
      Caption = 'Utils'
      object MenuListOfFiles: TMenuItem
        Caption = 'List of files'
        ShortCut = 16460
      end
    end
    object MenuApplication: TMenuItem
      Caption = 'Application'
      object MenuAlwaysOnTop: TMenuItem
        Caption = 'Always on top'
      end
      object MenuShowToolForm: TMenuItem
        Caption = 'Tool form'
        ShortCut = 16468
      end
    end
  end
  object pmMemo: TPopupMenu
    Left = 352
    Top = 112
    object MenuClearMemo: TMenuItem
      Caption = 'Clear'
    end
  end
  object pmTreeView: TPopupMenu
    Left = 352
    Top = 64
    object MenuExecute: TMenuItem
      Caption = 'Execute'
    end
    object MenuCollapseAll: TMenuItem
      Caption = 'Collapse all'
    end
    object MenuAddToToolForm: TMenuItem
      Caption = 'Add to Tool Form'
    end
  end
end
