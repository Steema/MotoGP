unit Unit_Ollama;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.Edit, FMX.Layouts, FMX.ListBox;

type
  TForm20 = class(TForm)
    Button1: TButton;
    MemoResponse: TMemo;
    EditAsk: TEdit;
    Layout1: TLayout;
    Label1: TLabel;
    ComboModel: TComboBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form20: TForm20;

implementation

{$R *.fmx}

uses
  System.Net.HttpClient, System.JSON, System.Threading,
  System.Net.URLClient, System.NetConsts,
  System.Diagnostics;

procedure AskOllama(const APrompt, AModel: string; OnResponse: TProc<string>);
begin
  TTask.Run(
    procedure
    var
      HTTP: THTTPClient;
      JSONBody, JSONResponse: TJSONObject;
      RequestStream, ResponseStream: TStringStream;
      ResponseText: string;
    begin
      HTTP := THTTPClient.Create;
      JSONBody := TJSONObject.Create;
      RequestStream := TStringStream.Create('', TEncoding.UTF8);
      ResponseStream := TStringStream.Create('', TEncoding.UTF8);
      try
        // 1. Prepare Ollama
        JSONBody.AddPair('model', AModel {'qwen3.5' 'phi3.5'});
        JSONBody.AddPair('prompt', APrompt);
        JSONBody.AddPair('stream', False); // False, full answer in one message

        RequestStream.WriteString(JSONBody.ToJSON);
        RequestStream.Position := 0;

        // 2. Send POST to local Ollama API
        HTTP.ResponseTimeout:=120000;

        HTTP.ContentType := 'application/json';
        HTTP.Post('http://localhost:11434/api/generate', RequestStream, ResponseStream);

        // 3. Process JSON response
        ResponseText := ResponseStream.DataString;
        JSONResponse := TJSONObject.ParseJSONValue(ResponseText) as TJSONObject;
        try
          if Assigned(JSONResponse) and JSONResponse.TryGetValue<string>('response', ResponseText) then
          begin
            // Back to UI (Main Thread)
            TThread.Queue(nil,
              procedure
              begin
                OnResponse(ResponseText);
              end);
          end;
        finally
          JSONResponse.Free;
        end;

      finally
        RequestStream.Free;
        ResponseStream.Free;
        JSONBody.Free;
        HTTP.Free;
      end;
    end);
end;

procedure TForm20.Button1Click(Sender: TObject);
var S: TStopWatch;
begin
  MemoResponse.Lines.Text := 'Thinking...';

  S:=TStopwatch.StartNew;

  AskOllama(EditAsk.Text, ComboModel.Text,
    procedure(Response: string)
    begin
      MemoResponse.Lines.Text := 'Time: '+S.ElapsedMilliseconds.ToString+#13#10+
        Response;
    end);
end;

end.
