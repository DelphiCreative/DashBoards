program BarChart;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form4},
  uChart in 'uChart.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
