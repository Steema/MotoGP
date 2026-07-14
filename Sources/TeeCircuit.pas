unit TeeCircuit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, TeEngine, Series,
  ExtCtrls, TeeProcs, Chart, TeeRacing, TeeTools, StdCtrls;

type
  TFormCircuit = class(TForm)
    Chart1: TChart;
    Series1: TLineSeries;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Series2: TPointSeries;
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Chart1AfterDraw(Sender: TObject);
  private
    { Private declarations }

    Circuit : ^TCircuit;

    procedure Init(var ACircuit:TCircuit);
  public
    { Public declarations }

    class function ShowCircuit(var ACircuit:TCircuit):Boolean; static;
  end;

implementation

{$R *.dfm}

uses
  TeeUtils, TeCanvas;

{ TFormCircuit }

procedure TFormCircuit.Chart1AfterDraw(Sender: TObject);

  procedure DrawLine(const A0,A1:Integer; const AColor:TColor);
  var P0, P1 : TPointFloat;
      C : TTeeCanvas;
  begin
    C:=Chart1.Canvas;

    P0.X:=Series1.CalcXPos(A0);
    P0.Y:=Series1.CalcYPos(A0);

    P1.X:=Series1.CalcXPos(A1);
    P1.Y:=Series1.CalcYPos(A1);

    C.Pen.Color:=AColor;
    C.Pen.Width:=3;
    DrawPerpendicular(C,P1,P0,100);
  end;

var t : Integer;
    tmpPos : Integer;
    P : TPoint;
begin
  DrawLine(1,0,clBlack);
  DrawLine(Circuit.PolePositionIndex+1,Circuit.PolePositionIndex,RGB(0,200,200));

  Chart1.Canvas.Brush.Color:=clOlive;
  Chart1.Canvas.Pen.Color:=clSkyBlue;

  for t:=0 to High(Circuit.Curves) do
  begin
    tmpPos:=Circuit.IndexOfPosition(Circuit.Curves[t].Position+240);

    P.X:=Series1.CalcXPos(tmpPos);
    P.Y:=Series1.CalcYPos(tmpPos);

    Chart1.Canvas.Ellipse(P.X-12,P.Y-12,P.X+12,P.Y+12);
  end;
end;

procedure TFormCircuit.Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var tmp : Integer;
begin
  tmp:=Series1.Clicked(X,Y);

  if tmp=-1 then
     Label1.Caption:=''
  else
     Label1.Caption:='#' +IntToStr(tmp);
end;

procedure TFormCircuit.Init(var ACircuit: TCircuit);

  function CalcMaxRadius:Single;
  var t : Integer;
  begin
    result:=0;

    for t:=0 to High(ACircuit.Radius) do
        if ACircuit.Radius[t]>result then
           result:=ACircuit.Radius[t];
  end;

var t : Integer;
    m : TMarksTipTool;
    MaxRadius : Single;
begin
  Circuit:=@ACircuit;

  Label1.Caption:='';

  // Track Points
  Series1.XValues.Order:=loNone;

  Series1.Clear;

  for t:=0 to High(ACircuit.Points) do
      Series1.AddXY(ACircuit.Points[t].X,ACircuit.Points[t].Y);

  Series1.Pointer.Size:=8;
  Series1.Pointer.Pen.Hide;

  Series1.ValueColor[0]:=clWhite;
  Series1.ValueColor[ACircuit.PolePositionIndex]:=clRed;

  // Radius
  Series2.XValues.Order:=loNone;
  Series2.Clear;

  MaxRadius:=CalcMaxRadius;

  for t:=0 to High(ACircuit.Radius) do
      Series2.AddXY(ACircuit.Points[t].X,ACircuit.Points[t].Y,'',RGB(0,255-Round(ACircuit.Radius[t]*255/MaxRadius),0));

  m:=TMarksTipTool.Create(Self);
  m.Series:=Series1;
  m.ParentChart:=Chart1;
  m.Style:=smsXY;
  m.Font.Size:=14;
  m.MouseDelay:=0;

  Label2.Caption:='Points: ' + IntToStr(Length(ACircuit.Points))+
                  ' Path Length: '+FloatToStr(PathLength(ACircuit.Points))+
                  ' Total Length: '+FloatToStr(ACircuit.TotalLength)+' meters';

end;

class function TFormCircuit.ShowCircuit(var ACircuit: TCircuit): Boolean;
begin
  with TFormCircuit.Create(nil) do
  try
    Init(ACircuit);
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

end.
