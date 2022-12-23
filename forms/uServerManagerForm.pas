unit uServerManagerForm;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, uCommonConsts, Vcl.Menus,
    System.IOUtils, System.ImageList, Vcl.ImgList, uArrayHelper;

type
    TServerManagerForm = class(TForm)
        pLeft: TPanel;
        sbRight: TScrollBox;
        pBottom: TPanel;
        splitter: TSplitter;
        tvList: TTreeView;
        pmList: TPopupMenu;
    	il16: TImageList;
        pcSettings: TPageControl;
        tsWelcome: TTabSheet;
        tsMain: TTabSheet;
        lbWelcome: TLabel;
        lbHost: TLabel;
        lbPort: TLabel;
        lbPassword: TLabel;
        ebHost: TEdit;
        ebPort: TEdit;
        ebPassword: TEdit;
        mDescription: TMemo;
        lbDescription: TLabel;
        bCreateServer: TButton;
        bSaveChanges: TButton;
        miRefresh: TMenuItem;
        lbSelectedServerInfo: TLabel;
        ebName: TEdit;
        lbName: TLabel;
        bConnect: TButton;
        bCreateFolder: TButton;
        miDelete: TMenuItem;
		procedure bConnectClick(Sender: TObject);
		procedure bCreateFolderClick(Sender: TObject);
		procedure bCreateServerClick(Sender: TObject);
		procedure bSaveChangesClick(Sender: TObject);
		procedure ebHostChange(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure miDeleteClick(Sender: TObject);
		procedure miRefreshClick(Sender: TObject);
		procedure tsWelcomeResize(Sender: TObject);
		procedure tvListChange(Sender: TObject; Node: TTreeNode);
		procedure tvListDblClick(Sender: TObject);
    private
    	{ Private declarations }
        procedure LoadServerList;
        procedure LoadDataDir(Path: string; Item: TTreeNode);
        procedure SaveChanges;
        procedure AddNewServer;
        procedure CreateNewFolder;
        procedure DeleteFolder;
        procedure Connect;
		procedure DisplayConnectionInfo(HideInfo: Boolean);
        function GetServerFilename(Node: TTreeNode = nil): string;
        function IsNodeAFolder(Node: TTreeNode = nil): Boolean;
    public
    	{ Public declarations }
    end;

var
	ServerManagerForm: TServerManagerForm;

implementation

uses uAppSettings, uServerSettings, uServerAddForm;

{$R *.dfm}

procedure TServerManagerForm.AddNewServer;
var
    FileName: string;
    FullPath: string;
    Node: TTreeNode;
begin
    ServerAddForm := TServerAddForm.Create(ServerManagerForm);
    try
    	if (ServerAddForm.ShowModal = mrOk) then
        begin
            FileName := ServerAddForm.ebFilename.Text;
            if not TPath.HasValidFileNameChars(FileName, false) then
            begin
                Application.MessageBox(T_ERROR_INVALID_FILENAME, T_ERROR, MB_OK);
                Exit;
            end;

            FullPath := GetServerFilename + '\' + FileName;

            if TFile.Exists(FullPath) then
            begin
                Application.MessageBox(T_ERROR_FILE_EXISTS, T_ERROR, MB_OK);
				Exit;
            end;

            ServerSettings.Data.Name:= ServerAddForm.ebName.Text;
            ServerSettings.Data.Host := ServerAddForm.ebHost.Text;
            ServerSettings.Data.Port := ServerAddForm.ebPort.Text;
            ServerSettings.Data.Password := ServerAddForm.ebPassword.Text;
            ServerSettings.Data.Description := ServerAddForm.mDescription.Text;
            ServerSettings.Save(FullPath);

            Node := tvList.Items.AddChild(tvList.Selected, FileName);
            Node.ImageIndex := 1;
            Node.SelectedIndex := 1;
            tvList.Selected.Expand(False);
        end;
    finally
    	ServerAddForm.Free;
    end;
end;

procedure TServerManagerForm.bConnectClick(Sender: TObject);
begin
	Connect;
end;

procedure TServerManagerForm.bCreateFolderClick(Sender: TObject);
begin
	CreateNewFolder;
end;

procedure TServerManagerForm.bCreateServerClick(Sender: TObject);
begin
	AddNewServer;
end;

procedure TServerManagerForm.bSaveChangesClick(Sender: TObject);
begin
	SaveChanges;
end;

procedure TServerManagerForm.Connect;
begin
	ModalResult := mrOk;
end;

procedure TServerManagerForm.CreateNewFolder;
var
    FolderName: string;
    FileName: string;
    FullPath: string;
begin
    if (tvList.Selected.Parent = nil) and not IsNodeAFolder then
        FolderName := ExcludeTrailingPathDelimiter(Settings.Data.DataDir)
    else
    	if IsNodeAFolder then
    		FolderName := GetServerFilename
        else
            FolderName := GetServerFilename(tvList.Selected.Parent);

    FileName := InputBox(T_QUESTION, T_ENTER_FILENAME, '');

    if not TPath.HasValidFileNameChars(FileName, False) then
    begin
    	Application.MessageBox(T_ERROR_INCORRECT_FILENAME, T_ERROR, MB_OK);
        Exit;
    end;

    FullPath := FolderName + '\' + FileName;

    if TDirectory.Exists(FullPath) then
    begin
    	Application.MessageBox(T_ERROR_PATH_EXISTS, T_ERROR, MB_OK);
        Exit;
    end;

    TDirectory.CreateDirectory(FullPath);
    LoadServerList;
end;

procedure TServerManagerForm.ebHostChange(Sender: TObject);
begin
    bSaveChanges.Enabled := True;
end;

procedure TServerManagerForm.FormCreate(Sender: TObject);
begin
    tvList.Hint := T_HINT_SERVER_LIST;
    LoadServerList;
end;

function TServerManagerForm.GetServerFilename(Node: TTreeNode = nil): string;
begin
	Result := '';
    if (Node = nil) then
        Node := tvList.Selected;
	while Node <> nil do
    begin
    	Result :=  '\' + Node.Text + Result;
        Node := Node.Parent;
    end;
    Result := ExcludeTrailingPathDelimiter(Settings.Data.DataDir) + Result;
    if not TPath.HasValidPathChars(Result, false) then
    begin
        Application.MessageBox(T_ERROR_INCORRECT_PATH, T_ERROR, MB_OK);
        Application.Terminate;
    end;

end;

function TServerManagerForm.IsNodeAFolder(Node: TTreeNode = nil): Boolean;
begin
    if (Node = nil) then
    	Node := tvList.Selected;
    if (Node <> nil) then
        Result := (Node.ImageIndex = 0)
    else begin
{$IFDEF DEBUG}
        raise Exception.Create('Debug: IsNodeAFolder - Selected item is null.');
{$ENDIF}
        Result := False;
    end;
end;

procedure TServerManagerForm.LoadServerList;
var
	Node: TTreeNode;
begin
    tvList.Items.Clear;
	if (TDirectory.Exists(Settings.Data.DataDir + Settings.Data.ServersDir)) then
    begin
        Node := tvList.Items.AddChild(nil, Settings.Data.ServersDir);
        Node.ImageIndex := 0;
    	Node.SelectedIndex := 0;
	    LoadDataDir(IncludeTrailingPathDelimiter(Settings.Data.DataDir + Settings.Data.ServersDir), Node);
    end;
end;

procedure TServerManagerForm.LoadDataDir(Path: string; Item: TTreeNode);
var
    Name: string;
    Node: TTreeNode;
begin
	for Name in TDirectory.GetDirectories(Path) do
    begin
    	Node := tvList.Items.AddChild(Item, ExtractFileName(Name));
        Node.ImageIndex := 0;
    	Node.SelectedIndex := 0;
        LoadDataDir(Name, Node);
    end;
	for Name in TDirectory.GetFiles(Path) do
    begin
	    Node := tvList.Items.AddChild(Item, ExtractFileName(Name));
        Node.ImageIndex := 1;
    	Node.SelectedIndex := 1;
    end;
end;

procedure TServerManagerForm.miRefreshClick(Sender: TObject);
begin
    LoadServerList;
end;

procedure TServerManagerForm.SaveChanges;
begin
	ServerSettings.Data.Name := ebName.Text;
    ServerSettings.Data.Host := ebHost.Text;
    ServerSettings.Data.Port := ebPort.Text;
    ServerSettings.Data.Password := ebPassword.Text;
    ServerSettings.Data.Description := mDescription.Lines.Text;
	ServerSettings.Save;
    bSaveChanges.Enabled := False;
    DisplayConnectionInfo(True);
end;

procedure TServerManagerForm.DeleteFolder;
begin
    if IsNodeAFolder then
    begin
    	if (Application.MessageBox(T_DELETE_FOLDER_QUESTION, T_WARNING, MB_YESNO) = IDYES) then
        begin
        	var Path: string := GetServerFilename;
        	try
            	TDirectory.Delete(Path, True);
        	except
                Application.MessageBox(T_ERROR_INCORRECT_PATH, T_ERROR, MB_OK);
            end;

            tvList.Selected.Delete;

            // If we deleted 'Servers' root, create it again and reload server list
            var RootPath: string := Settings.Data.DataDir + Settings.Data.ServersDir;
            if (Path = RootPath) then
            begin
                TDirectory.CreateDirectory(RootPath);
                LoadServerList;
            end;
        end;
	end else begin
    	if (Application.MessageBox(T_DELETE_FILE_QUESTION, T_WARNING, MB_YESNO) = IDYES) then
        begin
            try
            	TFile.Delete(GetServerFilename);
			except
                Application.MessageBox(T_ERROR_INCORRECT_PATH, T_ERROR, MB_OK);
            end;
            tvList.Selected.Delete;
        end;
    end;
end;

procedure TServerManagerForm.DisplayConnectionInfo(HideInfo: Boolean);
begin
    bConnect.Enabled := not HideInfo;
    if (HideInfo) then
        lbSelectedServerInfo.Caption := ''
    else begin
        var R: TRect;
        var Text: string := ServerSettings.Data.Name + ' @ ' + ServerSettings.Data.Host + ':' + ServerSettings.Data.Port;
        UniqueString(Text);
        R := lbSelectedServerInfo.ClientRect;
        lbSelectedServerInfo.Canvas.Font := lbSelectedServerInfo.Font;
        DrawText(lbSelectedServerInfo.Canvas.Handle, PChar(Text), Length(Text), R, DT_END_ELLIPSIS or DT_MODIFYSTRING or DT_NOPREFIX);
        lbSelectedServerInfo.Caption := Text;
    end;
end;

procedure TServerManagerForm.miDeleteClick(Sender: TObject);
begin
    DeleteFolder;
end;

procedure TServerManagerForm.tsWelcomeResize(Sender: TObject);
begin
    // Move the buttons to the center of the parent
	bCreateServer.Left := tsWelcome.Left + tsWelcome.Width div 2 - bCreateServer.Width div 2;
    bCreateFolder.Left := tsWelcome.Left + tsWelcome.Width div 2 - bCreateFolder.Width div 2;
end;

procedure TServerManagerForm.tvListChange(Sender: TObject; Node: TTreeNode);
var
	i: integer;
    Flag: Boolean;
begin
    if (bSaveChanges.Enabled) then
        if (Application.MessageBox(T_DATA_CHANGED, T_WARNING, MB_YESNO) = IDYES) then
            SaveChanges;
	tvList.Items.BeginUpdate;
    try
        Flag := IsNodeAFolder;
        pcSettings.Pages[0].TabVisible := Flag;
        for i := 1 to pcSettings.PageCount - 1 do
            pcSettings.Pages[i].TabVisible := not Flag;
        if not Flag then
        begin
        	ServerSettings.Load(GetServerFilename);
            ebName.Text := ServerSettings.Data.Name;
            ebHost.Text := ServerSettings.Data.Host;
            ebPort.Text := ServerSettings.Data.Port;
            ebPassword.Text := ServerSettings.Data.Password;
            mDescription.Lines.Text := ServerSettings.Data.Description;
        end;
        bCreateServer.Enabled := Flag;
        bCreateFolder.Enabled := Flag;
        DisplayConnectionInfo(Flag);
    finally
        tvList.Items.EndUpdate;
    end;
    bSaveChanges.Enabled := False;
end;

procedure TServerManagerForm.tvListDblClick(Sender: TObject);
begin
	if (not IsNodeAFolder) then
        Connect;
end;

end.
