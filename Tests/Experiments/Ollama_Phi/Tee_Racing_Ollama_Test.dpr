program Tee_Racing_Ollama_Test;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit_Ollama in 'Unit_Ollama.pas' {Form20};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm20, Form20);
  Application.Run;
end.
