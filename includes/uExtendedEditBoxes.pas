unit uExtendedEditBoxes;

interface

uses
	Winapi.Windows,
	Winapi.ShLwApi
    ;

procedure EnableAutoAppend(Handle: HWND);

implementation

procedure EnableAutoAppend(Handle: HWND);
begin
	SHAutoComplete(Handle, SHACF_AUTOAPPEND_FORCE_OFF or SHACF_AUTOSUGGEST_FORCE_OFF);
end;

end.
