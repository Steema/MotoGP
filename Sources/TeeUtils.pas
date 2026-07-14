{
  @davidberneda

  TeeChart Canvas drawing utils

}
unit TeeUtils;

interface

uses
  Windows, TeCanvas;

procedure DrawPerpendicular(const ACanvas:TTeeCanvas; const P0, P1: TPointFloat; const ALength:Single);

implementation

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

end.
