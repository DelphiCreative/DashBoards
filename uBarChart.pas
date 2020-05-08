unit uBarChart;

interface

uses
  FMX.Objects, System.Generics.Collections,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.PlatForm,FMX.Effects,
  FMX.Dialogs;

type
  TTipo = (vertical,horizontal);

type
  TSerie = class
    Valor,
    Cor :Integer;
    Hint :String;

  end;

type
  TGrafico = class

  private
    FValores: TDictionary<String, TSerie>;
    FMax: Integer;
    FTipo: TTipo;
    FTitulo: String;
    FCor: TAlphaColor;
    FCorFundo: TAlphaColor;
    procedure SetValores(const Value: TDictionary<String, TSerie>);
    procedure SetMax(const Value: Integer);
    procedure SetTipo(const Value: TTipo);
    procedure SetTitulo(const Value: String);
    procedure SetCor(const Value: TAlphaColor);
    procedure SetCorFundo(const Value: TAlphaColor);
    procedure Serie(Comp :TVertScrollBox; Por1 :Integer;
      Texto :String); overload;
    procedure Serie(Comp :THorzScrollBox); overload;
  protected
    property Valores : TDictionary<String,TSerie> read FValores write SetValores;
    property Tipo :TTipo read FTipo write SetTipo;
  public
    property Max :Integer read FMax write SetMax;
    property Titulo :String read FTitulo write SetTitulo;
    property Cor :TAlphaColor read FCor write SetCor;
    property CorFundo :TAlphaColor read FCorFundo write SetCorFundo;
    constructor Create(Comp : TRectangle;Tipo :TTipo);
    destructor Destroy; override;
    procedure AddSerie(int1 : Integer ;Hint :string);

    procedure CardMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure CardDragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure CardDragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);

//    procedure AddSerie()
  end;

implementation

var
  Serie :TSerie;
  i :Integer;
  Vert : TVertScrollBox;
  horz : THorzScrollBox;
  rFundo,
  rBar :  TRectangle;
  sTitulo : TText;
  Sombra: TShadowEffect;
  topo  : TLayout;

{ TGrafico }

procedure TGrafico.AddSerie(int1 : Integer ;Hint :string);
begin

   if Tipo = vertical then begin
      Serie(Vert,int1,Hint);

   end else begin
      rFundo := TRectangle.Create(Horz);

      rFUndo.Parent        := Horz;
      rFundo.Align         := TAlignLayout.Left;
      rFundo.Margins.Left  := 5;
      rFundo.Margins.Top   := 10;
      rFundo.Margins.Right := 5;
      rFundo.Height        := Horz.Height;

      rFundo.Width        := Horz.Width  / Max -20 ;

      rFundo.Position.X    := 0;
      rFundo.Position.Y    := 170;

      //rFundo.Size.Width          := 15  ;
      rFundo.Size.PlatformDefault := False;
      rFundo.Stroke.Kind          := TBrushKind.None;

      rBar := TRectangle.Create(rFundo);
      rBar.Align      := TAlignLayout.Bottom;
      rBar.Fill.Color := TAlphaColors.Cornflowerblue;
      rBar.Name  := 'Ret_'+Inttostr(i);
      rBar.Size.Height           :=  0;
      rBar.Size.PlatformDefault := False;
      rBar.Parent               := rFundo;
      rBar.Stroke.Kind          := TBrushKind.None;

      rBar.AnimateFloat('Height',(rFundo.Height  / 100) * int1,1, TAnimationType.In,TInterpolationType.Cubic);
   end;
   inc(i)

end;

procedure TGrafico.CardDragDrop(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
begin
   if Sender is TVertScrollBox then begin
      TControl(Data.Source).Position.Y:= Point.Y;
      TControl(Sender).AddObject(TControl(Data.Source));
   end;
end;

procedure TGrafico.CardDragOver(Sender: TObject; const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
begin
   Operation := TDragOperation.Copy;


end;

procedure TGrafico.CardMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var Svc: IFMXDragDropService;
    DragData: TDragObject;
    DragImage: TBitmap;
begin
   if TPlatformServices.Current.SupportsPlatformService(IFMXDragDropService, Svc) then begin
      DragImage       := TControl(Sender).MakeScreenshot;
      DragData.Source := Sender;
      DragData.Data   := DragImage;
      try
        Svc.BeginDragDrop(Application.MainForm, DragData, DragImage);
      finally
         DragImage.Free;
      end;
   end;

end;

constructor TGrafico.Create(Comp : TRectangle;Tipo :TTipo);
var Line1: TLine;

begin

   for I := Comp.ComponentCount - 1 downto 0 do
      Comp.Components[I].Free;

   Cor      := TAlphaColors.Cornflowerblue;
   CorFundo := Comp.Fill.Color;
   Max      := 0;
 //  Titulo   := 'Gráfico Delphi Creative';

   Sombra := TShadowEffect.Create(Comp);
   Sombra.Distance := 3;
   Sombra.Direction := 45;
   Sombra.Softness := 0.3;
   Sombra.Opacity := 0.6;
   Sombra.ShadowColor := TAlphaColors.Black;
   Sombra.Parent :=  Comp;

   topo := TLayout.Create(Comp);
   topo.Align := TAlignLayout.Top;
   topo.Size.Height := 33;
   topo.Size.PlatformDefault := False;
   topo.Parent := Comp;



   i := 0;
   Self.Tipo := Tipo;
   if Tipo = vertical then begin
      Vert                := TVertScrollBox.Create(topo);
      Vert.Parent         := Comp;
      Vert.Align          := TAlignLayout.Client;
      vert.Height         := Comp.Height - 60 ;
      vert.Width          := Comp.Width ;
      Vert.Margins.Top    := 5;
      Vert.Margins.Left   := 15;
      Vert.Margins.Right  := 15;
      Vert.Margins.Bottom := 5;
      Vert.OnDragOver     := CardDragOver;
      Vert.OnDragDrop     := CardDragDrop;

   end else begin

      Line1 := TLine.Create(Comp);
      Line1.LineType    := TLineType.Top;
      Line1.Position.X  := 368;
      Line1.Position.Y  := 352;
      Line1.Size.Width  := 146;
      Line1.Size.Height := 30;
      Line1.Size.PlatformDefault := False;
      Line1.Align := TAlignLayout.Bottom;
      Line1.Parent := Comp;

      horz := THorzScrollBox.Create(topo);
      horz.Parent := Comp;
      horz.Align := TAlignLayout.Client;
      horz.Margins.Top := 5;
      horz.Margins.Left := 5;
      horz.Margins.Right := 5;
      horz.Margins.Bottom := 0;

   end;

end;

destructor TGrafico.Destroy;
begin
  inherited;

  Valores.Free;

end;

procedure TGrafico.Serie(Comp: TVertScrollBox; Por1 :Integer;
  Texto :String);
begin
   rFundo := TRectangle.Create(Comp);
   rFundo.Parent        := Comp;
   rFundo.Align         := TAlignLayout.Top;
   rFundo.Fill.Color    := CorFundo ;
   rFundo.Margins.Top   := 2;
   rFundo.Width         := Comp.Width;
   rFundo.Position.X    := 5;
   rFundo.Position.Y    := 170;

   rFundo.Height        := Comp.Height  / Max -5 ;
   rFundo.Size.PlatformDefault := False;
   rFundo.Stroke.Kind   := TBrushKind.None;
   rFundo.OnDragOver    := CardDragOver;
   rFundo.OnDragDrop    := CardDragDrop;
   rFundo.OnMouseDown   := CardMouseDown;

   rBar := TRectangle.Create(rFundo);
   rBar.Align                := TAlignLayout.Left;
   //rBar.Fill.Kind           := TBrushKind.Gradient ;
   rBar.Fill.Color           := Cor ;
   rBar.HitTest              := False;
   rBar.Size.Width           :=  0;//(rFundo.Width / 100) * int1;
   rBar.Size.PlatformDefault := False;
   rBar.Parent               := rFundo;
   rBar.Stroke.Kind          := TBrushKind.None;

   {Sombra := TShadowEffect.Create(rBar);
   Sombra.Distance := 3;
   Sombra.Direction := 45;
   Sombra.Softness := 0.3;
   Sombra.Opacity := 0.6;
   Sombra.ShadowColor := Cor;
   Sombra.Parent :=  rBar;}

   sTitulo := TText.Create(rFundo);
   sTitulo.Parent := rFundo;
   sTitulo.Align  := TAlignLayout.Contents;
   sTitulo.Position.X := 0;
   sTitulo.Position.Y := 0;
   sTitulo.TextSettings.HorzAlign := TTextAlign.Leading;
   sTitulo.Width      := rFundo.Width;
   sTitulo.HitTest    := False;
   sTitulo.Text := Texto;

   rBar.AnimateFloat('Width',(rFundo.Width / 100) * Por1,1, TAnimationType.In,TInterpolationType.Cubic);


end;

procedure TGrafico.Serie(Comp: THorzScrollBox);
begin

end;

procedure TGrafico.SetCor(const Value: TAlphaColor);
begin
  FCor := Value;
end;

procedure TGrafico.SetCorFundo(const Value: TAlphaColor);
begin
  FCorFundo := Value;
end;

procedure TGrafico.SetMax(const Value: Integer);
begin
  FMax := Value;
end;

procedure TGrafico.SetTipo(const Value: TTipo);
begin
  FTipo := Value;
end;

procedure TGrafico.SetTitulo(const Value: String);
begin
   FTitulo := Value;

   sTitulo := TText.Create(Topo);
   sTitulo.Align  := TAlignLayout.Client;
   sTitulo.Parent     := Topo;
   sTitulo.Text := Titulo;

end;

procedure TGrafico.SetValores(const Value: TDictionary<String, TSerie>);
begin
  FValores := Value;
end;

end.
