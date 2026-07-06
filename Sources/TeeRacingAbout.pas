unit TeeRacingAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  jpeg, TeeProcs;

type
  TAboutForm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

procedure TAboutForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
   Image1.Stretch:=True;
end;

procedure TAboutForm.Image1Click(Sender: TObject);
begin
  TeeGotoURL(Handle,'https://www.steema.com');
end;

procedure TAboutForm.Label1Click(Sender: TObject);
begin
  TeeGotoURL(Handle,Label1.Caption);
end;

end.
