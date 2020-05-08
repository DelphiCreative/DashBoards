unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Ani,
  FMX.Colors, FMX.Effects, FMX.DateTimeCtrls,
  FireDAC.Stan.Intf, Math,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.ListBox, FMX.SearchBox, FMX.ScrollBox, FMX.Memo,
  FMX.MultiView, FMX.TabControl;

type
  TForm4 = class(TForm)
    StyleBook1: TStyleBook;
    TimeLine2: TRectangle;
    Calendario2: TRectangle;
    Timeline1: TRectangle;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    CircleChart1: TRectangle;
    CircleChart3: TRectangle;
    CircleChart4: TRectangle;
    CircleChart2: TRectangle;
    Label2: TLabel;
    TituloGC1: TEdit;
    CorGC1: TComboColorBox;
    ValorGC1: TTrackBar;
    Line1: TLine;
    Line2: TLine;
    Line3: TLine;
    Line4: TLine;
    Label3: TLabel;
    TituloGC4: TEdit;
    Line5: TLine;
    ValorGC4: TTrackBar;
    CorGC4: TComboColorBox;
    Label7: TLabel;
    TituloGC3: TEdit;
    Line6: TLine;
    ValorGC3: TTrackBar;
    CorGC3: TComboColorBox;
    Label8: TLabel;
    TituloGC2: TEdit;
    Line7: TLine;
    ValorGC2: TTrackBar;
    CorGC2: TComboColorBox;
    Verttical: TTabItem;
    BarHorzChart: TRectangle;
    CorGH: TComboColorBox;
    ValoresGV: TMemo;
    Button2: TButton;
    BarVertChart: TRectangle;
    Label9: TLabel;
    Label10: TLabel;
    TituloGV: TEdit;
    Line8: TLine;
    ValoresGH: TMemo;
    Label1: TLabel;
    TituloGH: TEdit;
    Line9: TLine;
    Label11: TLabel;
    Line10: TLine;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Calendario1: TRectangle;
    DataCC: TDateEdit;
    CorCC1: TComboColorBox;
    Label6: TLabel;
    ValoresCC: TMemo;
    Label4: TLabel;
    CorCC2: TComboColorBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Calendario3: TRectangle;
    ValoresCC2: TMemo;
    ComboColorBox2: TComboColorBox;
    Label16: TLabel;
    Label17: TLabel;
    DataCC2: TDateEdit;
    Label18: TLabel;
    ComboColorBox1: TComboColorBox;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label5: TLabel;
    Label19: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

uses uChart;

procedure TForm4.Button2Click(Sender: TObject);
begin

   BarHorzChart.ChartBarHorizontal(TituloGV.text,ValoresGV.Text,'');

   BarVertChart.ChartBarVertical(TituloGH.text,
                                (ValoresGH.Text).Replace(#$D#$A,''),CorGH.Color);

   CircleChart1.ChartCircular(TituloGC1.Text, Floor(ValorGC1.Value),CorGC1.Color);
   CircleChart2.ChartCircular(TituloGC2.Text, Floor(ValorGC2.Value),CorGC2.Color);
   CircleChart3.ChartCircular(TituloGC3.Text, Floor(ValorGC3.Value),CorGC3.Color);
   CircleChart4.ChartCircular(TituloGC4.Text, Floor(ValorGC4.Value),CorGC4.Color);

   Calendario1.ChartCalendario(DataCC.Date,
                              (ValoresCC.Text).Replace(#$D#$A,';'),CorCC1.Color);
   Calendario2.ChartCalendario(DataCC.Date,
                             (ValoresCC.Text).Replace(#$D#$A,';'),CorCC2.Color,2);


   TimeLine2.ChartTimeline(ValoresCC2.Text,0,ComboColorBox1.Color);
   Timeline1.ChartTimeline(ValoresCC2.Text,1,ComboColorBox2.Color);
   Calendario3.ChartCalendario(DataCC2.Date,
                             (ValoresCC2.Text).Replace(#$D#$A,';'),ComboColorBox1.Color);



end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  DataCC.Date := Now;
  DataCC2.Date := Now;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
