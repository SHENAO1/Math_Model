unit quxian;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, RzTabs, TeeTools,
  RzButton, RzShellDialogs, StdCtrls, RzLabel, RzCmboBx, RzPanel, RzStatus,
  Grids, TeeChartGrid, TeeNavigator;

type
  Tline_form = class(TForm)
    RzSaveDialog1: TRzSaveDialog;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    cht1: TChart;
    jiagong1: TFastLineSeries;
    jiagong2: TFastLineSeries;
    GridBandTool1: TGridBandTool;
    cht6: TChart;
    jiagongcount: TBarSeries;
    GridBandTool6: TGridBandTool;
    cht12: TChart;
    jiagong_BH: TBarSeries;
    GridBandTool12: TGridBandTool;
    TabSheet2: TRzTabSheet;
    cht2: TChart;
    xiatai1: TFastLineSeries;
    xiatai2: TFastLineSeries;
    GridBandTool2: TGridBandTool;
    cht7: TChart;
    xiataicount: TBarSeries;
    GridBandTool7: TGridBandTool;
    cht11: TChart;
    xiatai_count_BH: TBarSeries;
    GridBandTool11: TGridBandTool;
    TabSheet3: TRzTabSheet;
    cht3: TChart;
    zhongtai1: TFastLineSeries;
    zhongtai2: TFastLineSeries;
    GridBandTool3: TGridBandTool;
    cht8: TChart;
    zhongtaicount: TBarSeries;
    GridBandTool8: TGridBandTool;
    cht10: TChart;
    zhongtai_count_BH: TBarSeries;
    GridBandTool10: TGridBandTool;
    TabSheet4: TRzTabSheet;
    cht4: TChart;
    shangtaicount: TBarSeries;
    GridBandTool4: TGridBandTool;
    cht5: TChart;
    shangtai1: TFastLineSeries;
    shangtai2: TFastLineSeries;
    GridBandTool5: TGridBandTool;
    cht9: TChart;
    shang_tai_count_BH: TBarSeries;
    GridBandTool9: TGridBandTool;
    RzPanel1: TRzPanel;
    RzComboBox1: TRzComboBox;
    RzBitBtn1: TRzBitBtn;
    RzLabel1: TRzLabel;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    TabSheet5: TRzTabSheet;
    ChartGrid1: TChartGrid;
    RzPanel2: TRzPanel;
    ChartGridNavigator1: TChartGridNavigator;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzComboBox1Change(Sender: TObject);
  private
    { Private declarations }    
    procedure pinglv(line1,line2:TBarSeries);   
    function wucha_area(line1:TBarSeries;line2:TFastLineSeries):string;
  public
    { Public declarations }
  end;

var
  line_form: Tline_form;

implementation

{$R *.dfm}

procedure Tline_form.RzBitBtn1Click(Sender: TObject);
begin
  if RzSaveDialog1.Execute then
  case rzcombobox1.ItemIndex of
    0:cht1.SaveToBitmapFile(RzSaveDialog1.FileName);
    1:cht6.SaveToBitmapFile(RzSaveDialog1.FileName);
    2:cht12.SaveToBitmapFile(RzSaveDialog1.FileName);
    3:cht2.SaveToBitmapFile(RzSaveDialog1.FileName);
    4:cht7.SaveToBitmapFile(RzSaveDialog1.FileName);
    5:cht11.SaveToBitmapFile(RzSaveDialog1.FileName);
    6:cht3.SaveToBitmapFile(RzSaveDialog1.FileName);
    7:cht8.SaveToBitmapFile(RzSaveDialog1.FileName);
    8:cht10.SaveToBitmapFile(RzSaveDialog1.FileName);
    9:cht5.SaveToBitmapFile(RzSaveDialog1.FileName);
    10:cht4.SaveToBitmapFile(RzSaveDialog1.FileName);
    11:cht9.SaveToBitmapFile(RzSaveDialog1.FileName);
  end;
end;

procedure Tline_form.pinglv(line1,line2:TBarSeries);
var
  i:Integer;
  j,k:Single;
begin
  for i:=1 to line1.Count-2 do
  begin
    j:=Abs(line1.YValue[i-1]-line1.YValue[i]);
    k:=Abs(line1.YValue[i+1]-line1.YValue[i]);
    if (j>0) and(k>0) then line2.AddXY(line1.XValue[i],Abs(j-k)/j);
  end;
end;
function Tline_form.wucha_area(line1:TBarSeries;line2:TFastLineSeries):string;
var
  i:Integer;
  m:array [0..2] of Single;
begin
  m[0]:=0;  
  m[1]:=0;
  for i:=0 to line1.Count-1 do
  begin
    m[0]:=m[0]+line1.YValue[i];
  end;    
  for i:=1 to line2.Count-1 do
  begin
    m[1]:=m[1]+line2.YValue[i]*abs(line2.XValue[i]-line2.XValue[i-1]);
  end;
  Result:=Format('总误差面积：%.6f   总面积：%.6f   误差百分比：%.6f',[m[0],m[1],m[0]*100/m[1]]);
end;
procedure Tline_form.FormShow(Sender: TObject);
begin
  //计算频率比
  pinglv(jiagongcount,jiagong_BH);
  pinglv(xiataicount,xiatai_count_BH);
  pinglv(zhongtaicount,zhongtai_count_BH);
  pinglv(shangtaicount,shang_tai_count_BH);
  //计算误差
  RzStatusPane1.Caption:=wucha_area(jiagongcount,jiagong1)+'%';
end;


procedure Tline_form.RzComboBox1Change(Sender: TObject);
begin
  case rzcombobox1.ItemIndex of
    0:ChartGrid1.Chart:=cht1;
    1:ChartGrid1.Chart:=cht6;
    2:ChartGrid1.Chart:=cht12;
    3:ChartGrid1.Chart:=cht2;
    4:ChartGrid1.Chart:=cht7;
    5:ChartGrid1.Chart:=cht11;
    6:ChartGrid1.Chart:=cht3;
    7:ChartGrid1.Chart:=cht8;
    8:ChartGrid1.Chart:=cht10;
    9:ChartGrid1.Chart:=cht5;
    10:ChartGrid1.Chart:=cht4;
    11:ChartGrid1.Chart:=cht9;
  end;
end;

end.
