unit uMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

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
    uServerManagerForm, uCommonConsts, uAppSettings, uExtendedEditBoxes;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
    cbFindCommand.TextHint := T_HINT_FINDCOMMAND;
    cbCommand.TextHint := T_HINT_COMMAND_COMBOBOX;
end;

procedure TMainForm.ManageClick(Sender: TObject);
begin
    ServerManagerForm := TServerManagerForm.Create(MainForm);
    try
	    if (ServerManagerForm.ShowModal = mrOk) then
        begin
            ShowMessage('Connecting');
        end;
    finally
    	ServerManagerForm.Free;
    end;
end;

end.
