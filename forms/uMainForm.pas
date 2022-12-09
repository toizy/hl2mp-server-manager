unit uMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
    uCommonConsts;

type
    TMainForm = class(TForm)
        MainMenu: TMainMenu;
        Server: TMenuItem;
        MenuApplication: TMenuItem;
        MenuAlwaysOnTop: TMenuItem;
        MenuShowToolForm: TMenuItem;
        MenuUtils: TMenuItem;
        MenuListOfFiles: TMenuItem;
        mServerOutput: TMemo;
        pmMemo: TPopupMenu;
        MenuClearMemo: TMenuItem;
        pBottom: TPanel;
        cbCommand: TComboBox;
        sbRight: TScrollBox;
        tvCommands: TTreeView;
        splitter: TSplitter;
        pmTreeView: TPopupMenu;
        MenuExecute: TMenuItem;
        MenuCollapseAll: TMenuItem;
        MenuAddToToolForm: TMenuItem;
        View: TMenuItem;
        ServerOutput: TMenuItem;
        IncreaseFontSize: TMenuItem;
        DecreaseFontSize: TMenuItem;
        Manage: TMenuItem;
        cbFindCommand: TComboBox;
        procedure FormCreate(Sender: TObject);
        procedure ManageClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    MainForm: TMainForm;

implementation

uses
    uServerManagerForm;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
    cbFindCommand.TextHint := T_FINDCOMMAND_HINT;
    cbCommand.TextHint := T_COMMAND_CB_HINT;
end;

procedure TMainForm.ManageClick(Sender: TObject);
begin
    ServerManagerForm := TServerManagerForm.Create(MainForm);
    ServerManagerForm.ShowModal;
    ServerManagerForm.Free;
end;

end.
