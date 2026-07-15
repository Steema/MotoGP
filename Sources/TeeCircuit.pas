unit TeeCircuit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, TeEngine, Series,
  ExtCtrls, TeeProcs, Chart, TeeRacing, TeeTools, StdCtrls, Control,
  Grid, Tee.GridData.Rtti;

type
  TFormCircuit = class(TForm)
    Chart1: TChart;
    Series1: TLineSeries;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Series2: TPointSeries;
    CBRadius: TCheckBox;
    Series3: TPointSeries;
    CBApex: TCheckBox;
    CBDrawCurves: TCheckBox;
    Button1: TButton;
    CurvesGrid: TTeeGrid;
    Splitter1: TSplitter;
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Chart1AfterDraw(Sender: TObject);
    procedure CBRadiusClick(Sender: TObject);
    procedure CBApexClick(Sender: TObject);
    procedure CBDrawCurvesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }

    Circuit : ^TCircuit;

    CurvesData : TVirtualArrayData<TCurve>;

    procedure Init(var ACircuit:TCircuit);
  public
    { Public declarations }

    class function ShowCircuit(var ACircuit:TCircuit):Boolean; static;
  end;

implementation

{$R *.dfm}

uses
  TeeUtils, TeCanvas, Math;

// Helper function to get the normalized angle difference between -PI and PI
function GetAngleDifference(const Ang1, Ang2: Single): Single; inline;
begin
  Result := Ang1 - Ang2;

  while Result > Pi do Result := Result - 2 * Pi;

  while Result < -Pi do Result := Result + 2 * Pi;
end;

procedure DetectCorners(var ACircuit:TCircuit; CurvatureThreshold: Single = 0.05);
var
  i, j, L : Integer;
  N: Integer;
  Curvatures: Array of Single;
  AngleDiff: Double;
  IsTurning: Array of Boolean;
  InsideCorner: Boolean;
  CornerStart, CornerEnd, ApexIdx: Integer;
  MaxCurvature: Single;
  EntryAng, ExitAng, ApexAng : Single;
  Track : ^TPointFloatArray;
begin
  ACircuit.Curves:=nil;

  N := Length(ACircuit.Points);
  if N < 5 then Exit;

  L:=0;

  Track:=@ACircuit.Points;

  SetLength(Curvatures, N);
  SetLength(IsTurning, N);

  Curvatures[0] := 0;
  Curvatures[N-1] := 0;

  for i := 1 to N - 2 do
  begin
    EntryAng := SegmentAngle(Track^[i-1], Track^[i]);
    ExitAng := SegmentAngle(Track^[i], Track^[i+1]);

    AngleDiff := Abs(GetAngleDifference(ExitAng, EntryAng));

    Curvatures[i] := AngleDiff / (Distance(Track^[i-1], Track^[i]) + 0.001);

    IsTurning[i] := Curvatures[i] > CurvatureThreshold;
  end;

  // 2. DETECT CORNER INTERVALS AND FIND THE APEX
  InsideCorner := False;
  CornerStart := 0;

  for i := 1 to N - 2 do
  begin
    if IsTurning[i] and not InsideCorner then
    begin
      // Corner starts
      InsideCorner := True;
      CornerStart := i - 1; // Capture one point before the sharp turn starts
    end
    else
    if not IsTurning[i] and InsideCorner then
    begin
      // Corner ends
      InsideCorner := False;
      CornerEnd := i;

      // Noise filter: ensure the corner has a minimum length (e.g., at least 5 telemetry points)
      if (CornerEnd - CornerStart) > 5 then
      begin
        // Search for the APEX (the point of maximum curvature within this corner interval)
        MaxCurvature := -1.0;
        ApexIdx := CornerStart;

        for j := CornerStart to CornerEnd do
        begin
          if Curvatures[j] > MaxCurvature then
          begin
            MaxCurvature := Curvatures[j];
            ApexIdx := j;
          end;
        end;

        SetLength(ACircuit.Curves,L+1);

        ACircuit.Curves[L].EntryIndex := CornerStart;

        ACircuit.Curves[L].Entry:=PathLength(ACircuit.Points,0,CornerStart);

        //ACircuit.Curves[L].ApexIndex := ApexIdx;
        //ACircuit.Curves[L].ExitIndex := CornerEnd;

        ACircuit.Curves[L].BeforeApex := PathLength(ACircuit.Points,CornerStart,ApexIdx-1);
        ACircuit.Curves[L].ApexPosition:=ACircuit.Curves[L].Entry+ACircuit.Curves[L].BeforeApex;
        ACircuit.Curves[L].AfterApex := PathLength(ACircuit.Points,ApexIdx,CornerEnd-1);

        EntryAng := SegmentAngle(Track^[CornerStart], Track^[CornerStart+1]);
        ApexAng := SegmentAngle(Track^[ApexIdx-1], Track^[ApexIdx+1]);
        ExitAng := SegmentAngle(Track^[CornerEnd-1], Track^[CornerEnd]);

        ACircuit.Curves[L].EntryAngle := Abs(RadToDeg(GetAngleDifference(ApexAng, EntryAng)));
        ACircuit.Curves[L].ExitAngle :=  Abs(RadToDeg(GetAngleDifference(ExitAng, ApexAng)));
        ACircuit.Curves[L].TotalAngle := -RadToDeg(GetAngleDifference(ExitAng, EntryAng));

        Inc(L);
      end;
    end;
  end;
end;

{ TFormCircuit }

procedure TFormCircuit.Button1Click(Sender: TObject);
begin
  DetectCorners(Circuit^,0.002);

  Init(Circuit^);

  Chart1.Invalidate;
end;

procedure TFormCircuit.CBApexClick(Sender: TObject);
begin
  Series3.Visible:=CBApex.Checked;
end;

procedure TFormCircuit.CBDrawCurvesClick(Sender: TObject);
begin
  Chart1.invalidate;
end;

procedure TFormCircuit.CBRadiusClick(Sender: TObject);
begin
  Series2.Visible:=CBRadius.Checked;
end;

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

  if CBDrawCurves.Checked then
  begin
    Chart1.Canvas.Brush.Color:=clOlive;
    Chart1.Canvas.Pen.Color:=clSkyBlue;

    for t:=0 to High(Circuit.Curves) do
    begin
      tmpPos:=Circuit.Curves[t].EntryIndex; //Circuit.IndexOfPosition(Circuit.Curves[t].Entry);

      P.X:=Series1.CalcXPos(tmpPos);
      P.Y:=Series1.CalcYPos(tmpPos);

      Chart1.Canvas.Ellipse(P.X-12,P.Y-12,P.X+12,P.Y+12);
    end;
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
     Label1.Caption:='#' +IntToStr(tmp)+' '+FloatToStr(PathLength(Circuit.Points,tmp))+' m';
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

var t, tmp : Integer;
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

  // Apex
  Series3.XValues.Order:=loNone;
  Series3.Clear;

  for t:=0 to High(ACircuit.Curves) do
  begin
    tmp:=ACircuit.IndexOfPosition(ACircuit.Curves[t].ApexPosition);
    Series3.AddXY(ACircuit.Points[tmp].X,ACircuit.Points[tmp].Y);
  end;

  m:=TMarksTipTool.Create(Self);
  m.Series:=Series1;
  m.ParentChart:=Chart1;
  m.Style:=smsXY;
  m.Font.Size:=14;
  m.MouseDelay:=0;

  Label2.Caption:='Points: ' + IntToStr(Length(ACircuit.Points))+
                  ' Path Length: '+FloatToStr(PathLength(ACircuit.Points))+
                  ' Total Length: '+FloatToStr(ACircuit.TotalLength)+' meters';

  CurvesData.Free;
  CurvesData:=TVirtualArrayData<TCurve>.Create(ACircuit.Curves);

  CurvesGrid.Data:=CurvesData;
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
