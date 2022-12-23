unit uAppSettings;

interface

uses
    Vcl.Forms,
    System.SysUtils,
    System.IOUtils,
    Winapi.Windows
    ;

type
    TSettingsData = record
    	Version: Integer;
        DataDir: string;
        ServersDir: string;
    end;

    TSettings = record
        Data: TSettingsData;
    private
        IsInitialized: Boolean;
        SettingsFilename: string;
        procedure InitWithDefaults;
    public
        procedure Init;
        procedure Load;
        procedure Save;
    end;

var
    Settings: TSettings;

implementation

uses
	uJsonSerializer,
    uCommonConsts
    ;

const
    FILE_VERSION = 0;

{ TSettings }

procedure TSettings.Init;
const
    FILENAME = 'settings.json';
begin
    if (IsInitialized = False) then
		SettingsFilename := ExtractFilePath(Application.ExeName) + FILENAME;
    IsInitialized := True;
end;

procedure TSettings.InitWithDefaults;
begin
    Data.Version := FILE_VERSION;
    //Data.ServersDir := ExtractFilePath(TPath.GetHomePath) + 'Roaming\hl2mp_server_manager\servers';
    //	../Data/
    //      /Servers/
    Data.DataDir := ExtractFilePath(Application.ExeName) + 'Data\';
	Data.ServersDir := 'Servers';
    TDirectory.CreateDirectory(Data.DataDir);
    TDirectory.CreateDirectory(Data.DataDir + Data.ServersDir);
    Save;
end;

procedure TSettings.Load;
var
    Content: string;
begin
    //if not FileExists(SettingsFilename) then
    	InitWithDefaults;

    Content := TFile.ReadAllText(SettingsFilename, TEncoding.UTF8);
	Data := DSON.fromJson<TSettingsData>(Content);

    if (Data.Version <> FILE_VERSION) then
    begin
    	var Msg := PChar(Format(T_SETTINGS_VERSION_CONFLICT, [FILE_VERSION, Data.Version]));
    	Application.MessageBox(Msg, T_WARNING, MB_OK);
    end;
end;

procedure TSettings.Save;
var
    Content: string;
begin
    Content := DSON.toJson<TSettingsData>(Data, True);
    TFile.WriteAllText(SettingsFilename, Content, TEncoding.UTF8);
end;

initialization
    Settings.Init;
    Settings.Load;

end.
