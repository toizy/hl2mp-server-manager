program hl2mp_server_manager;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uMainForm in 'forms\uMainForm.pas' {MainForm},
  uCommonConsts in 'includes\uCommonConsts.pas',
  uServerManagerForm in 'forms\uServerManagerForm.pas' {ServerManagerForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  TStyleManager.TrySetStyle('Glow');
  Application.Run;
end.
