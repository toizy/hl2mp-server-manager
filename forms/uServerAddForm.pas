unit uServerAddForm;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
	TServerAddForm = class(TForm)
		lbHost: TLabel;
		lbPort: TLabel;
		lbPassword: TLabel;
		ebHost: TEdit;
		ebPort: TEdit;
		ebPassword: TEdit;
		bOk: TButton;
		ebName: TEdit;
		lbName: TLabel;
		mDescription: TMemo;
		ebFilename: TEdit;
		lbFilename: TLabel;
		procedure FormCreate(Sender: TObject);
		procedure bOkClick(Sender: TObject);
		procedure ebPortKeyPress(Sender: TObject; var Key: Char);
	private
		{ Private declarations }
	public
		{ Public declarations }
	end;

var
	ServerAddForm: TServerAddForm;

implementation

uses uExtendedEditBoxes;

{$R *.dfm}

procedure TServerAddForm.FormCreate(Sender: TObject);
begin
	EnableAutoAppend(ebName.Handle);
	EnableAutoAppend(ebHost.Handle);
	EnableAutoAppend(ebPort.Handle);
	EnableAutoAppend(ebPassword.Handle);
end;

procedure TServerAddForm.bOkClick(Sender: TObject);
begin
	ModalResult := mrOk;
end;

procedure TServerAddForm.ebPortKeyPress(Sender: TObject; var Key: Char);
begin
	case Ord(Key) of
		48 .. 57, 08:;
	else
		Key := #0;
	end;
end;

end.
