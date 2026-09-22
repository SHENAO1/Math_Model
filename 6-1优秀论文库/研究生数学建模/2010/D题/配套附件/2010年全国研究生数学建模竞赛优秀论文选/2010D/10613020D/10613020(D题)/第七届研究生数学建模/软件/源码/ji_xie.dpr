program ji_xie;

uses
  Forms,
  jixie in 'jixie.pas' {Form1},
  quxian in 'quxian.pas' {line_form},
  liu_lan in 'liu_lan.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tline_form, line_form);
  Application.Run;
end.
