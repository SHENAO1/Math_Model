object Form1: TForm1
  Left = 171
  Top = 27
  Width = 1153
  Height = 799
  BorderWidth = 5
  Caption = #30952#24202#21152#24037#20223#30495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GLSceneViewer1: TGLSceneViewer
    Left = 265
    Top = 29
    Width = 870
    Height = 687
    Camera = GLCamera1
    FieldOfView = 124.689353942871100000
    Align = alClient
    OnMouseDown = GLSceneViewer1MouseDown
    OnMouseMove = GLSceneViewer1MouseMove
  end
  object RzGroupBar1: TRzGroupBar
    Left = 0
    Top = 29
    Width = 265
    Height = 687
    ExclusiveMode = True
    GradientColorStart = clBtnFace
    GradientColorStop = clBtnShadow
    GroupBorderSize = 8
    Color = clBtnShadow
    ParentColor = False
    TabOrder = 1
    object RzGroup1: TRzGroup
      Items = <>
      Opened = True
      OpenedHeight = 377
      DividerVisible = False
      Caption = #21152#24037#21442#25968
      ParentColor = False
      object RzRadioGroup1: TRzRadioGroup
        Left = 8
        Top = 24
        Width = 209
        Height = 67
        Caption = #24037#20214
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #24037#20214'1'
          #24037#20214'2')
        TabOrder = 0
        OnClick = RzRadioGroup1Click
        object RzLabel39: TRzLabel
          Left = 10
          Top = 42
          Width = 57
          Height = 13
          AutoSize = False
          Caption = #36827#32473#37327
        end
        object RzLabel40: TRzLabel
          Left = 80
          Top = 42
          Width = 24
          Height = 13
          AutoSize = False
          Caption = '1/'
        end
        object RzLabel41: TRzLabel
          Left = 166
          Top = 41
          Width = 24
          Height = 14
          AutoSize = False
          Caption = 'mm'
        end
        object RzNumericEdit19: TRzNumericEdit
          Left = 96
          Top = 38
          Width = 65
          Height = 21
          TabOrder = 0
          OnChange = RzNumericEdit19Change
          Max = 100.000000000000000000
          Min = 6.000000000000000000
          Value = 8.000000000000000000
          DisplayFormat = '0'
        end
      end
      object RzRadioGroup2: TRzRadioGroup
        Left = 8
        Top = 147
        Width = 209
        Height = 214
        Caption = #30722#36718
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #22278#26609#24335
          #36718#24335)
        TabOrder = 1
        OnClick = RzRadioGroup2Click
        object RzGroupBox2: TRzGroupBox
          Left = 8
          Top = 40
          Width = 193
          Height = 169
          Caption = #21442#25968
          TabOrder = 0
          OnClick = RzGroupBox2Click
          object RzLabel1: TRzLabel
            Left = 11
            Top = 20
            Width = 30
            Height = 13
            AutoSize = False
            Caption = #38271#24230
          end
          object RzLabel2: TRzLabel
            Left = 11
            Top = 44
            Width = 30
            Height = 13
            AutoSize = False
            Caption = #21322#24452
          end
          object RzLabel3: TRzLabel
            Left = 12
            Top = 92
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object RzLabel4: TRzLabel
            Left = 12
            Top = 116
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object RzLabel32: TRzLabel
            Left = 160
            Top = 19
            Width = 24
            Height = 13
            AutoSize = False
            Caption = 'mm'
          end
          object RzLabel33: TRzLabel
            Left = 160
            Top = 43
            Width = 24
            Height = 13
            AutoSize = False
            Caption = 'mm'
          end
          object RzLabel34: TRzLabel
            Left = 160
            Top = 91
            Width = 24
            Height = 13
            AutoSize = False
            Caption = 'mm'
          end
          object RzLabel35: TRzLabel
            Left = 160
            Top = 115
            Width = 24
            Height = 13
            AutoSize = False
            Caption = 'mm'
          end
          object RzLabel45: TRzLabel
            Left = 12
            Top = 68
            Width = 69
            Height = 13
            AutoSize = False
            Caption = #21487#21152#24037#33539#22260
          end
          object RzLabel46: TRzLabel
            Left = 160
            Top = 67
            Width = 24
            Height = 13
            AutoSize = False
            Caption = '%'
          end
          object RzLabel47: TRzLabel
            Left = 12
            Top = 140
            Width = 61
            Height = 13
            AutoSize = False
            Caption = #21462#20540#28857#25968
          end
          object RzLabel48: TRzLabel
            Left = 160
            Top = 139
            Width = 24
            Height = 13
            AutoSize = False
            Caption = 'mm'
          end
          object RzNumericEdit1: TRzNumericEdit
            Left = 88
            Top = 16
            Width = 65
            Height = 21
            TabOrder = 0
            IntegersOnly = False
            DisplayFormat = '0'
          end
          object RzNumericEdit2: TRzNumericEdit
            Left = 88
            Top = 40
            Width = 65
            Height = 21
            TabOrder = 1
            IntegersOnly = False
            DisplayFormat = '0'
          end
          object RzNumericEdit3: TRzNumericEdit
            Left = 88
            Top = 88
            Width = 65
            Height = 21
            TabOrder = 2
            IntegersOnly = False
            DisplayFormat = '0'
          end
          object RzNumericEdit4: TRzNumericEdit
            Left = 88
            Top = 112
            Width = 65
            Height = 21
            TabOrder = 3
            IntegersOnly = False
            DisplayFormat = '0'
          end
          object RzNumericEdit23: TRzNumericEdit
            Left = 88
            Top = 64
            Width = 65
            Height = 21
            TabOrder = 4
            IntegersOnly = False
            Value = 20.000000000000000000
            DisplayFormat = '0'
          end
          object RzNumericEdit24: TRzNumericEdit
            Left = 88
            Top = 136
            Width = 65
            Height = 21
            TabOrder = 5
            Value = 1200.000000000000000000
            DisplayFormat = '0'
          end
        end
      end
      object RzGroupBox4: TRzGroupBox
        Left = 8
        Top = 96
        Width = 209
        Height = 49
        Caption = #21152#24037#20301#31227#37327
        TabOrder = 2
        object RzLabel43: TRzLabel
          Left = 10
          Top = 24
          Width = 41
          Height = 13
          AutoSize = False
          Caption = #36215#28857
        end
        object RzLabel44: TRzLabel
          Left = 112
          Top = 24
          Width = 41
          Height = 13
          AutoSize = False
          Caption = #32456#28857
        end
        object RzNumericEdit21: TRzNumericEdit
          Left = 40
          Top = 20
          Width = 57
          Height = 21
          DisabledColor = clWindow
          ReadOnlyColor = clWindow
          TabOrder = 0
          IntegersOnly = False
          Max = 600.000000000000000000
          Min = 1.000000000000000000
          Value = 600.000000000000000000
          DisplayFormat = '0.00'
        end
        object RzNumericEdit22: TRzNumericEdit
          Left = 141
          Top = 20
          Width = 57
          Height = 21
          DisabledColor = clWindow
          ReadOnlyColor = clWindow
          TabOrder = 1
          IntegersOnly = False
          Max = 600.000000000000000000
          DisplayFormat = '0.00'
        end
      end
    end
    object RzGroup2: TRzGroup
      Items = <>
      Opened = False
      OpenedHeight = 269
      DividerVisible = False
      Caption = #25511#21046#21442#25968
      ParentColor = False
      object RzGroupBox1: TRzGroupBox
        Left = 8
        Top = 31
        Width = 209
        Height = 218
        Caption = #22522#26412#21442#25968
        TabOrder = 0
        object RzLabel5: TRzLabel
          Left = 10
          Top = 24
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #24037#20214#26059#36716#36895#24230
        end
        object RzLabel6: TRzLabel
          Left = 10
          Top = 72
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #30005#26426#27493#36827#35282
        end
        object RzLabel7: TRzLabel
          Left = 10
          Top = 96
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #25511#21046#33033#20914#39057#29575
        end
        object RzLabel8: TRzLabel
          Left = 10
          Top = 120
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #20256#21160#27604
        end
        object RzLabel9: TRzLabel
          Left = 10
          Top = 144
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #34746#36317
        end
        object RzLabel10: TRzLabel
          Left = 10
          Top = 48
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #36724#21521#36827#32473#37327
        end
        object RzLabel11: TRzLabel
          Left = 10
          Top = 168
          Width = 89
          Height = 13
          AutoSize = False
          Caption = 'R'
        end
        object RzLabel12: TRzLabel
          Left = 10
          Top = 192
          Width = 89
          Height = 13
          AutoSize = False
          Caption = 'b'
        end
        object RzLabel24: TRzLabel
          Left = 166
          Top = 24
          Width = 40
          Height = 13
          AutoSize = False
          Caption = #36716'/'#20998
        end
        object RzLabel25: TRzLabel
          Left = 166
          Top = 48
          Width = 40
          Height = 13
          AutoSize = False
          Caption = 'mm'
        end
        object RzLabel26: TRzLabel
          Left = 166
          Top = 72
          Width = 40
          Height = 13
          AutoSize = False
          Caption = #176
        end
        object RzLabel27: TRzLabel
          Left = 166
          Top = 96
          Width = 40
          Height = 13
          AutoSize = False
          Caption = 'HZ'
        end
        object RzLabel28: TRzLabel
          Left = 166
          Top = 119
          Width = 40
          Height = 13
          AutoSize = False
          Caption = #65306'1'
        end
        object RzLabel29: TRzLabel
          Left = 166
          Top = 144
          Width = 40
          Height = 13
          AutoSize = False
          Caption = 'mm'
        end
        object RzLabel30: TRzLabel
          Left = 166
          Top = 168
          Width = 40
          Height = 13
          AutoSize = False
          Caption = 'mm'
        end
        object RzLabel31: TRzLabel
          Left = 166
          Top = 192
          Width = 40
          Height = 13
          AutoSize = False
          Caption = 'mm'
        end
        object RzNumericEdit5: TRzNumericEdit
          Left = 96
          Top = 20
          Width = 65
          Height = 21
          TabOrder = 0
          IntegersOnly = False
          Max = 300.000000000000000000
          Min = 250.000000000000000000
          Value = 250.000000000000000000
          DisplayFormat = '0'
        end
        object RzNumericEdit6: TRzNumericEdit
          Left = 96
          Top = 68
          Width = 65
          Height = 21
          TabOrder = 1
          IntegersOnly = False
          Max = 360.000000000000000000
          Value = 1.000000000000000000
          DisplayFormat = '0'
        end
        object RzNumericEdit7: TRzNumericEdit
          Left = 96
          Top = 92
          Width = 65
          Height = 21
          TabOrder = 2
          IntegersOnly = False
          Max = 100.000000000000000000
          Value = 80.000000000000000000
          DisplayFormat = '0'
        end
        object RzNumericEdit8: TRzNumericEdit
          Left = 96
          Top = 116
          Width = 65
          Height = 21
          TabOrder = 3
          IntegersOnly = False
          Max = 100.000000000000000000
          Value = 10.000000000000000000
          DisplayFormat = '0'
        end
        object RzNumericEdit9: TRzNumericEdit
          Left = 96
          Top = 140
          Width = 65
          Height = 21
          TabOrder = 4
          IntegersOnly = False
          Max = 100.000000000000000000
          Value = 12.000000000000000000
          DisplayFormat = '0'
        end
        object RzNumericEdit10: TRzNumericEdit
          Left = 96
          Top = 44
          Width = 65
          Height = 21
          TabOrder = 5
          IntegersOnly = False
          Max = 4.000000000000000000
          Value = 4.000000000000000000
          DisplayFormat = '0'
        end
        object RzNumericEdit11: TRzNumericEdit
          Left = 96
          Top = 164
          Width = 65
          Height = 21
          TabOrder = 6
          IntegersOnly = False
          Value = 300.000000000000000000
          DisplayFormat = '0'
        end
        object RzNumericEdit12: TRzNumericEdit
          Left = 96
          Top = 188
          Width = 65
          Height = 21
          TabOrder = 7
          IntegersOnly = False
          Value = 250.000000000000000000
          DisplayFormat = '0'
        end
      end
    end
    object RzGroup3: TRzGroup
      Items = <>
      Opened = False
      OpenedHeight = 417
      DividerVisible = False
      Caption = #20223#30495
      ParentColor = False
      object RzProgressBar1: TRzProgressBar
        Left = 8
        Top = 383
        Width = 209
        BarStyle = bsGradient
        BorderWidth = 0
        InteriorOffset = 0
        PartsComplete = 0
        Percent = 0
        TotalParts = 0
      end
      object RzBitBtn2: TRzBitBtn
        Tag = 1
        Left = 16
        Top = 27
        Width = 60
        GroupIndex = 1
        Caption = #24320#22987
        HotTrack = True
        TabOrder = 0
        OnClick = RzBitBtn2Click
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000530B0000530B00000001000000000000000000003300
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
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809
          09E8E8E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8E8E809
          1009E8E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8E8E8E8E8E809
          101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E809
          10101009E8E8E8E8E8E8E8E8E8E8E881ACACAC81E8E8E8E8E8E8E8E8E8E8E809
          1010101009E8E8E8E8E8E8E8E8E8E881ACACACAC81E8E8E8E8E8E8E8E8E8E809
          101010101009E8E8E8E8E8E8E8E8E881ACACACACAC81E8E8E8E8E8E8E8E8E809
          1010101009E8E8E8E8E8E8E8E8E8E881ACACACAC81E8E8E8E8E8E8E8E8E8E809
          10101009E8E8E8E8E8E8E8E8E8E8E881ACACAC81E8E8E8E8E8E8E8E8E8E8E809
          101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E809
          1009E8E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8E8E8E8E8E809
          09E8E8E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
        NumGlyphs = 2
      end
      object RzGroupBox3: TRzGroupBox
        Left = 8
        Top = 194
        Width = 209
        Height = 183
        Caption = #21152#24037#20449#24687
        TabOrder = 1
        object RzLabel13: TRzLabel
          Left = 10
          Top = 24
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #19979#21488#20301#31227#37327
        end
        object RzLabel14: TRzLabel
          Left = 10
          Top = 48
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #20013#21488#20301#31227#37327
        end
        object RzLabel15: TRzLabel
          Left = 10
          Top = 72
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #19978#21488#26059#36716#37327
        end
        object RzLabel16: TRzLabel
          Left = 10
          Top = 96
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #21152#24037#28857#22352#26631'X'
        end
        object RzLabel17: TRzLabel
          Left = 10
          Top = 120
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #21152#24037#28857#22352#26631'Y'
        end
        object RzLabel19: TRzLabel
          Left = 157
          Top = 24
          Width = 20
          Height = 13
          AutoSize = False
          Caption = 'mm'
        end
        object RzLabel20: TRzLabel
          Left = 157
          Top = 48
          Width = 20
          Height = 13
          AutoSize = False
          Caption = 'mm'
        end
        object RzLabel21: TRzLabel
          Left = 157
          Top = 72
          Width = 20
          Height = 13
          AutoSize = False
          Caption = #176
        end
        object RzLabel22: TRzLabel
          Left = 157
          Top = 96
          Width = 20
          Height = 13
          AutoSize = False
          Caption = 'mm'
        end
        object RzLabel23: TRzLabel
          Left = 157
          Top = 120
          Width = 20
          Height = 13
          AutoSize = False
          Caption = 'mm'
        end
        object RzLabel49: TRzLabel
          Left = 10
          Top = 144
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #26354#32447#26012#29575
        end
        object RzNumericEdit13: TRzNumericEdit
          Left = 93
          Top = 20
          Width = 57
          Height = 21
          DisabledColor = clWindow
          ReadOnly = True
          ReadOnlyColor = clWindow
          TabOrder = 0
          IntegersOnly = False
          DisplayFormat = '0.0000'
        end
        object RzNumericEdit14: TRzNumericEdit
          Left = 93
          Top = 44
          Width = 57
          Height = 21
          DisabledColor = clWindow
          ReadOnly = True
          ReadOnlyColor = clWindow
          TabOrder = 1
          IntegersOnly = False
          DisplayFormat = '0.0000'
        end
        object RzNumericEdit15: TRzNumericEdit
          Left = 93
          Top = 68
          Width = 57
          Height = 21
          DisabledColor = clWindow
          ReadOnly = True
          ReadOnlyColor = clWindow
          TabOrder = 2
          IntegersOnly = False
          DisplayFormat = '0.0000'
        end
        object RzNumericEdit16: TRzNumericEdit
          Left = 93
          Top = 92
          Width = 57
          Height = 21
          DisabledColor = clWindow
          ReadOnly = True
          ReadOnlyColor = clWindow
          TabOrder = 3
          IntegersOnly = False
          DisplayFormat = '0.0000'
        end
        object RzNumericEdit17: TRzNumericEdit
          Left = 93
          Top = 116
          Width = 57
          Height = 21
          DisabledColor = clWindow
          ReadOnly = True
          ReadOnlyColor = clWindow
          TabOrder = 4
          IntegersOnly = False
          DisplayFormat = '0.0000'
        end
        object RzNumericEdit25: TRzNumericEdit
          Left = 93
          Top = 140
          Width = 57
          Height = 21
          DisabledColor = clWindow
          ReadOnly = True
          ReadOnlyColor = clWindow
          TabOrder = 5
          IntegersOnly = False
          DisplayFormat = '0.0000'
        end
      end
      object RzBitBtn4: TRzBitBtn
        Tag = 2
        Left = 80
        Top = 27
        Width = 60
        GroupIndex = 1
        Caption = #20572#27490
        HotTrack = True
        TabOrder = 2
        OnClick = RzBitBtn2Click
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000430B0000430B00000001000000000000000000003300
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
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8090909
          09090909090909E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8091010
          10101010101009E8E8E8E8E8E881ACACACACACACACAC81E8E8E8E8E8E8090909
          09090909090909E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
        NumGlyphs = 2
      end
      object RzRadioGroup3: TRzRadioGroup
        Left = 8
        Top = 101
        Width = 209
        Height = 89
        Caption = #36827#32473#37327
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          #27491#24120
          #21152#36895)
        TabOrder = 3
        OnClick = RzRadioGroup3Click
        object RzLabel18: TRzLabel
          Left = 157
          Top = 40
          Width = 34
          Height = 13
          AutoSize = False
          Caption = 'mm/'#20998
        end
        object RzLabel36: TRzLabel
          Left = 10
          Top = 40
          Width = 41
          Height = 13
          AutoSize = False
          Caption = #36827#32473#37327
        end
        object RzLabel37: TRzLabel
          Left = 10
          Top = 64
          Width = 73
          Height = 13
          AutoSize = False
          Caption = #33033#20914#27493#36827#37327' '
        end
        object RzLabel38: TRzLabel
          Left = 157
          Top = 64
          Width = 51
          Height = 13
          AutoSize = False
          Caption = 'mm/'#33033#20914
        end
        object RzNumericEdit18: TRzNumericEdit
          Left = 93
          Top = 36
          Width = 57
          Height = 21
          DisabledColor = clWindow
          ReadOnly = True
          ReadOnlyColor = clWindow
          TabOrder = 0
          IntegersOnly = False
          DisplayFormat = '0.00'
        end
        object maichong_bujin: TRzNumericEdit
          Left = 93
          Top = 60
          Width = 57
          Height = 21
          DisabledColor = clWindow
          ReadOnly = True
          ReadOnlyColor = clWindow
          TabOrder = 1
          IntegersOnly = False
          DisplayFormat = '0.0000'
        end
      end
      object RzRadioGroup5: TRzRadioGroup
        Left = 8
        Top = 56
        Width = 209
        Height = 41
        Caption = #30722#36718#21152#24037#20301#32622
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #19981#21464
          #21464#21160)
        TabOrder = 4
        OnClick = RzRadioGroup5Click
      end
      object RzBitBtn3: TRzBitBtn
        Left = 144
        Top = 27
        Width = 60
        GroupIndex = 1
        Caption = #22797#20301
        HotTrack = True
        TabOrder = 5
        OnClick = RzBitBtn3Click
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000A30E0000A30E00000001000000000000000000003300
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
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E881E8E8E8E8E8E8E8E8E8E8E8E8E8E80909
          E8E8E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8E8090909
          09090909090909E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8E80909
          E8E8E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E881E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8A37878787878
          78E8E85E5E5E5E5E5E5E81818181818181E8E881818181818181A3D5D5D5D5D5
          78E8E85ED7D7D7D7D75E81ACACACACAC81E8E881E8E8E8E8E881A3D5D5D5D5D5
          78E8E85ED7D7D7D7D75E81ACACACACAC81E8E881E8E8E8E8E881A3D5D5D5D5D5
          78E8E85ED7D7D7D7D75E81ACACACACAC81E8E881E8E8E8E8E881A3D5D5D5D5D5
          78E8E85ED7D7D7D7D75E81ACACACACAC81E8E881E8E8E8E8E881A3D5D5A3A3A3
          A3E8E85ED7D75E5E5E5E81ACAC81818181E8E881E8E881818181A3D5D5A3D678
          E8E8E85ED7D75EE35EE881ACAC81AC81E8E8E881E8E881E381E8A3D5D5A378E8
          E8E8E85ED7D75E5EE8E881ACAC8181E8E8E8E881E8E88181E8E8A3A3A3A3E8E8
          E8E8E85E5E5E5EE8E8E881818181E8E8E8E8E881818181E8E8E8}
        NumGlyphs = 2
      end
    end
    object RzGroup4: TRzGroup
      Items = <>
      Opened = False
      OpenedHeight = 365
      DividerVisible = False
      Caption = #26354#32447
      ParentColor = False
      object RzPageControl1: TRzPageControl
        Left = 1
        Top = 20
        Width = 232
        Height = 341
        ActivePage = TabSheet1
        ParentColor = False
        TabIndex = 0
        TabOrder = 0
        TabOrientation = toBottom
        FixedDimension = 19
        object TabSheet1: TRzTabSheet
          Caption = #24037#20214
          object cht1: TChart
            Left = 0
            Top = 0
            Width = 230
            Height = 201
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
            Legend.Visible = False
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
            DepthAxis.TicksInner.Color = 11119017
            DepthTopAxis.TicksInner.Color = 11119017
            Frame.Visible = False
            LeftAxis.Axis.Color = 4210752
            LeftAxis.Grid.Visible = False
            LeftAxis.TicksInner.Color = 11119017
            RightAxis.TicksInner.Color = 11119017
            TopAxis.TicksInner.Color = 11119017
            View3D = False
            Align = alTop
            Color = clWhite
            TabOrder = 0
            OnDblClick = cht1DblClick
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
              Band2.Color = clWhite
              AxisID = 2
            end
          end
          object cht6: TChart
            Left = 0
            Top = 203
            Width = 230
            Height = 117
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
            TabOrder = 1
            OnDblClick = cht1DblClick
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
              Band2.Color = clWhite
              AxisID = 2
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Caption = #19979#21488
          object cht2: TChart
            Left = 0
            Top = 0
            Width = 230
            Height = 201
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
            Align = alTop
            Color = clWhite
            TabOrder = 0
            OnDblClick = cht1DblClick
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
              Band2.Color = clWhite
              AxisID = 2
            end
          end
          object cht7: TChart
            Left = 0
            Top = 201
            Width = 230
            Height = 117
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
            Align = alTop
            Color = clWhite
            TabOrder = 1
            OnDblClick = cht1DblClick
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
              Band2.Color = clWhite
              AxisID = 2
            end
          end
        end
        object TabSheet3: TRzTabSheet
          Caption = #20013#21488
          object cht3: TChart
            Left = 0
            Top = 0
            Width = 230
            Height = 201
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
            Align = alTop
            Color = clWhite
            TabOrder = 0
            OnDblClick = cht1DblClick
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
              Band2.Color = clWhite
              AxisID = 2
            end
          end
          object cht8: TChart
            Left = 0
            Top = 201
            Width = 230
            Height = 117
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
            Align = alTop
            Color = clWhite
            TabOrder = 1
            OnDblClick = cht1DblClick
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
              Band2.Color = clWhite
              AxisID = 2
            end
          end
        end
        object TabSheet4: TRzTabSheet
          Caption = #19978#21488
          object cht4: TChart
            Left = 0
            Top = 201
            Width = 230
            Height = 117
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
            Align = alTop
            Color = clWhite
            TabOrder = 0
            OnDblClick = cht1DblClick
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
              Band2.Color = clWhite
              AxisID = 2
            end
          end
          object cht5: TChart
            Left = 0
            Top = 0
            Width = 230
            Height = 201
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
            Align = alTop
            Color = clWhite
            TabOrder = 1
            OnDblClick = cht1DblClick
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
              Band2.Color = clWhite
              AxisID = 2
            end
          end
        end
      end
    end
  end
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 716
    Width = 1135
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 2
    object RzClockStatus1: TRzClockStatus
      Left = 985
      Top = 0
      Height = 19
      Align = alRight
      Alignment = taRightJustify
    end
    object RzStatusPane1: TRzStatusPane
      Left = 0
      Top = 0
      Width = 985
      Height = 19
      Align = alClient
    end
  end
  object RzToolbar1: TRzToolbar
    Left = 0
    Top = 0
    Width = 1135
    Height = 29
    Images = il1
    BorderInner = fsNone
    BorderOuter = fsGroove
    BorderSides = [sdTop]
    BorderWidth = 0
    TabOrder = 3
    ToolbarControls = (
      RzToolButton1
      RzToolButton2
      RzToolButton3
      RzToolButton4
      RzToolButton7
      RzToolButton8
      RzSpacer1
      RzToolButton5
      RzToolButton6
      RzSpacer2
      RzToolButton9
      RzSpacer3
      RzToolButton10)
    object RzToolButton1: TRzToolButton
      Tag = 1
      Left = 4
      Top = 2
      ImageIndex = 0
      OnMouseDown = RzToolButton1MouseDown
      OnMouseUp = RzToolButton1MouseUp
    end
    object RzToolButton2: TRzToolButton
      Tag = 2
      Left = 29
      Top = 2
      ImageIndex = 2
      OnMouseDown = RzToolButton1MouseDown
      OnMouseUp = RzToolButton1MouseUp
    end
    object RzToolButton3: TRzToolButton
      Tag = 3
      Left = 54
      Top = 2
      ImageIndex = 4
      OnMouseDown = RzToolButton1MouseDown
      OnMouseUp = RzToolButton1MouseUp
    end
    object RzToolButton4: TRzToolButton
      Tag = 4
      Left = 79
      Top = 2
      ImageIndex = 6
      OnMouseDown = RzToolButton1MouseDown
      OnMouseUp = RzToolButton1MouseUp
    end
    object RzToolButton7: TRzToolButton
      Tag = 5
      Left = 104
      Top = 2
      ImageIndex = 8
      OnMouseDown = RzToolButton1MouseDown
      OnMouseUp = RzToolButton1MouseUp
    end
    object RzToolButton8: TRzToolButton
      Tag = 6
      Left = 129
      Top = 2
      ImageIndex = 10
      OnMouseDown = RzToolButton1MouseDown
      OnMouseUp = RzToolButton1MouseUp
    end
    object RzSpacer1: TRzSpacer
      Left = 154
      Top = 2
    end
    object RzToolButton5: TRzToolButton
      Left = 162
      Top = 2
      ImageIndex = 12
    end
    object RzToolButton6: TRzToolButton
      Left = 187
      Top = 2
      ImageIndex = 14
    end
    object RzSpacer2: TRzSpacer
      Left = 212
      Top = 2
    end
    object RzToolButton9: TRzToolButton
      Left = 220
      Top = 2
      ImageIndex = 18
      OnClick = cht1DblClick
    end
    object RzToolButton10: TRzToolButton
      Left = 253
      Top = 2
      ImageIndex = 19
      OnClick = N3Click
    end
    object RzSpacer3: TRzSpacer
      Left = 245
      Top = 2
    end
  end
  object MainMenu1: TMainMenu
    Left = 592
    Top = 16
    object N1: TMenuItem
      Caption = #25171#24320
    end
    object N2: TMenuItem
      Caption = #32534#36753
    end
    object N3: TMenuItem
      Caption = #36864#20986
      OnClick = N3Click
    end
  end
  object GLScene1: TGLScene
    Left = 624
    Top = 16
    object DummyCube1: TGLDummyCube
      Scale.Coordinates = {6F12833B6F12833B6F12833B00000000}
      ShowAxes = True
      CubeSize = 1.000000000000000000
      object glcb_shang_tai: TGLCube
        Material.FrontProperties.Diffuse.Color = {FFFEFE3E0000803F000000000000803F}
        Material.FrontProperties.Emission.Color = {8180003E000000000000803F0000803F}
        Material.Texture.MappingTCoordinates.Coordinates = {000000000000803F0000000000000000}
        Position.Coordinates = {00000000000007C30000CD430000803F}
        CubeSize = {000016440000B44200009644}
      end
      object glcb_zhong_tai: TGLCube
        Material.FrontProperties.Ambient.Color = {0000803F00000000000000000000803F}
        Material.FrontProperties.Diffuse.Color = {00000000EBEAEA3E000000000000803F}
        Material.FrontProperties.Emission.Color = {B3B2323FA9A8283E000000000000803F}
        Material.FrontProperties.Specular.Color = {0000803F00000000000000000000803F}
        Material.Texture.MappingTCoordinates.Coordinates = {000000000000803F0000000000000000}
        Position.Coordinates = {00000000000061C30000CD430000803F}
        CubeSize = {00007A440000B4420080A244}
      end
      object glcb_xia_tai: TGLCube
        Material.FrontProperties.Diffuse.Color = {F8FEFE3E0000803F000000000000803F}
        Material.Texture.MappingTCoordinates.Coordinates = {000000000000803F0000000000000000}
        Position.Coordinates = {0000000000809DC3000000000000803F}
        CubeSize = {000096440000B44200803B45}
      end
      object sha_lun: TGLDummyCube
        Position.Coordinates = {000096430000484300009B430000803F}
        CubeSize = 1.000000000000000000
        object yuan_zhu: TGLCylinder
          Direction.Coordinates = {0000803F000000000000008000000000}
          Up.Coordinates = {00000000000000000000803F00000000}
          Visible = False
          BottomRadius = 40.000000000000000000
          Height = 60.000000000000000000
          Slices = 60
          TopRadius = 40.000000000000000000
        end
        object yuan_zhui: TGLDummyCube
          CubeSize = 1.000000000000000000
          object GLCylinder1: TGLCylinder
            Direction.Coordinates = {0000803F000000000000008000000000}
            Up.Coordinates = {00000000000000000000803F00000000}
            BottomRadius = 40.000000000000000000
            Height = 20.000000000000000000
            Slices = 32
            TopRadius = 40.000000000000000000
          end
          object GLTorus1: TGLTorus
            MajorRadius = 40.000000000000000000
            MinorRadius = 10.000000000000000000
            Rings = 60
            Sides = 60
          end
        end
        object glcb2: TGLCube
          CubeSize = {00002041000020410000C842}
        end
      end
      object glcb_work_coor: TGLDummyCube
        Position.Coordinates = {000000000000000000007A430000803F}
        ShowAxes = True
        CubeSize = 1.000000000000000000
        object glcb_work: TGLCube
          Material.FrontProperties.Diffuse.Color = {BBBABA3EBDBC3C3F000000000000803F}
          Material.FrontProperties.Emission.Color = {F3F2F23E00000000F2F1713F0000803F}
          Material.Texture.MappingTCoordinates.Coordinates = {000000000000803F0000000000000000}
          Position.Coordinates = {00000000000034C2000020430000803F}
          CubeSize = {0000E1430000B44200007A44}
          object gong_jian: TGLRevolutionSolid
            Position.Coordinates = {0000000000005C430000CDC30000803F}
            Nodes = <>
            Division = 180
            Parts = [rspOutside, rspInside]
            Slices = 60
            object GLCylinder2: TGLCylinder
              Material.FrontProperties.Emission.Color = {0000803F00000000000000000000803F}
              Position.Coordinates = {000000000000A0C1000000000000803F}
              BottomRadius = 172.000000000000000000
              Height = 40.000000000000000000
              Slices = 32
              TopRadius = 170.000000000000000000
            end
          end
          object glcb1: TGLCube
            Material.FrontProperties.Diffuse.Color = {BBBABA3EBBBABA3E000000000000803F}
            Material.FrontProperties.Emission.Color = {00000000A7A6263F000000000000803F}
            Material.Texture.MappingTCoordinates.Coordinates = {000000000000803F0000000000000000}
            Position.Coordinates = {00000000000075430080EDC30000803F}
            CubeSize = {0000C8430000C84300004842}
          end
        end
      end
    end
    object GLDCcamera: TGLDummyCube
      CubeSize = 1.000000000000000000
      object GLCamera1: TGLCamera
        DepthOfView = 1000.000000000000000000
        FocalLength = 180.000000000000000000
        TargetObject = GLDCcamera
        Position.Coordinates = {0000204100002041000020410000803F}
        object GLLightSource1: TGLLightSource
          ConstAttenuation = 1.000000000000000000
          SpotCutOff = 180.000000000000000000
        end
      end
    end
  end
  object tmr1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmr1Timer
    Left = 664
    Top = 16
  end
  object tmr2: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmr2Timer
    Left = 696
    Top = 16
  end
  object tmr3: TTimer
    Interval = 100
    OnTimer = tmr3Timer
    Left = 728
    Top = 16
  end
  object il1: TImageList
    Left = 320
    Top = 64
    Bitmap = {
      494C010115001900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000007000000001002000000000000070
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E2EFF100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E2EF
      F10000000000CCCCCC00E5E5E500E2EFF1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E2EFF10000000000B2B2
      B200999999009999990099999900B2B2B200CCCCCC0000000000E2EFF1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900999999009999
      990099999900FFFFFF00999999009999990099999900B2B2B200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009999990099999900C0C0C000C0C0
      C000CCCCCC00FFFFFF0099999900999999009999990099999900E2EFF1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900C0C0C000C0C0C000C0C0
      C000CCCCCC00FFFFFF0099999900C0C0C000C0C0C00099999900FFFFFF00CCCC
      CC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900C0C0C000C0C0C000C0C0
      C000CCCCCC00FFFFFF0099999900C0C0C000CCCCCC0099999900CCCCCC009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900C0C0C000999999009999
      9900CCCCCC00FFFFFF0099999900CCCCCC00CCCCCC00B2B2B200999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900C0C0C00066666600FFFF
      FF00CCCCCC00FFFFFF0099999900CCCCCC00C0C0C00099999900999999009999
      9900999999009999990099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900C0C0C000999999006666
      6600CCCCCC00FFFFFF0099999900E5E5E5009999990099999900999999009999
      9900999999009999990099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900C0C0C000C0C0C000C0C0
      C000CCCCCC00FFFFFF0099999900E5E5E5009999990099999900999999009999
      9900999999009999990099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900C0C0C000C0C0C000C0C0
      C000CCCCCC00FFFFFF0099999900CCCCCC00E2EFF10099999900999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900C0C0C000C0C0C000C0C0
      C000CCCCCC00FFFFFF0099999900CCCCCC00E5E5E500CCCCCC00C0C0C0009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009999990099999900C0C0C000C0C0
      C000CCCCCC00FFFFFF0099999900CCCCCC00E5E5E5009999990000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000999999009999
      9900C0C0C000FFFFFF0099999900999999009999990099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CCCC
      CC00999999009999990099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E2EFF100000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AC5D22FFAB5C22FFA95C
      21FFA85C21FFA75A21FFA65A21FFA65A20FFA55920FFA5591FFFA4581FFFA458
      1FFFA3581FFFA2571FFFA2571FFF0000000000000000AC5D22FFAB5C22FFA95C
      21FFA85C21FFA75A21FFA65A21FFA65A20FFA55920FFA5591FFFA4581FFFA458
      1FFFA3581FFFA2571FFFA2571FFF000000000522400004213F0004213F000110
      540001105400011054001C1A390036251F0036251F001C2A1F0001301F000130
      1F0001301F0004213F0004213F0005224000000000000000000000000000E2EF
      F100E5E5E500CCCCCC00E5E5E500E2EFF1000000000000000000000000000000
      00000000000000000000000000000000000000000000AE5E24FF091C0C4F0819
      0A460C12084501030109000000000603011D00000000000000000603011D0000
      0000030A041A0E1F0C680104020C0000000000000000AE5E24FF091C0C4F0819
      0A460C12084501030109000000000603011D00000000000000000603011D0000
      0000030A041A0E1F0C680104020C000000000B2B4B00CADAE200C5D6DE000800
      A7002F1EDB002513D700785A7500DAA73000D6A32C0059782C0041C985003DC5
      810014864D00C5D6DE00CADAE2000B2B4B0000000000E2EFF100E5E5E500B2B2
      B200CC9999009966660099666600B2B2B200CCCCCC00E5E5E500E2EFF1000000
      00000000000000000000000000000000000000000000AF5F24FF030A0419143F
      1B991F5D27E21F612AED0E2B1268000000000000000000000000000000000103
      01081E6728DE13451993000000000000000000000000AF5F24FF030A0419143F
      1B991F5D27E21F612AED0E2B1268000000000000000000000000000000000103
      01081E6728DE13451993000000000000000014365900B3C3CF00AEBFCB000A00
      B0002B1ADC001500D30080637900D8A52E00CF9C25006386350040C8840036BE
      7A001C945800AEBFCB00B3C3CF0014365900E5E5E500CC99990099666600CC99
      9900CC999900FFFFFF00996666009999990099999900B2B2B200E5E5E5000000
      00000000000000000000000000000000000000000000B16124FF070324400000
      00000000000017491F96257733F1185021A20106020C00000000000000001446
      1C88227E2FEF00000000000000000000000000000000B16124FF070324400000
      00000000000017491F96257733F1185021A20106020C00000000000000001446
      1C88227E2FEF000000000000000000000000183B5F00CADAE200C1D2DA000C00
      B6003221E2001800D900896D7D00DAA73000D09D2600678B380043CB870038C0
      7C001F9A5D00C1D2DA00CADAE200183B5F0099666600CC999900FFCC9900FFCC
      9900FFCCCC00FFFFFF0099666600336699003366990033669900E2EFF1000000
      00000000000000000000000000000000000000000000B36225FF000051540000
      161700000000000000000D29124A298237E8277E35E01F6228AD206D2BBE298E
      36F40F37145F000000000100191A0000000000000000B36225FF000051540000
      161700000000000000000D29124A298237E8277E35E01F6228AD206D2BBE298E
      36F40F37145F000000000100191A000000001A3E6200B7C7D300B2C3CF000D00
      BB003A29E8001B00DF008E748000DDAA3300D29F28006B903C0046CE8A003AC2
      7E0023A06100B2C3CF00B7C7D3001A3E620099666600FFCC9900FFCC9900FFCC
      9900FFCCCC00FFFFFF009966660066CCCC0066CCCC000099CC00FFFFFF00FFCC
      CC000000000000000000000000000000000000000000B56326FF00004F4F0300
      DCDC000000000000000000000000641F00771F5A2597277B32CC257B31CD0F34
      145700000000000000000D0BACB00000000000000000B56326FF00004F4F0300
      DCDC000000000000000000000000641F00771F5A2597277B32CC257B31CD0F34
      145700000000000000000D0BACB0000000001C416600D0DFE700C7D8E0000E00
      C0004130EE001D00E500977D8500E0AD3600D4A12A006F953F004AD18E003DC4
      810026A66600C7D8E000D0DFE7001C41660099666600FFCC9900FFCC9900FFCC
      9900FFCCCC00FFFFFF009966660066CCCC0066CCFF003399CC00FFCCCC00CC66
      00000000000000000000000000000000000000000000B76526FF0C07142F0B08
      FCFE0604848671270084DC4B00FFDA4A00FDDB4A01FE4A190157000000000000
      000000000000000000001B18F3FA0000000000000000B76526FF0C07142F0B08
      FCFE0604848671270084DC4B00FFDA4A00FDDB4A01FE4A190157000000000000
      000000000000000000001B18F3FA000000001E446A00BCCCD800B7C8D4000F00
      C4004737F3002000EA009C828700E3B03900D7A42D00729942004DD591003FC7
      830029AB6A00B7C8D400BCCCD8001E446A0099666600FFCC9900CC999900CC99
      6600FFCCCC00FFFFFF009966660099CCCC0099CCFF00B2B2B200FF660000CC66
      00000000000000000000000000000000000000000000B96628FF000000000C0A
      A1A51411F4FBAC3F30F77D300392020100039E3E07B8D4520BF86B2A077E0000
      0000000000001B18BAC02120E7F00000000000000000B96628FF000000000C0A
      A1A51411F4FBAC3F30F77D300392020100039E3E07B8D4520BF86B2A077E0000
      0000000000001B18BAC02120E7F00000000020466D00D6E4ED00CDDEE6001000
      C8007675FF007675FF00A28B8B00E6B33C00D9A62F00759D450050D8940041C9
      85002CAF6E00CDDEE600D6E4ED0020466D0099666600FFCC990099666600FFFF
      FF00FFCCCC00FFFFFF009966660099CCCC00C0C0C000CC660000CC660000CC66
      0000CC660000CC660000CC6600000000000000000000BB6728FF000000000000
      00002D20E7FE3826D7F900000000000000000000000090410FA8D6641BFB8740
      129F060523252C29F5FF4A2E5C970000000000000000BB6728FF000000000000
      00002D20E7FE3826D7F900000000000000000000000090410FA8D6641BFB8740
      129F060523252C29F5FF4A2E5C970000000022497000C1D0DD00BCCDD900372F
      CB001100CC003329CF00C28F1D00E9B63F00DAA7300079A2470053DB970043CB
      87002FB47100BCCDD900C1D0DD002249700099666600FFCC9900CC9999009966
      6600FFCCCC00FFFFFF009966660000000000CC660000CC660000CC660000CC66
      0000CC660000CC660000CC6600000000000000000000BC6729FF0D06021D7739
      0A8AA25259FA2C26ECF71A198F95000000000000000000000000793F168DD975
      2CFDD7752DFBD5782FF9DA7C32FE0000000000000000BC6729FF0D06021D7739
      0A8AA25259FA2C26ECF71A198F95000000000000000000000000793F168DD975
      2CFDD7752DFBD5782FF9DA7C32FE00000000244C7300DCEAF200D3E4EC00D3E4
      EC00D3E4EC00D3E4EC00C5921F00EBB84100DCA932007BA54A0066EEAA0066EE
      AA0031B87400D3E4EC00DCEAF200244C730099666600FFCC9900FFCC9900FFCC
      9900FFCCCC00FFFFFF009966660000000000CC999900CC660000CC660000CC66
      0000CC660000CC660000CC6600000000000000000000BD682AFF02010003D670
      22F99D541BB61C1B81873734F2FE0D0D383C0000000000000000080720223B39
      E1F1413CE3F66E441F80000000000000000000000000BD682AFF02010003D670
      22F99D541BB61C1B81873734F2FE0D0D383C0000000000000000080720223B39
      E1F1413CE3F66E441F800000000000000000264E7600C6D5E200C1D2DE00C1D2
      DE00C1D2DE00C1D2DE00C8952000EDBA4300DDAA33007EA84C0033BB770033BB
      770051BC8D00C1D2DE00C6D5E200264E760099666600FFCC9900FFCC9900FFCC
      9900FFCCCC00FFFFFF0099666600CCCCCC00E2EFF100CC999900FF660000CC66
      00000000000000000000000000000000000000000000BE692AFF2C180933D87D
      33FD07040109000000003431B6C34441EBFA3735BECA3D3BCEDD4543EAFB3E3D
      D2E209091F2200000000000000000000000000000000BE692AFF2C180933D87D
      33FD07040109000000003431B6C34441EBFA3735BECA3D3BCEDD4543EAFB3E3D
      D2E209091F2200000000000000000000000027507900E2EFF700D9EAF200D9EA
      F200D9EAF200D9EAF200CA972100FFCC5500FFCC5500CA972100D9EAF200D9EA
      F200D9EAF200D9EAF200E2EFF7002750790099666600FFCC9900FFCC9900FFCC
      9900FFCCCC00FFFFFF009966660099CCCC000000000099CCCC00FFCC9900CC66
      00000000000000000000000000000000000000000000BF6A2AFF4C2D14668E58
      2BA70000000000000000000000002A29808A4442D0E03F3EC4D31C1B575E0000
      00000000000000000000000000000000000000000000BF6A2AFF4C2D14668E58
      2BA70000000000000000000000002A29808A4442D0E03F3EC4D31C1B575E0000
      00000000000000000000000000000000000029527B00CAD9E500C5D6E200C5D6
      E200C5D6E200C5D6E200C5A34E00CC992200CC992200C5A34E00C5D6E200C5D6
      E200C5D6E200C5D6E200CAD9E50029527B0099666600CC999900FFCC9900FFCC
      9900FFCCCC00FFFFFF0099666600CCCCCC00000000003399CC0000000000FFCC
      99000000000000000000000000000000000000000000BF6A2AFF472E1A540000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BF6A2AFF472E1A540000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002A547D00EAF4FD00E5F2FA00E5F2
      FA00E5F2FA00E5F2FA00E5F2FA00E5F2FA00E5F2FA00E5F2FA00E5F2FA00E5F2
      FA00E5F2FA00E5F2FA00EAF4FD002A547D0000000000C0C0C000CC996600CC99
      9900CCCC9900FFFFFF00996666000099CC000099CC000099CC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002B557F002B557F002B557F002B55
      7F002B557F002B557F002B557F002B557F002B557F002B557F002B557F002B55
      7F002B557F002B557F002B557F002B557F00000000000000000000000000CCCC
      CC00CC9999009966660099666600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009933000099330000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009999990099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000993300009933000099330000993300009933000099330000993300009933
      0000993300000000000000000000000000000000000000000000000000009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000993300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000993300000000000000000000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000993300000000000000000000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000993300000000000000000000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC00CCCCCC00999999000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000993300000000000000000000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC660000CC660000CC6600009933
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC009999
      9900000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000993300000000000000000000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC00CCCCCC00999999000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000993300000000000000000000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000993300000000000000000000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000993300000000000000000000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000993300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000993300009933000099330000993300009933000099330000993300009933
      0000993300000000000000000000000000000000000000000000000000009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999000000000000000000000000000000000000000000000000000000
      0000000000009933000099330000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009999990099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC99660000000000CC99
      660000000000CC99660000000000CC99660000000000CC99660000000000CC99
      660000000000CC996600000000000000000000000000CCCCCC0000000000CCCC
      CC0000000000CCCCCC0000000000CCCCCC0000000000CCCCCC0000000000CCCC
      CC0000000000CCCCCC0000000000000000000000000099330000993300009933
      0000993300009933000099330000993300009933000099330000993300009933
      0000993300009933000000000000000000000000000099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600CC9966009933000000000000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC0099999900000000000000000000000000CC996600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CC996600000000000000000000000000CCCCCC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCCCCC0000000000000000000000000099330000CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600CC9966009933000000000000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600CC9966009933000000000000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC0099999900000000000000000000000000CC996600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CC996600000000000000000000000000CCCCCC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCCCCC0000000000000000000000000099330000993300009933
      0000993300009933000099330000993300009933000099330000993300009933
      0000993300009933000000000000000000000000000099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC996600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CC996600000000000000000000000000CCCCCC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCCCCC00000000000000000000000000CC996600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CC996600000000000000000000000000CCCCCC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCCCCC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000993300009933
      0000993300009933000099330000993300009933000099330000993300009933
      0000993300009933000000000000000000000000000099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      99009999990099999900000000000000000000000000CC996600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CC996600000000000000000000000000CCCCCC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCCCCC0000000000000000000000000099330000CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600CC9966009933000000000000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600CC9966009933000000000000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC0099999900000000000000000000000000CC996600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CC996600000000000000000000000000CCCCCC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCCCCC0000000000000000000000000099330000CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600CC9966009933000000000000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000993300009933
      0000993300009933000099330000993300009933000099330000993300009933
      0000993300009933000000000000000000000000000099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      99009999990099999900000000000000000000000000CC99660000000000CC99
      660000000000CC99660000000000CC99660000000000CC99660000000000CC99
      660000000000CC996600000000000000000000000000CCCCCC0000000000CCCC
      CC0000000000CCCCCC0000000000CCCCCC0000000000CCCCCC0000000000CCCC
      CC0000000000CCCCCC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009933000099330000993300009933000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009999990099999900999999009999990099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000993300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099330000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900CCCCCC009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000099330000CC660000CC660000CC660000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      000099999900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00999999000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC6600009933
      0000000000000000000000000000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC009999
      9900000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      000000000000000000000000000000000000000000000000000099330000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      000099330000000000000000000000000000000000000000000099999900CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000993300009933
      00009933000099330000CC660000CC660000CC66000099330000993300009933
      0000993300000000000000000000000000000000000000000000999999009999
      99009999990099999900CCCCCC00CCCCCC00CCCCCC0099999900999999009999
      990099999900000000000000000000000000000000000000000099330000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      000099330000000000000000000000000000000000000000000099999900CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC0099999900000000000000000000000000000000000000000099330000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      000099330000000000000000000000000000000000000000000099999900CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000993300009933
      00009933000099330000CC660000CC660000CC66000099330000993300009933
      0000993300000000000000000000000000000000000000000000999999009999
      99009999990099999900CCCCCC00CCCCCC00CCCCCC0099999900999999009999
      990099999900000000000000000000000000000000000000000099330000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      000099330000000000000000000000000000000000000000000099999900CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC6600009933
      0000000000000000000000000000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC009999
      9900000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000099330000CC660000CC660000CC660000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      000099999900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00999999000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099330000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900CCCCCC009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000993300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009933000099330000993300009933000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009999990099999900999999009999990099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099330000993300009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900999999009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000993300009933000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000999999009999990099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000099330000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000099999900CCCCCC00CCCCCC00999999000000
      0000000000000000000000000000000000000000000000000000000000000000
      000099330000CC660000CC660000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000099999900CCCCCC00CCCCCC00CCCCCC009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000099330000CC660000CC660000CC6600009933
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000099999900CCCCCC00CCCCCC00CCCCCC009999
      9900000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC6600009933000099330000993300009933
      0000993300009933000099330000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC009999990099999900999999009999
      9900999999009999990099999900000000000000000099330000993300009933
      000099330000993300009933000099330000CC660000CC660000CC660000CC66
      0000993300000000000000000000000000000000000099999900999999009999
      990099999900999999009999990099999900CCCCCC00CCCCCC00CCCCCC00CCCC
      CC0099999900000000000000000000000000000000000000000099330000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000CC660000CC6600009933000000000000000000000000000099999900CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC0099999900000000000000000099330000CC660000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000CC6600009933000000000000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC009999990000000000000000000000000099330000CC660000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000CC660000CC66000099330000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC0099999900000000000000000099330000CC660000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000CC660000CC66000099330000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC009999990000000000000000000000000099330000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000CC660000CC6600009933000000000000000000000000000099999900CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC0099999900000000000000000099330000CC660000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000CC6600009933000000000000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC009999990000000000000000000000000000000000000000009933
      0000CC660000CC660000CC660000CC6600009933000099330000993300009933
      0000993300009933000099330000000000000000000000000000000000009999
      9900CCCCCC00CCCCCC00CCCCCC00CCCCCC009999990099999900999999009999
      9900999999009999990099999900000000000000000099330000993300009933
      000099330000993300009933000099330000CC660000CC660000CC660000CC66
      0000993300000000000000000000000000000000000099999900999999009999
      990099999900999999009999990099999900CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00999999000000000000000000000000000000000000000000000000000000
      000099330000CC660000CC660000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000099999900CCCCCC00CCCCCC00CCCCCC009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000099330000CC660000CC660000CC6600009933
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000099999900CCCCCC00CCCCCC00CCCCCC009999
      9900000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000099330000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000099999900CCCCCC00CCCCCC00999999000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099330000993300009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900999999009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000993300009933000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000999999009999990099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000700000000100010000000000800300000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FDFF000000000000E8FF000000000000
      A05F000000000000803F000000000000001F000000000000000F000000000000
      000F000000000000000F00000000000000010000000000000001000000000000
      0001000000000000000F000000000000000F000000000000002F000000000000
      803F000000000000E1FF000000000000FFFFFFFFFFFFFDFF800180010000E0FF
      82D182D10000801F81E381E30000001F986798670000001F8C058C050000000F
      8E0D8E0D0000000F803D803D0000000FA019A01900000001B381B38100000101
      81C181C10000010180C380C30000000F840784070000008F8E1F8E1F000000AF
      9FFF9FFF0000803FFFFFFFFF0000E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF9FFF9FFE007E007F8FFF8FFE007E007F87FF87FE007E007
      F83FF83FE007E007F81FF81FE007E007F80FF80FE007E007F81FF81FE007E007
      F83FF83FE007E007F87FF87FE007E007F8FFF8FFE007E007F9FFF9FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      AAABAAAB80038003FFFFFFFF80038003BFFBBFFB80038003FFFFFFFF80038003
      BFFBBFFB80038003FFFFFFFFFFFFFFFFBFFBBFFBBFFBBFFBFFFFFFFFFFFFFFFF
      80038003BFFBBFFB80038003FFFFFFFF80038003BFFBBFFB80038003FFFFFFFF
      80038003AAABAAABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF83FF83FFEFFFEFF
      F83FF83FFC7FFC7FF83FF83FF83FF83FF83FF83FF01FF01FF83FF83FE00FE00F
      F83FF83FC007C007C007C007C007C007C007C007C007C007C007C007F83FF83F
      E00FE00FF83FF83FF01FF01FF83FF83FF83FF83FF83FF83FFC7FFC7FF83FF83F
      FEFFFEFFF83FF83FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFC7FFC7FFE3FFE3FF87FF87FFE1FFE1FF07FF07FFE0FFE0F
      E001E00180078007C001C001800380038001800180018001C001C00180038003
      E001E00180078007F07FF07FFE0FFE0FF87FF87FFE1FFE1FFC7FFC7FFE3FFE3F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
