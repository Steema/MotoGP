unit TeeCountryFlags;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
  Generics.Collections;

type
  TFormFlags = class(TForm)
    Memo1: TMemo;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

    Countries : TDictionary<String,String>;
    Flags : TDictionary<String,TGraphic>;
  public
    { Public declarations }

    function GetFlag(const ACountry:String):TGraphic;
  end;

var
  FormFlags: TFormFlags;

implementation

{$R *.dfm}
{$R Flags.res}

uses
  PngImage;

procedure TFormFlags.FormCreate(Sender: TObject);
var t, i : Integer;
    tmp : String;
begin
  Countries:=TDictionary<String,String>.Create;

  for t:=0 to Memo1.Lines.Count-1 do
  begin
    tmp:=Memo1.Lines[t];
    i:=Pos(',',tmp);

    Countries.Add(Copy(tmp,1,i-1),Copy(tmp,i+1,255));
  end;

  Flags:=TDictionary<String,TGraphic>.Create;
end;

procedure TFormFlags.FormDestroy(Sender: TObject);
var t : TGraphic;
begin
  for t in Flags.Values do
      t.Free;

  Flags.Free;
  Countries.Free;
end;

function TFormFlags.GetFlag(const ACountry:String):TGraphic;
var ResStream: TResourceStream;
    ID : String;
begin
  ID:=Countries[ACountry];

  if not Flags.TryGetValue(ID,result) then
  begin
    result:=TPngImage.Create;

    ResStream := TResourceStream.Create(HInstance, ID, RT_RCDATA);
    try
      result.LoadFromStream(ResStream);
    finally
      ResStream.Free;
    end;

    Flags.Add(ID,result);
  end;
end;

end.
