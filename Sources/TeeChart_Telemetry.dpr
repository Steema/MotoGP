program TeeChart_Telemetry;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {MainForm},
  TeeTorqueCurve in 'TeeTorqueCurve.pas' {FormTorqueCurve},
  TeeRacingAbout in 'TeeRacingAbout.pas' {AboutForm},
  TeeTire in 'TeeTire.pas',
  TeeUtils in 'TeeUtils.pas',
  TeeCircuit in 'TeeCircuit.pas' {FormCircuit},
  TeeRacing in 'TeeRacing.pas';

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
