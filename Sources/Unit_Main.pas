{
  @davidberneda

  https://github.com/Steema/MotoGP

}
unit Unit_Main;

interface

{.$DEFINE USE_SKIA}  // Enable Skia for Delphi (Skia4D)

uses
  Windows, Messages, SysUtils, Classes, Graphics, Types, PNGImage,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, CheckLst, Menus,

  TeEngine, TeCanvas, TeeProcs, Chart, Control, Grid, TeePenDlg, TeeSVGCanvas,
  TeeConst,

  {$IF TeeMsg_TeeChartPalette='TeeChart'}
  {$DEFINE TEEPRO} // <-- TeeChart Lite or Pro ?
  {$ENDIF}

  {$IFDEF TEEPRO}
  TeeComma,
  {$ENDIF}

  Tee.GridData.Strings, Tee.Grid.CSV, TeeGIS, TeeRacing, Tee.Painter,
  Tee.Grid.Columns, Tee.GridData.Rtti, Tee.Grid, Tee.Grid.RowGroup,
  Tee.Format, Tee.Renders, TeeTorqueCurve,
  Series, TeeNumericGauge, TeeGauges, TeeTools, TeeSurfa, TeeLinearGauge,
  Vcl.Buttons;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabTelemetry: TTabSheet;
    LapChart: TChart;
    PanelTop: TPanel;
    BStart: TButton;
    BPause: TButton;
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
    SplitterPole: TSplitter;
    Pilots: TTeeGrid;
    PageControl3: TPageControl;
    TabRace: TTabSheet;
    TabPole: TTabSheet;
    PoleGrid: TTeeGrid;
    Sensors: TTeeGrid;
    PoleChart: TChart;
    Semaphor: TChart;
    TimerStart: TTimer;
    Panel3: TPanel;
    CBMap: TComboBox;
    Panel4: TPanel;
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
    PageControl4: TPageControl;
    TabFrontView: TTabSheet;
    FrontView: TChart;
    TabSheet3: TTabSheet;
    PageControl5: TPageControl;
    TabSheet4: TTabSheet;
    BikeGrid: TTeeGrid;
    SpeedGauge: TNumericGauge;
    LeanGauge: TGaugeSeries;
    CursorLap: TColorLineTool;
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
    TabTires: TTabSheet;
    TiresGrid: TTeeGrid;
    Splitter3: TSplitter;
    PageControl6: TPageControl;
    Splitter4: TSplitter;
    TabLapTimes: TTabSheet;
    LapTimesGrid: TTeeGrid;
    CBSeasons: TComboBox;
    CBRounds: TComboBox;
    CBRace: TComboBox;
    heme1: TMenuItem;
    Clear1: TMenuItem;
    Dark1: TMenuItem;
    About1: TMenuItem;
    CurveSpeeds: TPointSeries;
    TabSheet1: TTabSheet;
    Circuits: TTeeGrid;
    CurvesGrid: TTeeGrid;
    Splitter5: TSplitter;
    TabAllPilots: TTabSheet;
    AllPilotsGrid: TTeeGrid;
    SiteWeather: TChart;
    rack1: TMenuItem;
    Bike1: TMenuItem;
    Panel1: TPanel;
    Label2: TLabel;
    CBViewLastLap: TCheckBox;
    EViewLap: TEdit;
    UDViewLap: TUpDown;
    Panel2: TPanel;
    Label4: TLabel;
    CBSelectedBike: TComboBox;
    FrontTire: TPaintBox;
    BackTire: TPaintBox;
    TireStatus: TTeeGrid;
    PanelBikeParams: TPanel;
    GearRatios: TTeeGrid;
    CBCategory: TComboBox;
    Splitter2: TSplitter;
    Splitter6: TSplitter;
    SeriesRadius: TFastLineSeries;
    SpeedButton1: TSpeedButton;
    BStop: TSpeedButton;
    Panel5: TPanel;
    LeaderBoard: TTeeGrid;
    Panel6: TPanel;
    ResultsGrid: TTeeGrid;
    ChampionGrid: TTeeGrid;
    Splitter7: TSplitter;
    PageControl7: TPageControl;
    TabSheet2: TTabSheet;
    TabLeaderChart: TTabSheet;
    LeaderChart: TChart;
    Options1: TMenuItem;
    Resolution1: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N51: TMenuItem;
    N101: TMenuItem;
    N201: TMenuItem;
    N301: TMenuItem;
    N401: TMenuItem;
    N501: TMenuItem;
    Label5: TLabel;
    EPoleRiders: TEdit;
    UDPoleRiders: TUpDown;
    Panel7: TPanel;
    TelemetryStep: TChart;
    PageControlTelemetry: TPageControl;
    TabSingleLap: TTabSheet;
    TabCompare: TTabSheet;
    TabAllLaps: TTabSheet;
    AllLaps: TChart;
    TowerLapRider: TTowerSeries;
    Panel8: TPanel;
    Label3: TLabel;
    CBRiderA: TComboBox;
    Label6: TLabel;
    CBRiderB: TComboBox;
    Label7: TLabel;
    Edit1: TEdit;
    UDLapsA: TUpDown;
    Label8: TLabel;
    Edit2: TEdit;
    UDLapsB: TUpDown;
    CompareChart: TChart;
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
    procedure GDI1Click(Sender: TObject);
    procedure Skia1Click(Sender: TObject);
    procedure OpenGL1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PoleGridSelect(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure LapChartAfterDraw(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Pole1Click(Sender: TObject);
    procedure Circuit1Click(Sender: TObject);
    procedure SeriesListClickCheck(Sender: TObject);
    procedure Dashboard1Click(Sender: TObject);
    procedure DashboardAfterDraw(Sender: TObject);
    procedure DashboardResize(Sender: TObject);
    procedure FrontViewAfterDraw(Sender: TObject);
    procedure Lean1Click(Sender: TObject);
    procedure TBLeanChange(Sender: TObject);
    procedure AllLapsGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: string);
    procedure Edit1Change(Sender: TObject);
    procedure CBSeasonsChange(Sender: TObject);
    procedure CBRaceChange(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Dark1Click(Sender: TObject);
    procedure CBRoundsChange(Sender: TObject);
    procedure SiteWeatherAfterDraw(Sender: TObject);
    procedure rack1Click(Sender: TObject);
    procedure Bike1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure CBViewLastLapClick(Sender: TObject);
    procedure EViewLapChange(Sender: TObject);
    procedure BikeGridSelect(Sender: TObject);
    procedure CBSelectedBikeChange(Sender: TObject);
    procedure FrontTirePaint(Sender: TObject);
    procedure BackTirePaint(Sender: TObject);
    procedure CBCategoryChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ChampionGridSelect(Sender: TObject);
    procedure PilotsCellEditing(const Sender: TObject; const AEditor: TControl;
      const AColumn: TColumn; const ARow: Integer);
    procedure PageControl7Change(Sender: TObject);
    procedure N1001Click(Sender: TObject);
    procedure EPoleRidersChange(Sender: TObject);
    procedure TelemetryStepAfterDraw(Sender: TObject);
    procedure CursorLapDragLine(Sender: TColorLineTool);
    procedure PageControlTelemetryChange(Sender: TObject);
    procedure CBRiderAChange(Sender: TObject);
  private
    { Private declarations }

    CircuitPath : TFastLineSeries; //TTeeBasePath;

    GIS : TGISRaster;

    RearBike : TGraphic;

    AllPilots,
    BikeData,
    RoundsData,
    PilotsData,
    SensorsData,
    TiresData,
    CircuitsData,
    Pole,
    ResultsData,
    LapsTimeData,
    CurvesGridData : TStringsData;

    StartCount : Integer;

    Race : TRace;

    Torque : TFormTorqueCurve;

    SwappingRider : Boolean; // True when there is a rider pass (internal use)

    SeriesSpeed,
    SeriesAcceleration,
    SeriesRPM,
    SeriesGear,
    SeriesThrottle,
    SeriesFrontBrake,
    SeriesBackBrake : TFastLineSeries;

    {$IFDEF TEEPRO}
    TeeCommander1 : TTeeCommander;
    {$ENDIF}

    procedure AddFlags(const AGrid:TTeeGrid; const ACountry:Integer; const AStrings:TStringsData);
    procedure AddResultsPoints;
    procedure AddRiderData(const APos:Integer; const Rider:Integer);
    procedure ApplyTheme(const ABack,AFont:Graphics.TColor);
    function CategoryPath:String;
    function CheckPilotExists(const S:String):Boolean;
    procedure ClearLapCharts;
    procedure CreateLeaderBoard;
    procedure CreateLeaderChart;
    procedure CreatePole;
    procedure DoPaintFlag(const ID:String; var AData: TRenderData);
    function DoStep:Boolean;
    procedure DrawTireIcon(const ACanvas:TCanvas; const AColumn:Integer);
    function FindInAllPilots(const S:String):Integer;
    procedure FillCategories;
    procedure FillSeasons;
    function FindBike(const ABike:String):TBike;
    function FindPilotNum(const ANum:String):Integer; // index inside PilotsData
    function FindRiderInPole(const ANumber:Integer):Integer;
    procedure InitPoleData;
    procedure LoadConfiguration;
    procedure RefillCharts;
    function CategorySeason:String;
    procedure PaintFastest(const Sender:TColumn; var AData:TRenderData; var DefaultPaint:Boolean);
    procedure PaintFlag(const Sender:TColumn; var AData:TRenderData; var DefaultPaint:Boolean);
    procedure PaintPoleDelta(const Sender:TColumn; var AData:TRenderData; var DefaultPaint:Boolean);
    procedure ReFillCompareChart;
    function Season:String;
    procedure SetCurrentLap(const ACurrent:Integer);
    procedure SetDashboard;
    procedure SetTeeCanvas(const AClass:TTeeCanvasClass);
    procedure SetupPilotGrid(const AGrid:TTeeGrid; const AColorColumn,ANumColumn:Integer);
    procedure StartRace;
    procedure TotalCircuitLength(const Axis:TChartAxis);
    procedure TrySetGISBounds;
    procedure UpdateCursorLap(var AData:TAllRidersData);
    procedure UpdateLapCharts;
    procedure VerifyAllPilots;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Math, IOUtils, UITypes, Registry, TimeSpan,

  TeeGDIPlus,

  {$IFDEF USE_SKIA}
  TeeSkia,
  {$ENDIF}

  TeeGLCanvas, TeeRacingAbout, Picture, TeeCountryFlags, TeeUtils, TeeCircuit;

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

function IntToTime(const m: Int64): string;
begin
  with TTimeSpan.FromMilliseconds(m) do
    Result := Format('%d:%.2d.%.3d', [Trunc(TotalMinutes), Seconds, Milliseconds]);
end;

const
  PauseCaption='Pause';
  ResumeCaption='Resume';

procedure TMainForm.About1Click(Sender: TObject);
begin
  with TAboutForm.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

const
  MotoGP_Registry='Software\Steema Software\MotoGP';

procedure SaveRegistry(const AKey,AName,AValue:String);
var R : TRegistry;
begin
  R:=TRegistry.Create;
  try
    if R.OpenKey(MotoGP_Registry+'\'+AKey,True) then
       R.WriteString(AName,AValue);
  finally
    R.Free;
  end;
end;

procedure TMainForm.BackTirePaint(Sender: TObject);
begin
  DrawTireIcon(BackTire.Canvas,7);
end;

procedure TMainForm.Bike1Click(Sender: TObject);
begin
  Bike1.Checked:=not Bike1.Checked;
  FrontView.Visible:=Rack1.Checked or Bike1.Checked;

  SaveRegistry('View','Bike',BoolToStr(Bike1.Checked,True));

  FrontView.Invalidate;
end;

procedure TMainForm.BikeGridSelect(Sender: TObject);
var tmp : String;
    tmpGears : TStringsData;
    tmpBike : TBike;
    t : Integer;
begin
  tmp:=BikeData[0,BikeGrid.Selected.Row];

  tmpBike:=FindBike(tmp);

  Torque.FillSample(tmpBike.Torque);
  Torque.Chart1.Legend.Title.Caption:=tmp;

  tmpGears:=TStringsData.Create(2,BikeData.Count);

  GearRatios.Data:=tmpGears;

  GearRatios.Columns[0].Header.Text:='Gear';
  GearRatios.Columns[1].Header.Text:='Ratio';

  FillSequential(tmpGears,0);

  for t:=0 to High(tmpBike.GearRatios) do
      tmpGears[1,t]:=FormatFloat('0.###',tmpBike.GearRatios[t]);
end;

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
  UDPoleRiders.Enabled:=False;

  CBCategory.Enabled:=False;
  CBSeasons.Enabled:=False;
  CBRounds.Enabled:=False;
  CBRace.Enabled:=False;

  Resolution1.Enabled:=False;

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

  UDPoleRiders.Enabled:=True;

  CBCategory.Enabled:=True;
  CBSeasons.Enabled:=True;
  CBRounds.Enabled:=True;
  CBRace.Enabled:=True;

  Resolution1.Enabled:=True;
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

const
  All_Pilots_File='All_Pilots.txt';
  All_Bikes_File='All_Bikes.txt';
  All_Tires_File='All_Tires.txt';

var DataPath:String='';

function FindDataPath:String;
begin
  if DataPath='' then
  begin
    DataPath:='Data';

    while not FileExists(DataPath+'\'+All_Pilots_File) do
    begin
      DataPath:='..\'+DataPath;

      if Length(DataPath)>100 then
         raise Exception.Create('Error Cannot find the Data folder');
    end;
  end;

  result:=DataPath;
end;

procedure TMainForm.CBCategoryChange(Sender: TObject);
begin
  FillSeasons;

  CBSeasons.ItemIndex:=CBSeasons.Items.IndexOf(IntToStr(CurrentYear));

  if CBSeasons.ItemIndex=-1 then
  begin
    Pilots.Data:=nil;
    ChampionGrid.Data:=nil;

    CBRounds.Clear;
    CBRounds.Enabled:=False;

    PoleGrid.Data:=nil;
  end
  else
    CBSeasonsChange(Self);

  UDPoleRiders.Enabled:=Pilots.Data<>nil;
  BStart.Enabled:=UDPoleRiders.Enabled;
end;

procedure TMainForm.CBMapChange(Sender: TObject);
begin
  GIS.Visible:=CBMap.ItemIndex>0;
  GIS.MapServer:=TMapServer(CBMap.ItemIndex-1);

  Circuit.Walls.Visible:=GIS.Visible;
  Circuit.Axes.Visible:=GIS.Visible;
end;

procedure TMainForm.CBRaceChange(Sender: TObject);

  procedure SetUpDown(const AUpDown:TUpDown; const AMin,AMax:Integer);
  begin
    AUpDown.Max:=AMax;
    AUpDown.Min:=AMin;
  end;

begin
  Race.TotalLaps:=StrToInt(RoundsData[3+CBRace.ItemIndex,CBRounds.ItemIndex]);

  SetUpDown(UDViewLap,1,Race.TotalLaps);
  SetUpDown(UDLapsA,1,Race.TotalLaps);
  SetUpDown(UDLapsB,1,Race.TotalLaps);

  SetCurrentLap(1);
end;

procedure TMainForm.TotalCircuitLength(const Axis:TChartAxis);
begin
  Axis.SetMinMax(0,Race.Circuit.TotalLength);
end;

procedure TMainForm.ReFillCompareChart;
var tmpA, tmpLapA,
    tmpB, tmpLapB : Integer;
    RPM : TAreaSeries;

    tmpStartA, tmpStartB,
    tmpEndA, tmpEndB,
    tmpMax,
    t : Integer;

begin
  tmpA:=CBRiderA.ItemIndex;
  tmpB:=CBRiderB.ItemIndex;

  tmpLapA:=UDLapsA.Position;
  tmpLapB:=UDLapsB.Position;

  CompareChart.Legend.Hide;

  TotalCircuitLength(CompareChart.Axes.Bottom);

  if (tmpA=-1) or (tmpB=-1) or (tmpLapA<1) or (tmpLapB<1) then
     CompareChart.Title.Caption:=''
  else
  begin
    CompareChart.Title.Caption:=CBRiderA.Text+' #'+IntToStr(tmpLapA)+' vs. '+CBRiderB.Text+' #'+IntToStr(tmpLapB);

    CompareChart.FreeAllSeries;

    RPM:=TAreaSeries.Create(Self);
    RPM.ParentChart:=CompareChart;
    RPM.AreaLinesPen.Hide;
    RPM.Pen.Hide;

    RPM.YOrigin:=0;
    RPM.UseYOrigin:=True;

    if Race.Riders[tmpA].Laps=0 then
    begin
      tmpStartA:=0;
      tmpEndA:=High(Race.Data);
    end
    else
      Race.Riders[tmpA].GetLapStartEnd(tmpLapA,tmpStartA,tmpEndA);

    if Race.Riders[tmpB].Laps=0 then
    begin
      tmpStartB:=0;
      tmpEndB:=High(Race.Data);
    end
    else
      Race.Riders[tmpB].GetLapStartEnd(tmpLapB,tmpStartB,tmpEndB);

    tmpMax:=Min(tmpEndA-tmpStartA,tmpEndB-tmpStartB);

    RPM.BeginUpdate;

    for t:=0 to tmpMax do
    begin
      // TODO: Sync A and B exact Position

      RPM.AddXY(Race.Data[tmpStartA+t].Data[tmpA].Position,Race.Data[tmpStartA+t].Data[tmpA].RPM-Race.Data[tmpStartB+t].Data[tmpB].RPM);
    end;

    RPM.EndUpdate;
  end;
end;

procedure TMainForm.CBRiderAChange(Sender: TObject);
begin
  ReFillCompareChart;
end;

procedure TMainForm.CBRoundsChange(Sender: TObject);
var tmp : Integer;
begin
  tmp:=CBRounds.ItemIndex;

  Circuits.Selected.Row:=CircuitsData.IndexOf(RoundsData[1,tmp],0);

  CreatePole;

  CursorLap.Value:=Race.Circuit.PolePosition;
end;

function TMainForm.FindInAllPilots(const S:String):Integer;
begin
  result:=AllPilots.IndexOf(S,0);
end;

procedure TMainForm.ChampionGridSelect(Sender: TObject);

  procedure SplitInto(const S:String; const AColumn:Integer);
  var tmp : TArray<String>;
      t, L, GridPos : Integer;
      OutStart : Boolean;
  begin
    for t:=0 to ResultsData.Count-1 do
    begin
      ResultsData[AColumn,t]:='';
      ResultsData[AColumn+1,t]:='';
    end;

    tmp:=S.Split(['|']);

    L:=Length(tmp);

    OutStart:=False;

    t:=0;

    GridPos:=0;

    while t<L do
    begin
      if tmp[t]='-' then
         OutStart:=True
      else
      begin
        ResultsData[AColumn,GridPos]:=tmp[t];

        if OutStart then
           ResultsData[AColumn+1,GridPos]:='OUT';

        Inc(GridPos);
      end;

      Inc(t);
    end;
  end;

begin
  if ChampionGrid.Selected.Row=-1 then
     ResultsGrid.Data:=nil
  else
  begin
    SplitInto(RoundsData[5,ChampionGrid.Selected.Row],1);
    SplitInto(RoundsData[6,ChampionGrid.Selected.Row],3);

    AddResultsPoints;

    ResultsGrid.Data:=ResultsData;

    ResultsGrid.Columns[0].Header.Text:='#';
    ResultsGrid.Columns[1].Header.Text:='Sprint';
    ResultsGrid.Columns[2].Header.Text:='Points';
    ResultsGrid.Columns[3].Header.Text:='Race';
    ResultsGrid.Columns[4].Header.Text:='Points';

    ResultsGrid.Columns[0].Width.Value:=30;
    ResultsGrid.Columns[1].Width.Value:=60;
    ResultsGrid.Columns[2].Width.Value:=70;
    ResultsGrid.Columns[3].Width.Value:=60;
    ResultsGrid.Columns[4].Width.Value:=70;

    SetupPilotGrid(ResultsGrid,1,1);
    SetupPilotGrid(ResultsGrid,3,3);

    ResultsGrid.Invalidate;
  end;
end;

function TMainForm.CheckPilotExists(const S:String):Boolean;
begin
  result:=FindInAllPilots(S)<>-1;

  if not result then
     raise Exception.Create('Error: Pilot with Code: '+s+' not found in All Pilots table');
end;

const
  SprintPoints:Array of Integer=[12,9,7,6,5,4,3,2,1];
  RacePoints:Array of Integer=[25,20,16,13,11,10,9,8,7,6,5,4,3,2,1];

procedure TMainForm.AddResultsPoints;
var t : Integer;
begin
  for t:=0 to High(SprintPoints) do
      ResultsData[2,t]:=IntToStr(SprintPoints[t]);

  for t:=0 to High(RacePoints) do
      ResultsData[4,t]:=IntToStr(RacePoints[t]);
end;

procedure TMainForm.CBSeasonsChange(Sender: TObject);

  procedure VerifyPilots;
  var t : Integer;
  begin
    for t:=0 to PilotsData.Count-1 do
        CheckPilotExists(PilotsData[0,t]);
  end;

  procedure CreateResultsData;
  begin
    ResultsData:=TStringsData.Create(5,PilotsData.Count);
    FillSequential(ResultsData,0);

    AddResultsPoints;
  end;

  procedure AddCountryColumn;
  var t, tmp : Integer;
  begin
    RoundsData.Resize(RoundsData.Columns+1,RoundsData.Rows);
    RoundsData.Headers[RoundsData.Columns-1]:='Country';

    for t:=0 to RoundsData.Count-1 do
    begin
      tmp:=CircuitsData.IndexOf(RoundsData[1,t],0);

      if tmp=-1 then
         raise Exception.Create('Error cannot find circuit: '+RoundsData[1,t]);

      RoundsData[RoundsData.Columns-1,t]:=CircuitsData[2,tmp];
    end;
  end;

begin
  //PilotsData.Free;
  Pilots.Data:=nil;

  PilotsData:=TCSVDataImport.FromFile(CategorySeason+'\Pilots.txt',True,',','');

  VerifyPilots;

  Pilots.Data:=PilotsData;

  SetupPilotGrid(Pilots,1,-1);

  if Pilots.Columns['Color']<>nil then
     Pilots.Columns['Color'].Hide;

  Pilots.Columns[1].Header.Text:='#';

  Pilots.Columns['Bike'].EditorClass:=TComboBox;

  if FileExists(CategorySeason+'\Rounds.txt') then
  begin
    CreateResultsData;

    RoundsData:=TCSVDataImport.FromFile(CategorySeason+'\Rounds.txt');

    AddCountryColumn;

    ChampionGrid.Data:=RoundsData;

    ChampionGrid.Columns[5].Hide;
    ChampionGrid.Columns[6].Hide;

    AddFlags(ChampionGrid,ChampionGrid.Columns.Count-1,RoundsData);

    FillItems(CBRounds.Items,RoundsData,1);

    CBRounds.Enabled:=True;

    CBRounds.ItemIndex:=0;
    CBRaceChange(Self);
  end
  else
  begin
    RoundsData:=nil;

    ChampionGrid.Data:=nil;
    ResultsGrid.Data:=nil;
    LeaderBoard.Data:=nil;

    CBRounds.Clear;
    CBRounds.Enabled:=False;
  end;

  CreatePole;

  PoleGrid.Columns[0].Width.Value:=32;
  PoleGrid.Columns[1].Width.Value:=40;

  PoleGrid.Invalidate;

  PoleGrid.Selected.Row:=0;
  PoleGridSelect(Self);
end;

const
  Pole_Index=0;
  Pole_Delta=1;
  Pole_Num=2;
  Pole_Name=3;
  Pole_Current=4;
  Pole_Last=5;
  Pole_Best=6;
  Pole_BestLap=7;

  Pilots_Bike=5;

procedure TMainForm.CBSelectedBikeChange(Sender: TObject);
var tmp : Integer;
begin
  tmp:=FindPilotNum(Pole[Pole_Num,PoleGrid.Selected.Row]);

  PilotsData[Pilots_Bike,tmp]:=CBSelectedBike.Items[CBSelectedBike.ItemIndex];
end;

procedure TMainForm.CBViewLastLapClick(Sender: TObject);
begin
  UDViewLap.Enabled:=not CBViewLastLap.Checked;
  EViewLap.Enabled:=UDViewLap.Enabled;
end;

procedure TMainForm.AllLapsGetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
  ValueIndex: Integer; var LabelText: string);
var tmp : Integer;
begin
  if Sender=AllLaps.DepthAxis then
     if ValueIndex=-1 then
     begin
       ValueIndex:=StrToInt(LabelText);

       if (ValueIndex>=0) and (ValueIndex<=High(Race.Riders)) then
       begin
         tmp:=FindRiderInPole(Race.Riders[ValueIndex].Number);

         LabelText:=IntToStr(Race.Riders[ValueIndex].Number)+' '+Pole[Pole_Name,tmp];
       end;
     end;
end;

// Choose a good font color, visible over AColor background
function CalcFontColor(const AColor:TColor):TColor;
begin
  if (AColor=clWhite) or (AColor=$FFE1) then
     result:=clBlack
  else
     result:=clWhite;
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

    ACanvas.Font.Color:=CalcFontColor(AColor);
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
var
  C : TTeeCanvas;

  procedure DrawFinishLine;
  var P0, P1 : TPointFloat;
  begin
    C.Pen.Color:=clBlack;

    P0.X:=CircuitPath.CalcXPos(0);
    P0.Y:=CircuitPath.CalcYPos(0);

    P1.X:=CircuitPath.CalcXPos(1);
    P1.Y:=CircuitPath.CalcYPos(1);

    DrawPerpendicular(C,P1,P0,30);
  end;

  procedure DrawCurves;
  var t : Integer;
      tmp : Integer;
      X,Y : Integer;
  begin
    for t:=0 to High(Race.Circuit.Curves) do
    begin
      tmp:=Race.Circuit.Curves[t].EntryIndex; //Race.Circuit.IndexOfPosition(Race.Circuit.Curves[t].Entry);

      X:=CircuitPath.CalcXPos(tmp);
      Y:=CircuitPath.CalcYPos(tmp);

      C.TextOut(X,Y,IntToStr(t+1));
    end;
  end;

  procedure DrawPilots;
  var L, t : Integer;
      Last : ^TAllRidersData;
      ShowNumbers : Boolean;
      P : TPoint;
      tmp,
      tmpPos : Integer;
  begin
    C.Brush.Style:=bsSolid;
    C.Pen.Style:=psClear;

    L:=High(Race.Data);

    if L>=0 then
    begin
      ShowNumbers:=Circuit.Width>350;

      C.Font.Color:=clWhite;
      C.TextAlign:=ta_Center;

      Last:=@Race.Data[L].Data;

      for t:=Pole.Count-1 downto 0 do
      begin
        tmp:=Race.PoleIndex[t];

        if Race.Riders[tmp].Active then
        begin
          tmpPos:=Race.Circuit.IndexOfPosition(Last^[tmp].Position);

          P.X:=CircuitPath.CalcXPos(tmpPos);
          P.Y:=CircuitPath.CalcYPos(tmpPos);

          DrawPilotNumber(C,ShowNumbers,P,14,Race.Riders[tmp].Color, IntToStr(Race.Riders[tmp].Number));
        end;
      end;
    end;
  end;

begin
  if CircuitPath.Count=0 then
     Exit;

  C:=Circuit.Canvas;

  DrawFinishLine;

  if Circuit.Width>500 then
     DrawCurves;

  DrawPilots;
end;

procedure TMainForm.CircuitsSelect(Sender: TObject);

  procedure AddRaceCurves;
  var t : Integer;
      Curve : ^TCurve;
  begin
    SetLength(Race.Circuit.Curves,CurvesGridData.Count);

    for t:=0 to CurvesGridData.Count-1 do
    begin
      Curve:=@Race.Circuit.Curves[t];

      Curve.Entry:=StrToFloat(CurvesGridData[1,t]);

      Curve.EntryIndex:=Race.Circuit.IndexOfPosition(Curve.Entry);

      Curve.Name:=CurvesGridData[2,t];

      Curve.TotalAngle:=StrToFloatDef(CurvesGridData[3,t],0);

      Curve.EntrySpeed:=StrToFloatDef(CurvesGridData[4,t],0);

      Curve.BeforeApex:=StrToFloatDef(CurvesGridData[5,t],0);

      Curve.ApexPosition:=Curve.Entry+Curve.BeforeApex;
    end;
  end;

  procedure AddCurves(const ACurves:Array of TCurve);
  var t : Integer;
      X : Single;
      tmp : String;
  begin
    for t:=0 to High(ACurves) do
    begin
      X:=ACurves[t].Entry;

      tmp:=IntToStr(t+1)+#13#10+ACurves[t].Name;

      CurveSeries.AddXY(X,ACurves[t].TotalAngle,tmp);
      CurveSpeeds.AddXY(X,ACurves[t].EntrySpeed/3.6);
    end;
  end;

  procedure SelectCircuit;
  var tmp : Single;
      tmpInt : Integer;
  begin
    if TryStrToInt(CircuitsData[5,Circuits.Selected.Row],tmpInt) then // Circuit (ie: Montmeló) # path point 17 is at the Finish Line
       Race.Circuit.FinishIndex:=tmpInt
    else
       Race.Circuit.FinishIndex:=0;

    if TryStrToFloat(CircuitsData[6,Circuits.Selected.Row],tmp) then // Circuit (ie: Montmeló) 126 // Offset in meters
       Race.Circuit.PolePosition:=tmp
    else
       Race.Circuit.PolePosition:=0;

    Race.Circuit.PolePositionIndex:=Race.Circuit.IndexOfPosition(Race.Circuit.PolePosition);

    if TryStrToFloat(CircuitsData[7,Circuits.Selected.Row],tmp) then // Mean above sea level
       Race.Circuit.Elevation:=tmp
    else
       Race.Circuit.Elevation:=0;

    TotalCircuitLength(LapChart.Axes.Bottom);

    LapChart.Axes.Left.EndPosition:=80;

    CursorLap.Value:=Race.Circuit.PolePosition;
  end;

  procedure FinishLoadCircuit;
  begin
    Race.Circuit.TotalLength:=PathLength(Race.Circuit.Points);

    // Add points to FastLine series
    CircuitPath.BeginUpdate;
    CircuitPath.XValues.Order:=loNone;
    CircuitPath.Clear;

    CircuitPath.AddArray(Race.Circuit.Points);

    CircuitPath.AddXY(Race.Circuit.Points[0].X,Race.Circuit.Points[0].Y);

    CircuitPath.EndUpdate;

    Race.Circuit.CalculateRadius;
  end;

  procedure LoadCSVPath(const AFile:String{; const APath:TTeeBasePath});
  var S: TStringsData;
      t : Integer;
  begin
    S:=TCSVDataImport.FromFile(AFile);

    SetLength(Race.Circuit.Points,S.Count);

    FormatSettings.DecimalSeparator:='.';

    for t:=0 to S.Count-1 do
    begin
      Race.Circuit.Points[t].X:=StrToFloat(S[0,t]);
      Race.Circuit.Points[t].Y:=StrToFloat(S[1,t]);
    end;

    FormatSettings.DecimalSeparator:=',';

    S.Free;

    FinishLoadCircuit;
  end;

  procedure CreateCircuitPath;
  var PathFile : String;

      function CalcFile(const AExtension:String):String;
      begin
        result:=TPath.Combine(FindDataPath+'\Circuits\Paths',TPath.ChangeExtension(PathFile,AExtension));
      end;

  var tmpPath : TTeeBasePath;
  begin
    PathFile:=CircuitsData[Circuits.Columns['Track'].Index,Circuits.Selected.Row];

    if PathFile<>'' then
    begin
      // Priority: CSV
      if FileExists(CalcFile('csv')) then
         LoadCSVPath(CalcFile('csv'))
      else
      if FileExists(CalcFile('svg')) then
      begin
        tmpPath:=LapChart.Canvas.CreatePath;
        try
          TSVGParser.ParsePath(tmpPath,TFile.ReadAllText(CalcFile('svg')));
          Race.Circuit.Points:=tmpPath.Flatten(0.1);
        finally
          tmpPath.Free;
        end;
      end;

      FinishLoadCircuit;
    end;
  end;

  procedure AddCircuitRadius;
  var t, L : Integer;
  begin
    SeriesRadius.BeginUpdate;
    SeriesRadius.Clear;

    L:=Length(Race.Circuit.Radius);

    for t:=0 to L-1 do
        SeriesRadius.AddXY(t*Race.Circuit.TotalLength/L, Race.Circuit.Radius[t]);

    SeriesRadius.EndUpdate;
  end;

  procedure CreateDataFromCurves;
  var t, L : Integer;
  begin
    L:=Length(Race.Circuit.Curves);

    CurvesGridData:=TStringsData.Create(7,L);

    FillSequential(CurvesGridData,0);

    for t:=0 to L-1 do
    begin
      CurvesGridData[1,t]:=FloatToStr(Race.Circuit.Curves[t].Entry);
      CurvesGridData[3,t]:=FloatToStr(Race.Circuit.Curves[t].TotalAngle); // Entry Angle?
      CurvesGridData[4,t]:=IntToStr(100); // TODO <-- calculate Entry Speed of each curve
      CurvesGridData[5,t]:=FloatToStr(Race.Circuit.Curves[t].BeforeApex);
    end;
  end;

var tmp : String;
begin
  Circuit.Invalidate;

  TrySetGISBounds;

  CreateCircuitPath;

  if Circuits.Data.Count>0 then
  begin
    tmp:=TPath.Combine(FindDataPath+'\Circuits\Curves',CircuitsData[3,Circuits.Selected.Row]+'.txt');

    if FileExists(tmp) then
    begin
      CurvesGridData:=TCSVDataImport.FromFile(tmp,True,',','');
      AddRaceCurves;
    end
    else
    begin
      TFormCircuit.DetectCorners(Race.Circuit);
      CreateDataFromCurves;
    end;

    CurvesGrid.Data:=CurvesGridData;

    CurvesGrid.Columns[0].Header.Text:='Curve';
    CurvesGrid.Columns[1].Header.Text:='Entry Position';
    CurvesGrid.Columns[2].Header.Text:='Name';
    CurvesGrid.Columns[3].Header.Text:='Total Angle';
    CurvesGrid.Columns[4].Header.Text:='Entry Speed';
    CurvesGrid.Columns[5].Header.Text:='To Apex';
  end;

  //AddCircuitRadius;

  SelectCircuit;

  CurveSeries.GetVertAxis.SetMinMax(-180,180);

  CurveSeries.Clear;
  CurveSeries.Title:='Curves';

  CurveSpeeds.Clear;
  CurveSpeeds.Title:='Entry Speed';

  AddCurves(Race.Circuit.Curves);

  CurveSeries.GetVertAxis.Title.Caption:='Angles';
end;

procedure TMainForm.LoadConfiguration;
var R : TRegistry;
    tmp : String;
begin
  R:=TRegistry.Create(KEY_READ);
  try
    if R.OpenKeyReadOnly(MotoGP_Registry+'\View') then
    begin
      if R.ValueExists('Theme') then
      begin
        tmp:=R.ReadString('Theme');

        if SameText(tmp,'Light') then
        begin
          Clear1.Checked:=True;
          Clear1Click(Self);
        end
        else
        if SameText(tmp,'Dark') then
        begin
          Dark1.Checked:=True;
          Dark1Click(Self);
        end;
      end;

      if R.ValueExists('Track') then
      begin
        rack1.Checked:=SameText(tmp,'TRUE');
        rack1Click(Self);
      end;

      if R.ValueExists('Bike') then
      begin
        Bike1.Checked:=SameText(tmp,'TRUE');
        Bike1Click(Self);
      end;
    end;

  finally
    R.Free;
  end;
end;

procedure TMainForm.N1001Click(Sender: TObject);
begin
  RealTimeFactor:=1/StrToInt(StripHotkey((Sender as TMenuItem).Caption));
end;

procedure TMainForm.Clear1Click(Sender: TObject);
begin
  ApplyTheme(clWhite,clBlack);
  SaveRegistry('View','Theme','Light');
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

  {$IFDEF TEEPRO}
  TeeCommander1:=TTeeCommander.Create(Self);
  TeeCommander1.Parent:=TabAllLaps;
  TeeCommander1.Panel:=AllLaps;
  {$ENDIF}
end;

function HTMLColor(const S:String):TColor;
begin
  if S='' then
     result:=clWhite
  else
     result:=RGB(
            StrToInt('$'+Copy(S,2,2)),
            StrToInt('$'+Copy(S,4,2)),
            StrToInt('$'+Copy(S,6,2))
            );
end;

procedure TMainForm.PaintPoleDelta(const Sender:TColumn; var AData:TRenderData; var DefaultPaint:Boolean);
begin
  DefaultPaint:=True;
end;

procedure TMainForm.PilotsCellEditing(const Sender: TObject;
  const AEditor: TControl; const AColumn: TColumn; const ARow: Integer);
begin
  if AEditor is TComboBox then
     if AColumn=Pilots.Columns['Bike'] then
        FillCombo(TComboBox(AEditor),BikeData,0,PilotsData[Pilots_Bike,ARow]);
end;

procedure TMainForm.CreatePole;

  procedure InitPoleGrid;
  var t : Integer;
      tmp : Integer;
  begin
    for t:=0 to Pole.Count-1 do
    begin
      Pole[Pole_Index,t]:=(t+1).ToString;

      Pole[Pole_Delta,t]:='';

      tmp:=Race.PoleIndex[t];

      Pole[Pole_Num,t]:=PilotsData[1,tmp];
      Pole[Pole_Name,t]:=PilotsData[0,tmp];
      Pole[Pole_Current,t]:='0:0.0'; // Current lap time
      Pole[Pole_Last,t]:='0:0.0';// Last lap time
      Pole[Pole_Best,t]:='0:0.0'; // Best lap time
      Pole[Pole_BestLap,t]:='0'; // Lap with best time
    end;

    PoleGrid.Data:=Pole;

    if PoleGrid.Selected.Row>Pole.Count then
       PoleGrid.Selected.Row:=Pole.Count-1;

    PoleGrid.Columns[Pole_Index].Header.Text:='#';

    PoleGrid.Columns[Pole_Delta].OnPaint:=PaintPoleDelta;

    PoleGrid.Columns[Pole_Num].Header.Text:='Num';
    PoleGrid.Columns[Pole_Name].Header.Text:='Name';
    PoleGrid.Columns[Pole_Current].Header.Text:='Current'; // Current lap time
    PoleGrid.Columns[Pole_Last].Header.Text:='Last'; // Last lap time
    PoleGrid.Columns[Pole_Best].Header.Text:='Best'; // Best lap time
    PoleGrid.Columns[Pole_BestLap].Header.Text:='Num'; // Lap with best time

    PoleGrid.Columns[Pole_Num].Width.Value:=54;
    PoleGrid.Columns[Pole_Name].Width.Value:=60;
    PoleGrid.Columns[Pole_Current].Width.Value:=90;
    PoleGrid.Columns[Pole_Last].Width.Value:=90;
    PoleGrid.Columns[Pole_Best].Width.Value:=90;
  end;

  procedure InitRaceRiders;
  var t : Integer;
  begin
    SetLength(Race.Riders,Pole.Count);

    for t:=0 to High(Race.Riders) do
    begin
      Race.Riders[t].Active:=True; // In Starting Grid
      Race.Riders[t].Number:=PilotsData[1,t].ToInteger;

      if PilotsData.Columns>4 then
         Race.Riders[t].Color:=HTMLColor(PilotsData[4,t]);

      Race.Riders[t].StartPole:=FindRiderInPole(Race.Riders[t].Number);
    end;
  end;

var t,
    RiderQuantity : Integer;
begin
  Pole.Free;

  if PilotsData=nil then
     Exit;

  if HasParameter('SINGLERIDER') then
  begin
    RiderQuantity:=1;
    UDPoleRiders.Position:=1;
  end
  else
     RiderQuantity:=Min(UDPoleRiders.Position,PilotsData.Rows);

  Pole:=TStringsData.Create(1+Pole_BestLap,RiderQuantity);

  SetLength(Race.PoleIndex,RiderQuantity);

  for t:=0 to RiderQuantity-1 do
      Race.PoleIndex[t]:=t;

  Race.ShufflePole(RiderQuantity);

  Race.StartPoleIndex:=DuplicateArray(Race.PoleIndex);

  InitPoleGrid;

  SetupPilotGrid(PoleGrid,Pole_Num,Pole_Num);

  Race.Weather:=DefaultWeather;

  InitRaceRiders;

  FillItems(CBRiderA.Items,PilotsData,0);
  FillItems(CBRiderB.Items,PilotsData,0);

  Race.Init;

  PoleGridSelect(Self);
end;

procedure TMainForm.CursorLapDragLine(Sender: TColorLineTool);
begin
  TelemetryStep.Invalidate;
end;

function TMainForm.FindPilotNum(const ANum:String):Integer; // index inside PilotsData
begin
  result:=PilotsData.IndexOf(ANum,1);
end;

// Cell colors from pilor color
procedure TMainForm.SetupPilotGrid(const AGrid:TTeeGrid; const AColorColumn,ANumColumn:Integer);
var tmp,t : Integer;
    f : Tee.Format.TTextFormat;
begin
  for t:=0 to AGrid.Data.Count-1 do
  begin
    if ANumColumn=-1 then
       tmp:=t
    else
       tmp:=FindPilotNum(AGrid.Data.AsString(AGrid.Columns[ANumColumn],t));

    if tmp=-1 then
       AGrid.CellFormat.Cell[t,AColorColumn].Format:=nil
    else
    begin
      f:=AGrid.CellFormat.Cell[t,AColorColumn].Format;

      if PilotsData.Columns>4 then
         f.Brush.Color:=HTMLColor(PilotsData[4,tmp])
      else
         f.Brush.Color:=clWhite;

      f.Brush.Show;

      f.Font.Color:=CalcFontColor(f.Brush.Color);

      f.Font.Name:=AGrid.Cells.Format.Font.Name;
      f.Font.Size:=AGrid.Cells.Format.Font.Size;

      f.Font.Style:=[];
    end;
  end;
end;

procedure TMainForm.SiteWeatherAfterDraw(Sender: TObject);

  function WeatherStyleToString(const AStyle:TWeatherStyle):String;
  begin
    case AStyle of
      wsDry: result:='Dry';
      wsWet: result:='Wet';
     wsRain: result:='Rain';
    end;
  end;

var C : TCanvas3D;
begin
  C:=SiteWeather.Canvas;

  C.Font.Color:=clNavy;
  C.TextAlign:=TA_LEFT;

  C.TextOut(15,10,'Temp: '+Race.Weather.AirTemperature.ToString+'°C');
  C.TextOut(185,10,'Track: '+Race.Weather.TrackTemperature.ToString+'°C');
  C.TextOut(15,32,WeatherStyleToString(Race.Weather.Style));
  C.TextOut(15,54,'Humidity: '+Race.Weather.Humidity.ToString+'%');

  C.TextOut(215,44,'Record: '+CircuitsData[12,Circuits.Selected.Row]+' '+CircuitsData[13,Circuits.Selected.Row]);
  C.TextOut(215,66,CircuitsData[14,Circuits.Selected.Row]);

  C.TextOut(15,76,'Air Density: '+FormatFloat('0.000',Race.Weather.AirDensity)+' kg/m³');
  C.TextOut(15,98,'Wind: '+FormatFloat('0.000',Race.Weather.Wind)+' km/h');
  C.TextOut(215,98,FormatFloat('0.000',Race.Weather.WindDirection)+' °');

  C.TextOut(15,120,'Elevation: '+Race.Circuit.Elevation.ToString+' m');
  C.TextOut(185,120,'Length: '+Race.Circuit.TotalLength.ToString+' m');
end;

procedure TMainForm.TrySetGISBounds;
var tmp : TArray<String>;
    Old : Char;
    S : String;
begin
  Exit; // !! Conflict between track axes bounds, and real GIS bounds

  if GIS<>nil then
  begin
    S:=(CircuitsData[8,Circuits.Selected.Row]);
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

function TMainForm.CategoryPath:String;
begin
  result:=FindDataPath+'\Category\'+CBCategory.Text;
end;

function TMainForm.Season:String;
begin
  result:=CBSeasons.Text;
end;

function TMainForm.CategorySeason:String;
begin
  result:=CategoryPath+'\Seasons\'+Season;
end;

procedure TMainForm.FillCategories;
begin
  FillFolders(FindDataPath+'\Category',CBCategory.Items);
end;

procedure TMainForm.FillSeasons;
begin
  FillFolders(CategoryPath+'\Seasons',CBSeasons.Items);
end;

// Check AllPilots Code field is not duplicated, and has 3 or 4 characters
procedure TMainForm.VerifyAllPilots;

  function Duplicated(const AtUntil:Integer; const S:String):Boolean;
  var t : Integer;
  begin
    for t:=0 to AtUntil do
        if SameText(S,AllPilots[0,t]) then
        begin
          result:=True;
          Exit;
        end;

    result:=False;
  end;

var t : Integer;
    s : String;
begin
  for t:=0 to AllPilots.Count-1 do
  begin
    s:=AllPilots[0,t];

    if Length(s)<3 then
       raise Exception.Create('Error: Pilot code is less than 3 characters: '+s);

    if Length(s)>4 then
       raise Exception.Create('Error: Pilot code is more than 4 characters: '+s);

    if Duplicated(t-1,s) then
       raise Exception.Create('Error: Pilot code is duplicated: '+s);
  end;
end;

procedure TMainForm.PaintFastest(const Sender:TColumn; var AData:TRenderData; var DefaultPaint:Boolean);
begin
  if Race.Fastest=Race.PoleIndex[AData.Row] then
     AData.Painter.Fill(AData.Bounds,clRed);

  DefaultPaint:=True;
end;

procedure TMainForm.DoPaintFlag(const ID:String; var AData: TRenderData);
var tmpFlag : TGraphic;
    tmp : TPicture;
    X : Single;
begin
  tmpFlag:=GetCountryFlag(ID);

  tmp:=TVCLPicture.From(tmpFlag);
  try
    X:=AData.Bounds.Left+(AData.Bounds.Width-tmpFlag.Width)*0.5;

    AData.Painter.Draw(tmp,X,AData.Bounds.Top+6);
  finally
    tmp.Free;
  end;
end;

procedure TMainForm.PaintFlag(const Sender: TColumn; var AData: TRenderData;
  var DefaultPaint: Boolean);
begin
  DoPaintFlag((Sender.TagObject as TStringsData)[Sender.Tag,AData.Row],AData);
  DefaultPaint:=False;
end;

procedure TMainForm.AddFlags(const AGrid:TTeeGrid; const ACountry:Integer; const AStrings:TStringsData);
var C : TColumn;
begin
  C:=AGrid.Columns.Add;
  C.Header.Text:='Flag';
  C.Width.Value:=60;
  C.Tag:=ACountry;
  C.TagObject:=AStrings;
  C.OnPaint:=PaintFlag;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  LapChart.Axes.FastCalc:=True;
  AllLaps.Axes.FastCalc:=True;

  PoleGrid.ParentFont:=True;
  Pilots.ParentFont:=True;
  Circuits.ParentFont:=True;
  ChampionGrid.ParentFont:=True;
  BikeGrid.ParentFont:=True;
  TiresGrid.ParentFont:=True;
  AllPilotsGrid.ParentFont:=True;
  CurvesGrid.ParentFont:=True;
  LeaderBoard.ParentFont:=True;
  ResultsGrid.ParentFont:=True;

  {$IFNDEF USE_SKIA}
  Skia1.Enabled:=False;
  {$ENDIF}

  AllPilots:=TCSVDataImport.FromFile(FindDataPath+'\'+All_Pilots_File);
  VerifyAllPilots;

  AllPilotsGrid.Data:=AllPilots;
  AddFlags(AllPilotsGrid,4,AllPilots);

  SensorsData:=TCSVDataImport.FromFile(FindDataPath+'\Sensors.txt');
  Sensors.Data:=SensorsData;

  Torque:=TFormTorqueCurve.Create(Self);
  Torque.Align:=alClient;
  TTeeVCL.AddFormTo(Torque,PanelBikeParams);

  TiresGrid.Data:=TCSVDataImport.FromFile(FindDataPath+'\'+All_Tires_File);

  BikeData:=TCSVDataImport.FromFile(FindDataPath+'\'+All_Bikes_File);
  BikeGrid.Data:=BikeData;
  BikeGrid.Columns['GearsRatio'].Hide;
  BikeGrid.Columns['TorqueCurve'].Hide;

  FillItems(CBSelectedBike.Items,BikeData,0);
  CBSelectedBike.ItemIndex:=0;

  CircuitPath:=TFastLineSeries.Create(Self);
  CircuitPath.ParentChart:=Circuit;
  CircuitPath.TreatNulls:=tnIgnore;
  CircuitPath.DrawStyle:=flAll;
  CircuitPath.Color:=RGB(130,0,0);
  CircuitPath.Pen.Width:=3;

  CircuitsData:=TCSVDataImport.FromFile(FindDataPath+'\Circuits\Circuits.txt');
  Circuits.Data:=CircuitsData;

  AddFlags(Circuits,2,CircuitsData);

//  AddFlags(Pilots,4,PilotsData);

  FillCategories;

  CBCategory.ItemIndex:=CBCategory.Items.IndexOf('MotoGP');
  CBCategoryChange(Self);

   // Start at Montmeló, Barcelona, Catalunya
  CBRounds.ItemIndex:=5;
  CBRoundsChange(Self);

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

  PoleGrid.Selected.FullRow:=True;

  PoleGrid.Columns['#'].OnPaint:=PaintFastest;

  PageControl1.ActivePage:=TabTelemetry;

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
  RearBike.LoadFromFile(FindDataPath+'\Images\rear_bike_small.png');

  PageControl2.ActivePage:=TabCircuits;
  PageControl1.ActivePage:=TabTelemetry;
  PageControl4.ActivePage:=TabFrontView;
  PageControl3.ActivePage:=TabRace;
  PageControlTelemetry.ActivePage:=TabSingleLap;

  LoadConfiguration;

  if HasParameter('TELEMETRYONLY') then
  begin
    Circuit1Click(Self);
    Pole1Click(Self);
    Dashboard1Click(Self);

    FrontView.Hide;
  end;
end;

procedure TMainForm.DrawTireIcon(const ACanvas:TCanvas; const AColumn:Integer);

  function TireLetter(const S:String):String;
  begin
    if S='' then
       result:='S'
    else
    begin
      // TODO: Link with TiresGrid to return info
      result:='M';
    end;
  end;

var tmp : Integer;
    tmpTire : String;
begin
  tmp:=PoleGrid.Selected.Row;

  if tmp<>-1 then
  begin
    tmpTire:=PilotsData[AColumn,FindPilotNum(Pole[Pole_Num,tmp])];

    ACanvas.Pen.Width:=3;
    ACanvas.Ellipse(2,2,30,30);
    ACanvas.Brush.Style:=bsClear;
    ACanvas.Font.Style:=[fsBold];
//    ACanvas.TextFlags:=TA_CENTER;
    ACanvas.TextOut(9,4,TireLetter(tmpTire));
  end;
end;

procedure TMainForm.FrontTirePaint(Sender: TObject);
begin
  DrawTireIcon(FrontTire.Canvas,6);
end;

procedure TMainForm.FrontViewAfterDraw(Sender: TObject);
var HTop : Integer;

    TopLeft,
    BottomLeft,
    TopRight,
    BottomRight : Integer;

  procedure DrawTrack;
  var C : TTeeCanvas;
      W, H : Integer;
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

    BottomLeft:=W div 20;
    BottomRight:=W-BottomLeft;

    TopLeft:=W div 3;
    TopRight:=W-TopLeft;

    C.Polygon([Point(BottomLeft,H),Point(TopLeft,HTop),Point(TopRight,HTop),Point(BottomRight,H)]);
  end;

  procedure DrawKerbs(const APos:Single);
  const F=500;
        H=10;

  var C : TTeeCanvas;
      t,
      X, Y : Integer;
      tmp : Single;
  begin
    C:=FrontView.Canvas;

    C.Pen.Style:=psSolid;
    C.Pen.Width:=3;

    C.Brush.Color:=RGB(130,20,10);
    C.Brush.Style:=bsSolid;
    C.Gradient.Visible:=False;

    for t:=1 to 19 do
    begin
      if C.Pen.Color=clSilver then
         C.Pen.Color:=RGB(138,0,0)
      else
         C.Pen.Color:=clSilver;

      tmp:=Power(t/19,2);

      X:=TopLeft+Round(tmp*(BottomLeft-TopLeft));

      Y:=HTop-50+(Round(APos) mod 50)+Round(tmp*(FrontView.Height-HTop));

      if Y>HTop then
      begin
        C.Line(X-3,Y,X-10-t,Y);

        X:=TopRight+Round(tmp*(BottomRight-TopRight));

        C.Line(X+3,Y,X+10+t,Y);
      end;
    end;
  end;

var L,
    tmp,
    tmpX,
    tmpY : Integer;
    R : TRect;
begin
  tmp:=PoleGrid.Selected.Row;

  L:=High(Race.Data);

  HTop:=FrontView.Height div 4;

  if rack1.Checked then
  begin
    DrawTrack;

    if (tmp=-1) or (L=-1) then
       DrawKerbs(Race.Circuit.PolePosition)
    else
       DrawKerbs(Race.Data[L].Data[tmp].Position);
  end;

  if tmp<>-1 then
  begin
    if Length(Race.PoleIndex)>1 then
       tmp:=Race.PoleIndex[tmp];

    DrawPilotNumber(FrontView.Canvas,True,Point(20,20),14,Race.Riders[tmp].Color, IntToStr(Race.Riders[tmp].Number));

    if Bike1.Checked then
    begin
      tmpX:=FrontView.Width div 2;
      tmpY:=FrontView.Height-20;

      R:=Rect(tmpX-(RearBike.Width div 2), tmpY-RearBike.Height,
              tmpX+(RearBike.Width div 2), tmpY);

      if Lean1.Checked then
         FrontView.Canvas.StretchRotate(R,RearBike,TBLean.Position)
      else
      if L<>-1 then
         FrontView.Canvas.StretchRotate(R,RearBike,Race.Data[L].Data[tmp].LeanAngle);
    end;
  end;
end;

procedure TMainForm.SetTeeCanvas(const AClass:TTeeCanvasClass);
begin
  CircuitPath.Free;
  CircuitPath:=nil;

  LapChart.Canvas:=AClass.Create;
  Circuit.Canvas:=AClass.Create;
  AllLaps.Canvas:=AClass.Create;
  PoleChart.Canvas:=AClass.Create;
  Semaphor.Canvas:=AClass.Create;
  FrontView.Canvas:=AClass.Create;
  Dashboard.Canvas:=AClass.Create;
end;

procedure TMainForm.Skia1Click(Sender: TObject);
begin
  {$IFDEF USE_SKIA}
  SetTeeCanvas(TTeeSkiaCanvas);
  {$ENDIF}
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  TFormCircuit.ShowCircuit(Race.Circuit);
end;

procedure TMainForm.GDI1Click(Sender: TObject);
begin
  SetTeeCanvas(TGDIPlusCanvas);
end;

procedure TMainForm.OpenGL1Click(Sender: TObject);
begin
  SetTeeCanvas(TGLCanvas);
end;

procedure TMainForm.CreateLeaderBoard;
var Points : Array of Integer;
    Leaders : TStringsData;

   procedure IncWins(const AWinsColumn,ARow:Integer);
   begin
     if Leaders[AWinsColumn,ARow]='' then
        Leaders[AWinsColumn,ARow]:='1'
     else
        Leaders[AWinsColumn,ARow]:=IntToStr(1+StrToInt(Leaders[AWinsColumn,ARow]));
   end;

   procedure AddPoints(const AWinsColumn:Integer; const S:String; const APoints:Array of Integer);
   var P : Array of String;
       t, tmp : Integer;
   begin
     P:=S.Split(['|']);

     for t:=0 to High(P) do
     begin
       if P[t]='-' then  // <-- Signals not classified rider after the "-"
          break;

       tmp:=FindPilotNum(P[t]);

       if tmp=-1 then
          raise Exception.Create('Error Pilot not found: '+P[t]);

       if t<Length(APoints) then
          Inc(Points[tmp],APoints[t]);

       if t=0 then // Winner
       begin
         IncWins(AWinsColumn,tmp);
         IncWins(9,tmp); // Total
       end;

       if t<3 then // Podium 0,1,2
          IncWins(10,tmp);
     end;
   end;

var t, tmpRider : Integer;
begin
  Leaders:=TStringsData.Create(11,PilotsData.Count);

  SetLength(Points,PilotsData.Count);

  FillSequential(Leaders,0);

  for t:=0 to High(Points) do
  begin
    Leaders[1,t]:=PilotsData[1,t];

    tmpRider:=FindInAllPilots(PilotsData[0,t]);
    Leaders[2,t]:=AllPilots[1,tmpRider]+' '+AllPilots[2,tmpRider];

    Leaders[4,t]:=PilotsData[2,t];
  end;

  if RoundsData<>nil then
  for t:=0 to RoundsData.Count-1 do
  begin
    AddPoints(7,RoundsData[5,t],SprintPoints);
    AddPoints(8,RoundsData[6,t],RacePoints);
  end;

  for t:=0 to High(Points) do
  begin
    Leaders[5,t]:=IntToStr(Points[t]);

    if t>0 then
       Leaders[6,t]:=IntToStr(Points[t]-Points[0]);
  end;

  LeaderBoard.Data:=Leaders;

  LeaderBoard.Columns[0].Header.Text:='#';
  LeaderBoard.Columns[1].Header.Text:='Number';
  LeaderBoard.Columns[2].Header.Text:='Name';
  LeaderBoard.Columns[3].Header.Text:='Flag';
  LeaderBoard.Columns[4].Header.Text:='Team';
  LeaderBoard.Columns[5].Header.Text:='Points';
  LeaderBoard.Columns[6].Header.Text:='Delta';
  LeaderBoard.Columns[7].Header.Text:='Sprint Wins';
  LeaderBoard.Columns[8].Header.Text:='Race Wins';
  LeaderBoard.Columns[9].Header.Text:='Total Wins';
  LeaderBoard.Columns[10].Header.Text:='Podiums';

  Leaders.SortBy(LeaderBoard.Columns[5],False,True);

  FillSequential(Leaders,0);

  SetupPilotGrid(LeaderBoard,1,1);
end;

procedure TMainForm.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=TabData then
  begin
    if DataGrid.Data=nil then
       DataGrid.Data:=TVirtualArrayData<TRaceData>.Create(Race.Data);
  end
  else
  if PageControl1.ActivePage=TabTelemetry then
     PageControlTelemetryChange(Self)
  else
  if PageControl1.ActivePage=TabChampionShip then
     if LeaderBoard.Data=nil then
        CreateLeaderBoard;
end;

procedure TMainForm.CreateLeaderChart;

  function FindItem(const S:String; const AItems:TArray<String>):Integer;
  var t : Integer;
  begin
    for t:=0 to High(AItems) do
        if AItems[t]=S then
        begin
          result:=t;
          Exit;
        end;

    result:=-1;
  end;

  function CalcPoints(const ARiderNum:String; const ARound:Integer):Integer;

    function Calc(const AColumn:Integer; const APoints:TArray<Integer>):Integer;
    var tmp : Integer;
    begin
      tmp:=FindItem(ARiderNum,RoundsData[AColumn,ARound].Split(['|']));

      if (tmp>-1) and (tmp<Length(APoints)) then
         result:=APoints[tmp]
      else
         result:=0;
    end;

  begin
    result:=Calc(5,SprintPoints)+Calc(6,RacePoints);
  end;

const
  MaxRiders=5;

var t,tt : Integer;
    S : TLineSeries;
    Total, RoundTotal : Integer;
    NumRider : String;
begin
  LeaderChart.FreeAllSeries;

  LeaderChart.Title.Caption:=CBCategory.Text+' '+CBSeasons.Text;
  LeaderChart.Title.Font.Size:=18;

  for t:=0 to MaxRiders-1 do
  begin
    S:=TLineSeries.Create(Self);
    S.ParentChart:=LeaderChart;

    NumRider:=LeaderBoard.Data.AsString(LeaderBoard.Columns[1],t);

    S.Title:=NumRider+' '+LeaderBoard.Data.AsString(LeaderBoard.Columns[2],t);
    S.Pointer.Visible:=True;

//    S.Color:=

    Total:=0;

    for tt:=0 to RoundsData.Count-1 do
    begin
      if RoundsData[5,tt]<>'' then
      begin
        RoundTotal:=CalcPoints(NumRider,tt);

        Inc(Total,RoundTotal);

        S.Add(Total,RoundsData[0,tt]+#13#10+RoundsData[7,tt]);
      end;
    end;
  end;
end;

procedure TMainForm.PageControl7Change(Sender: TObject);
begin
  if PageControl7.ActivePage=TabLeaderChart then
     CreateLeaderChart;
end;

procedure TMainForm.PageControlTelemetryChange(Sender: TObject);
begin
  if PageControlTelemetry.ActivePage=TabSingleLap then
  begin
    if SeriesSpeed.Count<2 then
       RefillCharts;
  end
  else
  if PageControlTelemetry.ActivePage=TabCompare then
       RefillCompareChart;
end;

procedure TMainForm.Pole1Click(Sender: TObject);
begin
  PanelPole.Visible:=not PanelPole.Visible;
  Pole1.Checked:=PanelPole.Visible;

  SplitterPole.Visible:=PanelPole.Visible;

  if PanelPole.Visible then
     SplitterPole.Left:=PanelPole.Left-5;
end;

// Draw the Pole Starting Grid
procedure TMainForm.PoleChartAfterDraw(Sender: TObject);
var XS,YS : Integer;
    C : TTeeCanvas;

  procedure DrawAt(X,Y:Integer; const Pilot:Integer);
  var tmp : TRider;
      tmpIndex : Integer;
  begin
    C.Line(X,Y+10,X,Y);
    C.LineTo(X+XS,Y);
    C.LineTo(X+XS,Y+10);

    if Length(Race.StartPoleIndex)>1 then
       tmpIndex:=Race.StartPoleIndex[Pilot]
    else
       tmpIndex:=Pilot;

    tmp:=Race.Riders[tmpIndex];

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

  for Row:=0 to ((Pole.Rows-1) div 3) do
  begin
    tmp:=3*Row;

    if tmp<Pole.Rows then
       DrawAt(X,Y+Row*YS,tmp);

    tmp:=1+3*Row;

    if tmp<Pole.Rows then
       DrawAt(X+(XS+XSep),Y+Row*YS+15,tmp);

    tmp:=2+3*Row;

    if tmp<Pole.Rows then
       DrawAt(X+2*(XS+XSep),Y+Row*YS+30,tmp);
  end;
end;

procedure TMainForm.ClearLapCharts;
begin
  SeriesSpeed.Clear;
  SeriesAcceleration.Clear;
  SeriesGear.Clear;
  SeriesThrottle.Clear;
  SeriesFrontBrake.Clear;
  SeriesBackBrake.Clear;
end;

procedure TMainForm.RefillCharts;

  function NewFastLine(const ATitle:String):TFastLineSeries;
  begin
    result:=TFastLineSeries.Create(Self);
    result.ParentChart:=LapChart;
    result.Title:=ATitle;

    result.TreatNulls:=tnIgnore;  // speed opt

    //result.DrawAllPoints:=False; // anti-alias?

    result.DrawStyle:=flAll;

    //result.FastPen:=True;
  end;

  procedure CreateSeries;
  begin
    SeriesSpeed:=NewFastLine('Speed m/s');
    SeriesAcceleration:=NewFastLine('Acceleration m/s²');
    SeriesRPM:=NewFastLine('RPM');
    SeriesGear:=NewFastLine('Gear');
    SeriesThrottle:=NewFastLine('Throttle %');
    SeriesFrontBrake:=NewFastLine('Front Brake');
    SeriesBackBrake:=NewFastLine('Back Brake');

    SeriesGear.Stairs:=True;
    SeriesThrottle.Stairs:=True;
    SeriesFrontBrake.Stairs:=True;
    SeriesBackBrake.Stairs:=True;

    SeriesThrottle.CustomVertAxis:=LapChart.CustomAxes[1];

    LapChart.CustomAxes[1].MaximumOffset:=3;

    SeriesFrontBrake.CustomVertAxis:=LapChart.CustomAxes[2];
    SeriesBackBrake.CustomVertAxis:=LapChart.CustomAxes[2];

    LapChart.Axes.Left.Title.Caption:='Speed m/s';

    LapChart.CustomAxes[1].Title.Caption:='Throttle';
    LapChart.CustomAxes[2].Title.Caption:='Brakes';

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
    StartOfLap,
    EndOfLap,

    tmpRider,
    tmpLap,
    t : Integer;
begin
  if SeriesSpeed=nil then
  begin
    CreateSeries;
    AddSeriesList;
  end;

  if PoleGrid.Selected.Row>-1 then
  begin
    Rider:=PoleGrid.Selected.Row;

    // Find in All Pilots to obtain name
    tmpRider:=FindInAllPilots(Pole[Pole_Name,Rider]);

    LapChart.Title.Caption:=Pole[Pole_Num,Rider]+' '+Pole[Pole_Name,Rider]+' '+AllPilots[1,tmpRider]+' '+AllPilots[2,tmpRider];
    LapChart.Title.Font.Size:=14;

    // Now in Pole
    tmpRider:=Race.PoleIndex[Rider];

    if Length(Race.Riders)>tmpRider then
    begin
      TotalCircuitLength(SeriesSpeed.GetHorizAxis);

      SeriesThrottle.GetVertAxis.SetMinMax(0,100);
      SeriesFrontBrake.GetVertAxis.SetMinMax(0,100);

      SeriesSpeed.BeginUpdate;
      SeriesAcceleration.BeginUpdate;
      SeriesGear.BeginUpdate;
      SeriesThrottle.BeginUpdate;
      SeriesFrontBrake.BeginUpdate;
      SeriesBackBrake.BeginUpdate;

      ClearLapCharts;

      if CBViewLastLap.Checked then
         if Race.Riders[tmpRider].Laps=0 then
            tmpLap:=0
         else
            tmpLap:=Race.Riders[tmpRider].Laps-1
      else
         tmpLap:=UDViewLap.Position-1;

      Race.Riders[tmpRider].GetLapStartEnd(tmpLap,StartOfLap,EndOfLap);

      if CBViewLastLap.Checked then
         EndOfLap:=High(Race.Data);

      for t:=StartOfLap to EndOfLap do
          AddRiderData(t,tmpRider);

      SeriesBackBrake.EndUpdate;
      SeriesFrontBrake.EndUpdate;
      SeriesThrottle.EndUpdate;
      SeriesGear.EndUpdate;
      SeriesAcceleration.EndUpdate;
      SeriesSpeed.EndUpdate;
    end;
  end;
end;

// TODO: Speed opt.
// Set XValues.Value and YValues.Value arrays directly, instead of calling
// AddXY
procedure TMainForm.AddRiderData(const APos:Integer; const Rider:Integer);
var X : Single;

  procedure CheckNew(const ASeries:TChartSeries; const ANew:Single);
  begin
    if (ASeries.Count<2) or (ANew<>ASeries.YValues.Last) then
       ASeries.AddXY(X,ANew)
    else
       ASeries.XValues.Value[ASeries.Count-1]:=X;
  end;

var tmp : ^TRiderData;
begin
  tmp:=@Race.Data[APos].Data[Rider];

  X:=tmp.Position;

  SeriesSpeed.AddXY(X,tmp.Speed);
  SeriesAcceleration.AddXY(X,tmp.Acceleration);

  // SeriesRPM.AddXY(X,tmp.RPM);

  CheckNew(SeriesGear,tmp.Gear);
  CheckNew(SeriesThrottle,tmp.Throttle);

  CheckNew(SeriesFrontBrake,tmp.FrontBrake);
  CheckNew(SeriesBackBrake,tmp.BackBrake);
end;

procedure TMainForm.UpdateLapCharts;
begin
  if PoleGrid.Selected.Row>-1 then
     AddRiderData(High(Race.Data),Race.PoleIndex[PoleGrid.Selected.Row]);
end;

procedure TMainForm.UpdateCursorLap(var AData:TAllRidersData);
begin
  if PoleGrid.Selected.Row=-1 then
     CursorLap.Value:=0
  else
     CursorLap.Value:=AData[Race.PoleIndex[PoleGrid.Selected.Row]].Position;  // Move chart cursor to position of first rider
end;

procedure TMainForm.PoleGridSelect(Sender: TObject);

  procedure FillLapTimes(const ARider:Integer);
  var t, L : Integer;
      tmpTime : Int64;
  begin
    if ARider<Length(Race.Riders) then
    begin
      L:=Length(Race.Riders[ARider].Ellapsed);

      FillSequential(LapsTimeData,0);

      for t:=0 to LapsTimeData.Rows-1 do
      begin
        if t<L then
           tmpTime:=Race.Riders[ARider].Ellapsed[t]
        else
           tmpTime:=0;

        if tmpTime=0 then
           LapsTimeData[1,t]:=''
        else
           LapsTimeData[1,t]:=IntToTime(tmpTime);
      end;
    end;
  end;

var tmp : Integer;
    tmpBike : String;
begin
  if SwappingRider then
     Exit;

  RefillCharts;

  tmp:=PoleGrid.Selected.Row;

  if tmp=-1 then
  begin
    FrontView.Title.Caption:='';

    TabLapTimes.TabVisible:=False;
    LapTimesGrid.Data:=nil;

    CBSelectedBike.ItemIndex:=0;
  end
  else
  begin
    FrontView.Title.Caption:=Pole[Pole_Num,tmp]+' '+Pole[Pole_Name,tmp];

    TabLapTimes.TabVisible:=True;

    LapsTimeData:=TStringsData.Create(2,Race.TotalLaps);
    LapTimesGrid.Data:=LapsTimeData;

    LapTimesGrid.Columns[0].Header.Text:='Lap';
    LapTimesGrid.Columns[1].Header.Text:='Time';

    tmpBike:=PilotsData[5,FindPilotNum(Pole[Pole_Num,tmp])];

    CBSelectedBike.ItemIndex:=CBSelectedBike.Items.IndexOf(tmpBike);

    FillLapTimes(Race.PoleIndex[tmp]);
  end;

  if Length(Race.Data)=0 then
     CursorLap.Value:=0
  else
     UpdateCursorLap(Race.Data[High(Race.Data)].Data);

  if TireStatus.Data=nil then
  begin
    TiresData:=TStringsData.Create(5,2);

    TiresData[0,0]:='Front';
    TiresData[0,1]:='Back';

//    TiresData[1,0]:=
//    TiresData[1,1]:=

    TireStatus.Data:=TiresData;

    TireStatus.Columns[0].Header.Text:='Tire';
    TireStatus.Columns[1].Header.Text:='Model';
    TireStatus.Columns[2].Header.Text:='Grip %';
    TireStatus.Columns[3].Header.Text:='Pressure';
    TireStatus.Columns[4].Header.Text:='Temperature';
  end;

  FrontTire.Invalidate;
  BackTire.Invalidate;

  FrontView.Invalidate;
end;

procedure TMainForm.rack1Click(Sender: TObject);
begin
  rack1.Checked:=not rack1.Checked;
  FrontView.Visible:=Rack1.Checked or Bike1.Checked;

  SaveRegistry('View','Track',BoolToStr(rack1.Checked,True));

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

function TMainForm.FindRiderInPole(const ANumber:Integer):Integer;
begin
  result:=Pole.IndexOf(IntToStr(ANumber),Pole_Num);
end;

procedure TMainForm.LapChartAfterDraw(Sender: TObject);
begin
  LapChart.Canvas.TextOut(10,10,Round(CursorLap.Value).ToString+' m');
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
    Pole[Pole_Current,t]:='0:0.0'; // Current lap time
    Pole[Pole_Last,t]:='0:0.0'; // Last lap time
    Pole[Pole_Best,t]:='0:0.0'; // Best lap time
    Pole[Pole_BestLap,t]:='0'; // Lap with best time
  end;
end;

procedure TMainForm.SetCurrentLap(const ACurrent:Integer);
begin
  CurrentLap.Caption:=IntToStr(ACurrent)+' of '+IntToStr(Race.TotalLaps);

  if CBViewLastLap.Checked then
     UDViewLap.Position:=Race.Current;
end;

function TMainForm.FindBike(const ABike:String):TBike;
var t : Integer;

   function AsSingle(const ACol:Integer):Single;
   begin
     result:=StrToFloat(BikeData[ACol,t]);
   end;

   function AsInteger(const ACol:Integer):Integer;
   begin
     result:=StrToInt(BikeData[ACol,t]);
   end;

   // Format, one pair of RPM and Nm newtons at that RPM:
   // 4500:70|9000:95|13000:118|15500:126|18500:105
   function ParseTorqueCurve(ACurve:String):TTorqueCurve;

     procedure AddPair(S:String);
     var i, L : Integer;
     begin
       i:=Pos(':',S);

       L:=Length(result);
       SetLength(result,L+1);

       result[L].RPM:=StrToInt(Copy(S,1,i-1));
       result[L].Nm:=StrToFloat(Copy(S,i+1,Length(S)));
     end;

   var i : Integer;
   begin
     result:=nil;

     repeat
        i:=Pos('|',ACurve);

        if i>0 then
        begin
          AddPair(Copy(ACurve,1,i-1));
          Delete(ACurve,1,i);
        end;

     until i=0;

     if ACurve<>'' then
        AddPair(ACurve);
   end;

   // Format, one value for each Gear:
   // 2.400|1.820|1.470|1.250|1.100|1.000
   function ParseGearRatios(ARatios:String):TGearRatios;
   var L : Integer;

     procedure AddGear(const S:String);
     begin
       SetLength(result,L+1);
       result[L]:=StrToFloat(S);
       Inc(L);
     end;

   var i : Integer;
   begin
     result:=nil;
     L:=0;

     repeat
        i:=Pos('|',ARatios);

        if i>0 then
        begin
          AddGear(Copy(ARatios,1,i-1));
          Delete(ARatios,1,i);
        end;

     until i=0;

     if ARatios<>'' then
        AddGear(ARatios);
   end;

var Old : Char;
begin
  for t:=0 to BikeData.Count-1 do
      if BikeData[0,t]=ABike then
      begin
        Old:=FormatSettings.DecimalSeparator;

        FormatSettings.DecimalSeparator:='.';
        try
          result.GearRatios:=ParseGearRatios(BikeData[23,t]);
          result.Torque:=ParseTorqueCurve(BikeData[24,t]);

          // Pneumatics
          result.Front.Tire.Grip:=1.7;
          result.Front.Tire.Diameter:=60; // cm
          result.Front.Tire.Friction:=0.02; // coefficient

          result.Back.Tire.Grip:=1.7;
          result.Back.Tire.Diameter:=69; // cm
          result.Back.Tire.Friction:=0.02; // coefficient

          result.CdAeroDynamic:=0.45; // 0.3 .. 0.7 coefficient

          //    CenterOfMassHeight : Integer; // mm distance from track to center of gravity
          //    WheelieWingEfficiency : Single;

          result.FrontArea:=0.5; // 0.5 m²

          result.Code:=BikeData[0,t];
          result.Factory:=BikeData[1,t];
          result.Weight:=AsSingle(2);
          result.Fuel:=AsSingle(3);
          result.Horses:=AsSingle(4);
          result.Watts:=result.Horses*735.5; // Watts
          result.MaxRPM:=AsInteger(5);
          result.GearUpRPM:=AsInteger(6);
          result.GearDownRPM:=AsInteger(7);
          result.IdleRPM:=AsInteger(8);
          result.Front.Wheel:=AsSingle(9);
          result.Front.BrakeForce:=AsSingle(10);
          result.Back.Wheel:=AsSingle(11);
          result.Back.BrakeForce:=AsSingle(12);

          result.TotalBrakeForce:=result.Front.BrakeForce+result.Back.BrakeForce;

          result.MaxLeanAngle:=AsSingle(13);
          result.TransmissionEfficiency:=AsSingle(14);
          result.EngineLayout:=BikeData[15,7];
          result.Wheelbase:=AsInteger(16);
          result.WeightDistributionFront:=AsSingle(17);
          result.MaxTorqueNm:=AsSingle(18);
          result.AerodynamicDownforce:=AsSingle(19);
          result.HasHoleshotDevice:=BikeData[20,t]='1';

          result.PrimaryRatio:=AsSingle(21); // 1.65;
          result.FinalDrive:=AsSingle(22); // 3.28  =   46/14  Rear/Front Sprocket Teeth

          result.Init;
        finally
          FormatSettings.DecimalSeparator:=Old;
        end;

        Exit;
      end;

  raise Exception.Create('Error Bike not found: '+ABike);
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

  procedure InitRiders;
  var t, tmp : Integer;
      tmpBike : String;
  begin
    for t:=0 to High(Race.Riders) do
    begin
      Race.Riders[t].Start(Race.TotalLaps);

      tmp:=Race.PoleIndex[t];

      tmpBike:=PilotsData[5,t];

      if tmpBike='' then
         tmpBike:='Default';

      Race.Riders[t].Bike:=FindBike(tmpBike);

      // Customize pilot

      Race.Riders[t].Pilot.Name:=PilotsData[1,t];
      Race.Riders[t].Pilot.Weight:=StrToFloat(PilotsData[3,t]);

      tmp:=FindInAllPilots(PilotsData[0,tmp]);

      Race.Riders[t].Pilot.Height:=StrToFloat(AllPilots[7,tmp]);
    end;
  end;

begin
  CursorLap.Value:=0;

  Race.Init;

  InitPoleData;

  Race.RiderEndsLap:=procedure(Rider,Lap:Integer)

  var tmpBest : Int64;
      tmpPole : Integer;
  begin
    {$IFOPT D+}
    if Lap>Race.TotalLaps then
       raise Exception.Create('Error Lap exceeds limits: '+IntToStr(Lap));
    {$ENDIF}

    if Race.Current<=Lap then
       if Race.Current<Race.TotalLaps then
       begin
         Race.Current:=Lap+1;
         SetCurrentLap(Race.Current);
       end;

    tmpPole:=FindRiderInPole(Race.Riders[Rider].Number);

    if CBViewLastLap.Checked then
       // Same rider that is selected, has ended a lap?
       if tmpPole=PoleGrid.Selected.Row then
          ClearLapCharts;

    Pole[Pole_Last,tmpPole]:=IntToTime(Race.Riders[Rider].Ellapsed[Lap-1]); // Last

    if Race.Riders[Rider].BestLap>0 then
    begin
      tmpBest:=Race.Riders[Rider].Ellapsed[Race.Riders[Rider].BestLap-1];

      Pole[Pole_Best,tmpPole]:=IntToTime(tmpBest); // Best
      Pole[Pole_BestLap,tmpPole]:=IntToStr(Race.Riders[Rider].BestLap); // Best

      if (Race.Fastest=-1) or (tmpBest<Race.FastestTime) then
      begin
        Race.FastestTime:=tmpBest;
        Race.Fastest:=Rider;
      end;
    end
    else
    begin
      Pole[Pole_Best,tmpPole]:='';
      Pole[Pole_BestLap,tmpPole]:='';
    end;

    if tmpPole=PoleGrid.Selected.Row then
    begin
      LapsTimeData[0,Lap-1]:=IntToStr(Lap);
      LapsTimeData[1,Lap-1]:=Pole[Pole_Last,tmpPole]; // Last
    end;

    // Rider time for Lap
    TowerLapRider.Value[Lap-1,Rider]:=Race.Riders[Rider].Ellapsed[Lap-1];
  end;

  Race.RiderPass:=procedure(Rider1,Rider2:Integer)

    procedure SwapRider(const A,B:Integer);
    var t : Integer;
        tmp : String;
    begin
      for t:=1 to Pole.Columns-1 do
      begin
        tmp:=Pole[t,A];
        Pole[t,A]:=Pole[t,B];
        Pole[t,B]:=tmp;
      end;

      if PoleGrid.Selected.Row=A then
         PoleGrid.Selected.Row:=B
      else
      if PoleGrid.Selected.Row=B then
         PoleGrid.Selected.Row:=A;
    end;

  var f : TTextFormat;
  begin
    SwappingRider:=True;
    try
      SwapRider(Rider1,Rider2);

      // Swap pilot colors at Pole grid
      f:=PoleGrid.CellFormat.Cell[Rider1,1].Format;
      f.Brush.Color:=HTMLColor(PilotsData[4,Race.PoleIndex[Rider2]]);
      f.Font.Color:=CalcFontColor(f.Brush.Color);

      f:=PoleGrid.CellFormat.Cell[Rider2,1].Format;
      f.Brush.Color:=HTMLColor(PilotsData[4,Race.PoleIndex[Rider1]]);
      f.Font.Color:=CalcFontColor(f.Brush.Color);
    finally
      SwappingRider:=False;
    end;
  end;

  InitRiders;

  Race.Ellapsed:=0;

  Race.Data[0].Time:=0;

  Race.Current:=1;

  SetCurrentLap(Race.Current);

  InitTowerLapRider;
end;

procedure ThemeGrid(const AGrid:TTeeGrid; const ABack,AFont:TColor);
var tmpGrid : TColor;
begin
  AGrid.Back.Brush.Color:=ABack;
  AGrid.Cells.Format.Font.Color:=AFont;

  if ABack=clBlack then
     tmpGrid:=clRed
  else
     tmpGrid:=clSilver;

  AGrid.Rows.Lines.Color:=tmpGrid;
end;

procedure ThemeChart(const AChart:TChart; const ABack,AFont:TColor);
var t : Integer;
    tmpGrid : TColor;
begin
  if AChart.Gradient.Visible then
  begin
    AChart.Gradient.StartColor:=ABack;
    AChart.Gradient.EndColor:=ABack;
  end
  else
    AChart.Color:=ABack;

  AChart.Title.Font.Color:=AFont;

  AChart.Walls.Back.Gradient.Visible:=False;
  AChart.Walls.Back.Color:=ABack;

  if ABack=clBlack then
     tmpGrid:=RGB(50,50,50)
  else
     tmpGrid:=RGB(220,210,210);

  for t:=0 to AChart.Axes.Count-1 do
  begin
    AChart.Axes[t].Texts.Font.Color:=AFont;
    AChart.Axes[t].Grid.Color:=tmpGrid;
  end;
end;

procedure TMainForm.ApplyTheme(const ABack,AFont:TColor);

  procedure ChangePanel(const APanel:TPanel);
  begin
    APanel.ParentBackground:=False;
    APanel.ParentColor:=False;
    APanel.Color:=ABack;
  end;

  procedure ChangeFonts(const ALabels:Array of TLabel);
  var t : Integer;
  begin
    for t:=0 to High(ALabels) do
        ALabels[t].Font.Color:=AFont;
  end;

begin
  ThemeGrid(PoleGrid,ABack,AFont);
  ThemeGrid(LapTimesGrid,ABack,AFont);
  ThemeGrid(ChampionGrid,ABack,AFont);
  ThemeGrid(BikeGrid,ABack,AFont);
  ThemeGrid(TiresGrid,ABack,AFont);
  ThemeGrid(DataGrid,ABack,AFont);
  ThemeGrid(Circuits,ABack,AFont);
  ThemeGrid(CurvesGrid,ABack,AFont);
  ThemeGrid(Pilots,ABack,AFont);
  ThemeGrid(Sensors,ABack,AFont);
  ThemeGrid(TireStatus,ABack,AFont);
  ThemeGrid(GearRatios,ABack,AFont);
  ThemeGrid(AllPilotsGrid,ABack,AFont);
  ThemeGrid(LeaderBoard,ABack,AFont);

  ThemeChart(SiteWeather,ABack,AFont);
  ThemeChart(LapChart,ABack,AFont);
  ThemeChart(Circuit,ABack,AFont);
  ThemeChart(Dashboard,ABack,AFont);
  ThemeChart(FrontView,ABack,AFont);
  ThemeChart(AllLaps,ABack,AFont);
  ThemeChart(LeaderChart,ABack,AFont);

  if Torque<>nil then
     ThemeChart(Torque.Chart1,ABack,AFont);

  SeriesList.Color:=ABack;
  SeriesList.Font.Color:=AFont;

  ChangePanel(Panel1);
  ChangePanel(Panel2);
  ChangePanel(Panel3);
  ChangePanel(Panel4);
  ChangePanel(PanelTop);

  ChangeFonts([CurrentLap,Label1,Label2,Label3,Label4,LRaceEllapsed]);

  {
  CBSingleRider.StyleElements := [];
  CBSingleRider.ParentFont:=False;
  CBSingleRider.ParentColor:=False;
  CBSingleRider.Font.Color:=AFont;
  }
end;

procedure TMainForm.Dark1Click(Sender: TObject);
begin
  ApplyTheme(clBlack,clWhite);
  SaveRegistry('View','Theme','Dark');
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
      if Length(Race.PoleIndex)>1 then
         Rider:=Race.PoleIndex[Rider];

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

  // slow !
  function FindPoleIndex(const AIndex:Integer):Integer;
  var t : Integer;
  begin
    for t:=0 to High(Race.PoleIndex) do
        if Race.PoleIndex[t]=AIndex then
        begin
          result:=t;
          Exit;
        end;

    result:=-1; // Exception
  end;

  procedure SetPoleDeltas;
  var t,
      tmp,
      tmpPole : Integer;
  begin
    for t:=0 to High(Race.StartPoleIndex) do
    begin
      tmpPole:=FindPoleIndex(Race.StartPoleIndex[t]);
      tmp:=t-tmpPole;

      if tmp=0 then
         Pole[Pole_Delta,tmpPole]:=''
      else
      if tmp>0 then
         Pole[Pole_Delta,tmpPole]:='+'+IntToStr(tmp)
      else
         Pole[Pole_Delta,tmpPole]:=IntToStr(tmp);
    end;
  end;

  procedure SetGapTimes(const L:Integer);
  var t,
      tmp,
      tmpLap,
      tmpTime : Integer;

      Gap, GapTime : Single;
  begin
    // Current time
    tmp:=Race.PoleIndex[0];

    tmpTime:=Race.Data[L].Time;

    tmpLap:=Race.Riders[tmp].Laps;

    if tmpLap>0 then
       Dec(tmpTime,Race.Data[Race.Riders[tmp].LapsTime[tmpLap-1]].Time);

    Pole[Pole_Current,0]:=IntToTime(tmpTime); // First pilot total race time

    // From pilot 1:
    for t:=1 to Pole.Count-1 do
    begin
      Gap:=Race.Data[L].Data[t].Position-Race.Data[L].Data[t-1].Position;

      if Race.Data[L].Data[t].Speed>0 then
         GapTime:=(Gap/Race.Data[L].Data[t].Speed)/SecsPerDay // meters/mps = seconds
      else
         GapTime:=0;

      Pole[Pole_Current,t]:=FormatDateTime('+s.zzz',GapTime);
    end;

    PoleGrid.Invalidate;
  end;

var L : Integer;
begin
  Race.Step;

  L:=High(Race.Data);

  result:=Race.StepRiders(L);

  if Race.TryPasses(Race.Data[L].Data) then
     PoleGrid.Invalidate;

  if Race.Data[L].Time mod 1000=0 then  // Refresh every second
  begin
    SetPoleDeltas;
    SetGapTimes(L);
  end;

  Circuit.Invalidate;

  if FrontView.Visible then
     FrontView.Invalidate;

  if CBViewLastLap.Checked then
  begin
    // Show current data (Speed,Acceleration,Gear,Throttle,etc) for the currently selected driver
    UpdateLapCharts;
    UpdateCursorLap(Race.Data[L].Data);
  end;

  if PageControl1.ActivePage=TabData then
     DataGrid.Invalidate;
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
  SetCurrentLap(0);
end;

procedure TMainForm.EPoleRidersChange(Sender: TObject);
begin
  CreatePole;

  PoleGrid.Invalidate;
  PoleChart.Invalidate;
  Circuit.Invalidate;
end;

procedure TMainForm.EViewLapChange(Sender: TObject);
begin
  if not CBViewLastLap.Checked then
     RefillCharts;
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

procedure TMainForm.TelemetryStepAfterDraw(Sender: TObject);

  function LocateNearest(const ASeries:TChartSeries; const AValue:Single):Integer;
  var t : Integer;
  begin
    for t:=0 to ASeries.Count-1 do
    begin
      if ASeries.XValues.Value[t]>AValue then
      begin
        result:=t;
        Exit;
      end;
    end;

    result:=-1;
  end;

var Y, t, tmp : Integer;
    S : TChartSeries;
begin
  Y:=10;

  for t:=0 to LapChart.SeriesCount-1 do
  begin
    S:=LapChart[t];

    if (S<>CurveSeries) and (S<>CurveSpeeds) and S.Visible then
    begin
      tmp:=LocateNearest(S,CursorLap.Value);

      if tmp<>-1 then
      begin
        TelemetryStep.Canvas.TextOut(10,Y,S.Title);

        Inc(Y,20);
        TelemetryStep.Canvas.TextOut(10,Y,FormatFloat('0.###',S.MandatoryValueList[tmp]));

        Inc(Y,40);
      end;
    end;
  end;
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

  LRaceEllapsed.Caption:=IntToTime(Race.Ellapsed);
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
