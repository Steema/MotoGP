{
  @davidberneda

  TeeChart Canvas drawing utils

}
unit TeeUtils;

interface

uses
  Windows, Classes, SysUtils, TeCanvas, StdCtrls, Controls,
  Tee.GridData.Strings;

procedure FillCombo(const ACombo:TCustomCombo; const ASource:TStringsData; const AColumn:Integer; const ASelected:String); overload;
procedure FillCombo(const ACombo:TCustomCombo; const Values:Array of String; const ASelected:String); overload;

procedure FillItems(const AItems:TStrings; const ASource:TStringsData; const AColumn:Integer); overload;
procedure FillItems(const AItems:TStrings; const Values:Array of String); overload;

procedure FillFolders(const APath:String; const AItems:TStrings);

procedure FillSequential(const AData:TStringsData; const AColumn:Integer);

procedure DrawPerpendicular(const ACanvas:TTeeCanvas; const P0, P1: TPointFloat; const ALength:Single);

implementation

uses
  IOUtils;

procedure DrawPerpendicular(const ACanvas:TTeeCanvas; const P0, P1: TPointFloat; const ALength:Single);
var
  DX, DY: Single;
  PX, PY: Single;

  tmpMid,
  Distance: Single;

  X0,Y0,X1,Y1: Integer;
begin
  DX := P1.X - P0.X;
  DY := P1.Y - P0.Y;

  PX := -DY;
  PY := DX;

  Distance := Sqrt((PX * PX) + (PY * PY));

  if Distance>0 then
  begin
    tmpMid:=ALength*0.5;

    PX := PX / Distance;
    PY := PY / Distance;

    X0 := Round(P1.X - PX * tmpMid);
    Y0 := Round(P1.Y - PY * tmpMid);

    X1 := Round(P1.X + PX * tmpMid);
    Y1 := Round(P1.Y + PY * tmpMid);

    ACanvas.Line(X0,Y0,X1,Y1);
  end;
end;

function FindValue(const AItems:TStrings; const AValue:String):Integer;
var t : Integer;
begin
  for t:=0 to AItems.Count-1 do
      if SameText(AItems[t],AValue) then
         Exit(t);

  result:=-1;
end;

// Add all Values to ACombo, and try to find ASelected to set ItemIndex
procedure FillCombo(const ACombo:TCustomCombo; const Values:Array of String; const ASelected:String);
begin
  FillItems(ACombo.Items,Values);
  ACombo.ItemIndex:=FindValue(ACombo.Items,ASelected);
end;

procedure FillCombo(const ACombo:TCustomCombo; const ASource:TStringsData; const AColumn:Integer; const ASelected:String); overload;
begin
  FillItems(ACombo.Items,ASource,AColumn);
  ACombo.ItemIndex:=FindValue(ACombo.Items,ASelected);
end;

procedure FillItems(const AItems:TStrings; const ASource:TStringsData; const AColumn:Integer);
var t : Integer;
begin
  AItems.BeginUpdate;
  try
    AItems.Clear;

    for t:=0 to ASource.Count-1 do
        AItems.Add(ASource[AColumn,t]);
  finally
    AItems.EndUpdate;
  end;
end;

procedure FillItems(const AItems:TStrings; const Values:Array of String);
var t : Integer;
begin
  AItems.BeginUpdate;
  try
    AItems.Clear;

    for t:=Low(Values) to High(Values) do
        AItems.Add(Values[t]);
  finally
    AItems.EndUpdate;
  end;
end;

procedure FillFolders(const APath:String; const AItems:TStrings);
var S, tmp : String;
begin
  AItems.BeginUpdate;;
  try
    AItems.Clear;

    for S in TDirectory.GetDirectories(APath) do
    begin
      tmp:=ExtractFileName(S);

      if Copy(tmp,1,1)<>'_' then
         AItems.Add(tmp);
    end;
  finally
    AItems.EndUpdate;
  end;
end;

procedure FillSequential(const AData:TStringsData; const AColumn:Integer);
var t : Integer;
begin
  for t:=0 to AData.Count-1 do
      AData[AColumn,t]:=IntToStr(t+1);
end;

end.
