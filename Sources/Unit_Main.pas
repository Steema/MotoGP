unit Unit_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  System.Types,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.CheckLst,

  VCLTee.TeEngine, VCLTee.TeCanvas, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.Control, VCLTee.Grid, VCLTee.TeePenDlg,
  VCLTee.TeeSVGCanvas,

  Tee.GridData.Strings, Tee.Grid.CSV, TeeGIS, TeeRacing, Tee.Painter,
  Tee.Grid.Columns,

  TeeTorqueCurve,

  VCLTee.Series, Vcl.Menus, VCLTee.TeeNumericGauge, VCLTee.TeeGauges;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabLap: TTabSheet;
    TabLaps: TTabSheet;
    LapChart: TChart;
    Chart2: TChart;
    PanelTop: TPanel;
    BStart: TButton;
    BPause: TButton;
    BStop: TButton;
    Label2: TLabel;
    Edit1: TEdit;
    TotalLaps: TUpDown;
    PageControl2: TPageControl;
    TabCircuits: TTabSheet;
    TabPilots: TTabSheet;
    PanelCircuit: TPanel;
    Circuit: TChart;
    TabSensors: TTabSheet;
    Splitter1: TSplitter;
    Timer1: TTimer;
    PanelPole: TPanel;
    CurrentLap: TLabel;
    Splitter2: TSplitter;
    Pilots: TTeeGrid;
    PageControl3: TPageControl;
    TabRace: TTabSheet;
    TabPole: TTabSheet;
    PoleGrid: TTeeGrid;
    Sensors: TTeeGrid;
    Circuits: TTeeGrid;
    PoleChart: TChart;
    Semaphor: TChart;
    TimerStart: TTimer;
    Panel3: TPanel;
    CBMap: TComboBox;
    Panel4: TPanel;
    BRandomPole: TButton;
    CurveSeries: TPointSeries;
    Label1: TLabel;
    LRaceEllapsed: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    View1: TMenuItem;
    Render1: TMenuItem;
    GDI1: TMenuItem;
    Skia1: TMenuItem;
    OpenGL1: TMenuItem;
    TabChampionShip: TTabSheet;
    PanelFull: TPanel;
    Button1: TButton;
    ChampionGrid: TTeeGrid;
    PageControl4: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FrontView: TChart;
    TabSheet3: TTabSheet;
    LBBikes: TListBox;
    PageControl5: TPageControl;
    TabSheet4: TTabSheet;
    TabTorqueCurve: TTabSheet;
    BikeGrid: TTeeGrid;
    SpeedGauge: TNumericGauge;
    LeanGauge: TGaugeSeries;
    procedure BStartClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BPauseClick(Sender: TObject);
    procedure BStopClick(Sender: TObject);
    procedure CircuitAfterDraw(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CircuitsSelect(Sender: TObject);
    procedure PoleChartAfterDraw(Sender: TObject);
    procedure TimerStartTimer(Sender: TObject);
    procedure SemaphorAfterDraw(Sender: TObject);
    procedure CBMapChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BRandomPoleClick(Sender: TObject);
    procedure GDI1Click(Sender: TObject);
    procedure Skia1Click(Sender: TObject);
    procedure OpenGL1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PoleGridSelect(Sender: TObject);
    procedure LBBikesClick(Sender: TObject);
    procedure FrontViewBeforeDrawSeries(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FrontViewResize(Sender: TObject);
  private
    { Private declarations }

    CircuitPoints : TPointFloatArray;

    CircuitPath : TTeeBasePath;
    GIS : TGISRaster;

    BikeData,
    SeasonData,
    PilotsData,
    SensorsData,
    CircuitsData,
    Pole : TStringsData;

    StartCount : Integer;

    Race : TRace;

    Torque : TFormTorqueCurve;

    SeriesSpeed,
    SeriesAcceleration : TFastLineSeries;

    procedure CreatePole;
    function DoStep:Boolean;
    function FindRiderInPole(const ARider:Integer):Integer;
    procedure InitRaceData;
    function PilotPosition(const APosition:Single):TPoint;
    function PilotPositionIndex(const APosition:Single):Integer;
    procedure RefillCharts;
    procedure SetTeeCanvas(const AClass:TTeeCanvasClass);
    procedure StartRace;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Math, IOUtils, Tee.Format, UITypes,

  TeeGDIPlus, TeeSkia, TeeGLCanvas, TeeFrontView;

const
  PauseCaption='Pause';
  ResumeCaption='Resume';

procedure TMainForm.BPauseClick(Sender: TObject);
begin
  Timer1.Enabled:=BPause.Caption=ResumeCaption;

  if Timer1.Enabled then
     BPause.Caption:=PauseCaption
  else
     BPause.Caption:=ResumeCaption;
end;

procedure TMainForm.BStartClick(Sender: TObject);
begin
  BStart.Enabled:=False;

  BRandomPole.Enabled:=False;

  StartCount:=0;
  TimerStart.Enabled:=True;
end;

procedure TMainForm.BStopClick(Sender: TObject);
begin
  Timer1.Enabled:=False;

  BPause.Caption:=PauseCaption;
  BPause.Enabled:=False;
  BStop.Enabled:=False;
  BStart.Enabled:=True;

  Race.Ellapsed.Stop;

  BRandomPole.Enabled:=True;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  if PanelCircuit.Parent=TabCircuits then
  begin
    PanelFull.Hide;
    PanelCircuit.Align:=alClient;
    PanelCircuit.Parent:=Self;
  end
  else
  begin
    PanelCircuit.Align:=alTop;
    PanelCircuit.Parent:=TabCircuits;
    PanelCircuit.Height:=PanelCircuit.Width;


    PanelFull.Show;
  end;
end;

procedure TMainForm.BRandomPoleClick(Sender: TObject);
begin
  CreatePole;
  PoleGrid.Invalidate;
end;

const MotoGP='..\..\Data\MotoGP';

procedure TMainForm.CBMapChange(Sender: TObject);
begin
  GIS.Visible:=CBMap.ItemIndex>0;
  GIS.MapServer:=TMapServer(CBMap.ItemIndex-1);

  Circuit.Walls.Visible:=GIS.Visible;
end;

function TMainForm.PilotPositionIndex(const APosition:Single):Integer;
begin
  result:=Round(APosition*(1+Length(CircuitPoints))/Race.Circuit.Length);

  {$IFOPT D+}
  if (result<0) or (result>=Length(CircuitPoints)) then
     result:=0;
  {$ENDIF}
end;

function TMainForm.PilotPosition(const APosition:Single):TPoint;
var tmpPos : Integer;
begin
  tmpPos:=PilotPositionIndex(APosition);
  result.X:=Round(CircuitPoints[tmpPos].X);
  result.Y:=Round(CircuitPoints[tmpPos].Y);
end;

procedure TMainForm.CircuitAfterDraw(Sender: TObject);

  function LoadCircuitPath(const ID:String):String;
  begin
    if ID='' then
       result:=''
    else
       result:=TFile.ReadAllText(MotoGP+'\Circuits\'+ID+'.svg');
  end;

  procedure AddCurves(const ACurves:Array of TCurve);
  var t : Integer;
  begin
    for t:=0 to High(ACurves) do
        CurveSeries.AddXY(ACurves[t].Position,ACurves[t].Angle,ACurves[t].Name);
  end;

  procedure AddCircuitPath;
  const CRLF=#13#10;
  begin
    CircuitPath:=LapChart.Canvas.CreatePath;
    TSVGParser.ParsePath(CircuitPath,LoadCircuitPath(CircuitsData[3,Circuits.Selected.Row]));

    CircuitPoints:=CircuitPath.Flatten(0.25);

    Race.Circuit.Length:=4657; // Circuite (ie: Montmeló) length in meters
    Race.Circuit.PolePosition:=120;

    Race.Circuit.FillCurves([620,700,950,1300,1650,1820,2000,2120,2350,2900,3150,3350,3650,3950],
                           ['1'+CRLF+'Elf','2','3'+CRLF+'Renault','Repsol','Seat','6','Würth','8','Campsa','La Caixa','11','Banc Sabadell','Europcar','New Holland'],
                           [90,-45,180,90,-135,-15,-90,45,60,-80,-45,90,60,90]);



    CurveSeries.GetVertAxis.SetMinMax(-180,180);

    CurveSeries.Clear;
    CurveSeries.Title:='Curves';

    AddCurves(Race.Circuit.Curves);

    CurveSeries.GetVertAxis.Title.Caption:='Angles';
    LapChart.Axes.Bottom.SetMinMax(0,Race.Circuit.Length);
    LapChart.Axes.Left.EndPosition:=75;
  end;

  procedure DrawCircuit(const ACanvas:TTeeCanvas);
  begin
    ACanvas.Brush.Style:=bsClear;
    ACanvas.Pen.Width:=3;
    ACanvas.Pen.Color:=clRed;
    CircuitPath.Draw(Circuit.Canvas);
  end;

  procedure DrawPilots(const ACanvas:TTeeCanvas);
  var L, t : Integer;
      Last : TAllRidersData;
      ShowNumbers : Boolean;
      P : TPoint;
  begin
    ACanvas.Brush.Style:=bsSolid;
    ACanvas.Pen.Style:=psClear;

    L:=High(Race.Data);

    if L>=0 then
    begin
      ShowNumbers:=Circuit.Width>500;

      ACanvas.Font.Color:=clWhite;
      ACanvas.TextAlign:=ta_Center;

      Last:=Race.Data[L].Data;

      for t:=0 to High(Race.Riders) do
          if Race.Riders[t].Active then
          begin
            ACanvas.Brush.Color:=Race.Riders[t].Color;

            P:=PilotPosition(Last[t].Position);

            if ShowNumbers then
            begin
              ACanvas.Ellipse(RectFromCenter(P,14,14));
              ACanvas.TextOut(P.X,P.Y,Race.Riders[t].Number.ToString);
            end
            else
             ACanvas.FillRect(RectFromCenter(P,4,4));
          end;
      end;
  end;

  function HorizScale:Single;
  begin
    result:=(GIS.CalcXPosValue(2.226)-GIS.CalcXPosValue(2.20))/GIS.GetHorizAxis.IAxisSize;
  end;

  function VertScale:Single;
  begin
    result:=(GIS.CalcYPosValue(41.55)-GIS.CalcYPosValue(41.562))/GIS.GetVertAxis.IAxisSize;
  end;

var X,Y : Integer;
    T : TCanvasTransform;
begin
  if CircuitPath=nil then
     AddCircuitPath;

  T:=Circuit.Canvas.Transform;

  T.Save;
  try
    X:=GIS.CalcXPosValue(2.246);
    Y:=GIS.CalcYPosValue(41.574);

    T.Translate(X,Y);

    T.Scale(HorizScale,VertScale);

    T.Rotate(-7);

    DrawCircuit(Circuit.Canvas);
    DrawPilots(Circuit.Canvas);
  finally
    T.Restore;
  end;
end;

procedure TMainForm.CircuitsSelect(Sender: TObject);
begin
  FreeAndNil(CircuitPath);
  Circuit.Invalidate;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CircuitPath.Free;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  if ParamCount>0 then
     if ParamStr(1).ToUpper='SLOW' then
        Timer1.Interval:=100;

  WindowState:=TWindowState.wsMaximized;
end;

procedure Shuffle(var Items:TArray<Integer>);
var t : Integer;
begin
  Randomize;

  for t:=High(Items) downto 1 do
      SwapInteger(Items[t],Items[Random(t+1)])
end;

function HTMLColor(const S:String):TColor;
begin
  result:=RGB(
            StrToInt('$'+Copy(S,2,2)),
            StrToInt('$'+Copy(S,4,2)),
            StrToInt('$'+Copy(S,6,2))
            );
end;

procedure TMainForm.CreatePole;
var t,tmp : Integer;
    Index : TArray<Integer>;
begin
  Pole.Free;
  Pole:=TStringsData.Create(6,PilotsData.Rows);

  SetLength(Index,PilotsData.Rows);

  for t:=0 to PilotsData.Rows-1 do
      Index[t]:=t;

  Shuffle(Index);

  for t:=0 to PilotsData.Rows-1 do
  begin
    Pole[0,t]:=(t+1).ToString;

    tmp:=Index[t];

    Pole[1,t]:=PilotsData[0,tmp];
    Pole[2,t]:=PilotsData[1,tmp];
    Pole[3,t]:='1:35.610';
    Pole[4,t]:=''; // flag
    Pole[5,t]:=PilotsData[2,tmp];
  end;

  PoleGrid.Data:=Pole;

  SetLength(Race.Riders,PilotsData.Rows);

  for t:=0 to High(Race.Riders) do
  begin
    Race.Riders[t].Active:=True; // In Starting Grid
    Race.Riders[t].Number:=PilotsData.Cells[0,t].ToInteger;
    Race.Riders[t].Color:=HTMLColor(PilotsData.Cells[4,t]);
    Race.Riders[t].Pole:=FindRiderInPole(Race.Riders[t].Number);
  end;

  InitRaceData;
end;

const
  Season='2026';

procedure TMainForm.FormShow(Sender: TObject);

  procedure SetupGrid(const AGrid:TTeeGrid; const AColumn:Integer);
  var t : Integer;
      f : Tee.Format.TTextFormat;
  begin
    for t:=0 to PilotsData.Rows-1 do
    begin
      f:=AGrid.CellFormat.Cell[t,AColumn].Format;
      f.Brush.Color:=HTMLColor(PilotsData.Cells[4,t]);
      f.Brush.Show;
      f.Font.Color:=clWhite;
    end;
  end;

begin
  PoleGrid.ParentFont:=True;
  Pilots.ParentFont:=True;
  Circuits.ParentFont:=True;
  ChampionGrid.ParentFont:=True;
  BikeGrid.ParentFont:=True;

  PilotsData:=TCSVDataImport.FromFile(MotoGP+'\'+Season+'\Pilots.txt',True,',','');
  Pilots.Data:=PilotsData;

  SetupGrid(Pilots,0);

  SensorsData:=TCSVDataImport.FromFile(MotoGP+'\Sensors.txt');
  Sensors.Data:=SensorsData;

  CircuitsData:=TCSVDataImport.FromFile(MotoGP+'\Circuits.csv');
  Circuits.Data:=CircuitsData;

  Circuits.Selected.Row:=5; // Barcelona

  SeasonData:=TCSVDataImport.FromFile(MotoGP+'\'+Season+'\Rounds.txt');
  ChampionGrid.Data:=SeasonData;

  CreatePole;

  SetupGrid(PoleGrid,1);

  PoleGrid.Columns[1].Width.Value:=40;

  Circuit.Axes.Visible:=True;

  GIS:=TGISRaster.Create(Self);
  Circuit.AddSeries(GIS);

  // Barcelona Lat Lon
//  GIS.SetBounds(41,42, 1.4,2.8);

  GIS.SetBounds(41.56, 41.576, 2.24, 2.27);

  // Enable zoooming in-out with the mouse wheel
  Circuit.Panning.MouseWheel:=pmwNone;
  Circuit.Zoom.MouseWheel:=pmwNormal;

  GIS.Visible:=False;

  // Optional: Disk cache to store map graphic tiles (to avoid http requests)

  var tmpFolder:=TPath.Combine(TPath.GetTempPath,'TeeGISCache');
  ForceDirectories(tmpFolder);

  GIS.Path:=tmpFolder;

  CBMap.ItemIndex:=0;
  CBMapChange(Self);

  // Select top rider
  PoleGrid.Selected.Row:=0;

  Torque:=TFormTorqueCurve.Create(Self);
  Torque.Align:=alClient;
  TTeeVCL.AddFormTo(Torque,TabTorqueCurve);

  LBBikes.ItemIndex:=0;
  LBBikesClick(Self);

  PageControl1.ActivePage:=TabLap;

  LeanGauge.CircleBrush.Style:=bsClear;
end;

function CalcLeanAngle(const APoints: TPointFloatArray; Current: Integer; const Speed:Single): Single;
const MaxLean=64;
var
  P1, P2, P3: TPointFloat;
  L : Integer;
  Angle1, Angle2, DeltaAngle: Single;
begin
  L:=Length(APoints);

  P1 := APoints[Current];
  P2 := APoints[(Current + 1) mod L];
  P3 := APoints[(Current + 2) mod L];

  Angle1 := ArcTan2(P2.Y - P1.Y, P2.X - P1.X);
  Angle2 := ArcTan2(P3.Y - P2.Y, P3.X - P2.X);

  DeltaAngle := Angle2 - Angle1;

  if DeltaAngle > Pi then DeltaAngle := DeltaAngle - (2 * Pi);
  if DeltaAngle < -Pi then DeltaAngle := DeltaAngle + (2 * Pi);

  Result := DeltaAngle * Speed * 15.0;

  if Result > MaxLean then Result := MaxLean
  else
  if Result < -MaxLean then Result := -MaxLean;
end;

procedure TMainForm.FrontViewBeforeDrawSeries(Sender: TObject);
var Rider, tmp, L : Integer;
    Speed,
    LeanAngle : Single;
begin
  if CircuitPoints=nil then
     Exit;

  Rider:=PoleGrid.Selected.Row; // TODO: Index in the Riders Data array !

  if Rider>-1 then
  begin
    L:=High(Race.Data);

    if L>-1 then
    begin
      tmp:=PilotPositionIndex(Race.Data[L].Data[Rider].Position);

      Speed:=Race.Data[L].Data[Rider].Speed;

      LeanAngle:=CalcLeanAngle(CircuitPoints,tmp,Speed);
      LeanGauge.Value:=Round(LeanAngle);
      SpeedGauge.Value:=Round(Speed);

      TFrontView.Draw(FrontView,LeanGauge.Value);
    end;
  end
  else
  begin
    LeanGauge.Value:=0;
    SpeedGauge.Value:=0;
  end;
end;

procedure TMainForm.FrontViewResize(Sender: TObject);
begin
  SpeedGauge.CustomBounds:=Rect(10,10,400,100);
  LeanGauge.CustomBounds:=Rect(10,90,FrontView.Width-10,FrontView.Height-10);
end;

procedure TMainForm.SetTeeCanvas(const AClass:TTeeCanvasClass);
begin
  CircuitPath.Free;
  CircuitPath:=nil;

  LapChart.Canvas:=AClass.Create;
  Circuit.Canvas:=AClass.Create;
  Chart2.Canvas:=AClass.Create;
  PoleChart.Canvas:=AClass.Create;
  Semaphor.Canvas:=AClass.Create;
end;

procedure TMainForm.Skia1Click(Sender: TObject);
begin
  SetTeeCanvas(TTeeSkiaCanvas);
end;

procedure TMainForm.GDI1Click(Sender: TObject);
begin
  SetTeeCanvas(TGDIPlusCanvas);
end;

procedure TMainForm.OpenGL1Click(Sender: TObject);
begin
  SetTeeCanvas(TGLCanvas);
end;

procedure TMainForm.PoleChartAfterDraw(Sender: TObject);
var XS,YS : Integer;
    C : TTeeCanvas;

  procedure DrawAt(X,Y:Integer; const Pilot:String);
  begin
    C.Line(X,Y+10,X,Y);
    C.LineTo(X+XS,Y);
    C.LineTo(X+XS,Y+10);
    C.TextOut(X+10,Y+10,Pilot);
  end;

var X,XSep,
    Y,
    tmp,
    Row : Integer;
begin

  C:=PoleChart.Canvas;

  C.Pen.Color:=clYellow;
  C.Pen.Width:=3;
  C.Font.Color:=clWhite;

  X:=80;
  XS:=40;
  YS:=80;
  Y:=80;
  XSep:=50;

  for Row:=0 to (Pole.Rows div 3) do
  begin
    DrawAt(X,Y+Row*YS,Pole.Cells[1,3*Row]);

    tmp:=1+3*Row;

    if tmp<Pole.Rows then
       DrawAt(X+(XS+XSep),Y+Row*YS+15,Pole.Cells[1,tmp]);

    tmp:=2+3*Row;

    if tmp<Pole.Rows then
       DrawAt(X+2*(XS+XSep),Y+Row*YS+30,Pole.Cells[1,tmp]);
  end;
end;

procedure TMainForm.RefillCharts;
var Rider,
    t : Integer;
    X : Single;
begin
  if SeriesSpeed=nil then
  begin
    SeriesSpeed:=TFastLineSeries.Create(Self);
    SeriesAcceleration:=TFastLineSeries.Create(Self);

    SeriesSpeed.ParentChart:=LapChart;
    SeriesAcceleration.ParentChart:=LapChart;

    SeriesSpeed.Title:='Speed';
    SeriesAcceleration.Title:='Acceleration';
  end;

  Rider:=PoleGrid.Selected.Row;

  if Rider>=0 then
  begin
    LapChart.Title.Caption:=Pole.Cells[1,Rider]+' '+Pole.Cells[2,Rider];

    SeriesSpeed.GetHorizAxis.SetMinMax(0,Race.Circuit.Length);

    SeriesSpeed.BeginUpdate;
    SeriesAcceleration.BeginUpdate;

    SeriesSpeed.Clear;
    SeriesAcceleration.Clear;

    for t:=0 to High(Race.Data) do
    begin
      X:=Race.Data[t].Data[Rider].Position;

      SeriesSpeed.AddXY(X,Race.Data[t].Data[Rider].Speed);
      SeriesAcceleration.AddXY(X,Race.Data[t].Data[Rider].Acceleration);
    end;

    SeriesAcceleration.EndUpdate;
    SeriesSpeed.EndUpdate;
  end;
end;

procedure TMainForm.PoleGridSelect(Sender: TObject);
begin
  RefillCharts;
end;

procedure TMainForm.SemaphorAfterDraw(Sender: TObject);
var t : Integer;
begin
  with Semaphor.Canvas do
  begin
    Brush.Color:=clRed;
    Pen.Color:=clBlack;
    Pen.Width:=1;

    for t:=0 to Min(4,StartCount-1) do
    begin
      Ellipse(12+t*14,8,22+t*14,20);
    end;
  end;
end;

function TMainForm.FindRiderInPole(const ARider:Integer):Integer;
var t : Integer;
begin
  for t:=0 to Pole.Count-1 do
      if Pole.Cells[0,t].ToInteger=ARider then
      begin
        result:=t;
        Exit;
      end;

  result:=-1;
end;

procedure TMainForm.InitRaceData;
var t : Integer;
begin
  SetLength(Race.Data,1);
  SetLength(Race.Data[0].Data,Length(Race.Riders));

  for t:=0 to High(Race.Riders) do
      Race.Data[0].Data[t].Init(Race.Riders[t].Pole*3);
end;

procedure TMainForm.LBBikesClick(Sender: TObject);
var tmp : String;
begin
  tmp:=LBBikes.Items[LBBikes.ItemIndex];

  BikeData:=TCSVDataImport.FromFile(MotoGP+'\'+Season+'\Bikes\'+tmp+'\Parameters.txt',True,',','');
  BikeGrid.Data:=BikeData;

  Torque.FillSample(DefaultBike.Torque);

  Torque.Chart1.Legend.Title.Caption:=LBBikes.Items[LBBikes.ItemIndex];
end;

procedure TMainForm.StartRace;
var t : Integer;
begin
  Race.TotalLaps:=TotalLaps.Position;

  InitRaceData;

  Race.RiderEndsLap:=procedure(Lap:Integer)
  begin
    if Lap<=TotalLaps.Position then
    begin
      if Race.Current<Lap then
      begin
        Race.Current:=Lap;
        CurrentLap.Caption:=Race.Current.ToString+' of '+TotalLaps.Position.ToString;
      end;
    end;
  end;

  for t:=0 to High(Race.Riders) do
      Race.Riders[t].Start(Race.TotalLaps);

  Race.Ellapsed.Start;
  Race.Data[0].Time:=Race.Ellapsed.ElapsedMilliseconds;
end;

function TMainForm.DoStep:Boolean;
var L, t : Integer;
begin
  result:=False;

  L:=Length(Race.Data);
  SetLength(Race.Data,L+1);

  Race.Data[L].Time:=Race.Ellapsed.ElapsedMilliseconds;

  SetLength(Race.Data[L].Data,Length(Race.Riders));

  // for each Pilot
  for t:=0 to High(Race.Riders) do
      if Race.Riders[t].Active then
      begin
        Race.Data[L].Data[t].Step(Race.Data[L-1].Data[t]);

        if Race.Data[L].Data[t].Position>Race.Circuit.Length then
        begin
          Race.Data[L].Data[t].Position:=0; // New lap

          Inc(Race.Riders[t].Laps);
          Race.RiderEndsLap(Race.Riders[t].Laps);

          if Race.Riders[t].Laps>=Race.TotalLaps then
             Race.Riders[t].Active:=False; // Finished
        end;

        result:=Race.Riders[t].Active;
      end;

  Circuit.Invalidate;

  // Show Speed and Acceleration for selected driver
  RefillCharts;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;

  if DoStep then
  begin
    Timer1.Enabled:=True;

    FrontView.Invalidate;
  end
  else
     BStopClick(Self);

  LRaceEllapsed.Caption:=Race.Ellapsed.Elapsed.ToString;
end;

procedure TMainForm.TimerStartTimer(Sender: TObject);
begin
  Inc(StartCount);

  if StartCount=10 then
  begin
    StartCount:=0;
    TimerStart.Enabled:=False;
    Timer1.Enabled:=True;

    BPause.Enabled:=True;
    BStop.Enabled:=True;

    StartRace;
  end;

  Semaphor.Invalidate;
end;

end.
