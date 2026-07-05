{
  @davidberneda

  https://github.com/Steema/MotoGP

}
unit Unit_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  System.Types, System.TimeSpan,

  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.CheckLst,

  VCLTee.TeEngine, VCLTee.TeCanvas, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.Control, VCLTee.Grid, VCLTee.TeePenDlg,
  VCLTee.TeeSVGCanvas,

  Tee.GridData.Strings, Tee.Grid.CSV, TeeGIS, TeeRacing, Tee.Painter,
  Tee.Grid.Columns, Tee.GridData.Rtti,

  TeeTorqueCurve, PNGImage,

  VCLTee.Series, Vcl.Menus, VCLTee.TeeNumericGauge, VCLTee.TeeGauges,
  VCLTee.TeeTools, VCLTee.TeeSurfa, VCLTee.TeeLinearGauge, VCLTee.TeeComma;

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
    TabFrontView: TTabSheet;
    FrontView: TChart;
    TabSheet3: TTabSheet;
    LBBikes: TListBox;
    PageControl5: TPageControl;
    TabSheet4: TTabSheet;
    TabTorqueCurve: TTabSheet;
    BikeGrid: TTeeGrid;
    SpeedGauge: TNumericGauge;
    LeanGauge: TGaugeSeries;
    CursorLap: TColorLineTool;
    TowerLapRider: TTowerSeries;
    TabData: TTabSheet;
    DataGrid: TTeeGrid;
    FuelGauge: TLinearGauge;
    FrontView1: TMenuItem;
    Pole1: TMenuItem;
    N1: TMenuItem;
    Circuit1: TMenuItem;
    SeriesList: TCheckListBox;
    Dashboard: TChart;
    Dashboard1: TMenuItem;
    DebugLean: TPanel;
    TBLean: TTrackBar;
    N2: TMenuItem;
    Debug1: TMenuItem;
    Lean1: TMenuItem;
    TeeCommander1: TTeeCommander;
    TabTires: TTabSheet;
    TiresGrid: TTeeGrid;
    Splitter3: TSplitter;
    PageControl6: TPageControl;
    Splitter4: TSplitter;
    TabLapTimes: TTabSheet;
    LapTimesGrid: TTeeGrid;
    CBSeasons: TComboBox;
    TabAllPilots: TTabSheet;
    AllPilotsGrid: TTeeGrid;
    CBRounds: TComboBox;
    CBRace: TComboBox;
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
    procedure Exit1Click(Sender: TObject);
    procedure LapChartAfterDraw(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FrontView1Click(Sender: TObject);
    procedure Pole1Click(Sender: TObject);
    procedure Circuit1Click(Sender: TObject);
    procedure SeriesListClickCheck(Sender: TObject);
    procedure Dashboard1Click(Sender: TObject);
    procedure DashboardAfterDraw(Sender: TObject);
    procedure DashboardResize(Sender: TObject);
    procedure FrontViewAfterDraw(Sender: TObject);
    procedure Lean1Click(Sender: TObject);
    procedure TBLeanChange(Sender: TObject);
    procedure Chart2GetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);
    procedure Edit1Change(Sender: TObject);
    procedure CBSeasonsChange(Sender: TObject);
    procedure CBRaceChange(Sender: TObject);
  private
    { Private declarations }

    CircuitPath : TTeeBasePath;
    GIS : TGISRaster;

    RearBike : TGraphic;

    BikeData,
    RoundsData,
    PilotsData,
    SensorsData,
    CircuitsData,
    Pole,
    LapsTimeData : TStringsData;

    StartCount : Integer;

    Race : TRace;

    Torque : TFormTorqueCurve;

    RacePoleIndex, // Current pole during race (keeps changing)
    StartPoleIndex // Pole at grid, race start, immutable
     : TArray<Integer>;

    SeriesSpeed,
    SeriesAcceleration,
    SeriesRPM,
    SeriesThrottle : TFastLineSeries;

    SeriesGear : TLineSeries;

    procedure CreatePole;
    function DoStep:Boolean;
    procedure FillRounds;
    procedure FillSeasons;
    function FindRiderInPole(const ARider:Integer):Integer;
    procedure InitPoleData;
    procedure InitRaceData;
    procedure RefillCharts;
    function MotoGPSeason:String;
    function Season:String;
    procedure SetCurrentLap(const ACurrent:Integer);
    procedure SetDashboard;
    procedure SetTeeCanvas(const AClass:TTeeCanvasClass);
    procedure SetupPilotGrid(const AGrid:TTeeGrid; const AColorColumn,ANumColumn:Integer);
    procedure StartRace;
    procedure TrySetGISBounds;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Math, IOUtils, Tee.Format, UITypes,

  TeeGDIPlus, TeeSkia, TeeGLCanvas;

function HasParameter(const AParameter:String):Boolean;
var t : Integer;
begin
  for t:=1 to ParamCount do
      if UpperCase(ParamStr(t))=UpperCase(AParameter) then
      begin
        result:=True;
        Exit;
      end;

  result:=False;
end;

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

  CBSeasons.Enabled:=False;
  CBRounds.Enabled:=False;
  CBRace.Enabled:=False;

  StartCount:=0;

  if HasParameter('NOSEMAPHOR') then
     StartCount:=9;

  TimerStart.Enabled:=True;
end;

procedure TMainForm.BStopClick(Sender: TObject);
begin
  Timer1.Enabled:=False;

  BPause.Caption:=PauseCaption;
  BPause.Enabled:=False;
  BStop.Enabled:=False;
  BStart.Enabled:=True;

  TBLean.Enabled:=True;
  DebugLean.Visible:=Lean1.Visible;

  Race.Ellapsed.Stop;

  BRandomPole.Enabled:=True;

  CBSeasons.Enabled:=True;
  CBRounds.Enabled:=True;
  CBRace.Enabled:=True;
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
  PoleChart.Invalidate;
end;

const MotoGP='..\..\Data\MotoGP';

procedure TMainForm.CBMapChange(Sender: TObject);
begin
  GIS.Visible:=CBMap.ItemIndex>0;
  GIS.MapServer:=TMapServer(CBMap.ItemIndex-1);

  Circuit.Walls.Visible:=GIS.Visible;
  Circuit.Axes.Visible:=GIS.Visible;
end;

procedure TMainForm.CBRaceChange(Sender: TObject);
begin
  Race.TotalLaps:=StrToInt(RoundsData.Cells[3+CBRace.ItemIndex,CBRounds.ItemIndex]);
  SetCurrentLap(0);
end;

procedure TMainForm.CBSeasonsChange(Sender: TObject);
begin
  PilotsData:=TCSVDataImport.FromFile(MotoGPSeason+'\Pilots.txt',True,',','');
  Pilots.Data:=PilotsData;

  SetupPilotGrid(Pilots,0,-1);

  Pilots.Columns['Color'].Hide;

  TiresGrid.Data:=TCSVDataImport.FromFile(MotoGPSeason+'\Tires.txt');

  RoundsData:=TCSVDataImport.FromFile(MotoGPSeason+'\Rounds.txt');
  ChampionGrid.Data:=RoundsData;

  FillRounds;

  CBRounds.ItemIndex:=0;
  CBRaceChange(Self);

  CreatePole;

  PoleGrid.Columns[1].Width.Value:=40;

  PoleGrid.Invalidate;
end;

procedure TMainForm.Chart2GetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
  ValueIndex: Integer; var LabelText: string);
var tmp : Integer;
begin
  if Sender=Chart2.DepthAxis then
     if ValueIndex=-1 then
     begin
       ValueIndex:=StrToInt(LabelText);

       if (ValueIndex>=0) and (ValueIndex<=High(Race.Riders)) then
       begin
         tmp:=FindRiderInPole(Race.Riders[ValueIndex].Number);

         LabelText:=IntToStr(Race.Riders[ValueIndex].Number)+' '+Pole.Cells[2,tmp];
       end;
     end;
end;

procedure DrawPilotNumber(const ACanvas:TTeeCanvas; const ShowNumbers:Boolean;
                          const P:TPoint;
                          const ASize:Integer;
                          const AColor:TColor; const ANumber:String);
begin
  ACanvas.Brush.Color:=AColor;
  ACanvas.Gradient.Visible:=False;
  ACanvas.Brush.Style:=bsSolid;

  if ShowNumbers then
  begin
    ACanvas.Ellipse(RectFromCenter(P,ASize,ASize));
    ACanvas.TextAlign:=TA_CENTER;

    ACanvas.Font.Color:=clWhite;
    ACanvas.TextOut(P.X+1,P.Y-8,ANumber);
  end
  else
    ACanvas.FillRect(RectFromCenter(P,ASize div 3,ASize div 3));
end;

procedure TMainForm.Circuit1Click(Sender: TObject);
begin
  PanelCircuit.Visible:=not PanelCircuit.Visible;
  Circuit1.Checked:=PanelCircuit.Visible;
end;

procedure TMainForm.CircuitAfterDraw(Sender: TObject);

  function LoadCircuitPath(const ID:String):String;
  begin
    if ID='' then
       result:=''
    else
       result:=TFile.ReadAllText(MotoGP+'\Circuits\Paths\'+ID+'.svg');
  end;

  procedure AddCurves(const ACurves:Array of TCurve);
  var t : Integer;
  begin
    for t:=0 to High(ACurves) do
        CurveSeries.AddXY(ACurves[t].Position,ACurves[t].Angle,ACurves[t].Name);
  end;

  // Montmeló
  procedure AddCircuitPath;
  var PathFile : String;
  begin
    CircuitPath:=LapChart.Canvas.CreatePath;

    PathFile:=CircuitsData[3,Circuits.Selected.Row];

    if PathFile<>'' then
    begin
      TSVGParser.ParsePath(CircuitPath,LoadCircuitPath(PathFile));

      Race.Circuit.Points:=CircuitPath.Flatten(0.25);

      Race.Circuit.FillCurves(

      [620,700,950,1300,1650,1820,2000,2120,2350,2900,3150,3350,3650,3950], // Positions in meters
      ['Elf','2','Renault','Repsol','Seat','6','Würth','8','Campsa','La Caixa','11','Banc Sabadell','Europcar','New Holland'], // Names
      [90,-45,180,90,-135,-15,-90,45,60,-80,-45,90,60,90],  // Angles in degrees
      [100,120,150,105,75,140,115,155,0,85,130,110,125,165],   // Safe entry speed km/h
      [45,30,85,40,25,0,35,45,0,35,0,55,40,60]); // Meters from entry position to Apex


       CurveSeries.GetVertAxis.SetMinMax(-180,180);

      CurveSeries.Clear;
      CurveSeries.Title:='Curves';

      AddCurves(Race.Circuit.Curves);

      CurveSeries.GetVertAxis.Title.Caption:='Angles';
    end;
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
            P:=Race.Circuit.PointPosition(Last[t].Position);

            DrawPilotNumber(ACanvas,ShowNumbers,P,14,Race.Riders[t].Color, IntToStr(Race.Riders[t].Number));
          end;
      end;
  end;

  function HorizScale:Single;
  begin
    result:=(GIS.CalcXPosValue(2.27)-GIS.CalcXPosValue(2.20))/GIS.GetHorizAxis.IAxisSize/3;
  end;

  function VertScale:Single;
  begin
    result:=(GIS.CalcYPosValue(41.53)-GIS.CalcYPosValue(41.562))/GIS.GetVertAxis.IAxisSize/3;
  end;

  procedure PaintCircuitPath;
  var X,Y : Integer;
      T : TCanvasTransform;
  begin
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

  function WeatherStyleToString(const AStyle:TWeatherStyle):String;
  begin
    case AStyle of
      wsDry: result:='Dry';
      wsWet: result:='Wet';
     wsRain: result:='Rain';
    end;
  end;


  procedure PaintWeather;
  begin
    Circuit.Canvas.Font.Color:=clNavy;
    Circuit.Canvas.TextAlign:=TA_LEFT;

    Circuit.Canvas.TextOut(15,10,'Temp: '+Race.Weather.AirTemperature.ToString+'°C');
    Circuit.Canvas.TextOut(15,30,'Track: '+Race.Weather.TrackTemperature.ToString+'°C');
    Circuit.Canvas.TextOut(15,50,WeatherStyleToString(Race.Weather.Style));
    Circuit.Canvas.TextOut(15,70,'Humidity: '+Race.Weather.Humidity.ToString+'%');
    Circuit.Canvas.TextOut(15,90,'Air Density: '+FormatFloat('0.000',Race.Weather.AirDensity)+' kg/m³');

    Circuit.Canvas.TextOut(15,120,'Elevation: '+Race.Circuit.Elevation.ToString+' m');
    Circuit.Canvas.TextOut(15,140,'Length: '+Race.Circuit.TotalLength.ToString+' m');
  end;

  procedure SelectCircuit;
  var tmp : Single;
  begin
    if TryStrToFloat(CircuitsData[4,Circuits.Selected.Row],tmp) then // Circuite (ie: Montmeló) length in meters
       Race.Circuit.TotalLength:=tmp
    else
       Race.Circuit.TotalLength:=0;

    if TryStrToFloat(CircuitsData[5,Circuits.Selected.Row],tmp) then // Circuite (ie: Montmeló) 120 // Offset in meters
       Race.Circuit.PolePosition:=tmp
    else
       Race.Circuit.PolePosition:=0;

    // TODO: Find index using PolePosition
    Race.Circuit.PolePositionIndex:=8;  // Offset in point indexes

    if TryStrToFloat(CircuitsData[6,Circuits.Selected.Row],tmp) then // Mean above sea level
       Race.Circuit.Elevation:=tmp
    else
       Race.Circuit.Elevation:=0;

    LapChart.Axes.Bottom.SetMinMax(0,Race.Circuit.TotalLength);
    LapChart.Axes.Left.EndPosition:=75;
  end;

begin
  if CircuitPath=nil then
     AddCircuitPath;

  SelectCircuit;

  PaintCircuitPath;

  PaintWeather;
end;

procedure TMainForm.CircuitsSelect(Sender: TObject);
begin
  FreeAndNil(CircuitPath);
  Circuit.Invalidate;

  TrySetGISBounds;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CircuitPath.Free;
  RearBike.Free;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  if HasParameter('SLOW') then
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

  // Randomly choose and sort riders
  procedure ShufflePoleIndex;
  var t : Integer;
  begin
    SetLength(RacePoleIndex,Pole.Count);

    for t:=0 to High(RacePoleIndex) do
        RacePoleIndex[t]:=t;

    Shuffle(RacePoleIndex);
  end;

  function CopyPoleIndex:TArray<Integer>;
  var t, L : Integer;
  begin
    L:=Length(RacePoleIndex);

    SetLength(result,L);

    for t:=0 to L-1 do
        result[t]:=RacePoleIndex[t];
  end;

  procedure InitPoleGrid;
  var t : Integer;
      tmp : Integer;
  begin
    for t:=0 to Pole.Count-1 do
    begin
      Pole[0,t]:=(t+1).ToString;

      tmp:=RacePoleIndex[t];

      Pole[1,t]:=PilotsData[0,tmp];
      Pole[2,t]:=PilotsData[1,tmp];
      Pole[3,t]:='0:0.0'; // Current lap time
      Pole[4,t]:='0:0.0';// Last lap time
      Pole[5,t]:='0:0.0'; // Best lap time
      Pole[6,t]:='0'; // Lap with best time

      Pole[7,t]:=''; // flag
      Pole[8,t]:=PilotsData[2,tmp];
    end;

    PoleGrid.Data:=Pole;

    PoleGrid.Columns[0].Header.Text:='#';
    PoleGrid.Columns[1].Header.Text:='Num';
    PoleGrid.Columns[2].Header.Text:='Name';
    PoleGrid.Columns[3].Header.Text:='Current'; // Current lap time
    PoleGrid.Columns[4].Header.Text:='Last'; // Last lap time
    PoleGrid.Columns[5].Header.Text:='Best'; // Best lap time
    PoleGrid.Columns[6].Header.Text:='Num'; // Lap with best time
    PoleGrid.Columns[7].Header.Text:=''; // flag
    PoleGrid.Columns[8].Header.Text:='Team';

    PoleGrid.Columns[3].Width.Value:=90;
    PoleGrid.Columns[4].Width.Value:=90;
    PoleGrid.Columns[5].Width.Value:=90;
  end;

  procedure InitRaceRiders;
  var t : Integer;
  begin
    SetLength(Race.Riders,Pole.Count);

    for t:=0 to High(Race.Riders) do
    begin
      Race.Riders[t].Active:=True; // In Starting Grid
      Race.Riders[t].Number:=PilotsData.Cells[0,t].ToInteger;
      Race.Riders[t].Color:=HTMLColor(PilotsData.Cells[4,t]);
      Race.Riders[t].Pole:=FindRiderInPole(Race.Riders[t].Number);
    end;
  end;

var RiderQuantity : Integer;
begin
  Pole.Free;

  RiderQuantity:=PilotsData.Rows; // <-- use to test, for example 1 or 2 riders only

  if HasParameter('SINGLERIDER') then
     RiderQuantity:=1;

  Pole:=TStringsData.Create(9,RiderQuantity);

  ShufflePoleIndex;

  StartPoleIndex:=CopyPoleIndex;

  InitPoleGrid;

  SetupPilotGrid(PoleGrid,1,1);

  InitRaceRiders;

  InitRaceData;
end;

// Cell colors from pilor color
procedure TMainForm.SetupPilotGrid(const AGrid:TTeeGrid; const AColorColumn,ANumColumn:Integer);

  function PilotNum(const ANum:String):Integer; // index inside PilotsData
  var t : Integer;
  begin
    for t:=0 to PilotsData.Count-1 do
        if PilotsData.Cells[0,t]=ANum then
        begin
          result:=t;
          Exit;
        end;

    result:=-1; // error !
  end;

var tmp,t : Integer;
    f : Tee.Format.TTextFormat;
begin
  for t:=0 to AGrid.Data.Count-1 do
  begin
    f:=AGrid.CellFormat.Cell[t,AColorColumn].Format;

    if ANumColumn=-1 then
       tmp:=t
    else
       tmp:=PilotNum(AGrid.Data.AsString(AGrid.Columns[ANumColumn],t));

    f.Brush.Color:=HTMLColor(PilotsData.Cells[4,tmp]);
    f.Brush.Show;
    f.Font.Color:=clWhite;
  end;
end;

procedure TMainForm.TrySetGISBounds;
var tmp : TArray<String>;
    Old : Char;
    S : String;
begin
  if GIS<>nil then
  begin
    S:=(CircuitsData.Cells[7,Circuits.Selected.Row]);
    tmp:=S.Split([' ']);

    if Length(tmp)=4 then // ok: 41.56 41.576 2.24 2.27
    begin
      Old:=FormatSettings.DecimalSeparator;

      FormatSettings.DecimalSeparator:='.';
      try
        GIS.SetBounds(StrToFloat(tmp[0]),StrToFloat(tmp[2]),StrToFloat(tmp[1]),StrToFloat(tmp[3]));
      finally
        FormatSettings.DecimalSeparator:=Old;
      end;
    end;
  end;
end;

function TMainForm.Season:String;
begin
  result:=CBSeasons.Text;
end;

function TMainForm.MotoGPSeason:String;
begin
  result:=MotoGP+'\Seasons\'+Season;
end;

procedure TMainForm.FillRounds;
var t : Integer;
begin
  CBRounds.Clear;

  for t:=0 to RoundsData.Count-1 do
      CBRounds.Items.Add(RoundsData[1,t]);
end;

procedure TMainForm.FillSeasons;
begin
  CBSeasons.Clear;

  for var S in TDirectory.GetDirectories(MotoGP+'\Seasons') do
      CBSeasons.Items.Add(ExtractFileName(S));
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  PoleGrid.ParentFont:=True;
  Pilots.ParentFont:=True;
  Circuits.ParentFont:=True;
  ChampionGrid.ParentFont:=True;
  BikeGrid.ParentFont:=True;
  TiresGrid.ParentFont:=True;
  AllPilotsGrid.ParentFont:=True;

  AllPilotsGrid.Data:=TCSVDataImport.FromFile(MotoGP+'\AllPilots.txt');

  SensorsData:=TCSVDataImport.FromFile(MotoGP+'\Sensors.txt');
  Sensors.Data:=SensorsData;

  CircuitsData:=TCSVDataImport.FromFile(MotoGP+'\Circuits\Circuits.txt');
  Circuits.Data:=CircuitsData;

  Circuits.Selected.Row:=5; // Montmeló, Barcelona, Catalunya

  FillSeasons;

  CBSeasons.ItemIndex:=CBSeasons.Items.IndexOf(IntToStr(CurrentYear));
  CBSeasonsChange(Self);

  Circuit.Axes.Visible:=False;

  GIS:=TGISRaster.Create(Self);
  Circuit.AddSeries(GIS);

  TrySetGISBounds;

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

  SpeedGauge.Value:=0;
  LeanGauge.HandDistance:=30;
  LeanGauge.CircleBrush.Style:=bsClear;
  LeanGauge.Value:=0;

  FuelGauge.Value:=20;
  FuelGauge.Maximum:=22;
  FuelGauge.Ranges[0].EndValue:=FuelGauge.Maximum;

  Race.Weather.Init;
  Race.Weather.CalculateAirDensity(Race.Circuit.Elevation);

  RearBike:=TPngImage.Create;
  RearBike.LoadFromFile(MotoGP+'\Images\rear_bike.png');
end;

procedure TMainForm.FrontView1Click(Sender: TObject);
begin
  FrontView.Visible:=not FrontView.Visible;
  FrontView1.Checked:=FrontView.Visible;

  TabFrontView.TabVisible:=Dashboard.Visible or FrontView.Visible;
end;

procedure TMainForm.FrontViewAfterDraw(Sender: TObject);

  procedure DrawTrack;
  var C : TTeeCanvas;
      W, H, HTop: Integer;
  begin
    C:=FrontView.Canvas;
    C.Pen.Style:=psClear;
    C.Pen.Color:=RGB(100,100,100);
    C.Brush.Color:=C.Pen.Color;
    C.Brush.Style:=bsSolid;

    C.Gradient.Visible:=True;
    C.Gradient.StartColor:=C.Pen.Color;
    C.Gradient.EndColor:=RGB(200,200,200);

    W:=FrontView.Width;
    H:=FrontView.Height;
    HTop:=340;

    C.Polygon([Point(20,H),Point(160,HTop),Point(W-160,HTop),Point(W-20,H)]);
  end;

  procedure DrawKerbs(const APos:Single);
  var C : TTeeCanvas;
      t, W, H : Integer;
  begin
    Exit;

    C:=FrontView.Canvas;
    C.Pen.Style:=psClear;
    C.Brush.Color:=RGB(130,20,10);
    C.Brush.Style:=bsSolid;
    C.Gradient.Visible:=False;

    for t:=0 to 5 do
    begin
      H:=FrontView.Height-Round(40*t)+(Round(APos) mod 10);
      W:=20+Round(7*t);

      C.Polygon([Point(W,H),Point(W+14-t,H-35),Point(W+14-2*t+60,H-35),Point(W+60,H)]);

      W:=FrontView.Width-180+Round(7*t);

      C.Polygon([Point(W,H),Point(W+14-t,H-35),Point(W+14-t+60,H-35),Point(W+60,H)]);
    end;
  end;

var L, tmp : Integer;
    R : TRect;
begin
  DrawTrack;

  tmp:=PoleGrid.Selected.Row;

  L:=High(Race.Data);

  if (tmp=-1) or (L=-1) then
     DrawKerbs(Race.Circuit.PolePosition)
  else
     DrawKerbs(Race.Data[L].Data[tmp].Position);

  if tmp<>-1 then
  begin
    tmp:=RacePoleIndex[tmp];
    DrawPilotNumber(FrontView.Canvas,True,Point(20,20),14,Race.Riders[tmp].Color, IntToStr(Race.Riders[tmp].Number));

    R:=Rect(110,450,FrontView.Width-110,860);

    if Lean1.Checked then
       FrontView.Canvas.StretchRotate(R,RearBike,TBLean.Position)
    else
    if L<>-1 then
       FrontView.Canvas.StretchRotate(R,RearBike,Race.Data[L].Data[tmp].LeanAngle);
  end;
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

procedure TMainForm.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=TabData then
  begin
    if DataGrid.Data=nil then
       //DataGrid.Data:=TVirtualData<TRace>.Create(Race);
       DataGrid.Data:=TVirtualArrayData<TRider>.Create(Race.Riders);
  end;
end;

procedure TMainForm.Pole1Click(Sender: TObject);
begin
  PanelPole.Visible:=not PanelPole.Visible;
  Pole1.Checked:=PanelPole.Visible;

  if PanelPole.Visible then
     Splitter2.Left:=PanelPole.Left-5;
end;

procedure TMainForm.PoleChartAfterDraw(Sender: TObject);
var XS,YS : Integer;
    C : TTeeCanvas;

  procedure DrawAt(X,Y:Integer; const Pilot:Integer);
  var tmp : TRider;
  begin
    C.Line(X,Y+10,X,Y);
    C.LineTo(X+XS,Y);
    C.LineTo(X+XS,Y+10);

    tmp:=Race.Riders[StartPoleIndex[Pilot]];

    DrawPilotNumber(C,True,Point(X+20,Y+30),14,tmp.Color,IntToStr(tmp.Number));
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
  Y:=130;
  XSep:=50;

  for Row:=0 to (Pole.Rows div 3) do
  begin
    tmp:=3*Row;

    DrawAt(X,Y+Row*YS,tmp);

    tmp:=1+3*Row;

    if tmp<Pole.Rows then
       DrawAt(X+(XS+XSep),Y+Row*YS+15,tmp);

    tmp:=2+3*Row;

    if tmp<Pole.Rows then
       DrawAt(X+2*(XS+XSep),Y+Row*YS+30,tmp);
  end;
end;

procedure TMainForm.RefillCharts;

  procedure CreateSeries;
  begin
    SeriesSpeed:=TFastLineSeries.Create(Self);
    SeriesAcceleration:=TFastLineSeries.Create(Self);
    SeriesRPM:=TFastLineSeries.Create(Self);
    SeriesGear:=TLineSeries.Create(Self);
    SeriesThrottle:=TFastLineSeries.Create(Self);

    SeriesSpeed.ParentChart:=LapChart;
    SeriesAcceleration.ParentChart:=LapChart;
    SeriesRPM.ParentChart:=LapChart;
    SeriesGear.ParentChart:=LapChart;
    SeriesThrottle.ParentChart:=LapChart;

    SeriesSpeed.Title:='Speed m/s';
    SeriesAcceleration.Title:='Acceleration m/s²';
    SeriesRPM.Title:='RPM';
    SeriesGear.Title:='Gear';
    SeriesThrottle.Title:='Throttle %';

    // Brakes
    // Tires Temperature and pressure
  end;

  procedure AddSeriesList;
  var t : Integer;
  begin
    SeriesList.Clear;

    for t:=0 to LapChart.SeriesCount-1 do
        SeriesList.Items.Add(LapChart.Series[t].Title);

    SeriesList.CheckAll(TCheckBoxState.cbChecked);
  end;

var Rider,
    StartLap, t : Integer;
    X : Single;
begin
  if SeriesSpeed=nil then
  begin
    CreateSeries;
    AddSeriesList;
  end;

  if PoleGrid.Selected.Row>-1 then
  begin
    Rider:=PoleGrid.Selected.Row;

    LapChart.Title.Caption:=Pole.Cells[1,Rider]+' '+Pole.Cells[2,Rider];

    if Length(Race.Riders)>Rider then
    begin
      SeriesSpeed.GetHorizAxis.SetMinMax(0,Race.Circuit.TotalLength);

      SeriesSpeed.BeginUpdate;
      SeriesAcceleration.BeginUpdate;

      SeriesSpeed.Clear;
      SeriesAcceleration.Clear;

      if Race.Riders[Rider].Laps=0 then
         StartLap:=0
      else
         StartLap:=Race.Riders[Rider].LapsTime[Race.Riders[Rider].Laps-1];

      for t:=StartLap to High(Race.Data) do
      begin
        X:=Race.Data[t].Data[Rider].Position;

        SeriesSpeed.AddXY(X,Race.Data[t].Data[Rider].Speed);
        SeriesAcceleration.AddXY(X,Race.Data[t].Data[Rider].Acceleration);
      end;

      SeriesAcceleration.EndUpdate;
      SeriesSpeed.EndUpdate;
    end;
  end;
end;

procedure TMainForm.PoleGridSelect(Sender: TObject);
var tmp : Integer;
begin
  RefillCharts;

  tmp:=PoleGrid.Selected.Row;

  if tmp=-1 then
  begin
    FrontView.Title.Caption:='';

    TabLapTimes.TabVisible:=False;
    LapTimesGrid.Data:=nil;
  end
  else
  begin
    FrontView.Title.Caption:=Pole.Cells[1,tmp]+' '+Pole.Cells[2,tmp];

    TabLapTimes.TabVisible:=True;

    LapsTimeData:=TStringsData.Create(2,Race.TotalLaps);
    LapTimesGrid.Data:=LapsTimeData;

    LapTimesGrid.Columns[0].Header.Text:='Lap';
    LapTimesGrid.Columns[1].Header.Text:='Time';
  end;

  FrontView.Invalidate;
end;

procedure TMainForm.SemaphorAfterDraw(Sender: TObject);
var t : Integer;
begin
  with Semaphor.Canvas do
  begin
    Brush.Color:=clRed;
    Pen.Color:=clBlack;
    Pen.Width:=1;

    for t:=0 to 4 do
    begin
      if StartCount<=t then
         Brush.Style:=bsClear
      else
         Brush.Style:=bsSolid;

      Ellipse(12+t*14,8,22+t*14,20);
    end;
  end;
end;

procedure TMainForm.SeriesListClickCheck(Sender: TObject);
begin
  LapChart.Series[SeriesList.ItemIndex].Active:=SeriesList.Checked[SeriesList.ItemIndex];
end;

function TMainForm.FindRiderInPole(const ARider:Integer):Integer;
var t : Integer;
begin
  for t:=0 to Pole.Count-1 do
      if Pole.Cells[1,t].ToInteger=ARider then
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

procedure TMainForm.LapChartAfterDraw(Sender: TObject);
begin
  LapChart.Canvas.TextOut(10,10,Round(CursorLap.Value).ToString+' m');
end;

procedure TMainForm.LBBikesClick(Sender: TObject);
var tmp : String;
begin
  tmp:=LBBikes.Items[LBBikes.ItemIndex];

  BikeData:=TCSVDataImport.FromFile(MotoGPSeason+'\Bikes\'+tmp+'\Parameters.txt',True,',','');
  BikeGrid.Data:=BikeData;

  Torque.FillSample(DefaultBike.Torque);

  Torque.Chart1.Legend.Title.Caption:=LBBikes.Items[LBBikes.ItemIndex];
end;

procedure TMainForm.Lean1Click(Sender: TObject);
begin
  DebugLean.Visible:=not DebugLean.Visible;
  Lean1.Checked:=DebugLean.Visible;
end;

procedure TMainForm.InitPoleData;
var t : Integer;
begin
  for t:=1 to Pole.Count-1 do
  begin
    Pole[3,t]:='0:0.0'; // Current lap time
    Pole[4,t]:='0:0.0'; // Last lap time
    Pole[5,t]:='0:0.0'; // Best lap time
    Pole[6,t]:='0'; // Lap with best time
  end;
end;

function IntToTime(const m: Int64): string;
begin
  with TTimeSpan.FromMilliseconds(m) do
    Result := Format('%d:%.2d.%.3d', [Trunc(TotalMinutes), Seconds, Milliseconds]);
end;

procedure TMainForm.SetCurrentLap(const ACurrent:Integer);
begin
  CurrentLap.Caption:=IntToStr(ACurrent)+' of '+IntToStr(Race.TotalLaps);
end;

procedure TMainForm.StartRace;

  procedure InitTowerLapRider;
  var X,Z : Integer;
  begin
    TowerLapRider.NumXValues:=Race.TotalLaps;
    TowerLapRider.NumZValues:=Length(Race.Riders);

    TowerLapRider.FillGridIndex;

    TowerLapRider.GetHorizAxis.Increment:=1;

    TowerLapRider.ParentChart.DepthAxis.Title.Hide;

    TowerLapRider.ParentChart.DepthAxis.Visible:=True;
//    TowerLapRider.ParentChart.DepthAxis.Texts.Style:=talText;
    TowerLapRider.ParentChart.DepthAxis.Increment:=1;
    TowerLapRider.ParentChart.DepthAxis.Texts.Separation:=0;

    for X:=0 to TowerLapRider.NumXValues-1 do
        for Z:=0 to TowerLapRider.NumZValues-1 do
        begin
          TowerLapRider.Value[X,Z]:=0;
//          TowerLapRider.ValueColor[TowerLapRider.GridIndex[X,Z]]:=Race.Riders[Z].Color;
        end;
  end;

var t : Integer;
begin
  CursorLap.Value:=0;

  InitRaceData;

  InitPoleData;

  Race.RiderEndsLap:=procedure(Rider,Lap:Integer)
  begin
    if Lap<=Race.TotalLaps then
    begin
      if Race.Current<Lap then
      begin
        Race.Current:=Lap;
        SetCurrentLap(Race.Current);
      end;

      Pole.Cells[4,Rider]:=IntToTime(Race.Riders[Rider].Ellapsed[Lap-1]); // Last

      if Race.Riders[Rider].BestLap>0 then
      begin
        Pole.Cells[5,Rider]:=IntToTime(Race.Riders[Rider].Ellapsed[Race.Riders[Rider].BestLap-1]); // Best
        Pole.Cells[6,Rider]:=IntToStr(Race.Riders[Rider].BestLap); // Best
      end
      else
      begin
        Pole.Cells[5,Rider]:='';
        Pole.Cells[6,Rider]:='';
      end;

      LapsTimeData.Cells[0,Lap-1]:=IntToStr(Lap);
      LapsTimeData.Cells[1,Lap-1]:=Pole.Cells[4,Rider]; // Last

      TowerLapRider.Value[Lap-1,Rider]:=Race.Riders[Rider].Ellapsed[Lap-1];
    end;
  end;

  for t:=0 to High(Race.Riders) do
  begin
    Race.Riders[t].Start(Race.TotalLaps);

    // Customize pilot

    Race.Riders[t].Pilot.Name:=PilotsData.Cells[1,t];
    Race.Riders[t].Pilot.Weight:=StrToFloat(PilotsData.Cells[5,t]);
    Race.Riders[t].Pilot.Height:=StrToFloat(PilotsData.Cells[6,t]);
  end;

  Race.Ellapsed.Start;

  Race.Data[0].Time:=Race.Ellapsed.ElapsedMilliseconds;

  InitTowerLapRider;
end;

procedure TMainForm.Dashboard1Click(Sender: TObject);
begin
  Dashboard.Visible:=not Dashboard.Visible;
  Dashboard1.Checked:=Dashboard.Visible;

  TabFrontView.TabVisible:=Dashboard.Visible or FrontView.Visible;
end;

procedure TMainForm.DashboardAfterDraw(Sender: TObject);

  procedure DrawParameters(var Rider:TRiderData);
  var C : TTeeCanvas;

    procedure DrawBrake(const ABrake:Single; X,Y:Integer);
    var tmp : Integer;
    begin
      tmp:=Round(ABrake*0.2);

      if tmp>0 then
         C.Ellipse(Rect(X-tmp,Y,X+tmp,Y+2*tmp));
    end;

  begin
    C:=Dashboard.Canvas;
    C.TextOut(10,10,IntToStr(Rider.RPM)+' RPM');
    C.TextOut(DashBoard.Width-80,60,IntToStr(Rider.Gear)+' Gear');

    C.Brush.Style:=bsSolid;
    C.Brush.Color:=RGB(220,0,60);
    C.Pen.Style:=psClear;

    DrawBrake(Rider.FrontBrake,DashBoard.Width-70,90);
    DrawBrake(Rider.BackBrake,DashBoard.Width-70,140);
  end;

var Rider, L : Integer;
begin
  Rider:=PoleGrid.Selected.Row;

  if Rider>-1 then
  begin
    L:=High(Race.Data);

    if L>-1 then
    begin
      Rider:=RacePoleIndex[Rider];
      DrawParameters(Race.Data[L].Data[Rider]);
    end;
  end;
end;

procedure TMainForm.DashboardResize(Sender: TObject);
begin
  SpeedGauge.CustomBounds:=Rect(10,10,Dashboard.Width-10,60);
  LeanGauge.CustomBounds:=Rect(10,60,Dashboard.Width-10,Dashboard.Height+40);
  FuelGauge.CustomBounds:=Rect(10,40,50,Dashboard.Height-40);
end;

function TMainForm.DoStep:Boolean;

  // Any rider passed others?
  function SwapRiders(var AllRiders:TAllRidersData):Boolean;

    procedure SwapRider(const A,B:Integer);
    var t : Integer;
        tmp : String;
    begin
      for t:=1 to Pole.Columns-1 do
      begin
        tmp:=Pole.Cells[t,A];
        Pole.Cells[t,A]:=Pole.Cells[t,B];
        Pole.Cells[t,B]:=tmp;
      end;
    end;

  var t,
      Num,
      tmp, tmpI : Integer;
  begin
    result:=False;

    t:=1;

    while t<Length(RacePoleIndex) do
    begin
      Num:=RacePoleIndex[t];

      if Race.Riders[Num].Active then
      begin
        tmp:=t;

        while AllRiders[tmp].Position>AllRiders[tmp-1].Position do
        begin
          result:=True;

          SwapRider(tmp,tmp-1);

          tmpI:=RacePoleIndex[tmp];
          RacePoleIndex[tmp]:=RacePoleIndex[tmp-1];
          RacePoleIndex[tmp-1]:=tmpI;

          tmp:=tmp-1;

          if tmp<2 then
             break;
        end;
      end;

      Inc(t);
    end;
  end;

  function StepRiders(const L:Integer):Boolean;
  var t : Integer;
      NumLap : Integer; // Current finished lap for a rider (starting at 1)
      Delta : Integer;
      LapTime : Int64;
      Brake : TBrakeDecision;
      CurrentPhase : TTurnPhase;
      TriggerBrakeDist  : Single;
  begin
    result:=False;

    // for each Pilot
    for t:=0 to High(Race.Riders) do
      if Race.Riders[t].Active then
      begin
        Delta:=Race.Data[L].Time-Race.Data[L-1].Time;

        Race.Data[L].Data[t].Step(Delta/1000, Race.Riders[t].Bike, Race.Riders[t].Pilot, Race.Data[L-1].Data[t]);

        // Finished lap?
        if Race.Data[L].Data[t].Position>Race.Circuit.TotalLength then
        begin
          Race.Data[L].Data[t].Position:=0; // New lap

          NumLap:=1+Race.Riders[t].Laps;

          Race.Riders[t].LapsTime[NumLap-1]:=L;

          if NumLap=1 then
             LapTime:=Race.Data[L].Time-Race.Data[0].Time
          else
             LapTime:=Race.Data[L].Time-Race.Data[Race.Riders[t].LapsTime[NumLap-2]].Time;

          Race.Riders[t].Ellapsed[NumLap-1]:=LapTime;

          if NumLap=1 then
             Race.Riders[t].BestLap:=1
          else
          if LapTime<Race.Riders[t].Ellapsed[Race.Riders[t].BestLap] then
             Race.Riders[t].BestLap:=NumLap;

          Inc(Race.Riders[t].Laps);
          Race.RiderEndsLap(t,Race.Riders[t].Laps);

          Race.Riders[t].NextCurve:=1;

          if Race.Riders[t].Laps>=Race.TotalLaps then
             Race.Riders[t].Active:=False; // Rider Race Finished
        end;

        result:=Race.Riders[t].Active;

        if result then
        begin
          Brake:=EvaluateBrakingPoint(Race.Data[L].Data[t].Position, Race.Data[L].Data[t].Speed,
                                      Race.Circuit.Curves[Race.Riders[t].NextCurve-1],
                                      Race.Riders[t].Bike.MaxBrakeDeceleration);


          TriggerBrakeDist:= Race.Circuit.Curves[Race.Riders[t].NextCurve-1].Position - Brake.BrakingDistanceNeeded;

          CurrentPhase := DetermineTrackPhase(Race.Data[L].Data[t].Position, Race.Circuit.Curves[Race.Riders[t].NextCurve-1], TriggerBrakeDist);

          case CurrentPhase of

            tpApproach:
              begin
                if Race.Data[L].Data[t].Throttle<100 then
                begin
                  Race.Data[L].Data[t].Throttle:=100;
                  Race.Data[L].Data[t].RPM:=Race.Riders[t].Bike.MaxRPM;


                  // No brakes
                  Race.Data[L].Data[t].FrontBrake:=0;
                  Race.Data[L].Data[t].BackBrake:=0;

                  // Bike upright
                  Race.Data[L].Data[t].LeanAngle:=0;
                end;
              end;

            tpBraking:
              begin
                if Race.Data[L].Data[t].Throttle>0 then
                begin
                  Race.Data[L].Data[t].Throttle:=0;
                  Race.Data[L].Data[t].RPM:=Race.Riders[t].Bike.IdleRPM;


                  // Brake Bite
                  Race.Data[L].Data[t].FrontBrake:=90;
                  Race.Data[L].Data[t].BackBrake:=30;

                  // Bike Upright
                  Race.Data[L].Data[t].LeanAngle:=0;
                end;
              end;

            tpCornering:
              begin
                // TODO: Accurate LeanAngle
                // tmp:=Race.Circuit.IndexOfPosition(Race.Data[L].Data[Rider].Position);
                // Race.Data[L].Data[t].LeanAngle:=CalcLeanAngle(Race.Circuit.Points,tmp,Speed);

                if Race.Circuit.Curves[Race.Riders[t].NextCurve-1].Angle<0 then
                   Race.Data[L].Data[t].LeanAngle:= -Race.Riders[t].Bike.MaxLeanAngle
                else
                   Race.Data[L].Data[t].LeanAngle:=Race.Riders[t].Bike.MaxLeanAngle;

                // TrailBraking progressively (The Release)
                Race.Data[L].Data[t].TrailBrake(Race.Circuit.Curves[Race.Riders[t].NextCurve-1].ApexPosition);
              end;

            tpAcceleration:
              begin
                // Un-brake
                Race.Data[L].Data[t].FrontBrake:=0;

                Race.Data[L].Data[t].BackBrake:=0;

                // Bike up progressive
                Race.Data[L].Data[t].StandUp;

                // Throttle depends on Lean angle
                Race.Data[L].Data[t].Throttle:=CalculateThrottle(Race.Data[L].Data[t].LeanAngle,Race.Riders[t].Bike.MaxLeanAngle);
                Race.Data[L].Data[t].RPM:=Race.Riders[t].Bike.MaxRPM;

             end;
          end;

          if Race.Data[L].Data[t].Position>Race.Circuit.Curves[Race.Riders[t].NextCurve-1].ApexPosition then
          begin
            // Next Curve
            Inc(Race.Riders[t].NextCurve);

            if Race.Riders[t].NextCurve>Length(Race.Circuit.Curves) then
               Race.Riders[t].NextCurve:=1;
          end;

        end;

      end;
  end;

  procedure SetGapTimes(const L:Integer);
  var t : Integer;
      Gap, GapTime : Single;
  begin
    // Current time
    Pole.Cells[3,0]:=IntToTime(Race.Data[L].Time); // First pilot total race time

    // From pilot 1:
    for t:=1 to Pole.Count-1 do
    begin
      Gap:=Race.Data[L].Data[t].Position-Race.Data[L].Data[t-1].Position;

      if Race.Data[L].Data[t].Speed>0 then
         GapTime:=(Gap/Race.Data[L].Data[t].Speed)/86400 // seconds per day
      else
         GapTime:=0;

      Pole.Cells[3,t]:=TimeToStr(GapTime);
    end;

    PoleGrid.Invalidate;
  end;

var L : Integer;
begin
  L:=Length(Race.Data);
  SetLength(Race.Data,L+1);

  if RealTimeFactor=0 then
     Race.Data[L].Time:=Race.Ellapsed.ElapsedMilliseconds
  else
     Race.Data[L].Time:=Race.Data[L-1].Time+Round(1000*RealTimeFactor);

  SetLength(Race.Data[L].Data,Length(Race.Riders));

  result:=StepRiders(L);

//  if SwapRiders(Race.Data[L].Data) then
     PoleGrid.Invalidate;

  CursorLap.Value:=Race.Data[L].Data[0].Position;

  SetGapTimes(L);

  Circuit.Invalidate;

  FrontView.Invalidate;

  if PageControl1.ActivePage=TabLap then
     // Show Speed and Acceleration for currently selected driver
     RefillCharts;

  if PageControl1.ActivePage=TabData then
     DataGrid.Invalidate;
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
  SetCurrentLap(0);
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.SetDashboard;
var Rider,
    //tmp,
    L : Integer;
    Speed : Single;
begin
  if Race.Circuit.Points=nil then
     Exit;

  Rider:=PoleGrid.Selected.Row;

  if Rider>-1 then
  begin
    L:=High(Race.Data);

    if L>-1 then
    begin
      // tmp:=Race.Circuit.IndexOfPosition(Race.Data[L].Data[Rider].Position);

      Speed:=Race.Data[L].Data[Rider].Speed;

      LeanGauge.Value:=Round(Race.Data[L].Data[Rider].LeanAngle);
      SpeedGauge.Value:=Round(Speed*3.6); // to km/h

      FuelGauge.Value:=Race.Riders[Rider].Bike.Fuel;
    end;
  end
  else
  begin
    LeanGauge.Value:=0;
    SpeedGauge.Value:=0;
  end;
end;

procedure TMainForm.TBLeanChange(Sender: TObject);
begin
  LeanGauge.Value:=TBLean.Position;
  FrontView.Invalidate;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;

  if DoStep then
  begin
    Timer1.Enabled:=True;

    if Dashboard.Visible then
       SetDashboard;

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

    TBLean.Enabled:=False;
    DebugLean.Visible:=False;

    BPause.Enabled:=True;
    BStop.Enabled:=True;

    StartRace;
  end;

  Semaphor.Invalidate;
end;

end.
