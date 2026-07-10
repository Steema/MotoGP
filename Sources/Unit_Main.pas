{
  @davidberneda

  https://github.com/Steema/MotoGP

}
unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Types,

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
  Tee.Format, Tee.Renders,

  TeeTorqueCurve, PNGImage,

  Series, TeeNumericGauge, TeeGauges, TeeTools, TeeSurfa, TeeLinearGauge;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabLap: TTabSheet;
    TabLaps: TTabSheet;
    LapChart: TChart;
    AllLaps: TChart;
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
    TabFrontView: TTabSheet;
    FrontView: TChart;
    TabSheet3: TTabSheet;
    PageControl5: TPageControl;
    TabSheet4: TTabSheet;
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
    Label3: TLabel;
    CBViewMode: TComboBox;
    EViewLap: TEdit;
    UDViewLap: TUpDown;
    Panel2: TPanel;
    Label4: TLabel;
    CBSelectedBike: TComboBox;
    CBSingleRider: TCheckBox;
    FrontTire: TPaintBox;
    BackTire: TPaintBox;
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
    procedure CBSingleRiderClick(Sender: TObject);
    procedure CBSelectedBikeChange(Sender: TObject);
    procedure FrontTirePaint(Sender: TObject);
    procedure BackTirePaint(Sender: TObject);
  private
    { Private declarations }

    CircuitPath : TTeeBasePath;
    GIS : TGISRaster;

    RearBike : TGraphic;

    AllPilots,
    BikeData,
    RoundsData,
    PilotsData,
    SensorsData,
    CircuitsData,
    Pole,
    LapsTimeData,
    CurvesGridData : TStringsData;

    StartCount : Integer;

    Race : TRace;

    Torque : TFormTorqueCurve;

    RacePoleIndex, // Current pole during race (keeps changing)
    StartPoleIndex // Pole at grid, race start, immutable
     : TArray<Integer>;

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

    procedure AddRiderData(const APos:Integer; const Rider:Integer);
    procedure ApplyTheme(const ABack,AFont:Graphics.TColor);
    function CheckPilotExists(const S:String):Boolean;
    procedure ClearLapCharts;
    procedure CreatePole;
    procedure DoPaintFlag(const ID:String; var AData: TRenderData);
    function DoStep:Boolean;
    procedure DrawTireIcon(const ACanvas:TCanvas; const AColumn:Integer);
    function FindInAllPilots(const S:String):Integer;
    procedure FillRounds;
    procedure FillSeasons;
    function FindBike(const ABike:String):TBike;
    function FindPilotNum(const ANum:String):Integer; // index inside PilotsData
    function FindRiderInPole(const ARider:Integer):Integer;
    procedure InitPoleData;
    procedure LoadConfiguration;
    procedure RefillCharts;
    function MotoGPSeason:String;
    procedure PaintFastest(const Sender:TColumn; var AData:TRenderData; var DefaultPaint:Boolean);
    procedure PaintFlag(const Sender:TColumn; var AData:TRenderData; var DefaultPaint:Boolean);
    function Season:String;
    procedure SetCurrentLap(const ACurrent:Integer);
    procedure SetDashboard;
    procedure SetTeeCanvas(const AClass:TTeeCanvasClass);
    procedure SetupPilotGrid(const AGrid:TTeeGrid; const AColorColumn,ANumColumn:Integer);
    procedure StartRace;
    procedure TrySetGISBounds;
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

  TeeGDIPlus, TeeSkia, TeeGLCanvas, TeeRacingAbout, Picture,

  TeeCountryFlags;

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
begin
  tmp:=BikeData.Cells[0,BikeGrid.Selected.Row];

  Torque.FillSample(FindBike(tmp).Torque);
  Torque.Chart1.Legend.Title.Caption:=tmp;
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
  Circuit.Invalidate;
end;

var DataPath:String='';

function MotoGP:String;
begin
  if DataPath='' then
  begin
    DataPath:='Data\MotoGP';

    while not FileExists(DataPath+'\AllPilots.txt') do
    begin
      DataPath:='..\'+DataPath;

      if Length(DataPath)>100 then
         raise Exception.Create('Error Cannot find the Data folder');
    end;
  end;

  result:=DataPath;
end;

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

  UDViewLap.Max:=Race.TotalLaps;
  UDViewLap.Min:=1;

  SetCurrentLap(1);
end;

procedure TMainForm.CBRoundsChange(Sender: TObject);

  function FindCircuit(const S:String):Integer;
  var t : Integer;
  begin
    for t:=0 to CircuitsData.Count-1 do
        if CircuitsData.Cells[0,t]=S then
        begin
          result:=t;
          Exit;
        end;

    result:=-1;
  end;

var tmp : Integer;
begin
  tmp:=CBRounds.ItemIndex;

  Circuits.Selected.Row:=FindCircuit(RoundsData.Cells[1,tmp]);
end;

function TMainForm.FindInAllPilots(const S:String):Integer;
var t : Integer;
begin
  for t:=0 to AllPilots.Count-1 do
  begin
    if AllPilots.Cells[0,t]=S then
    begin
      result:=t;
      Exit;
    end;
  end;

  result:=-1;
end;

function TMainForm.CheckPilotExists(const S:String):Boolean;
begin
  result:=FindInAllPilots(S)<>-1;

  if not result then
     raise Exception.Create('Error: Pilot with Code: '+s+' not found in All Pilots table');
end;

procedure TMainForm.CBSeasonsChange(Sender: TObject);

  procedure VerifyPilots;
  var t : Integer;
  begin
    for t:=0 to PilotsData.Count-1 do
        CheckPilotExists(PilotsData.Cells[0,t]);
  end;

begin
  PilotsData:=TCSVDataImport.FromFile(MotoGPSeason+'\Pilots.txt',True,',','');

  VerifyPilots;

  Pilots.Data:=PilotsData;

  SetupPilotGrid(Pilots,1,-1);

  if Pilots.Columns['Color']<>nil then
     Pilots.Columns['Color'].Hide;

  Pilots.Columns[1].Header.Text:='#';

  if FileExists(MotoGPSeason+'\Tires.txt') then
     TiresGrid.Data:=TCSVDataImport.FromFile(MotoGPSeason+'\Tires.txt');

  if FileExists(MotoGPSeason+'\Rounds.txt') then
  begin
    RoundsData:=TCSVDataImport.FromFile(MotoGPSeason+'\Rounds.txt');
    ChampionGrid.Data:=RoundsData;

    SetupPilotGrid(ChampionGrid,5,5);
    SetupPilotGrid(ChampionGrid,6,6);

    FillRounds;

    CBRounds.Enabled:=True;

    CBRounds.ItemIndex:=0;
    CBRaceChange(Self);
  end
  else
  begin
    ChampionGrid.Data:=nil;
    CBRounds.Clear;
    CBRounds.Enabled:=False;
  end;

  CreatePole;

  PoleGrid.Columns[1].Width.Value:=40;
  PoleGrid.Invalidate;

  PoleGrid.Selected.Row:=0;
  PoleGridSelect(Self);
end;

procedure TMainForm.CBSelectedBikeChange(Sender: TObject);
var tmp : Integer;
begin
  tmp:=FindPilotNum(Pole.Cells[1,PoleGrid.Selected.Row]);

  PilotsData.Cells[5,tmp]:=CBSelectedBike.Items[CBSelectedBike.ItemIndex];
end;

procedure TMainForm.CBSingleRiderClick(Sender: TObject);
begin
  BRandomPoleClick(Self); // Recreate Pole
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

         LabelText:=IntToStr(Race.Riders[ValueIndex].Number)+' '+Pole.Cells[2,tmp];
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

  function LoadCircuitPath(const ID:String):String;
  begin
    if ID='' then
       result:=''
    else
       result:=TFile.ReadAllText(MotoGP+'\Circuits\Paths\'+ID+'.svg');
  end;

  procedure AddCurves(const ACurves:Array of TCurve);
  var t : Integer;
      X : Single;
      tmp : String;
  begin
    for t:=0 to High(ACurves) do
    begin
      X:=ACurves[t].Position;

      tmp:=IntToStr(t+1)+#13#10+ACurves[t].Name;

      CurveSeries.AddXY(X,ACurves[t].Angle,tmp);
      CurveSpeeds.AddXY(X,ACurves[t].EntrySpeed/3.6);
    end;
  end;

  // Montmeló
  procedure AddCircuitPath;
  var PathFile : String;
      t : Integer;
  begin
    CircuitPath:=LapChart.Canvas.CreatePath;

    PathFile:=CircuitsData[3,Circuits.Selected.Row];

    if PathFile<>'' then
    begin
      TSVGParser.ParsePath(CircuitPath,LoadCircuitPath(PathFile));

      Race.Circuit.Points:=CircuitPath.Flatten(0.25);

      if CurvesGridData<>nil then
      begin
        SetLength(Race.Circuit.Curves,CurvesGridData.Count);

        for t:=0 to CurvesGridData.Count-1 do
        begin
          Race.Circuit.Curves[t].Position:=StrToFloat(CurvesGridData.Cells[1,t]);
          Race.Circuit.Curves[t].Name:=CurvesGridData.Cells[2,t];
          Race.Circuit.Curves[t].Angle:=StrToFloatDef(CurvesGridData.Cells[3,t],0);
          Race.Circuit.Curves[t].EntrySpeed:=StrToFloatDef(CurvesGridData.Cells[4,t],0);
          Race.Circuit.Curves[t].ApexPosition:=Race.Circuit.Curves[t].Position+StrToFloatDef(CurvesGridData.Cells[5,t],0);
        end;
      end;

      CurveSeries.GetVertAxis.SetMinMax(-180,180);

      CurveSeries.Clear;
      CurveSeries.Title:='Curves';

      CurveSpeeds.Clear;
      CurveSpeeds.Title:='Entry Speed';

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
            P:=Race.Circuit.PointPosition(Last[t].Position+Race.Circuit.PolePosition);

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

    SiteWeather.Invalidate;
  end;

begin
  if CircuitPath=nil then
     AddCircuitPath;

  SelectCircuit;

  PaintCircuitPath;
end;

procedure TMainForm.CircuitsSelect(Sender: TObject);
var tmp : String;
begin
  FreeAndNil(CircuitPath);
  Circuit.Invalidate;

  TrySetGISBounds;

  if Circuits.Data.Count>0 then
     if Circuits.Selected.Row>0 then
     begin
       tmp:=MotoGP+'\Circuits\Curves\'+CircuitsData[3,Circuits.Selected.Row]+'.txt';

       if FileExists(tmp) then
       begin
         CurvesGridData:=TCSVDataImport.FromFile(tmp,True,',','');
         CurvesGrid.Data:=CurvesGridData;
       end
       else
       begin
         CurvesGrid.Data:=nil;
         CurvesGridData:=nil;
       end;
     end;
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
  TeeCommander1.Parent:=TabLaps;
  TeeCommander1.Panel:=AllLaps;
  {$ENDIF}
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

      Pole[1,t]:=PilotsData[1,tmp];
      Pole[2,t]:=PilotsData[0,tmp];
      Pole[3,t]:='0:0.0'; // Current lap time
      Pole[4,t]:='0:0.0';// Last lap time
      Pole[5,t]:='0:0.0'; // Best lap time
      Pole[6,t]:='0'; // Lap with best time

      Pole[7,t]:=''; // flag
      Pole[8,t]:=PilotsData[2,tmp];
    end;

    PoleGrid.Data:=Pole;

    if PoleGrid.Selected.Row>Pole.Count then
       PoleGrid.Selected.Row:=Pole.Count-1;

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
      Race.Riders[t].Number:=PilotsData.Cells[1,t].ToInteger;

      if PilotsData.Columns>4 then
         Race.Riders[t].Color:=HTMLColor(PilotsData.Cells[4,t]);

      Race.Riders[t].Pole:=FindRiderInPole(Race.Riders[t].Number);
    end;
  end;

var tmp,
    RiderQuantity : Integer;
begin
  // Current rider selected
  if CBSingleRider.Checked then
     tmp:=FindPilotNum(Pole.Cells[1,PoleGrid.Selected.Row])
  else
     tmp:=-1;

  Pole.Free;

  if HasParameter('SINGLERIDER') or (tmp<>-1) then
     RiderQuantity:=1
  else
     RiderQuantity:=PilotsData.Rows;

  Pole:=TStringsData.Create(9,RiderQuantity);

  if tmp=-1 then // All pilots
     ShufflePoleIndex
  else
  begin
    SetLength(RacePoleIndex,1);
    RacePoleIndex[0]:=tmp;
  end;

  StartPoleIndex:=CopyPoleIndex;

  InitPoleGrid;

  SetupPilotGrid(PoleGrid,1,1);

  Race.Weather:=DefaultWeather;

  InitRaceRiders;

  Race.Init;
end;

function TMainForm.FindPilotNum(const ANum:String):Integer; // index inside PilotsData
var t : Integer;
begin
  for t:=0 to PilotsData.Count-1 do
      if PilotsData.Cells[1,t]=ANum then
      begin
        result:=t;
        Exit;
      end;

  result:=-1; // error !
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

    if tmp<>-1 then
    begin
      f:=AGrid.CellFormat.Cell[t,AColorColumn].Format;

      if PilotsData.Columns>4 then
         f.Brush.Color:=HTMLColor(PilotsData.Cells[4,tmp])
      else
         f.Brush.Color:=clWhite;

      f.Brush.Show;

      f.Font.Color:=CalcFontColor(f.Brush.Color);
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

  C.TextOut(215,44,'Record: '+CircuitsData.Cells[11,Circuits.Selected.Row]+' '+CircuitsData.Cells[12,Circuits.Selected.Row]);
  C.TextOut(215,66,CircuitsData.Cells[13,Circuits.Selected.Row]);

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

// Check AllPilots Code field is not duplicated, and has 3 or 4 characters
procedure TMainForm.VerifyAllPilots;

  function Duplicated(const AtUntil:Integer; const S:String):Boolean;
  var t : Integer;
  begin
    for t:=0 to AtUntil do
        if SameText(S,AllPilots.Cells[0,t]) then
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
    s:=AllPilots.Cells[0,t];

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
  if Race.Fastest=AData.Row then
     AData.Painter.Fill(AData.Bounds,clRed);

  DefaultPaint:=True;
end;

procedure TMainForm.DoPaintFlag(const ID:String; var AData: TRenderData);
var tmpFlag : TGraphic;
    tmp : TPicture;
begin
  tmpFlag:=FormFlags.GetFlag(ID);

  tmp:=TVCLPicture.From(tmpFlag);
  try
    AData.Painter.Draw(tmp,AData.Bounds.Left+4,AData.Bounds.Top+4);
  finally
    tmp.Free;
  end;
end;

procedure TMainForm.PaintFlag(const Sender: TColumn; var AData: TRenderData;
  var DefaultPaint: Boolean);
begin
  DoPaintFlag((Sender.TagObject as TStringsData).Cells[Sender.Tag,AData.Row],AData);
  DefaultPaint:=False;
end;

procedure TMainForm.FormShow(Sender: TObject);

  procedure FillBikes(const Items:TStrings);
  var t : Integer;
  begin
    Items.BeginUpdate;
    try
      Items.Clear;

      for t:=0 to BikeData.Count-1 do
          Items.Add(BikeData.Cells[0,t]);
    finally
      Items.EndUpdate;
    end;
  end;

  procedure AddFlags(const AGrid:TTeeGrid; const ACountry:Integer; const AStrings:TStringsData);
  var C : TColumn;
  begin
    C:=AGrid.Columns.Add;
    C.Header.Text:='Flag';
    C.Tag:=ACountry;
    C.TagObject:=AStrings;
    C.OnPaint:=PaintFlag;
  end;

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

  AllPilots:=TCSVDataImport.FromFile(MotoGP+'\AllPilots.txt');
  VerifyAllPilots;

  AllPilotsGrid.Data:=AllPilots;
  AddFlags(AllPilotsGrid,4,AllPilots);

  SensorsData:=TCSVDataImport.FromFile(MotoGP+'\Sensors.txt');
  Sensors.Data:=SensorsData;

  Torque:=TFormTorqueCurve.Create(Self);
  Torque.Align:=alBottom;
  TTeeVCL.AddFormTo(Torque,TabSheet4);

  BikeData:=TCSVDataImport.FromFile(MotoGP+'\AllBikes.txt');
  BikeGrid.Data:=BikeData;

  FillBikes(CBSelectedBike.Items);
  CBSelectedBike.ItemIndex:=0;

  CircuitsData:=TCSVDataImport.FromFile(MotoGP+'\Circuits\Circuits.txt');
  Circuits.Data:=CircuitsData;

  AddFlags(Circuits,2,CircuitsData);

  FillSeasons;

  CBSeasons.ItemIndex:=CBSeasons.Items.IndexOf(IntToStr(CurrentYear));
  CBSeasonsChange(Self);

   // Montmeló, Barcelona, Catalunya
  CBRounds.ItemIndex:=5;
  CBRoundsChange(Self);
  //Circuits.Selected.Row:=5;

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
  RearBike.LoadFromFile(MotoGP+'\Images\rear_bike_small.png');

  PageControl2.ActivePage:=TabCircuits;
  PageControl1.ActivePage:=TabLap;
  PageControl4.ActivePage:=TabFrontView;
  PageControl3.ActivePage:=TabRace;

  LoadConfiguration;
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
    tmpTire:=PilotsData.Cells[AColumn,FindPilotNum(Pole.Cells[1,tmp])];

    ACanvas.Pen.Width:=3;
    ACanvas.Ellipse(2,2,30,30);
    ACanvas.Brush.Style:=bsClear;
    ACanvas.Font.Style:=[fsBold];
    ACanvas.TextOut(10,4,TireLetter(tmpTire));
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
    if Length(RacePoleIndex)>1 then
       tmp:=RacePoleIndex[tmp];

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
  end
  else
  if PageControl1.ActivePage=TabLap then
  begin
    if SeriesSpeed.Count<2 then
       RefillCharts;
  end;
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

    if Length(StartPoleIndex)>1 then
       tmpIndex:=StartPoleIndex[Pilot]
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

  procedure CreateSeries;
  begin
    SeriesSpeed:=TFastLineSeries.Create(Self);
    SeriesAcceleration:=TFastLineSeries.Create(Self);
    SeriesRPM:=TFastLineSeries.Create(Self);
    SeriesGear:=TFastLineSeries.Create(Self);
    SeriesThrottle:=TFastLineSeries.Create(Self);
    SeriesFrontBrake:=TFastLineSeries.Create(Self);
    SeriesBackBrake:=TFastLineSeries.Create(Self);

    SeriesSpeed.ParentChart:=LapChart;
    SeriesAcceleration.ParentChart:=LapChart;
    SeriesRPM.ParentChart:=LapChart;
    SeriesGear.ParentChart:=LapChart;
    SeriesThrottle.ParentChart:=LapChart;
    SeriesFrontBrake.ParentChart:=LapChart;
    SeriesBackBrake.ParentChart:=LapChart;

    SeriesSpeed.Title:='Speed m/s';
    SeriesAcceleration.Title:='Acceleration m/s²';
    SeriesRPM.Title:='RPM';
    SeriesGear.Title:='Gear';
    SeriesThrottle.Title:='Throttle %';
    SeriesFrontBrake.Title:='Front Brake';
    SeriesBackBrake.Title:='Back Brake';

    SeriesGear.Stairs:=True;
    SeriesThrottle.Stairs:=True;
    SeriesFrontBrake.Stairs:=True;
    SeriesBackBrake.Stairs:=True;

    SeriesThrottle.CustomVertAxis:=LapChart.CustomAxes[1];
    SeriesFrontBrake.CustomVertAxis:=LapChart.CustomAxes[1];
    SeriesBackBrake.CustomVertAxis:=LapChart.CustomAxes[1];

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

    tmpMin: Single;
begin
  if SeriesSpeed=nil then
  begin
    CreateSeries;
    AddSeriesList;
  end;

  if PoleGrid.Selected.Row>-1 then
  begin
    Rider:=PoleGrid.Selected.Row;

    tmpRider:=FindInAllPilots(Pole.Cells[2,Rider]);

    LapChart.Title.Caption:=Pole.Cells[1,Rider]+' '+Pole.Cells[2,Rider]+' '+AllPilots.Cells[1,tmpRider]+' '+AllPilots.Cells[2,tmpRider];
    LapChart.Title.Font.Size:=14;

    if Length(Race.Riders)>Rider then
    begin
      if UDViewLap.Position=1 then
         tmpMin:=-Race.Riders[RacePoleIndex[Rider]].Pole*Race.PoleDistance
      else
         tmpMin:=0;

      SeriesSpeed.GetHorizAxis.SetMinMax(tmpMin,Race.Circuit.TotalLength);

      SeriesSpeed.BeginUpdate;
      SeriesAcceleration.BeginUpdate;
      SeriesGear.BeginUpdate;
      SeriesThrottle.BeginUpdate;
      SeriesFrontBrake.BeginUpdate;
      SeriesBackBrake.BeginUpdate;

      ClearLapCharts;

      if CBViewLastLap.Checked then
         if Race.Riders[Rider].Laps=0 then
            tmpLap:=0
         else
            tmpLap:=Race.Riders[Rider].Laps-1
      else
         tmpLap:=UDViewLap.Position-1;

      if Race.Riders[Rider].Laps<=tmpLap then
         StartOfLap:=0
      else
         StartOfLap:=Race.Riders[Rider].LapsTime[tmpLap-1];

      if CBViewLastLap.Checked or (Length(Race.Riders[Rider].LapsTime)=0) then
         EndOfLap:=High(Race.Data)
      else
         EndOfLap:=Race.Riders[Rider].LapsTime[tmpLap];

      for t:=StartOfLap to EndOfLap do
          AddRiderData(t,RacePoleIndex[Rider]);

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

begin
  X:=Race.Data[APos].Data[Rider].Position;

  SeriesSpeed.AddXY(X,Race.Data[APos].Data[Rider].Speed);
  SeriesAcceleration.AddXY(X,Race.Data[APos].Data[Rider].Acceleration);

  CheckNew(SeriesGear,Race.Data[APos].Data[Rider].Gear);
  CheckNew(SeriesThrottle,Race.Data[APos].Data[Rider].Throttle);

  CheckNew(SeriesFrontBrake,Race.Data[APos].Data[Rider].FrontBrake);
  CheckNew(SeriesBackBrake,Race.Data[APos].Data[Rider].BackBrake);
end;

procedure TMainForm.UpdateLapCharts;
begin
  if PoleGrid.Selected.Row>-1 then
     AddRiderData(High(Race.Data),PoleGrid.Selected.Row);
end;

procedure TMainForm.PoleGridSelect(Sender: TObject);
var tmp : Integer;
    tmpBike : String;
begin
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
    FrontView.Title.Caption:=Pole.Cells[1,tmp]+' '+Pole.Cells[2,tmp];

    TabLapTimes.TabVisible:=True;

    LapsTimeData:=TStringsData.Create(2,Race.TotalLaps);
    LapTimesGrid.Data:=LapsTimeData;

    LapTimesGrid.Columns[0].Header.Text:='Lap';
    LapTimesGrid.Columns[1].Header.Text:='Time';

    tmpBike:=PilotsData.Cells[5,FindPilotNum(Pole.Cells[1,tmp])];

    CBSelectedBike.ItemIndex:=CBSelectedBike.Items.IndexOf(tmpBike);
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

function TMainForm.FindRiderInPole(const ARider:Integer):Integer;
var t : Integer;
begin
  for t:=0 to Pole.Count-1 do
      if StrToInt(Pole.Cells[1,t])=ARider then
      begin
        result:=t;
        Exit;
      end;

  result:=-1;
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

  if CBViewLastLap.Checked then
     UDViewLap.Position:=Race.Current;
end;

function TMainForm.FindBike(const ABike:String):TBike;
var t : Integer;

   function AsSingle(const ACol:Integer):Single;
   begin
     result:=StrToFloat(BikeData.Cells[ACol,t]);
   end;

   function AsInteger(const ACol:Integer):Integer;
   begin
     result:=StrToInt(BikeData.Cells[ACol,t]);
   end;

var Old : Char;
begin
  for t:=0 to BikeData.Count-1 do
      if BikeData.Cells[0,t]=ABike then
      begin
        Old:=FormatSettings.DecimalSeparator;

        FormatSettings.DecimalSeparator:='.';
        try
          result.Torque:=TBike.DefaultTorqueCurve;
          result.GearRatios:=TBike.DefaultGearRatios;

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

          result.Code:=BikeData.Cells[0,t];
          result.Factory:=BikeData.Cells[1,t];
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
          result.MaxLeanAngle:=AsSingle(13);
          result.TransmissionEfficiency:=AsSingle(14);
          result.EngineLayout:=BikeData.Cells[15,7];
          result.Wheelbase:=AsInteger(16);
          result.WeightDistributionFront:=AsSingle(17);
          result.MaxTorqueNm:=AsSingle(18);
          result.AerodynamicDownforce:=AsSingle(19);
          result.HasHoleshotDevice:=BikeData.Cells[20,t]='1';

          result.MaxGear:=AsInteger(21);  // 3..7
          result.PrimaryRatio:=AsSingle(22); // 1.65;
          result.FinalDrive:=AsSingle(23); // 3.28  =   46/14  Rear/Front Sprocket Teeth
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
  begin
    for t:=0 to High(Race.Riders) do
    begin
      Race.Riders[t].Start(Race.TotalLaps);

      tmp:=RacePoleIndex[t];

      Race.Riders[t].Bike:=FindBike(PilotsData.Cells[5,tmp]);

      // Customize pilot

      Race.Riders[t].Pilot.Name:=PilotsData.Cells[1,tmp];
      Race.Riders[t].Pilot.Weight:=StrToFloat(PilotsData.Cells[3,tmp]);

      tmp:=FindInAllPilots(PilotsData.Cells[0,tmp]);

      Race.Riders[t].Pilot.Height:=StrToFloat(AllPilots.Cells[7,tmp]);
    end;
  end;

begin
  CursorLap.Value:=0;

  Race.Init;

  InitPoleData;

  Race.RiderEndsLap:=procedure(Rider,Lap:Integer)

  var tmpBest : Int64;
  begin
    if Lap<=Race.TotalLaps then
    begin
      if Race.Current<=Lap then
      begin
        Race.Current:=Lap+1;
        SetCurrentLap(Race.Current);
      end;

      if CBViewLastLap.Checked then
         // Same rider that is selected, has ended a lap?
         if Rider=RacePoleIndex[PoleGrid.Selected.Row] then
            ClearLapCharts;

      Pole.Cells[4,Rider]:=IntToTime(Race.Riders[Rider].Ellapsed[Lap-1]); // Last

      if Race.Riders[Rider].BestLap>0 then
      begin
        tmpBest:=Race.Riders[Rider].Ellapsed[Race.Riders[Rider].BestLap-1];

        Pole.Cells[5,Rider]:=IntToTime(tmpBest); // Best
        Pole.Cells[6,Rider]:=IntToStr(Race.Riders[Rider].BestLap); // Best

        if (Race.Fastest=-1) or (tmpBest<Race.FastestTime) then
        begin
          Race.FastestTime:=tmpBest;
          Race.Fastest:=Rider;
        end;
      end
      else
      begin
        Pole.Cells[5,Rider]:='';
        Pole.Cells[6,Rider]:='';
      end;

      LapsTimeData.Cells[0,Lap-1]:=IntToStr(Lap);
      LapsTimeData.Cells[1,Lap-1]:=Pole.Cells[4,Rider]; // Last

      // Rider time for Lap
      TowerLapRider.Value[Lap-1,Rider]:=Race.Riders[Rider].Ellapsed[Lap-1];
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
     tmpGrid:=clSilver;

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
  ThemeGrid(AllPilotsGrid,ABack,AFont);

  ThemeChart(SiteWeather,ABack,AFont);
  ThemeChart(LapChart,ABack,AFont);
  ThemeChart(Circuit,ABack,AFont);
  ThemeChart(Dashboard,ABack,AFont);
  ThemeChart(FrontView,ABack,AFont);
  ThemeChart(AllLaps,ABack,AFont);

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
      if Length(RacePoleIndex)>1 then
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
      Curve : ^TCurve;
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
          Race.Data[L].Data[t].Position:=Race.Data[L].Data[t].Position-Race.Circuit.TotalLength; // New lap

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
          Curve:=@Race.Circuit.Curves[Race.Riders[t].NextCurve-1];

          Brake:=EvaluateBrakingPoint(Race.Data[L].Data[t].Position, Race.Data[L].Data[t].Speed,
                                      Curve^,
                                      Race.Riders[t].Bike.Front.BrakeForce+Race.Riders[t].Bike.Back.BrakeForce);


          TriggerBrakeDist:= Curve.Position - Brake.BrakingDistanceNeeded;

          CurrentPhase := DetermineTrackPhase(Race.Data[L].Data[t].Position, Curve^, TriggerBrakeDist);

          case CurrentPhase of

            tpApproach:
              begin
                if Race.Data[L].Data[t].Throttle<100 then
                begin
                  Race.Data[L].Data[t].Throttle:=100;
                  //Race.Data[L].Data[t].RPM:=Race.Riders[t].Bike.MaxRPM;


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
                  Race.Data[L].Data[t].Throttle:=0;  // Engine Brake Force


                  //Race.Data[L].Data[t].RPM:=Race.Riders[t].Bike.IdleRPM;


                  // Brake Bite %
                  Race.Data[L].Data[t].FrontBrake:=90;
                  Race.Data[L].Data[t].BackBrake:=30;

                  // Put Bike Upright
                  Race.Data[L].Data[t].LeanAngle:=0;
                end;
              end;

            tpCornering:
              begin
                // TODO: Accurate LeanAngle
                // tmp:=Race.Circuit.IndexOfPosition(Race.Data[L].Data[Rider].Position);
                // Race.Data[L].Data[t].LeanAngle:=CalcLeanAngle(Race.Circuit.Points,tmp,Speed);

                if Curve.Angle<0 then
                   Race.Data[L].Data[t].LeanAngle:= -Race.Riders[t].Bike.MaxLeanAngle
                else
                   Race.Data[L].Data[t].LeanAngle:=Race.Riders[t].Bike.MaxLeanAngle;

                // TrailBraking progressively (The Release)
                Race.Data[L].Data[t].TrailBrake(Curve.ApexPosition);
              end;

            tpAcceleration:
              begin
                // Release brakes
                Race.Data[L].Data[t].FrontBrake:=0;

                Race.Data[L].Data[t].BackBrake:=0;

                // Bike up progressive
                Race.Data[L].Data[t].StandUp;

                // Throttle depends on Lean angle
                Race.Data[L].Data[t].Throttle:=CalculateThrottle(Race.Data[L].Data[t].LeanAngle,Race.Riders[t].Bike.MaxLeanAngle);
                //Race.Data[L].Data[t].RPM:=Race.Riders[t].Bike.MaxRPM;

             end;
          end;

          { TODO: Check is speed is too much at this point (slidout, lowside crash)
          if CheckSlidOut(Race.Data[L].Data[t].Speed,
                          Race.Circuit.Radius[Race.Circuit.IndexOfPosition(Race.Data[L].Data[t].Position)],
                          TotalMass,
                          TireTemp,
                          DryOrWet,
                          Race.Riders[t].Bike) then

               Race.Riders[t].Active:=False;
          }

          if Race.Data[L].Data[t].Position>Curve.ApexPosition then
             Race.Riders[t].GoToNextCurve(Length(Race.Circuit.Curves));
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

var tmp, L : Integer;
begin
  L:=Length(Race.Data);
  SetLength(Race.Data,L+1);

  tmp:=Round(1000*RealTimeFactor);

  Inc(Race.Ellapsed,tmp);

  Race.Data[L].Time:=Race.Data[L-1].Time+tmp;

  SetLength(Race.Data[L].Data,Length(Race.Riders));

  result:=StepRiders(L);

//  if SwapRiders(Race.Data[L].Data) then     TODO
//     PoleGrid.Invalidate;

  SetGapTimes(L);

  Circuit.Invalidate;

  if FrontView.Visible then
     FrontView.Invalidate;

  if PageControl1.ActivePage=TabLap then
     if CBViewLastLap.Checked then
     begin
       // Show current data (Speed,Acceleration,Gear,Throttle,etc) for the currently selected driver
       UpdateLapCharts;

       CursorLap.Value:=Race.Data[L].Data[0].Position;  // Move chart cursor to position of first rider
     end;

  if PageControl1.ActivePage=TabData then
     DataGrid.Invalidate;
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
  SetCurrentLap(0);
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
