object ServerAddForm: TServerAddForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add server'
  ClientHeight = 256
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object lbHost: TLabel
    Left = 8
    Top = 67
    Width = 25
    Height = 15
    Caption = 'Host'
  end
  object lbPort: TLabel
    Left = 8
    Top = 96
    Width = 22
    Height = 15
    Caption = 'Port'
  end
  object lbPassword: TLabel
    Left = 8
    Top = 125
    Width = 50
    Height = 15
    Caption = 'Password'
  end
  object lbName: TLabel
    Left = 8
    Top = 11
    Width = 32
    Height = 15
    Caption = 'Name'
  end
  object lbFilename: TLabel
    Left = 8
    Top = 38
    Width = 54
    Height = 15
    Caption = 'File  name'
  end
  object ebHost: TEdit
    Left = 80
    Top = 64
    Width = 193
    Height = 23
    TabOrder = 1
  end
  object ebPort: TEdit
    Left = 80
    Top = 93
    Width = 193
    Height = 23
    TabOrder = 2
    OnKeyPress = ebPortKeyPress
  end
  object ebPassword: TEdit
    Left = 80
    Top = 122
    Width = 193
    Height = 23
    PasswordChar = '*'
    TabOrder = 3
  end
  object bOk: TButton
    Left = 176
    Top = 223
    Width = 97
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = bOkClick
  end
  object ebName: TEdit
    Left = 80
    Top = 8
    Width = 193
    Height = 23
    TabOrder = 0
  end
  object mDescription: TMemo
    Left = 5
    Top = 152
    Width = 268
    Height = 65
    Lines.Strings = (
      'Enter server description...')
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object ebFilename: TEdit
    Left = 80
    Top = 35
    Width = 193
    Height = 23
    TabOrder = 6
  end
end
