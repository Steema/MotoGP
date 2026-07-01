{
  @davidberneda
}
unit TeeRacing;

interface

uses
  SysUtils, Types, Graphics, TeCanvas, Diagnostics;

type
  TWeatherStyle=(wsDry, wsWet, wsRain);

  TWeather=record
  public
    AirTemperature : Single; // C
    TrackTemperature : Single; // C
    Humidity : Single; // %
    Style : TWeatherStyle; // wsDry

    AirDensity: Single; // Pending to calculate = 1.225; //  kg/m3

    procedure Init;
    procedure CalculateAirDensity(const AElevationMeters: Single);
  end;

  // Curves (Corners) of a circuit path
  TCurve=record
    Position : Single;  // meters from start (might not be from Finish line)
    Name : String;
    Angle : Single;  // -180..0..+180  (left or right curve)
    EntrySpeed : Single; // km/h safe entry speed, with Dry Track and not super-hot asphalt
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

    Points : TPointFloatArray; // Closed path of XY points

    TotalLength : Single; // Total length of circuit

    PolePosition : Single; // Meters from Finish to Start
    PolePositionIndex : Integer; // Index of Pole position point in circuit path

    Elevation : Single; // Sea level meters

    procedure FillCurves(
       const APositions:Array of Single;
       const ANames:Array of String;
       const Angles:Array of Single;
       const EntrySpeeds: array of Single);

    function IndexOfPosition(const APosition:Single):Integer; // Index of Points, rounded to near APosition
    function PointPosition(const APosition:Single):TPoint;
  end;

  TBikeFrontBack=record
  public
    Wheel : Single; // Inches diameter
    Tire : TTire;
  end;

  TGearRatios=Array of Single; // Ratio for every Gear, 0=Neutral

  TTorqueAtRPM=record
  public
    RPM : Integer;
    Nm : Single;
  end;

  TTorqueCurve=Array of TTorqueAtRPM;

  TBike=record
    Weight : Single; // kg
    Fuel : Single; // kg
    FuelLiquid : Single; // cubic centimeters

    Horses : Single; // CV
    Watts : Single; // Watts
    MaxRPM : Integer; // 14000

    Torque : TTorqueCurve;
    GearRatios : TGearRatios;

    Front : TBikeFrontBack;
    Back : TBikeFrontBack;

    TransmissionEficiency: Single; // = 95; // %
    CdAeroDynamic : Single; // 0.3 .. 0.7 coefficient
    FrontArea : Single; // 0.5 m²

    MaxBreakDecelaration : Single; // 15 .. 18 m/s²
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
    // Breaking : 0..100%  (breaks very soon or too late?)
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
    RPM : Integer;

    Clutch : Single; // from 0 to 1

    Speed,    // meters/sec   0..140  (0..400 km/h)
    Acceleration,  // -20 .. 20  m/s² (in G: -2 .. 1.2 "g")
    Position : Single;  // meters from race start

    Gear : Integer; // 0..7

    Throttle : Single; // 0..100% gas

    // FrontTire : TTireData
    // BackTire : TTireData
    // FrontBreak : Single;  %
    // BackBreak : Single;   %
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

    BestLap : Integer; // Lap number (starting at 1) with best time

    Color : TColor;

    Ellapsed : TArray<Int64>; // Milliseconds of each finished lap
    LapsTime : TArray<Integer>;  // When the rider crosses each lap finish, indexed to TRace.Data

    procedure Start(const TotalLaps:Integer);
  end;

  TAllRaceData=Array of TRaceData;

  TRace=record
  public
    Circuit : TCircuit;

    TotalLaps : Integer; // Race laps

    RiderEndsLap : TProc<Integer,Integer>; // Rider,Lap

    Current : Integer; // Current lap (of faster pilot)

    Ellapsed: TStopwatch;

    Weather : TWeather;

    Data : TAllRaceData;

    Riders : Array of TRider;
  end;

var
  DefaultBike : TBike;
  DefaultPilot : TPilot;
  DefaultWeather : TWeather;

type
  TBrakeDecision = record
    NeedsToBrake: Boolean;
    DistanceToBrakePoint: Double; // Metres que falten per haver de frenar (si és > 0)
    BrakingDistanceNeeded: Double;// Metres totals que necessitarà per frenar
  end;

function EvaluateBrakingPoint(const ABikePosition, ABikeSpeedMPS: Double;
                              const ACorner: TCurve;
                              const AMaxDecelerationMPS2: Double): TBrakeDecision;

implementation

uses
  Math;

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


{ TCircuit }

procedure TCircuit.FillCurves(const APositions: array of Single;
                              const ANames: array of String;
                              const Angles: array of Single;
                              const EntrySpeeds: array of Single);
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
    Curves[t].EntrySpeed:=EntrySpeeds[t];
  end;
end;

{ TCircuit }

function TCircuit.IndexOfPosition(const APosition: Single): Integer;
var L : Integer;
begin
  L:=Length(Points);

  result:=(PolePositionIndex+Round(APosition*(1+L)/TotalLength)) mod L;
end;

function TCircuit.PointPosition(const APosition:Single):TPoint;
var tmpPos : Integer;
begin
  tmpPos:=IndexOfPosition(APosition);
  result.X:=Round(Points[tmpPos].X);
  result.Y:=Round(Points[tmpPos].Y);
end;

{ TRider }

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

procedure TRiderData.Init(const StartPosition:Single);
begin
  RPM:=14000;   // Throttle max

  Clutch:=1;  //

  Speed:=0;

  Acceleration:=0.7+Random(30)*0.01;
  Position:=StartPosition; // Finish line - pole grid position in meters
end;


procedure TRiderData.Step(const Prev: TRiderData);
const G = 9.81; // Earth Gravity meters/sec2
      RGear = 5;
      RFinal = 3;

var Thrust,
    ThrustTorque,
    TotalGrip,
    TotalMass,
    AirResistance,
    MotorTorque, // Nm
    RollingFriction : Single;
begin
  RPM:=Prev.RPM;

  MotorTorque:=TorqueAtRPM(DefaultBike.Torque,RPM);

  ThrustTorque:=(MotorTorque*RGear*RFinal*0.01*DefaultBike.TransmissionEficiency)/(0.5*DefaultBike.Back.Tire.Diameter*0.01);

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

  AirResistance:=0.5 * DefaultWeather.AirDensity * DefaultBike.CdAeroDynamic * DefaultBike.FrontArea * Sqr(Prev.Speed);

  // TODO: Pacejka's Magic Formula o Magic Formula Tire Model
  RollingFriction:= DefaultBike.Back.Tire.Friction * TotalMass * G;

  Acceleration:=(Thrust - AirResistance - RollingFriction) / TotalMass;

  Speed:=Prev.Speed+Prev.Acceleration;
  Position:=Prev.Position+Speed;
end;

function DefaultTorqueCurve:TTorqueCurve;
begin
  SetLength(result,6);

  result[0].RPM:= 5000; result[0].Nm:= 70;
  result[1].RPM:= 8000; result[1].Nm:= 95;
  result[2].RPM:=11000; result[2].Nm:=115;
  result[3].RPM:=14000; result[3].Nm:=110;
  result[4].RPM:=17000; result[4].Nm:=100;
  result[5].RPM:=18000; result[5].Nm:= 90;
end;

function DefaultGearRatios:TGearRatios;
begin
  SetLength(result,8);  // 7 Gears + Neutral

  result[0]:=0;
  result[1]:=2.6;
  result[2]:=2.1;
  result[3]:=1.75;
  result[4]:=1.5;
  result[5]:=1.32;
  result[6]:=1.18;
  result[7]:=1.1;
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

  DefaultBike.Torque:=DefaultTorqueCurve;

  DefaultBike.GearRatios:=DefaultGearRatios;

  DefaultBike.TransmissionEficiency:=95; // %

  DefaultBike.CdAeroDynamic:=0.45; // 0.3 .. 0.7 coefficient
  DefaultBike.FrontArea:=0.5; // 0.5 m²

  DefaultBike.MaxBreakDecelaration:=15; // m/s²

  // Clutch
end;

procedure InitDefaultWeather;
begin

end;

procedure InitDefaultPilot;
begin
  DefaultPilot.Name:='Marc Màrquez';
  DefaultPilot.Height:=1.69;
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
  AirDensity:=1.225; // kg/m3
end;

function EvaluateBrakingPoint(const ABikePosition, ABikeSpeedMPS: Double;
                              const ACorner: TCurve;
                              const AMaxDecelerationMPS2: Double): TBrakeDecision;
var
  vRequiredBrakingDistance: Double;
  vBrakingTriggerPosition: Double;
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
  vRequiredBrakingDistance := (Sqr(ABikeSpeedMPS) - Sqr(ACorner.EntrySpeed/3.6)) / (2.0 * AMaxDecelerationMPS2);
  Result.BrakingDistanceNeeded := vRequiredBrakingDistance;

  // 2. Determine the exact track coordinate where braking MUST start
  vBrakingTriggerPosition := ACorner.Position - vRequiredBrakingDistance;

  // 3. Compare with current bike position
  if ABikePosition >= vBrakingTriggerPosition then
  begin
    // The bike has reached or passed the limit! Must brake immediately.
    Result.NeedsToBrake := True;
    Result.DistanceToBrakePoint := 0.0;
  end
  else
  begin
    // Still safe, returning how many meters are left before the braking zone
    Result.NeedsToBrake := False;
    Result.DistanceToBrakePoint := vBrakingTriggerPosition - ABikePosition;
  end;
end;

initialization
  InitDefaultBike;
  InitDefaultPilot;
  DefaultWeather.Init;
end.
