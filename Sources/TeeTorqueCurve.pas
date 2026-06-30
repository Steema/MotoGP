unit TeeTorqueCurve;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCLTee.TeEngine, VCLTee.Series,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart,

  VCLTee.TeeDragPoint, TeeRacing;

type
  TFormTorqueCurve = class(TForm)
    Chart1: TChart;
    Series1: TLineSeries;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure FillSample(const ACurve:TTorqueCurve);
  end;

implementation

{$R *.dfm}

{ TFormTorqueCurve }

procedure TFormTorqueCurve.FillSample(const ACurve:TTorqueCurve);
var t : Integer;
begin
  Chart1.Axes.Left.Title.Caption := 'Torque (Nm)';
  Chart1.Axes.Bottom.Title.Caption := 'RPM';

  Series1.Clear;

  for t:=0 to High(ACurve) do
      Series1.AddXY(ACurve[t].RPM,ACurve[t].Nm);

  Series1.Cursor:=crHandPoint;

  Series1.DrawStyle:=dsCurve;
  Series1.TreatNulls:=tnIgnore;

  Series1.Pointer.Show;
  Series1.Pointer.Style:=psCircle;
  Series1.Pointer.Size:=14;

  Chart1.Axes.Left.SetMinMax(0,150);
  Chart1.Axes.Bottom.SetMinMax(0,20000);

end;

procedure TFormTorqueCurve.FormCreate(Sender: TObject);
var tmp : TDragPointTool;
begin
  tmp:=TDragPointTool.Create(Self);
  tmp.Series:=Series1;

  tmp.DragStyle:=dsY;

  Chart1.Tools.Add(tmp);
end;

end.
