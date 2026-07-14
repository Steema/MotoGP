{
  @davidberneda

  Returns a png image corresponding to the country name ACountry.

}
unit TeeCountryFlags;

interface

uses
  Classes, Graphics;

function GetCountryFlag(const ACountry:String):TGraphic;

implementation

{$R Flags.res}  // See Flags.rc source file

uses
  Windows, PngImage, Generics.Collections;

var
  Countries : TDictionary<String,String>=nil;
  Flags : TDictionary<String,TGraphic>=nil;

procedure CreateCountries;
var i : Integer;
    tmp : String;
    tmpText : TStringList;
    RS: TResourceStream;
begin
  Countries:=TDictionary<String,String>.Create;

  tmpText:=TStringlist.Create;
  try
     RS:=TResourceStream.Create(HInstance, 'ALL_FLAGS', RT_RCDATA);
     try
       tmpText.LoadFromStream(RS);
     finally
       RS.Free;
     end;

    for tmp in tmpText do
    begin
      i:=Pos(',',tmp);

      Countries.Add(Copy(tmp,1,i-1),Copy(tmp,i+1,255));
    end;
  finally
    tmpText.Free;
  end;

  Flags:=TDictionary<String,TGraphic>.Create;
end;

function GetCountryFlag(const ACountry:String):TGraphic;
var ResStream: TResourceStream;
    ID : String;
begin
  if Countries=nil then
     CreateCountries;

  ID:=Countries[ACountry];

  if not Flags.TryGetValue(ID,result) then
  begin
    result:=TPngImage.Create;

    ResStream:=TResourceStream.Create(HInstance, ID, RT_RCDATA);
    try
      result.LoadFromStream(ResStream);
    finally
      ResStream.Free;
    end;

    Flags.Add(ID,result);
  end;
end;

procedure DestroyFlags;
var t : TGraphic;
begin
  if Flags<>nil then
     for t in Flags.Values do
         t.Free;

  Flags.Free;
  Countries.Free;
end;

initialization
finalization
  DestroyFlags;
end.
