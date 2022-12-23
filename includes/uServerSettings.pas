unit uServerSettings;

interface

uses
    Vcl.Forms,
    System.SysUtils,
    System.IOUtils,
    Winapi.Windows,
    uArrayHelper
    ;

type
    TServerCommands = record
    	Commands: TArrayRecord<TServerCommands>;
        Name: string;
        Cmd: string;
        Arg: string;
        NeedConfirmation: Boolean;
	end;

    TSettingsData = record
    	Version: Integer;
        Name: string;
        Host: string;
        Port: string;
        Password: string;
        Description: string;
        Commands: TServerCommands;
    end;

    TServerSettings = record
        Data: TSettingsData;
    private
        SettingsFilename: string;
    public
        procedure Load(Filename: string = '');
        procedure Save(Filename: string = '');
    end;

var
    ServerSettings: TServerSettings;

implementation

uses
	uJsonSerializer,
    uCommonConsts
    ;

const
    FILE_VERSION = 0;

{ TSettings }

procedure TServerSettings.Load(Filename: string = '');
var
    Content: string;
begin
	if (Filename <> '') then
    	SettingsFilename := Filename;
    Content := TFile.ReadAllText(SettingsFilename, TEncoding.UTF8);
	Data := DSON.fromJson<TSettingsData>(Content);
    if (Data.Version <> FILE_VERSION) then
    begin
    	var Msg := PChar(Format(T_SETTINGS_VERSION_CONFLICT, [FILE_VERSION, Data.Version]));
    	Application.MessageBox(Msg, T_WARNING);
        Application.Terminate;
    end;
end;

procedure TServerSettings.Save(Filename: string = '');
var
    Content: string;
begin
    if (Filename <> '') then
    	SettingsFilename := Filename;
    Content := DSON.toJson<TSettingsData>(Data, True);
    TFile.WriteAllText(SettingsFilename, Content, TEncoding.UTF8);
end;

end.
