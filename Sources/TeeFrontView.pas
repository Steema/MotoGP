unit TeeFrontView;

interface

uses
  TeeProcs, TeCanvas;

type
  TFrontView=record
  public
    class procedure Draw(const APanel:TCustomTeePanel; const LeanAngle:Single); static;
  end;

implementation

uses
  Windows, Graphics, Types;

class procedure TFrontView.Draw(const APanel:TCustomTeePanel; const LeanAngle:Single);
var
  Canvas: TCanvas3D;
  Trackoffset : Integer;
  Width, Height : Integer;
  CenterX, CenterY: Integer;
  BikeWidth, BikeHeight: Integer;
  HorizonY: Integer;
  LeftEdge, RightEdge: Integer;
  LeanRad: Double;
  WheelX, WheelY: Integer;
  BodyX, BodyY: Integer;
begin
  Canvas:=APanel.Canvas;

  Width:=APanel.Width;
  Height:=APanel.Height;

  TrackOffset:=Round(-LeanAngle* 4);

  // --- 1. CONFIGURACIÓ INICIAL ---
  CenterX := Width div 2;
  CenterY := Height div 2;
  HorizonY := CenterY - 10; // Alçada de la línia de l'horitzó

  BikeWidth := 40;
  BikeHeight := 90;

  // Convertim l'angle d'inclinació (lean angle) a radiants
  // LeanAngle positiu = Corba a la dreta (moto s'inclina a l'esquerra de la pantalla)
  LeanRad := (LeanAngle * Pi) / 180.0;

  // --- 2. NETEJAR EL CANVAS (EL CELS) ---
  Canvas.Brush.Color := rgb(135, 206, 235); // Blau cel
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(Rect(0, 0, Width, HorizonY));

  // --- 3. DIBUIXAR LA PISTA (ASFALT I ESCAPATORI) ---
  // El terra general (escapatori de gespa)
  Canvas.Brush.Color := rgb(34, 139, 34); // Verd gespa
  Canvas.FillRect(Rect(0, HorizonY, Width, Height));

  // Dibuixar la pista (asfalt) en perspectiva (un trapezi)
  // Apliquem el 'TrackOffset' per moure la pista a l'esquerra/dreta
  LeftEdge := CenterX - 250 + TrackOffset;
  RightEdge := CenterX + 250 + TrackOffset;

  Canvas.Brush.Color := rgb(80, 80, 80); // Asfalt gris fosc
  Canvas.Pen.Color := rgb(60, 60, 60);
  Canvas.Pen.Width := 1;

  Canvas.Polygon([
    Point(CenterX + (TrackOffset div 4), HorizonY), // Punt llunyà esquerra de la pista
    Point(CenterX + (TrackOffset div 4), HorizonY), // Punt llunyà dreta de la pista
    Point(RightEdge, Height),                      // Primer pla dreta
    Point(LeftEdge, Height)                        // Primer pla esquerra
  ]);

  // Línies blanques del límit de la pista (pianos/kerbs basics)
  Canvas.Pen.Color := clWhite;
  Canvas.Pen.Width := 3;
  Canvas.MoveTo(CenterX + (TrackOffset div 4), HorizonY);
  Canvas.LineTo(LeftEdge, Height);
  Canvas.MoveTo(CenterX + (TrackOffset div 4), HorizonY);
  Canvas.LineTo(RightEdge, Height);

  // --- 4. DIBUIXAR LA MOTO (SISTEMA LOCAL VECTORIAL) ---
  // El punt de contacte del pneumàtic amb l'asfalt (sempre fix a baix al centre)
  WheelX := CenterX;
  WheelY := Height - 60;

  // Calculem la posició del cos de la moto basat en l'angle d'inclinació
  // Usem trigonometria bàsica per rotar el vector vertical de la moto
  BodyX := WheelX + Round(BikeHeight * Sin(LeanRad));
  BodyY := WheelY - Round(BikeHeight * Cos(LeanRad));

  // A) Dibuixar el pneumàtic davanter (un el·lipse fosc petit)
  Canvas.Pen.Color := clBlack;
  Canvas.Brush.Color := rgb(30, 30, 30);
  Canvas.Ellipse(WheelX - 15, WheelY - 20, WheelX + 15, WheelY + 20);

  // B) Dibuixar la línia de la forquilla / xassís (eix d'inclinació)
  Canvas.Pen.Color := rgb(200, 200, 200); // Color alumini/plata
  Canvas.Pen.Width := 6;
  Canvas.MoveTo(WheelX, WheelY);
  Canvas.LineTo(BodyX, BodyY);

  // C) Dibuixar la cúpula / carenat (Cos principal de la moto)
  Canvas.Pen.Width := 2;
  Canvas.Pen.Color := clMaroon;
  Canvas.Brush.Color := clRed; // Moto vermella (estil Ducati)

  // Dibuixem un cercle o trapezi centrat en el punt del cos mogut per l'angle
  Canvas.Ellipse(BodyX - BikeWidth, BodyY - 20, BodyX + BikeWidth, BodyY + 20);

  {
  // D' Dibuixar la visera/pantalla del pilot (casc i cúpula)
  Canvas.Brush.Color := clBlack;
  Canvas.Ellipse(BodyX - 15, BodyY - 35, BodyX + 15, BodyY - 10);

  // E) Dibuixar el manillar (línia perpendicular al cos)
  Canvas.Pen.Color := clBlack;
  Canvas.Pen.Width := 4;

  // Per fer-ho simple, dibuixem una línia horitzontal desplaçada amb el cos
  Canvas.MoveTo(BodyX - 35, BodyY);
  Canvas.LineTo(BodyX + 35, BodyY);
  }
end;

end.
