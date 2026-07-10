{
  @davidberneda

  https://github.com/Steema/MotoGP

}
unit TeeRacing;

interface

uses
  Windows, SysUtils, Types, TeCanvas;

const
  RealTimeFactor = 0.1; // 5 times per second (no realtime)

type
  TWeatherStyle=(wsDry, wsWet, wsRain);

  TWeather=record
  public
    AirTemperature : Single; // C
    TrackTemperature : Single; // C
    Humidity : Single; // %
    Style : TWeatherStyle; // wsDry

    Wind : Single; // km/h
    WindDirection : Single; // 0..360 Degree 0=North, 90=East, 180=South, 270=West

    AirDensity: Single; // Pending to calculate = 1.225; //  kg/m3

    procedure Init;
    procedure CalculateAirDensity(const AElevationMeters: Single);
  end;

  // Curves (Corners) of a circuit path
  TCurve=record
    Position : Single; // Entry position of this curve, (in meters from start, might not be from Finish line)
    Name : String;
    Angle : Single;  // -180..0..+180  (left or right curve)
    EntrySpeed : Single; // km/h safe entry speed, with Dry Track and not super-hot asphalt

    ApexPosition : Single; // Position of Apex in meters
    Slope : Single; // In degrees, from last curve
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

  //TPointFloatArray=Array of TPointFloat;

  TCircuit=record
  public
    Curves : Array of TCurve;

    Points : TPointFloatArray; // Closed path of XY points

    Radius : Array of Single; // Radius in meters at each point of the circuit

    TotalLength : Single; // Total length of circuit

    PolePosition : Single; // Offset Meters only to draw pilots at the Circuit path
    PolePositionIndex : Integer; // Index of Pole position point in circuit path

    Elevation : Single; // Sea level meters

    function IndexOfPosition(const APosition:Single):Integer; // Index of Points, rounded to near APosition
    function PointPosition(const APosition:Single):TPoint;

    procedure CalculateRadius;
  end;

  TBikeFrontBack=record
  public
    Wheel : Single; // Inches diameter
    Tire : TTire;
    BrakeForce : Single; // m/s²   3 .. 19.0 front,   3 .. 12.5 back
  end;

  TGearRatios=Array of Single; // Ratio for every Gear, 0=Neutral

  TTorqueAtRPM=record
  public
    RPM : Integer;
    Nm : Single;
  end;

  TTorqueCurve=Array of TTorqueAtRPM;

  TBike=record
    Code,
    Factory : String;

    Weight : Single; // kg

    Fuel : Single; // kg

    Horses : Single; // CV
    Watts : Single; // Watts

    MaxRPM : Integer; // 18000
    IdleRPM : Integer; // 4000
    GearUpRPM : Integer; // 17200
    GearDownRPM : Integer; // 11000

    Torque : TTorqueCurve;
    MaxTorqueNm : Single; //  Nm  (maximum at peak of curve)

    PrimaryRatio : Single; // 1.65
    FinalDrive : Single; // 3.28  =   46/14  Rear/Front Sprocket Teeth

    MaxGear : Integer; // 7
    GearRatios : TGearRatios;

    Front : TBikeFrontBack;
    Back : TBikeFrontBack;

    TransmissionEfficiency: Single; // = 95; // %

    Wheelbase : Integer; // mm  distance between axes   1420..1460
    // CenterOfMassHeight : Integer; // mm distance from track to center of gravity

    EngineLayout : String; // V4 V2 I4 I2 Single

    WeightDistributionFront : Single; // %    ie: 52% Front (48% Back)

    CdAeroDynamic : Single; // 0.3 .. 0.7 coefficient

    AerodynamicDownforce : Single; // DragCoefficient

    // WheelieWingEfficiency : Single;

    FrontArea : Single; // 0.5 m²

    //MaxBrakeDeceleration : Single; // 15 .. 18 m/s²

    MaxLeanAngle : Single; // Degrees 64°

    HasHoleshotDevice : Boolean;

    function FuelLiquid : Single; // in cubic centimeters

    class function DefaultGearRatios:TGearRatios; static;
    class function DefaultTorqueCurve:TTorqueCurve; static;
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

    SweatLoss : Single; // Grams, Starts at Zero

    // Parameters:
    // Braking : 0..100%  (brakes very soon or too late?)
    // Curve pass:   (fast inside curves?)
    // Start Reaction time: 0 .. 200 msec

    procedure CalcTotalMass;
  end;

  TTireData=record
  public
    Temperature : Single; // degree °C
    Pressure : Single;
  end;

  // Instant data
  TRiderData=record
  public
    RPM : Integer;

    Clutch : Boolean; // from 0 to 1

    Speed,    // meters/sec   0..140  (0..400 km/h)
    Acceleration,  // -20 .. 20  m/s² (in G: -2 .. 1.2 "g")
    Position : Single;  // meters from race start

    Gear : Integer; // 0..7

    Throttle : Single; // 0..100% gas

    // FrontTire : TTireData
    // BackTire : TTireData

    FrontBrake : Single; // 0..100 %
    BackBrake : Single;  // 0..100 %

    LeanAngle : Single; // 0..65° degree (or crash, or Lowside)

    procedure Init(const AStartPosition:Single);

    procedure Step(const TimeFactor:Single; // 0.1 = 10 times per second
                   var Bike:TBike;
                   var Pilot:TPilot;
                   const Prev:TRiderData);

    procedure StandUp;
    procedure TrailBrake(const ApexPosition:Single);
  end;

  TAllRidersData=TArray<TRiderData>;

  // All riders at an instant
  TRaceData=record
    Time : Int64; // msec Ellapsed from race start
    Data : TAllRidersData; // all riders at a given exact time
  end;

  TColor=UInt32;

  TRider=record
  public
    Active : Boolean;  // in race, not crashed or out or at pitbox

    Number : Integer; // 93 = MM

    Pole : Integer; // Position in the race pole

    Laps : Integer;  // how many laps this pilot

    BestLap : Integer; // Lap number (starting at 1) with best time

    Color : TColor;

    NextCurve : Integer; // The number of the most closer curve (corner)

    Bike : TBike;
    Pilot : TPilot;

    Ellapsed : TArray<Int64>; // Milliseconds of each finished lap
    LapsTime : TArray<Integer>;  // When the rider crosses each lap finish, indexed to TRace.Data

    procedure GoToNextCurve(const ATotalCurves:Integer);
    procedure Start(const TotalLaps:Integer);
  end;

  TAllRaceData=TArray<TRaceData>;

  TRace=record
  public
    Circuit : TCircuit;

    TotalLaps : Integer; // Race laps

    RiderEndsLap : TProc<Integer,Integer>; // Rider,Lap

    Fastest : Integer; // Index of Rider that has the Fastest Lap in this Race
    FastestTime : Int64; // Time of the best lap of Fastest rider

    Current : Integer; // Current lap (of 1st pilot)

    Ellapsed: Int64; // Milliseconds from Race Start

    Weather : TWeather;

    PoleDistance : Single; // Distance in meters between each rider at starting grid

    Data : TAllRaceData;

    Riders : Array of TRider;

    procedure Init;
  end;

var
  DefaultPilot : TPilot;
  DefaultWeather : TWeather;

type
  TBrakeDecision = record
    NeedsToBrake: Boolean;
    DistanceToBrakePoint: Single;  // Meters to start braking
    BrakingDistanceNeeded: Single; // Meters needed to brake until corner's entry position
  end;

function EvaluateBrakingPoint(const ABikePosition, ABikeSpeedMPS: Single;
                              const ACorner: TCurve;
                              const AMaxDecelerationMPS2: Single): TBrakeDecision;

// Returns True is the bike has a LowSide
function CheckSlidOut(
  const Speed: Single; // En m/s
  const Radius: Single;     // En metres
  const TotalMass: Single;    // Moto + Pilot kg (ex: 250.0)
  const TireTemp: Single; // Connectat amb el mòdul anterior (°C)
  const DryOrWet: Single;
  const Bike:TBike): Boolean;  // Multiplier Factor (1.0 = Dry, 0.5 = Wet)

type
  TTurnPhase = (tpApproach, tpBraking, tpCornering, tpAcceleration);

function DetermineTrackPhase(const BikePosition:Single;
                             const ACorner:TCurve;
                             const ABrakeTriggerPosition:Single): TTurnPhase;

// Percent of Throttle depending on Lean Angle in degrees
function CalculateThrottle(const ALeanAngle,MaxAngle:Single):Single;

function CalcLeanAngle(const APoints: TPointFloatArray; Current: Integer; const Speed:Single): Single;

implementation

uses
  Math;

{ Other factors:

   Gear relations
   Wheelie effect
   Slip effect
   Weight transferences
   Traction controls
}


{ TCircuit }

procedure TCircuit.CalculateRadius;
var
  t, N: Integer;
  A, B, C: TPointFloat;
  a_len, b_len, c_len: Single;
  Area2: Single;
begin
  N := Length(Points);
  SetLength(Radius, N);

  if N < 3 then
  begin
    for t := 0 to N - 1 do Radius[t] := 0;
    Exit;
  end;

  for t := 0 to N - 1 do
  begin
    // 1. Obtain 3 points (current, previous and next)
    A := Points[(t - 1 + N) mod N];
    B := Points[t];
    C := Points[(t + 1) mod N];

    // 2. Calc triangle side lengths
    a_len := Sqrt(Sqr(B.X - A.X) + Sqr(B.Y - A.Y)); // A-B
    b_len := Sqrt(Sqr(C.X - B.X) + Sqr(C.Y - B.Y)); // B-C
    c_len := Sqrt(Sqr(A.X - C.X) + Sqr(A.Y - C.Y)); // C-A

    // 3. Calc Area*2 (cross-product)
    Area2 := Abs((B.X - A.X) * (C.Y - A.Y) - (B.Y - A.Y) * (C.X - A.X));

    // 4. Calc radious, if Area is close to zero, it means we are on a straight line
    if Area2 < 0.00001 then
       Radius[t] := 0
    else
       // R = (a * b * c) / (4 * Area)
       Radius[t] := (a_len * b_len * c_len) / (2.0 * Area2);
  end;
end;

function TCircuit.IndexOfPosition(const APosition: Single): Integer;
var L : Integer;
begin
  L:=Length(Points);

  result:=Round(APosition*(1+L)/TotalLength) mod L;
end;

function TCircuit.PointPosition(const APosition:Single):TPoint;
var tmpPos : Integer;
begin
  tmpPos:=IndexOfPosition(APosition);
  result.X:=Round(Points[tmpPos].X);
  result.Y:=Round(Points[tmpPos].Y);
end;

{ TRider }

// Next Curve
procedure TRider.GoToNextCurve(const ATotalCurves: Integer);
begin
  if NextCurve=ATotalCurves then
     NextCurve:=1
  else
     Inc(NextCurve);
end;

procedure TRider.Start(const TotalLaps:Integer);
var t : Integer;
begin
  Active:=True;
  Laps:=0;

  BestLap:=0;

  SetLength(LapsTime,TotalLaps);

  for t:=0 to High(LapsTime) do
      LapsTime[t]:=0;

  SetLength(Ellapsed,TotalLaps);

  for t:=0 to High(Ellapsed) do
      Ellapsed[t]:=0;

  NextCurve:=1; // At Start

  Pilot:=DefaultPilot;

  Pilot.SweatLoss:=0;
end;

function TorqueAtRPM(const Curve:TTorqueCurve; const RPM: Integer): Single;
var
  t: Integer;
  Len: Integer;
  P1, P2: TTorqueAtRPM;
  Fraction: Single;
begin
  Len := Length(Curve);

  // 1. Edge Case: Empty array
  if Len = 0 then
    Exit(0.0);

  // 2. Edge Case: Only one data point available
  if Len = 1 then
    Exit(Curve[0].Nm);

  // 3. Boundary Case: Target is below or equal to the lowest RPM
  if RPM <= Curve[0].RPM then
    Exit(Curve[0].Nm);

  // 4. Boundary Case: Target is above or equal to the highest RPM
  if RPM >= Curve[Len - 1].RPM then
    Exit(Curve[Len - 1].Nm);

  // 5. Find the bounding points
  for t := 0 to Len - 2 do
  begin
    if (RPM >= Curve[t].RPM) and (RPM <= Curve[t + 1].RPM) then
    begin
      P1 := Curve[t];
      P2 := Curve[t + 1];

      // Prevent division by zero if two identical RPM points exist
      if P2.RPM = P1.RPM then
        Exit(P1.Nm);

      // Calculate how far along the target is between P1 and P2 (0.0 to 1.0)
      Fraction := (RPM - P1.RPM) / (P2.RPM - P1.RPM);

      // Calculate the interpolated Nm
      Exit(P1.Nm + Fraction * (P2.Nm - P1.Nm));
    end;
  end;

  // Fallback default
  Result := 0.0;
end;

{ TRiderData }

procedure TRiderData.Init(const AStartPosition:Single);
begin
  Throttle:=100; // Full Throttle

  RPM:=14000; // Bike.MaxRPM?  // Throttle max

  Clutch:=True;  // Ready to start

  Gear:=1;

  Speed:=0;

  FrontBrake:=0;
  BackBrake:=0;

  Position:=AStartPosition; // Finish line - pole grid position in meters
end;

const
  // Average BSFC for a high-performance racing engine at high load
  // ~235 grams of fuel per kilowatt-hour
  BSFC_BASE = 235.0;
  FUEL_DENSITY_RACING = 0.750; // Racing fuel density is roughly 0.75 kg/L (750 g/L)  g/cm³ (or g/mL)

// LitersPerHour := (GramsPerSecond * 3600.0) / (FUEL_DENSITY_RACING * 1000.0);

// Returns Grams per Second
function CalculateInstantFuelConsumption(const TorqueNm: Single;
                                         const EngineRPM: Integer;
                                         const ThrottlePercent: Single): Single;
var
  vPowerKW: Single;
  vCurrentBSFC: Single;
begin
  // Adjust BSFC based on throttle. Engines are less efficient at partial throttle
  // If throttle is closed but RPM is high (engine braking), consumption is near zero.
  if ThrottlePercent < 1.0 then
  begin
    Result := 0.02 * (EngineRPM / 15000.0); // Tiny fuel flow to maintain idle/lubrication
    Exit;
  end;

  // Convert Torque (Nm) and RPM to Kilowatts (kW)
  // Constant 9549.2965 comes from (60 * 1000) / (2 * Pi)
  vPowerKW := (TorqueNm * EngineRPM) / 9549.2965;

  // Guard against negative power calculation just in case
  if vPowerKW < 0 then vPowerKW := 0;

  // Efficiency correction curve approximation
  vCurrentBSFC := BSFC_BASE * (1.0 + (1.0 - (ThrottlePercent / 100.0)) * 0.3);

  // 3. Calculate consumption in Grams per Second
  // Formula: (kW * BSFC) / 3600 seconds in an hour
  Result := (vPowerKW * vCurrentBSFC) / 3600.0;
end;

procedure TRiderData.StandUp;
var Step : Single;
begin
  if LeanAngle>0 then
  begin
    // 5% of current LeanAngle // TODO: Depends on speed, pilot etc
    Step:=5*LeanAngle*0.01;

    LeanAngle := LeanAngle - Step;

    if LeanAngle < 0 then
       LeanAngle := 0;
  end;
end;

procedure TRiderData.Step(const TimeFactor:Single; var Bike:TBike; var Pilot:TPilot; const Prev: TRiderData);

{
  // Clutch phase, calculate two rpm, the wheel and the engine
  WheelRPM := Bike.Back.Wheel.AngularVelocity * RGear * RFinal * AltresFactors;

  if WheelRPM < 2500 then
  begin
    EngineRPM := EngineRPM + (Throttle * 150.0) - 20.0;

    if (EngineRPM < 1200) then EngineRPM := 1200;
    if (EngineRPM > 5000) then EngineRPM := 5000;
  end
  else
  begin
    EngineRPM := RodaRPM;
  end;
}

const
  InchToCm = 2.54;

  function CalcRPM:Integer;
  var RadPerSec : Single;
  begin
    RadPerSec:=Prev.Speed/(Bike.Back.Wheel * InchToCm * 0.5 * 0.01);
    result:=Round( (RadPerSec / (2 * Pi)) * 60 * Bike.GearRatios[Gear] * Bike.FinalDrive * Bike.PrimaryRatio);
  end;

const G = 9.81; // Earth Gravity meters/sec2
      BodyPosition=0.5; // 0..1  1=Standing, 0=Fully Crouched, 0.5=Normal
      SweatRate=3000/3600; // Grams per second.   3Kg per hour

var Thrust,  // Nm
    ThrustTorque, // Nm
    TotalGrip,
    TotalMass, // Kg
    TotalBrakingForce,
    AirResistance,
    MotorTorque, // Nm
    PilotBodyFactor, // coefficient
    RollingFriction : Single;
begin
  RPM:=Prev.RPM;

  Gear:=Prev.Gear;

  LeanAngle:=Prev.LeanAngle;

  //if RPM>=Bike.IdleRPM then
  begin
    if Prev.Clutch then
    begin
      Clutch:=Prev.Speed<10; // Tricky, keep Clutch until speed is >10m/sec

      // TODO: Clutch from 0 to 100% during start, first 1.5 seconds

      RPM:=Bike.GearUpRPM;
    end
    else
    begin
      RPM:=CalcRPM;

      if (RPM>=Bike.GearUpRPM) and (Gear<Bike.MaxGear) then
      begin
        Inc(Gear);
        RPM:=CalcRPM;
      end
      else
      if (RPM<=Bike.GearDownRPM) and (Gear>1) then
      begin
        if Prev.Speed>1 then
        begin
          Dec(Gear);
          RPM:=CalcRPM;
        end;
      end;
    end;

    MotorTorque:=TorqueAtRPM(Bike.Torque,RPM);
    ThrustTorque:=(MotorTorque * Bike.PrimaryRatio * Bike.GearRatios[Gear] * Bike.FinalDrive * 0.01 * Bike.TransmissionEfficiency)/(0.5*Bike.Back.Tire.Diameter*0.01);
  end
  {
  else
  begin
    MotorTorque:=0;
    ThrustTorque:=0;
  end};

  Pilot.SweatLoss:=Pilot.SweatLoss+TimeFactor*SweatRate;

  TotalMass:=Bike.Weight+Bike.Fuel+Pilot.TotalMass-Pilot.SweatLoss;
  TotalGrip:= Bike.Back.Tire.Grip * TotalMass * G;

  if Prev.Speed=0 then // Start time
  begin
    Thrust:=ThrustTorque;

    if TotalGrip<Thrust then
       Thrust:=TotalGrip;
  end
  else
  begin
    Thrust:=Bike.Watts/Prev.Speed;

    if ThrustTorque<Thrust then
       Thrust:=ThrustTorque;

    if TotalGrip<Thrust then
       Thrust:=TotalGrip;
  end;

  // TODO Body Position: Hanging Off, Lean Angle, Knee Down, Elbow Down, Leg Dangle

  PilotBodyFactor:=(1 + 0.0025 * (Pilot.Height - 175)) * (0.85 + 0.3* BodyPosition);

  AirResistance:=0.5 * DefaultWeather.AirDensity * Bike.CdAeroDynamic * Bike.FrontArea * PilotBodyFactor * Sqr(Prev.Speed);

  // TODO: Apply wind and wind-direction to AirResistance, SideResistance

  // TODO: Pacejka's Magic Formula o Magic Formula Tire Model
  RollingFriction:= Bike.Back.Tire.Friction * TotalMass * G;  // TODO slope positive or negative: * Sin(Slope)

  // TODO: Tire degradation (weight loss, grip)

  // Brembo carbon brake disks 355 mm diameter

  FrontBrake:=Prev.FrontBrake;
  BackBrake:=Prev.BackBrake;

  // Newtons
  if (FrontBrake>0) or (BackBrake>0) then
     TotalBrakingForce:=TotalMass * ((Bike.Front.BrakeForce*FrontBrake*0.01)+(Bike.Back.BrakeForce*BackBrake*0.01))
  else
     TotalBrakingForce:=0;

  if TotalBrakingForce>0 then
     Acceleration:= -(TotalBrakingForce + AirResistance + RollingFriction) / TotalMass
  else
     Acceleration:=(Thrust - AirResistance - RollingFriction) / TotalMass;

  Speed:=Prev.Speed+Acceleration*TimeFactor;

  if Speed<0 then
     Speed:=0; // Brake to stop

  Position:=Prev.Position+Speed*TimeFactor;

  Throttle:=Prev.Throttle;

  // Fuel
  Bike.Fuel:=Bike.Fuel-0.001*CalculateInstantFuelConsumption(MotorTorque,RPM,Throttle)*TimeFactor;

  if Bike.Fuel<=0 then
  begin
    RPM:=Bike.IdleRPM; // Force stop
    Throttle:=0;
    Gear:=0;
  end;
end;

procedure TRiderData.TrailBrake(const ApexPosition: Single);
begin
  FrontBrake:=FrontBrake-(ApexPosition-Position)*0.01;  // TODO: Calc dynamic target distance based on speed

  if FrontBrake < 0 then
     FrontBrake := 0;

  BackBrake:=BackBrake-(ApexPosition-Position)*0.01;

  if BackBrake < 0 then
     BackBrake := 0;
end;

{ TBike }

class function TBike.DefaultTorqueCurve:TTorqueCurve;
begin
  SetLength(result,6);

  result[0].RPM:= 5000; result[0].Nm:= 70;
  result[1].RPM:= 8000; result[1].Nm:= 95;
  result[2].RPM:=11000; result[2].Nm:=115;
  result[3].RPM:=14000; result[3].Nm:=110;
  result[4].RPM:=17000; result[4].Nm:=100;
  result[5].RPM:=18000; result[5].Nm:= 90;
end;

class function TBike.DefaultGearRatios:TGearRatios;
begin
  SetLength(result,7);  // 6 Gears + Neutral

  result[0]:=0;  // Neutral
  result[1]:=2.6;
  result[2]:=2.1;
  result[3]:=1.75;
  result[4]:=1.5;
  result[5]:=1.32;
  result[6]:=1.18;
end;

procedure InitDefaultPilot;
begin
  DefaultPilot.Name:='Mr. Dummy';
  DefaultPilot.Height:=1.69; // cm
  DefaultPilot.Weight:=64;  // kg

  DefaultPilot.RaceLeather:=5.0; // kg
  DefaultPilot.Helmet:=1.4; // kg
  DefaultPilot.Gloves:=0.4; // kg
  DefaultPilot.Boots:=1.7; // kg
  DefaultPilot.KneeSliders:=0.2; // kg
  DefaultPilot.ElbowSliders:=0.2; // kg
  DefaultPilot.BackProtector:=0.6; // kg
  DefaultPilot.Airbag:=2.2; // kg

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

/// <summary>
/// Calculates the exact air density (kg/m³) taking into account elevation,
/// relative humidity, and ambient air temperature.
/// </summary>
/// <param name="AElevationMeters">Elevation above sea level in meters (m)</param>
/// <param name="AHumidityPercent">Relative humidity as a percentage (0 to 100)</param>
/// <param name="ATemperatureCelsius">Air temperature in degrees Celsius (°C)</param>
/// <returns>Air density in kg/m³</returns>
function DoCalculateAirDensity(const AElevationMeters, AHumidityPercent, ATemperatureCelsius: Single): Single;
const
  // International Standard Atmosphere (ISA) Constants
  P0 = 101325.0;          // Standard sea-level atmospheric pressure in Pascals (Pa)
  T0 = 288.15;            // Standard sea-level temperature in Kelvin (K)
  G = 9.80665;            // Acceleration due to gravity (m/s²)
  L = 0.0065;             // Standard temperature lapse rate (K/m)
  R_DRY = 287.058;        // Specific gas constant for dry air (J/kg·K)
  R_VAPOR = 461.495;      // Specific gas constant for water vapor (J/kg·K)
  M_AIR = 0.0289644;      // Molar mass of dry air (kg/mol)
  R_UNIVERSAL = 8.31447;  // Universal gas constant (J/mol·K)
var
  vTemperatureKelvin: Single;
  vTotalPressure: Single;
  vSaturationPressure: Single;
  vVaporPressure: Single;
  vDryAirPressure: Single;
  vDryAirDensity: Single;
  vWaterVaporDensity: Single;
begin
  // 1. Convert temperature to Kelvin
  vTemperatureKelvin := ATemperatureCelsius + 273.15;

  // 2. Calculate local barometric pressure (Pa) based on elevation using the barometric formula
  // Note: 'Power' requires System.Math in the uses clause
  vTotalPressure := P0 * Power(1.0 - (L * AElevationMeters) / T0, (G * M_AIR) / (R_UNIVERSAL * L));

  // 3. Calculate saturation water vapor pressure (Pa) using Tetens' Equation
  vSaturationPressure := 610.78 * Power(10, (7.5 * ATemperatureCelsius) / (ATemperatureCelsius + 237.3));

  // 4. Calculate actual partial pressure of water vapor based on relative humidity
  vVaporPressure := vSaturationPressure * (AHumidityPercent / 100.0);

  // 5. Calculate partial pressure of dry air
  vDryAirPressure := vTotalPressure - vVaporPressure;

  // 6. Apply the ideal gas law to find the density of both components
  vDryAirDensity := vDryAirPressure / (R_DRY * vTemperatureKelvin);
  vWaterVaporDensity := vVaporPressure / (R_VAPOR * vTemperatureKelvin);

  // 7. Return the combined density of the moist air (kg/m³)
  Result := vDryAirDensity + vWaterVaporDensity;
end;

{ TWeather }

procedure TWeather.CalculateAirDensity(const AElevationMeters: Single);
begin
  AirDensity:=DoCalculateAirDensity(AElevationMeters,Humidity,AirTemperature);
end;

procedure TWeather.Init;
begin
  Style:=TWeatherStyle.wsDry;
  AirTemperature:=24.5;
  TrackTemperature:=40;
  Humidity:=50;

  // No wind
  Wind:=0;
  WindDirection:=0;

  AirDensity:=1.225; // kg/m3
end;

function DetermineTrackPhase(const BikePosition:Single; const ACorner:TCurve; const ABrakeTriggerPosition:Single): TTurnPhase;
begin
  // On or past Apex?
  if BikePosition >= ACorner.ApexPosition then
     Result := tpAcceleration
  else
  if BikePosition >= ACorner.Position then
     Result := tpCornering // Still passing curve
  else
  if BikePosition >= ABrakeTriggerPosition then
     Result := tpBraking // Still braking
  else
     Result := tpApproach; // Full speed
end;

function EvaluateBrakingPoint(const ABikePosition, ABikeSpeedMPS: Single;
                              const ACorner: TCurve;
                              const AMaxDecelerationMPS2: Single): TBrakeDecision;
var
  BrakingTriggerPosition: Single;
begin
  // If the bike is already going slower than the corner target speed, no need to brake yet
  if ABikeSpeedMPS <= ACorner.EntrySpeed/3.6 then
  begin
    Result.NeedsToBrake := False;
    Result.DistanceToBrakePoint := ACorner.Position - ABikePosition;
    Result.BrakingDistanceNeeded := 0.0;
    Exit;
  end;

  // 1. Calculate how many meters are required to slow down to the target speed
  // Formula: d = (V_actual² - V_target²) / (2 * a)
  Result.BrakingDistanceNeeded := (Sqr(ABikeSpeedMPS) - Sqr(ACorner.EntrySpeed/3.6)) / (2.0 * AMaxDecelerationMPS2);

  // 2. Determine the exact track coordinate where braking MUST start
  BrakingTriggerPosition := ACorner.Position - Result.BrakingDistanceNeeded;

  // 3. Compare with current bike position
  if ABikePosition >= BrakingTriggerPosition then
  begin
    // The bike has reached or passed the limit! Must brake immediately.
    Result.NeedsToBrake := True;
    Result.DistanceToBrakePoint := 0;
  end
  else
  begin
    // Still safe, returning how many meters are left before the braking zone
    Result.NeedsToBrake := False;
    Result.DistanceToBrakePoint := BrakingTriggerPosition - ABikePosition;
  end;
end;

{ TBike }

function TBike.FuelLiquid: Single; // cm³
begin
  result:=Fuel/FUEL_DENSITY_RACING; // From Grams to Cubic Centimeters
end;

// Percent of Throttle depending on Lean Angle in degrees
function CalculateThrottle(const ALeanAngle,MaxAngle:Single):Single;
begin
  Result := 100.0 * (1.0 - (ALeanAngle / MaxAngle));

  // At least 10% throttle
  if Result < 10.0 then
     Result := 10.0;
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

  if Result > MaxLean then
     Result := MaxLean
  else
  if Result < -MaxLean then
     Result := -MaxLean;
end;

{ TRace }

procedure TRace.Init;
var t : Integer;
begin
  PoleDistance:=3; // 3 meters
  Fastest:=-1;
  FastestTime:=0;

  SetLength(Data,1);
  SetLength(Data[0].Data,Length(Riders));

  for t:=0 to High(Riders) do
      Data[0].Data[t].Init(-Riders[t].Pole*PoleDistance);
end;

// Returns True is the bike has a LowSide
function CheckSlidOut(
  const Speed: Single; // En m/s
  const Radius: Single;     // En metres
  const TotalMass: Single;    // Moto + Pilot kg (ex: 250.0)
  const TireTemp: Single; // Connectat amb el mòdul anterior (°C)
  const DryOrWet: Single;
  const Bike:TBike): Boolean;  // Multiplier Factor (1.0 = Dry, 0.5 = Wet)
const
  G = 9.81; // Gravetat (m/s²)
var
  Centrifugal: Single;
  Vertical: Single;
  MuActual: Double;
  MaxAdherence: Single;
  NeedsLeanAngle: Single;
const
  ANGLE_LIMIT_MOTO = 64.0; // Límit físic d'inclinació en MotoGP (graus)
begin
  Result := False; // No crash, no slidout

  // Avoid divide by zero errors when on a straight line
  if Radius > 9999.0 then Exit;

  if Speed < 5.0 then Exit; // Can't slidout at low speed

  // Calc Grip coefficient based on tire temperature (ok between 80°C .. 110°C)
  if (TireTemp >= 80.0) and (TireTemp <= 110.0) then
     MuActual := 1.5 // Max dry Grip
  else
  if TireTemp < 50.0 then
     MuActual := 0.9 // Cold tire, few grip
  else
  if TireTemp > 130.0 then
     MuActual := 1.1 // Hot tire, bad grip
  else
     MuActual := 1.2; // Medium range

  // Apply track status penalty
  MuActual := MuActual * DryOrWet;

  // Calc dynamic forces
  Vertical := TotalMass * G;
  Centrifugal := (TotalMass * Sqr(Speed)) / Radius;

  // Max force to tires, before slidout
  MaxAdherence := Vertical * MuActual;

  // Lateral force is bigger
  if Centrifugal > MaxAdherence then
     Result := True
  else
  begin
    // Calc theoric lean angle for current radius and speed
    NeedsLeanAngle := RadToDeg(ArcTan(Sqr(Speed) / (Radius * G)));

    if NeedsLeanAngle > Bike.MaxLeanAngle then
       Result := True;
  end;
end;

initialization
  InitDefaultPilot;
  DefaultWeather.Init;
end.
