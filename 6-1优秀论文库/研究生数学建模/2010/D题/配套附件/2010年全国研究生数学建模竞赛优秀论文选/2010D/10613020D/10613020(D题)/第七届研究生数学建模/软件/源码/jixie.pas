{create by 干锋 于第七届全国研究生数学建模竞赛 2010-9-17 - 2010-9-20。
有疑问请发送邮件至ganfengabc@126.com}
unit jixie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLObjects, GLScene, GLMisc, StdCtrls, ExtCtrls,
  GLCadencer, GLWin32Viewer, GLPolyhedron, Menus, GLExtrusion,
  GLGeomObjects, RzStatus, RzPanel, RzGroupBar, RzRadGrp, RzButton, Mask,
  RzEdit,VectorGeometry, RzLabel, RzPrgres, Series, TeEngine, TeeProcs,
  Chart, RzTabs, TeeTools, ImgList;

//type Phorizlineseries=^Thorizlineseries;
type
  TForm1 = class(TForm)
	 GLSceneViewer1: TGLSceneViewer;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    RzGroup2: TRzGroup;
    RzStatusBar1: TRzStatusBar;
    RzClockStatus1: TRzClockStatus;
    RzRadioGroup1: TRzRadioGroup;
    GLScene1: TGLScene;
    DummyCube1: TGLDummyCube;
    yuan_zhu: TGLCylinder;
    glcb_xia_tai: TGLCube;
    glcb_zhong_tai: TGLCube;
    glcb_shang_tai: TGLCube;
    glcb_work: TGLCube;
    gong_jian: TGLRevolutionSolid;
    glcb1: TGLCube;
    GLCamera1: TGLCamera;
    GLLightSource1: TGLLightSource;
    sha_lun: TGLDummyCube;
    yuan_zhui: TGLDummyCube;
    GLCylinder1: TGLCylinder;
    GLTorus1: TGLTorus;
    RzRadioGroup2: TRzRadioGroup;
    RzGroupBox2: TRzGroupBox;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzNumericEdit1: TRzNumericEdit;
    RzNumericEdit2: TRzNumericEdit;
    RzLabel3: TRzLabel;
    RzNumericEdit3: TRzNumericEdit;
    RzLabel4: TRzLabel;
    RzNumericEdit4: TRzNumericEdit;
    RzGroupBox1: TRzGroupBox;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzNumericEdit5: TRzNumericEdit;
    RzNumericEdit6: TRzNumericEdit;
    RzLabel7: TRzLabel;
    RzNumericEdit7: TRzNumericEdit;
    RzNumericEdit8: TRzNumericEdit;
    RzLabel8: TRzLabel;
    RzNumericEdit9: TRzNumericEdit;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzNumericEdit10: TRzNumericEdit;
    RzLabel11: TRzLabel;
    RzNumericEdit11: TRzNumericEdit;
    RzLabel12: TRzLabel;
    RzNumericEdit12: TRzNumericEdit;
    RzGroup3: TRzGroup;
    RzBitBtn2: TRzBitBtn;
    tmr1: TTimer;
    GLCylinder2: TGLCylinder;
    RzProgressBar1: TRzProgressBar;
    glcb_work_coor: TGLDummyCube;
    RzGroupBox3: TRzGroupBox;
    RzNumericEdit13: TRzNumericEdit;
    RzLabel13: TRzLabel;
    RzNumericEdit14: TRzNumericEdit;
    RzLabel14: TRzLabel;
    RzNumericEdit15: TRzNumericEdit;
    RzLabel15: TRzLabel;
    RzNumericEdit16: TRzNumericEdit;
    RzLabel16: TRzLabel;
    RzNumericEdit17: TRzNumericEdit;
    RzLabel17: TRzLabel;
    RzBitBtn4: TRzBitBtn;
    glcb2: TGLCube;
    RzRadioGroup3: TRzRadioGroup;
    RzNumericEdit18: TRzNumericEdit;
    tmr2: TTimer;
    RzLabel18: TRzLabel;
    RzLabel19: TRzLabel;
    RzLabel20: TRzLabel;
    RzLabel21: TRzLabel;
    RzLabel22: TRzLabel;
    RzLabel23: TRzLabel;
    RzLabel24: TRzLabel;
    RzLabel25: TRzLabel;
    RzLabel26: TRzLabel;
    RzLabel27: TRzLabel;
    RzLabel28: TRzLabel;
    RzLabel29: TRzLabel;
    RzLabel30: TRzLabel;
    RzLabel31: TRzLabel;
    RzLabel32: TRzLabel;
    RzLabel33: TRzLabel;
    RzLabel34: TRzLabel;
    RzLabel35: TRzLabel;
    RzGroup4: TRzGroup;
    tmr3: TTimer;
    GLDCcamera: TGLDummyCube;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    cht1: TChart;
    jiagong2: TFastLineSeries;
    TabSheet2: TRzTabSheet;
    cht2: TChart;
    xiatai1: TFastLineSeries;
    xiatai2: TFastLineSeries;
    TabSheet3: TRzTabSheet;
    cht3: TChart;
    zhongtai1: TFastLineSeries;
    zhongtai2: TFastLineSeries;
    TabSheet4: TRzTabSheet;
    cht4: TChart;
    jiagong1: TFastLineSeries;
    GridBandTool1: TGridBandTool;
    GridBandTool2: TGridBandTool;
    GridBandTool3: TGridBandTool;
    GridBandTool4: TGridBandTool;
    cht5: TChart;
    shangtai1: TFastLineSeries;
    shangtai2: TFastLineSeries;
    GridBandTool5: TGridBandTool;
    cht6: TChart;
    GridBandTool6: TGridBandTool;
    cht7: TChart;
    GridBandTool7: TGridBandTool;
    cht8: TChart;
    GridBandTool8: TGridBandTool;
    RzLabel36: TRzLabel;
    RzLabel37: TRzLabel;
    maichong_bujin: TRzNumericEdit;
    RzLabel38: TRzLabel;
    shangtaicount: TBarSeries;
    zhongtaicount: TBarSeries;
    xiataicount: TBarSeries;
    RzLabel39: TRzLabel;
    RzNumericEdit19: TRzNumericEdit;
    RzLabel40: TRzLabel;
    RzLabel41: TRzLabel;
    RzToolbar1: TRzToolbar;
    RzToolButton1: TRzToolButton;
    il1: TImageList;
    RzToolButton2: TRzToolButton;
    RzToolButton3: TRzToolButton;
    RzToolButton4: TRzToolButton;
    RzToolButton7: TRzToolButton;
    RzToolButton8: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzToolButton5: TRzToolButton;
    RzToolButton6: TRzToolButton;
    jiagongcount: TBarSeries;
    RzStatusPane1: TRzStatusPane;
    RzGroupBox4: TRzGroupBox;
    RzLabel43: TRzLabel;
    RzLabel44: TRzLabel;
    RzNumericEdit21: TRzNumericEdit;
    RzNumericEdit22: TRzNumericEdit;
    RzRadioGroup5: TRzRadioGroup;
    RzSpacer2: TRzSpacer;
    RzToolButton9: TRzToolButton;
    RzBitBtn3: TRzBitBtn;
    RzLabel45: TRzLabel;
    RzNumericEdit23: TRzNumericEdit;
    RzLabel46: TRzLabel;
    RzLabel47: TRzLabel;
    RzNumericEdit24: TRzNumericEdit;
    RzLabel48: TRzLabel;
    RzLabel49: TRzLabel;
    RzNumericEdit25: TRzNumericEdit;
    RzToolButton10: TRzToolButton;
    RzSpacer3: TRzSpacer;
    procedure GLSceneViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RzRadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzRadioGroup2Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure RzRadioGroup3Click(Sender: TObject);
    procedure tmr2Timer(Sender: TObject);
    procedure tmr3Timer(Sender: TObject);
    procedure cht1DblClick(Sender: TObject);
    procedure RzToolButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RzToolButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure RzRadioGroup5Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure RzNumericEdit19Change(Sender: TObject);
    procedure RzGroupBox2Click(Sender: TObject);
  private
	 { D閏larations priv閑s }
    mdx, mdy : Integer;
    procedure prepare_jiagong;
    procedure yundong(x1,x2,x3:single);
    procedure fang_zhen;
    procedure clear_line;
    function bujin_yidong(line1:TFastLineSeries;line_count:TBarSeries;j,i:single):Single;
    function bujin_xuanzhuan(line1:TFastLineSeries;line_count:TBarSeries;j,i:single):Single;
    function cta_zhuanhuan(x1,x2:Single):Single;
  public
	 { D閏larations publiques }
  end;
var
  Form1: TForm1;
  model_line:TStringList;
  model_line_k:TStringList;
  shalun_point:array  of TVector;
  shalun_point_no:Integer;
  shalun_change:Boolean;
  shalun_point_direct:Integer=1;
  run_point,dir:Integer;
  total_point:Integer=0;
  first:boolean=True;
  start_end:array [0..1] of Integer;
  //maichong_div:array [0..2] of Single;
const
  cta_unit=180/pi;

implementation

{$R *.DFM}

uses  math,GLBehaviours, liu_lan, quxian;

procedure TForm1.prepare_jiagong;
var
  vector:TVector;
  n:Single;
  i:integer;
begin
  SetLength(shalun_point,RzNumericEdit24.IntValue);
  maichong_bujin.Value:=RzNumericEdit9.Value/(RzNumericEdit8.Value*360/RzNumericEdit6.Value);
  //生成砂轮表面离散数据
  vector:=sha_lun.Position.AsVector;
  if RzRadioGroup2.ItemIndex=0 then
  begin
    vector[0]:=vector[0]-yuan_zhu.TopRadius;
    vector[1]:=yuan_zhu.Height*RzNumericEdit23.Value/RzNumericEdit24.IntValue/100;
    vector[2]:=vector[2]-yuan_zhu.Height*RzNumericEdit23.Value/200;
    for i:=0 to RzNumericEdit24.IntValue-1 do
      shalun_point[i]:=VectorMake(vector[2]+vector[1]*i,vector[0],0);
  end else
  begin
    vector[0]:=vector[0]-GLTorus1.MajorRadius;
    vector[1]:=GLTorus1.MinorRadius;
    for i:=0 to RzN //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////umericEdit24.IntValue-1 do
    begin
      n:=(i*RzNumericEdit23.Value/RzNumericEdit24.IntValue+90-RzNumericEdit23.Value/2)/cta_unit;
      shalun_point[i]:=VectorMake(vector[2]+vector[1]*cos(n),vector[0]-vector[1]*sin(n),pi/2-n);
    end;
  end;
  shalun_point_no:=0;
  clear_line;
  first:=True;
  //定义起始和终止加工位置
  start_end[0]:=Trunc(RzNumericEdit21.Value*RzNumericEdit19.Value);
  start_end[1]:=Trunc(RzNumericEdit22.Value*RzNumericEdit19.Value);
  run_point:=start_end[0]-1;
end;

procedure TForm1.RzRadioGroup1Click(Sender: TObject);
var
  i:Integer;
  j:Single;
begin
  model_line:=TStringList.Create;   
  model_line_k:=TStringList.Create;
  for i:=0 to 600*RzNumericEdit19.IntValue do
  begin
    j:=i/RzNumericEdit19.IntValue;
    if RzRadioGroup1.ItemIndex=0 then
    begin
      //生成工件1数据
      model_line.Add(FloatToStr(-7*sqr(600-j)/18000+0.45*(600-j)));
      model_line_k.Add(FloatToStr(1/60-(7*j)/9000));
    end else
    begin
      //生成工件2数据
      model_line.Add(FloatToStr(30*exp(-j/400)*sin((j+25*pi)/100)+130));
      model_line_k.Add(FloatToStr((3*cos(pi/4 + j/100))/(10*exp(j/400))-(3*sin(pi/4 + j/100))/(40*exp(j/400))));
    end;
  end;
  total_point:=i;
  gong_jian.Nodes.Clear;
  i:=total_point-1;                                   
  //生成工件2模型
  gong_jian.Nodes.AddNode(0,i/RzNumericEdit19.IntValue,0);
  while i>0 do
  begin
    gong_jian.Nodes.AddNode(StrToFloat(model_line.Strings[i]),i/RzNumericEdit19.IntValue,0);
    i:=i-16;
  end;
  gong_jian.PitchAngle:=-90;
end;
procedure TForm1.GLSceneViewer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin           
	mdx:=x; mdy:=y;
  GLSceneViewer1.SetFocus;
end;

procedure TForm1.GLSceneViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    GLCamera1.MoveAroundTarget(mdy-y, mdx-x);
	mdx:=x; mdy:=y;
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
	GLCamera1.AdjustDistanceToTarget(Power(1.1, WheelDelta/120));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  RzRadioGroup1.OnClick(Sender);
  RzRadioGroup2.OnClick(Sender);
end;   

procedure TForm1.FormShow(Sender: TObject);  
var
  vector:TVector;
begin             
  GLSceneViewer1.SetFocus;      
  vector:=gong_jian.AbsolutePosition;
  sha_lun.Position.Y:=vector[1]/0.004;
end;

procedure TForm1.RzRadioGroup2Click(Sender: TObject);
begin
  if RzRadioGroup2.ItemIndex=0 then
  begin
    yuan_zhu.Visible:=True;
    yuan_zhui.Visible:=false;
    RzLabel1.Caption:='长度';
    RzLabel2.Caption:='半径';
    RzLabel45.Caption:='可加工范围';
    RzNumericEdit1.Value:=yuan_zhu.Height;
    RzNumericEdit2.Value:=yuan_zhu.TopRadius;
  end else
  begin
    yuan_zhu.Visible:=False;
    yuan_zhui.Visible:=True;  
    RzLabel1.Caption:='厚度';
    RzLabel2.Caption:='直径';    
    RzLabel45.Caption:='可加工角度';
    RzNumericEdit1.Value:=GLCylinder1.Height;
    RzNumericEdit2.Value:=GLCylinder1.TopRadius+GLTorus1.MinorRadius;
  end;
  RzNumericEdit3.Value:=-sha_lun.Position.Z;
  RzNumericEdit4.Value:=-sha_lun.Position.X;
end;
//电机的传动控制模型
function Tform1.cta_zhuanhuan(x1,x2:Single):Single;
begin
  result:=ArcTan(x2*maichong_bujin.Value/RzNumericEdit11.Value+tan(x1/cta_unit))*cta_unit;
end;
//上台旋转角度对应脉冲数
function Tform1.bujin_xuanzhuan(line1:TFastLineSeries;line_count:TBarSeries;j,i:single):Single;
var
  dy:Single;
  m:integer;
begin
  result:=i;
  dy:=j-result;
  m:=0;
  while Abs(j-result)>maichong_bujin.Value do
  begin
    result:=cta_zhuanhuan(result,sign(dy));
    inc(m);
  end;
  if m>0 then
  begin
    line1.AddXY(RzNumericEdit16.Value,result);
    line_count.AddXY(RzNumericEdit16.Value,m);
  end else
    result:=j;
end;     
//下、中台移动对应脉冲数
function Tform1.bujin_yidong(line1:TFastLineSeries;line_count:TBarSeries;j,i:single):Single;
var
  dy:Single;
  m,k:integer;
begin
  result:=i;
  dy:=j-result;
  m:=Trunc(abs(dy)/maichong_bujin.Value);
  if m>0 then
  begin
    result:=result+maichong_bujin.Value*m*sign(dy);
    line1.AddXY(RzNumericEdit16.Value,result);
    line_count.AddXY(RzNumericEdit16.Value,m);
  end else
    result:=j;
end;

procedure Tform1.yundong(x1,x2,x3:single);
var
  a,b,c,d:array [0..2] of Single;
begin
  //磨床的逆运动学模型
  a[0]:=shalun_point[shalun_point_no][0]-x1*cos(x3)+x2*sin(x3)+RzNumericEdit12.Value*cos(x3);
  a[1]:=shalun_point[shalun_point_no][1]-(x2*cos(x3)+x1*sin(x3))+RzNumericEdit12.Value*sin(x3);
  a[2]:=x3*cta_unit;
  glcb_shang_tai.Position.Z:=a[0]+160;
  glcb_zhong_tai.Position.Z:=a[0]+160;
  glcb_work_coor.Position.Z:=a[0];
  glcb_shang_tai.Position.X:=a[1];
  glcb_work_coor.Position.X:=a[1];
  glcb_work_coor.TurnAngle:=a[2];
  jiagong1.AddXY(x1,x2);
  xiatai1.AddXY(x1,a[0]);
  zhongtai1.AddXY(x1,a[1]);
  shangtai1.AddXY(x1,a[2]);
  if first then
  begin
    first:=False;
    RzNumericEdit13.Value:=a[0];
    RzNumericEdit14.Value:=a[1];
    RzNumericEdit15.Value:=a[2];
  end else
  begin
    b[0]:=bujin_yidong(xiatai2,xiataicount,a[0],RzNumericEdit13.Value);
    b[1]:=bujin_yidong(zhongtai2,zhongtaicount,a[1],RzNumericEdit14.Value);
    b[2]:=bujin_xuanzhuan(shangtai2,shangtaicount,a[2],RzNumericEdit15.Value);
    if b[0]<>a[0] then RzNumericEdit13.Value:=b[0];
    if b[1]<>a[1] then RzNumericEdit14.Value:=b[1];
    if b[2]<>a[2] then RzNumericEdit15.Value:=b[2];
    b[0]:=b[0]-a[0];
    b[1]:=a[1]-b[1];
    b[2]:=(a[2]-b[2])/cta_unit;
    if ((b[0]-b[1])<>0)or (b[2]<>0) then
    begin
      if ((b[0]-b[1])<>0) then
      begin
        d[0]:=Sqrt(Sqr(b[0])+sqr(b[1]));
        d[1]:=ArcTan(b[1]/b[0])+x3;
        c[0]:=x1-d[0]*cos(d[1]);
        c[1]:=x2+d[0]*sin(d[1]);
      end else
      begin
        c[0]:=x1;
        c[1]:=x2;
      end;
      d[2]:=(c[1]-(RzNumericEdit12.Value-c[0])*tan(b[2]))*cos(b[2]);
      d[1]:=RzNumericEdit12.Value-d[2]*tan(b[2])-(RzNumericEdit12.Value-c[0])/cos(b[2]);
      jiagong2.AddXY(d[1],d[2]);
      jiagongcount.AddXY(x1,Abs((x1-d[1])*(x2-d[2]))/2);
    end;
  end;
end;

//procedure fang_zhen(Pointer:TPoint);stdcall;
procedure TForm1.fang_zhen;
begin
  if run_point>=start_end[1] then
  begin
    RzNumericEdit16.Value:=run_point/RzNumericEdit19.Value;
    RzNumericEdit17.Value:=StrToFloat(model_line.Strings[run_point]);
    RzNumericEdit25.Value:=StrToFloat(model_line_k.Strings[run_point]);
    if shalun_change then
    begin
      {if not Boolean(run_point mod 3) then
      begin}
        if shalun_point_no>RzNumericEdit24.IntValue-2 then
          shalun_point_direct:=-1;
        if shalun_point_no<1 then
          shalun_point_direct:=1;
        shalun_point_no:=shalun_point_no+shalun_point_direct;
      //end;
    end;      
    yundong(RzNumericEdit16.Value,RzNumericEdit17.Value,shalun_point[shalun_point_no][2]-ArcTan(RzNumericEdit25.Value));
    Dec(run_point);
    RzProgressBar1.Percent:=Trunc(run_point*100/total_point);
  end else
    RzBitBtn4.Click;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
{var
  ID:DWORD; }
begin
  //CreateThread(nil, 0, @fang_zhen, nil, 0, ID);
  fang_zhen;
end;
procedure Tform1.clear_line;
{var
  i:integer;}
begin
  {for i:=0 to Form1.ComponentCount-1 do
  begin
    if Form1.Components[i].ClassName = 'TFastLineSeries' then
      (Form1.Components[i] as TFastLineSeries).Clear;
    if Form1.Components[i].ClassName = 'TBarSeries' then
      (Form1.Components[i] as TBarSeries).Clear;
  end; }
  jiagong1.Clear;   
  jiagong2.Clear;
  jiagongcount.Clear;
  xiatai1.Clear;
  xiatai2.Clear;
  xiataicount.Clear;
  zhongtai1.Clear;
  zhongtai2.Clear;   
  zhongtaicount.Clear;
  shangtai1.Clear;
  shangtai2.Clear;
  shangtaicount.Clear;
end;
procedure TForm1.RzBitBtn2Click(Sender: TObject);
begin
  RzNumericEdit18.Value:=RzNumericEdit5.Value*RzNumericEdit10.Value/100;
  RzRadioGroup3.OnClick(Sender);    
  RzRadioGroup5.OnClick(Sender);
  case (Sender as TRzBitBtn).Tag of
    1:begin
        prepare_jiagong;
        tmr1.Enabled:=True;
        RzStatusPane1.Caption:='正在用 '+RzRadioGroup2.Items.Strings[RzRadioGroup2.itemindex]+' 砂轮，对 '+RzRadioGroup1.Items.Strings[RzRadioGroup1.itemindex]+' 进行加工...';
        RzStatusPane1.Blinking:=false;
    end;
    2:begin
        tmr1.Enabled:=false;
        RzStatusPane1.Caption:='加工停止！';
        RzStatusPane1.Blinking:=True;
    end;
  end;
  RzGroup1.Enabled:=not tmr1.Enabled;
  tmr2.Enabled:=tmr1.Enabled;
end;


procedure TForm1.RzRadioGroup3Click(Sender: TObject);
begin
  if RzRadioGroup3.ItemIndex=0 then
    tmr1.Interval:=Trunc(60000/RzNumericEdit18.Value)
  else
    tmr1.Interval:=Trunc(100/RzNumericEdit18.Value);
end;

procedure TForm1.tmr2Timer(Sender: TObject);
var
  i:Single;
begin
  i:=RzNumericEdit5.Value*0.6;
  gong_jian.Turn(i);
  sha_lun.Roll(-i);
end;

procedure TForm1.tmr3Timer(Sender: TObject);
begin
  TMyThread.Create(@GLDCcamera,@GLCamera1,dir);
end;

procedure TForm1.cht1DblClick(Sender: TObject);
begin
  line_form:=Tline_form.Create(Self);
  line_form.jiagong1.Assign(jiagong1);
  line_form.jiagong2.Assign(jiagong2);
  line_form.jiagongcount.Assign(jiagongcount);
  line_form.xiatai1.Assign(xiatai1);
  line_form.xiatai2.Assign(xiatai2);
  line_form.xiataicount.Assign(xiataicount);
  line_form.zhongtai1.Assign(zhongtai1);
  line_form.zhongtai2.Assign(zhongtai2);
  line_form.zhongtaicount.Assign(zhongtaicount);
  line_form.shangtai1.Assign(shangtai1);
  line_form.shangtai2.Assign(shangtai2);
  line_form.shangtaicount.Assign(shangtaicount);
  line_form.Show;
end;

procedure TForm1.RzToolButton1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dir:=(sender as Trztoolbutton).tag;
end;

procedure TForm1.RzToolButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dir:=0;
end;

procedure TForm1.RzBitBtn3Click(Sender: TObject);
begin
  RzBitBtn4.Click;
  yundong(310,260,0);
end;

procedure TForm1.RzRadioGroup5Click(Sender: TObject);
begin
  if RzRadioGroup5.ItemIndex =0 then
  begin
    shalun_change:=False;
    shalun_point_no:=Trunc(RzNumericEdit24.Value/2);
  end else
    shalun_change:=True;

end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.RzNumericEdit19Change(Sender: TObject);
begin
  RzRadioGroup1.OnClick(Sender);
end;

procedure TForm1.RzGroupBox2Click(Sender: TObject);
begin
  if RzRadioGroup2.ItemIndex=0 then
  begin
    yuan_zhu.Height:=RzNumericEdit1.Value;
    yuan_zhu.TopRadius:=RzNumericEdit2.Value;
  end else
  begin
    GLCylinder1.Height:=RzNumericEdit1.Value;
    GLTorus1.MinorRadius:=RzNumericEdit1.Value;
    GLCylinder1.TopRadius:=RzNumericEdit2.Value-RzNumericEdit1.Value;
  end;
  sha_lun.Position.Z:=-RzNumericEdit3.Value;
  sha_lun.Position.X:=-RzNumericEdit4.Value;
end;

end.
