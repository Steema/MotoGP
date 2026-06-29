program TeeChart_Telemetry;

uses
  Vcl.Forms,
  Unit_Main in 'Unit_Main.pas' {MainForm},
  TeeGIS in 'TeeGIS.pas',
  TeeRacing in 'TeeRacing.pas',
  TeeFrontView in 'TeeFrontView.pas';

{$R *.res}

begin
  {$IFOPT D+}
  ReportMemoryLeaksOnShutdown:=True;
  {$ENDIF}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
