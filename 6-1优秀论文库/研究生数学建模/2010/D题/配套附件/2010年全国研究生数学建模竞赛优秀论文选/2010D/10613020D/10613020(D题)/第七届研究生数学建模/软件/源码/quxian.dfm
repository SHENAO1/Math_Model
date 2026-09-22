object line_form: Tline_form
  Left = 307
  Top = 43
  Width = 1046
  Height = 806
  Caption = #26354#32447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RzPageControl1: TRzPageControl
    Left = 0
    Top = 29
    Width = 1038
    Height = 724
    ActivePage = TabSheet1
    Align = alClient
    ParentColor = False
    TabIndex = 0
    TabOrder = 0
    FixedDimension = 19
    object TabSheet1: TRzTabSheet
      Caption = #24037#20214
      object cht1: TChart
        Left = 0
        Top = 0
        Width = 1034
        Height = 387
        BackWall.Gradient.EndColor = clWhite
        BackWall.Gradient.StartColor = 15395562
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        Foot.Font.Name = 'Verdana'
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.LegendStyle = lsSeries
        Legend.Shadow.Color = 13421772
        Legend.Symbol.Pen.Visible = False
        Legend.TopPos = 0
        SubFoot.Font.Name = 'Verdana'
        SubTitle.Font.Name = 'Verdana'
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        BottomAxis.TicksInner.Color = 11119017
        BottomAxis.Title.Caption = 'X - mm'
        DepthAxis.TicksInner.Color = 11119017
        DepthTopAxis.TicksInner.Color = 11119017
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Visible = False
        LeftAxis.TicksInner.Color = 11119017
        LeftAxis.Title.Caption = 'Y - mm'
        RightAxis.TicksInner.Color = 11119017
        TopAxis.TicksInner.Color = 11119017
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 0
        ColorPaletteIndex = 13
        object jiagong1: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #24037#20214#29702#35770#26354#32447
          LinePen.Color = clRed
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object jiagong2: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clGreen
          Title = #23454#38469#21152#24037#26354#32447
          LinePen.Color = clGreen
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object GridBandTool1: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
      object cht6: TChart
        Left = 0
        Top = 387
        Width = 1034
        Height = 157
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Legend.Visible = False
        SubTitle.Visible = False
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.AxisValuesFormat = '00e-0'
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alBottom
        Color = clWhite
        TabOrder = 1
        ColorPaletteIndex = 9
        object jiagongcount: TBarSeries
          BarPen.Color = clRed
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 8
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #19978#21488#33033#20914#27425#25968
          BarWidthPercent = 1
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8553090
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = #38271#26465
          YValues.Order = loNone
        end
        object GridBandTool6: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
      object cht12: TChart
        Left = 0
        Top = 544
        Width = 1034
        Height = 157
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Legend.Visible = False
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alBottom
        Color = clWhite
        TabOrder = 2
        ColorPaletteIndex = 9
        object jiagong_BH: TBarSeries
          BarPen.Color = clRed
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 8
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #19978#21488#33033#20914#27425#25968
          BarWidthPercent = 1
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8553090
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = #38271#26465
          YValues.Order = loNone
        end
        object GridBandTool12: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
    end
    object TabSheet2: TRzTabSheet
      Caption = #19979#21488
      object cht2: TChart
        Left = 0
        Top = 0
        Width = 1034
        Height = 387
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        BottomAxis.Title.Caption = 'X - mm'
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Visible = False
        LeftAxis.Title.Caption = 'Y - mm'
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 0
        ColorPaletteIndex = 9
        object xiatai1: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #19979#21488#29702#35770#32447#20301#31227#26354#32447
          LinePen.Color = clRed
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object xiatai2: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clGreen
          Title = #19979#21488#23454#38469#32447#20301#31227#26354#32447
          LinePen.Color = clGreen
          Stairs = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object GridBandTool2: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
      object cht7: TChart
        Left = 0
        Top = 387
        Width = 1034
        Height = 157
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Legend.Visible = False
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alBottom
        Color = clWhite
        TabOrder = 1
        ColorPaletteIndex = 9
        object xiataicount: TBarSeries
          BarPen.Color = clRed
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 8
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #19978#21488#33033#20914#27425#25968
          BarWidthPercent = 1
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8553090
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = #38271#26465
          YValues.Order = loNone
        end
        object GridBandTool7: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
      object cht11: TChart
        Left = 0
        Top = 544
        Width = 1034
        Height = 157
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Legend.Visible = False
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.AxisValuesFormat = '00e-0'
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alBottom
        Color = clWhite
        TabOrder = 2
        ColorPaletteIndex = 9
        object xiatai_count_BH: TBarSeries
          BarPen.Color = clRed
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 8
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #19978#21488#33033#20914#27425#25968
          BarWidthPercent = 1
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8553090
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = #38271#26465
          YValues.Order = loNone
        end
        object GridBandTool11: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
    end
    object TabSheet3: TRzTabSheet
      Caption = #20013#21488
      object cht3: TChart
        Left = 0
        Top = 0
        Width = 1034
        Height = 387
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        BottomAxis.Title.Caption = 'X - mm'
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Visible = False
        LeftAxis.Title.Caption = 'Y - mm'
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 0
        ColorPaletteIndex = 9
        object zhongtai1: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #20013#21488#29702#35770#32447#20301#31227#26354#32447
          LinePen.Color = clRed
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object zhongtai2: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clGreen
          Title = #20013#21488#23454#38469#32447#20301#31227#26354#32447
          LinePen.Color = clGreen
          Stairs = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object GridBandTool3: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
      object cht8: TChart
        Left = 0
        Top = 387
        Width = 1034
        Height = 157
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Legend.Visible = False
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alBottom
        Color = clWhite
        TabOrder = 1
        ColorPaletteIndex = 9
        object zhongtaicount: TBarSeries
          BarPen.Color = clRed
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 8
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #19978#21488#33033#20914#27425#25968
          BarWidthPercent = 1
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8553090
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = #38271#26465
          YValues.Order = loNone
        end
        object GridBandTool8: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
      object cht10: TChart
        Left = 0
        Top = 544
        Width = 1034
        Height = 157
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Legend.Visible = False
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.AxisValuesFormat = '00e-0'
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alBottom
        Color = clWhite
        TabOrder = 2
        ColorPaletteIndex = 9
        object zhongtai_count_BH: TBarSeries
          BarPen.Color = clRed
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 8
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #19978#21488#33033#20914#27425#25968
          BarWidthPercent = 1
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8553090
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = #38271#26465
          YValues.Order = loNone
        end
        object GridBandTool10: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
    end
    object TabSheet4: TRzTabSheet
      Caption = #19978#21488
      object cht4: TChart
        Left = 0
        Top = 387
        Width = 1034
        Height = 157
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Legend.Visible = False
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alBottom
        Color = clWhite
        TabOrder = 0
        ColorPaletteIndex = 9
        object shangtaicount: TBarSeries
          BarPen.Color = clRed
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 8
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #19978#21488#33033#20914#27425#25968
          BarWidthPercent = 1
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8553090
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = #38271#26465
          YValues.Order = loNone
        end
        object GridBandTool4: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
      object cht5: TChart
        Left = 0
        Top = 0
        Width = 1034
        Height = 387
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        BottomAxis.Title.Caption = 'X - mm'
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Visible = False
        LeftAxis.Title.Caption = 'Y- '#24230
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 1
        ColorPaletteIndex = 9
        object shangtai1: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #19978#21488#29702#35770#35282#20301#31227#26354#32447
          LinePen.Color = clRed
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object shangtai2: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clGreen
          Title = #19978#21488#23454#38469#35282#20301#31227#26354#32447
          LinePen.Color = clGreen
          Stairs = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object GridBandTool5: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
      object cht9: TChart
        Left = 0
        Top = 544
        Width = 1034
        Height = 157
        BackWall.Pen.Visible = False
        BottomWall.Pen.Visible = False
        BottomWall.Size = 4
        LeftWall.Pen.Visible = False
        LeftWall.Size = 4
        Legend.Alignment = laBottom
        Legend.Color = clInfoBk
        Legend.Frame.Color = clGray
        Legend.Frame.Visible = False
        Legend.Shadow.Color = 13421772
        Legend.TopPos = 0
        Legend.Visible = False
        Title.Alignment = taLeftJustify
        Title.Color = clInfoBk
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Title.Frame.Color = clGray
        Title.Shadow.HorizSize = 0
        Title.Shadow.VertSize = 0
        Title.Text.Strings = (
          'TChart')
        Title.Transparent = False
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 13421772
        BottomAxis.Grid.Visible = False
        Frame.Visible = False
        LeftAxis.Axis.Color = 4210752
        LeftAxis.AxisValuesFormat = '00e-0'
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alBottom
        Color = clWhite
        TabOrder = 2
        ColorPaletteIndex = 9
        object shang_tai_count_BH: TBarSeries
          BarPen.Color = clRed
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 8
          Marks.Frame.Color = clGray
          Marks.Shadow.Color = 13421772
          Marks.Shadow.HorizSize = 2
          Marks.Shadow.VertSize = 2
          Marks.Visible = False
          SeriesColor = clRed
          Title = #19978#21488#33033#20914#27425#25968
          BarWidthPercent = 1
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8553090
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = #38271#26465
          YValues.Order = loNone
        end
        object GridBandTool9: TGridBandTool
          Band1.Color = 15329769
          Band1.Transparency = 50
          Band2.Color = clWhite
          Band2.Transparency = 50
          AxisID = 2
        end
      end
    end
    object TabSheet5: TRzTabSheet
      Caption = #25968#25454
      object ChartGrid1: TChartGrid
        Left = 0
        Top = 25
        Width = 1034
        Height = 676
        Align = alClient
        Options = [goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goTabs, goThumbTracking]
        TabOrder = 0
        Chart = cht1
      end
      object RzPanel2: TRzPanel
        Left = 0
        Top = 0
        Width = 1034
        Height = 25
        Align = alTop
        AutoSize = True
        BorderOuter = fsNone
        TabOrder = 1
        object ChartGridNavigator1: TChartGridNavigator
          Left = 0
          Top = 0
          Width = 304
          Height = 25
          TabOrder = 0
          Grid = ChartGrid1
        end
      end
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 1038
    Height = 29
    Align = alTop
    AutoSize = True
    BorderOuter = fsFlatRounded
    TabOrder = 1
    object RzLabel1: TRzLabel
      Left = 21
      Top = 8
      Width = 60
      Height = 13
      Caption = #36873#25321#22270#24418
    end
    object RzComboBox1: TRzComboBox
      Left = 85
      Top = 4
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = #24037#20214#26354#32447#22270
      OnChange = RzComboBox1Change
      Items.Strings = (
        #24037#20214#26354#32447#22270
        #24037#20214#35823#24046#22270
        #24037#20214#35823#24046#21464#21270#22270
        #19979#21488#26354#32447#22270
        #19979#21488#33033#20914#27425#25968#22270
        #19979#21488#33033#20914#39057#29575#22270
        #20013#21488#26354#32447#22270
        #20013#21488#33033#20914#27425#25968#22270
        #20013#21488#33033#20914#39057#29575#22270
        #19978#21488#26354#32447#22270
        #19978#21488#33033#20914#27425#25968#22270
        #19978#21488#33033#20914#39057#29575#22270)
      ItemIndex = 0
    end
    object RzBitBtn1: TRzBitBtn
      Left = 234
      Top = 2
      Width = 56
      Caption = #20445#23384
      HotTrack = True
      TabOrder = 1
      OnClick = RzBitBtn1Click
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000730E0000730E00000001000000000000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809090909
        090909090909090909E8E8E881818181818181818181818181E8E809101009E3
        1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
        1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
        1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
        E3E3E3E3E309101009E8E881ACAC81E3E3E3E3E3E381ACAC81E8E80910101009
        090909090910101009E8E881ACACAC818181818181ACACAC81E8E80910101010
        101010101010101009E8E881ACACACACACACACACACACACAC81E8E80910100909
        090909090909101009E8E881ACAC8181818181818181ACAC81E8E8091009D7D7
        D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E8091009D709
        0909090909D7091009E8E881AC81D7818181818181D781AC81E8E8091009D7D7
        D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E809E309D709
        0909090909D7090909E8E881E381D7818181818181D7818181E8E8091009D7D7
        D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E80909090909
        090909090909090909E8E88181818181818181818181818181E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
      NumGlyphs = 2
    end
  end
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 753
    Width = 1038
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 2
    object RzStatusPane1: TRzStatusPane
      Left = 0
      Top = 0
      Width = 1038
      Height = 19
      Align = alClient
    end
  end
  object RzSaveDialog1: TRzSaveDialog
    Filter = 'BMP|*.bmp|JPG|*.jpg'
    Left = 577
    Top = 9
  end
end
