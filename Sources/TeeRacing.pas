unit TeeRacing;

interface

uses
  SysUtils, Graphics, TeCanvas, Diagnostics;

type
  // Curves of a circuit path
  TCurve=record
    Position : Single;
    Name : String;
    Angle : Single;  // -180..0..+180  (left or right curve)
  end;

  TTire=record
    Grip : Single;  // Dry: 1.5 .. 1.8  // Wet/Rain: 0.9 .. 1.1
    SlipRatio : Single; // % slip
    Diameter : Single; // cm
    Drop : Single; // degradation
    Friction : Single; // coefficient, resistance
  end;

  TAsphalt=record  // Tarmac, Track Surface
  public
    Abrasiveness : Single; // Micro / Macro  0.5 mm ... 2.0 mm
  end;

  TCircuit=record
  public
    Curves : Array of TCurve;

    Length : Single; // Total length of circuit
    PolePosition : Single; // Meters from Finish to Start

    procedure FillCurves(const APositions:Array of Single;
       const ANames:Array of String;
       const Angles:Array of Single);
  end;

  TBikeFrontBack=record
  public
    Wheel : Single; // Inches diameter
    Tire : TTire;
  end;

  TBike=record
    Weight : Single; // kg
    Fuel : Single; // kg
    FuelLiquid : Single; // cubic centimeters
    Horses : Single; // CV
    Watts : Single; // Watts
    MaxRPM : Integer; // 14000

    Front : TBikeFrontBack;
    Back : TBikeFrontBack;
  end;

  TPilot=record
    Name : String; // Marc Màrquez

    Height,  // cm
    Weight : Single; // kg

    // Weights:
    RaceLeather,
    Helmet,
    Gloves,
    Boots,
    KneeSliders,
    ElbowSliders,
    BackProtector,
    Airbag : Single;

    TotalMass : Single; // Read-only, calculated

    // Parameters:
    // Breaking : 100%  (breaks very bad or very well)
    // Curve pass:   (fast inside curves?)
    // Start Reaction time: 0 .. 200 msec

    procedure CalcTotalMass;
  end;

  TTireData=record
  public
    Temperature : Single; // degree
    Pressure : Single;
  end;

  // Instant data
  TRiderData=record
  public
    Speed,    // meters/sec   0..400
    Acceleration,  // m/sqr(sec)  -2 .. 1.2 "g"
    Position : Single;  // meters from race start

    Gear : Integer; // 0..7

    // FrontTire : TTireData
    // BackTire : TTireData
    // FrontBreak : Single;  %
    // BackBreak : Single;   %
    // Throttle : Single; %
    // LeanAngle : Single; // 0..65 degree (or crash, or Lowside)

    procedure Init(const StartPosition:Single);
    procedure Step(const Prev:TRiderData);
  end;

  TAllRidersData=Array of TRiderData;

  // All riders at an instant
  TRaceData=record
    Time : Int64; // msec Ellapsed from race start
    Data : TAllRidersData; // all riders at a given exact time
  end;

  TRider=record
  public
    Active : Boolean;  // in race, not crashed or out or at pitbox

    Number : Integer; // 93 = MM

    Pole : Integer; // Position in the race pole

    Laps : Integer;  // how many laps this pilot

    Color : TColor;

    LapsTime : TArray<Integer>;  // When the rider crosses each lap finish, indexed to TRace.Data

    procedure Start(const TotalLaps:Integer);
  end;

  TAllRaceData=Array of TRaceData;

  TRace=record
  public
    Circuit : TCircuit;

    TotalLaps : Integer; // Race laps

    RiderEndsLap : TProc<Integer>;

    Current : Integer; // Current lap (of faster pilot)

    Ellapsed: TStopwatch;

    Data : TAllRaceData;

    Riders : Array of TRider;
  end;

var
  DefaultBike : TBike;
  DefaultPilot : TPilot;

implementation

// Formulas

{ Other factors:

   Motor power curve
   Gear relations
   Wheel radius
   Transmission efficiency 95%
   Wheelie effect
   Slip effect
   Weight transferences
   Traction controls
}


procedure TCircuit.FillCurves(const APositions: array of Single;
  const ANames: array of String; const Angles: array of Single);
var L,t : Integer;
begin
  Curves:=nil;

  L:=High(APositions);

  SetLength(Curves,L+1);

  for t:=0 to L do
  begin
    Curves[t].Position:=APositions[t];
    Curves[t].Name:=ANames[t];
    Curves[t].Angle:=Angles[t];
  end;
end;

{ TRider }

procedure TRider.Start(const TotalLaps:Integer);
var t : Integer;
begin
  Active:=True;
  Laps:=0;

  SetLength(LapsTime,TotalLaps);

  for t:=0 to High(LapsTime) do
      LapsTime[t]:=0;
end;

{ TRiderData }

procedure TRiderData.Init(const StartPosition:Single);
begin
  Speed:=0;
  Acceleration:=0.7+Random(30)*0.01;
  Position:=StartPosition; // Finish line - pole grid position in meters
end;

procedure TRiderData.Step(const Prev: TRiderData);
const G = 9.81; // Earth Gravity meters/sec2
      AirDensity=1.225; //  kg/m3
      CdAeroDynamic= 0.45; // * Front Area

      MotorTorque = 110; // Nm
      RGear = 5;
      RFinal = 3;

      TransmissionEficiency = 0.95; // %

var Thrust,
    ThrustTorque,
    TotalGrip,
    TotalMass,
    AirResistance,
    RollingFriction : Single;
begin
  ThrustTorque:=(MotorTorque*RGear*RFinal*TransmissionEficiency)/(0.5*DefaultBike.Back.Tire.Diameter*0.01);

  TotalMass:=DefaultBike.Weight+DefaultBike.Fuel+DefaultPilot.TotalMass;
  TotalGrip:= DefaultBike.Back.Tire.Grip * TotalMass * G;

  if Prev.Speed=0 then // Start time
  begin
    Thrust:=ThrustTorque;

    if TotalGrip<Thrust then
       Thrust:=TotalGrip;
  end
  else
  begin
    Thrust:=DefaultBike.Watts/Prev.Speed;

    if ThrustTorque<Thrust then
       Thrust:=ThrustTorque;

    if TotalGrip<Thrust then
       Thrust:=TotalGrip;
  end;

  AirResistance:=0.5 * AirDensity * CdAeroDynamic * Sqr(Prev.Speed);

  // TODO: Pacejka's Magic Formula o Magic Formula Tire Model
  RollingFriction:= DefaultBike.Back.Tire.Friction * TotalMass * G;

  Acceleration:=(Thrust - AirResistance - RollingFriction) / TotalMass;

  Speed:=Prev.Speed+Prev.Acceleration;
  Position:=Prev.Position+Speed;
end;

procedure InitDefaultBike;
begin
  DefaultBike.Weight:=160; // kg
  DefaultBike.Fuel:=20; // kg
  DefaultBike.FuelLiquid:=15; // liters
  DefaultBike.Horses:=250; // CV
  DefaultBike.Watts:=DefaultBike.Horses*735.5; // Watts
  DefaultBike.MaxRPM:=14000;

  DefaultBike.Back.Wheel:=17; // inch  x 2.54 = 43.18 cm
  DefaultBike.Back.Tire.Grip:=1.7;
  DefaultBike.Back.Tire.Diameter:=69; // cm
  DefaultBike.Back.Tire.Friction:=0.02; // coefficient

  DefaultBike.Front.Wheel:=17; // inch  x 2.54 = 43.18 cm
  DefaultBike.Front.Tire.Grip:=1.7;
  DefaultBike.Front.Tire.Diameter:=60; // cm
  DefaultBike.Front.Tire.Friction:=0.02; // coefficient

  // Clutch
end;

procedure InitDefaultPilot;
begin
  DefaultPilot.Name:='Marc Màrquez';
  DefaultPilot.Height:=1.69;
  DefaultPilot.Weight:=64;  // Kg

  DefaultPilot.RaceLeather:=5.0; // Kg
  DefaultPilot.Helmet:=1.4; // Kg
  DefaultPilot.Gloves:=0.4; // Kg
  DefaultPilot.Boots:=1.7; // Kg
  DefaultPilot.KneeSliders:=0.2; // Kg
  DefaultPilot.ElbowSliders:=0.2; // Kg
  DefaultPilot.BackProtector:=0.6; // Kg
  DefaultPilot.Airbag:=2.2; // Kg

  DefaultPilot.CalcTotalMass;
end;

{ TPilot }

procedure TPilot.CalcTotalMass;
begin
  TotalMass:=

    Weight+
    RaceLeather+
    Helmet+
    Gloves+
    Boots+
    KneeSliders+
    ElbowSliders+
    BackProtector+
    Airbag;
end;

initialization
  InitDefaultBike;
  InitDefaultPilot;
end.
