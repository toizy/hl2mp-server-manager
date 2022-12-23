hl2mp_server_manager

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uMainForm in 'forms\uMainForm.pas' {MainForm},
  uCommonConsts in 'includes\uCommonConsts.pas',
  uServerManagerForm in 'forms\uServerManagerForm.pas' {ServerManagerForm},
  uJsonSerializer in 'includes\uJsonSerializer.pas',
  uAppSettings in 'includes\uAppSettings.pas',
  uServerAddForm in 'forms\uServerAddForm.pas' {ServerAddForm},
  uServerSettings in 'includes\uServerSettings.pas',
  uArrayHelper in 'includes\uArrayHelper.pas',
  uExtendedEditBoxes in 'includes\uExtendedEditBoxes.pas';

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  TStyleManager.TrySetStyle('Glow');
  Application.Run;
end.
