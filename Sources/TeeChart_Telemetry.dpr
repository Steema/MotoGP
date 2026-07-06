program TeeChart_Telemetry;

uses
  Vcl.Forms,
  Unit_Main in 'Unit_Main.pas' {MainForm},
  TeeRacing in 'TeeRacing.pas',
  TeeTorqueCurve in 'TeeTorqueCurve.pas' {FormTorqueCurve},
  TeeRacingAbout in 'TeeRacingAbout.pas' {AboutForm};

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
