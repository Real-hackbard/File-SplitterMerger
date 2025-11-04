object Form1: TForm1
  Left = 382
  Top = 115
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'File Splitter & Merger'
  ClientHeight = 392
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnShow = FormShow
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 52
    Width = 403
    Height = 321
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    TabStop = False
    OnChanging = PageControlChanging
    ExplicitWidth = 399
    ExplicitHeight = 320
    object SplitTab: TTabSheet
      Caption = 'Splitter'
      object Label3: TLabel
        Left = 48
        Top = 6
        Width = 22
        Height = 13
        Caption = 'File :'
      end
      object Label4: TLabel
        Left = 32
        Top = 33
        Width = 38
        Height = 13
        Caption = 'Output :'
      end
      object Label7: TLabel
        Left = 19
        Top = 86
        Width = 51
        Height = 13
        Caption = 'After Split :'
      end
      object Label5: TLabel
        Left = 9
        Top = 60
        Width = 61
        Height = 13
        Caption = 'Split Format :'
      end
      object Label13: TLabel
        Left = 76
        Top = 86
        Width = 6
        Height = 13
        Caption = '?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Button1: TButton
        Left = 363
        Top = 3
        Width = 24
        Height = 21
        Hint = 'Load any file to Splitt'
        Caption = '...'
        TabOrder = 0
        TabStop = False
        OnClick = Button1Click
      end
      object Edit1: TEdit
        Left = 76
        Top = 3
        Width = 281
        Height = 21
        TabStop = False
        TabOrder = 1
        OnExit = Edit1Exit
      end
      object Button2: TButton
        Left = 363
        Top = 30
        Width = 24
        Height = 21
        Hint = 'Select Output Folder'
        Caption = '...'
        TabOrder = 2
        TabStop = False
        OnClick = Button2Click
      end
      object Edit2: TEdit
        Left = 76
        Top = 30
        Width = 281
        Height = 21
        Hint = 'blank = use source file'#39's folder'
        TabStop = False
        TabOrder = 3
      end
      object SplitBottomPanel: TPanel
        Left = 0
        Top = 261
        Width = 395
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 6
        object BitBtn1: TBitBtn
          Left = 282
          Top = 3
          Width = 75
          Height = 25
          Caption = '[ Split ]'
          Glyph.Data = {
            42010000424D4201000000000000760000002800000011000000110000000100
            040000000000CC00000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            777770000000777777777770000070000000777777777770BFB0700000007777
            77700000FBF07000000077777770BFB0BFB07000000077000000FBF000007000
            0000770FBFB0BFBFB07770000000770BFBF0FBFBF07770000000770FBFB0BFBF
            B07770000000770BFBF00000007770000000770FBFBFBFB0777770000000770B
            FBFBFBF0777770000000770FBFBFBFB0777770000000770BFBFBFBF077777000
            0000770000000000777770000000777777777777777770000000777777777777
            777770000000}
          TabOrder = 0
          TabStop = False
          OnClick = BitBtn1Click
        end
        object btnOpenSplitDir: TButton
          Left = 76
          Top = 3
          Width = 61
          Height = 25
          Hint = 'Browse Output folder'
          Caption = 'Folder'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          TabStop = False
          OnClick = btnOpenSplitDirClick
        end
      end
      object gbSplitSize: TGroupBox
        Left = 76
        Top = 107
        Width = 281
        Height = 130
        Caption = 'Split Size'
        TabOrder = 4
        object Label9: TLabel
          Left = 116
          Top = 101
          Width = 48
          Height = 13
          Caption = 'MegaByte'
        end
        object Label10: TLabel
          Left = 24
          Top = 101
          Width = 26
          Height = 13
          Caption = 'Size :'
        end
        object Label11: TLabel
          Left = 16
          Top = 70
          Width = 34
          Height = 13
          Caption = 'Quick :'
        end
        object SpinEdit1: TSpinEdit
          Left = 56
          Top = 97
          Width = 54
          Height = 22
          TabStop = False
          MaxValue = 0
          MinValue = 1
          TabOrder = 0
          Value = 1
          OnChange = ChangeSplitOptions
        end
        object RadioButton1: TRadioButton
          Left = 10
          Top = 26
          Width = 40
          Height = 17
          Caption = 'GiB'
          TabOrder = 1
          OnClick = ChangeSplitOptions
        end
        object RadioButton2: TRadioButton
          Left = 56
          Top = 26
          Width = 40
          Height = 17
          Caption = 'MiB'
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = ChangeSplitOptions
        end
        object RadioButton3: TRadioButton
          Left = 102
          Top = 26
          Width = 40
          Height = 17
          Caption = 'KiB'
          TabOrder = 3
          OnClick = ChangeSplitOptions
        end
        object RadioButton4: TRadioButton
          Left = 148
          Top = 25
          Width = 51
          Height = 17
          Caption = 'Bytes'
          TabOrder = 4
          OnClick = ChangeSplitOptions
        end
        object RadioButton5: TRadioButton
          Left = 205
          Top = 25
          Width = 52
          Height = 17
          Caption = 'Equal'
          TabOrder = 5
          OnClick = RadioButton5Click
        end
        object ComboBox1: TComboBox
          Left = 56
          Top = 67
          Width = 108
          Height = 21
          Style = csDropDownList
          TabOrder = 6
          TabStop = False
          OnChange = ComboBox1Change
          Items.Strings = (
            '100 Bytes'
            '1 KB'
            '100 Kb'
            '1 MB'
            '10 MB'
            '100 MB'
            '200 MB'
            '1 GB')
        end
      end
      object Edit3: TEdit
        Left = 76
        Top = 57
        Width = 281
        Height = 21
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Text = '%f%.%p%'
      end
      object ProgressBar1: TProgressBar
        Left = 76
        Top = 243
        Width = 281
        Height = 10
        Step = 1
        TabOrder = 7
      end
    end
    object JoinTab: TTabSheet
      Caption = 'Merger'
      ImageIndex = 1
      object Label2: TLabel
        Left = 1
        Top = 30
        Width = 72
        Height = 13
        Caption = 'Files to Merge :'
      end
      object Label1: TLabel
        Left = 16
        Top = 6
        Width = 57
        Height = 13
        Caption = 'Output File :'
      end
      object Label6: TLabel
        Left = 3
        Top = 60
        Width = 62
        Height = 13
        Caption = 'Drag or Load'
      end
      object Label12: TLabel
        Left = 3
        Top = 79
        Width = 55
        Height = 13
        Caption = 'File Parts to'
      end
      object Label14: TLabel
        Left = 3
        Top = 98
        Width = 33
        Height = 13
        Caption = 'Merge.'
      end
      object ListBox1: TListBox
        Left = 76
        Top = 30
        Width = 281
        Height = 208
        TabStop = False
        Style = lbOwnerDrawFixed
        Ctl3D = True
        DragMode = dmAutomatic
        ItemHeight = 18
        ParentCtl3D = False
        PopupMenu = PopUpMenu1
        TabOrder = 0
        OnDragDrop = ListBox1DragDrop
        OnDragOver = ListBox1DragOver
        OnDrawItem = ListBox1DrawItem
        OnMouseDown = ListBox1MouseDown
      end
      object JoinBottomPanel: TPanel
        Left = 0
        Top = 261
        Width = 395
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitTop = 260
        ExplicitWidth = 391
        object BitBtn6: TBitBtn
          Left = 282
          Top = 3
          Width = 75
          Height = 25
          Caption = '[ Merge ]'
          Glyph.Data = {
            42010000424D4201000000000000760000002800000011000000110000000100
            040000000000CC00000000000000000000001000000000000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7777700000007777777777777777700000007777700000000007700000007777
            70FBFBFBFB0770000000777770BFBFBFBF0770000000777770FBFBFBFB077000
            0000777770BFBFBFBF07700000007770000000FBFB07700000007770BFBFB0BF
            BF07700000007770FBFBF0FBFB07700000007770BFBFB0BFBF07700000007000
            00FBF00000077000000070BFB0BFB07777777000000070FBF000007777777000
            000070BFB0777777777770000000700000777777777770000000777777777777
            777770000000}
          TabOrder = 0
          TabStop = False
          OnClick = BitBtn6Click
        end
      end
      object Edit4: TEdit
        Left = 76
        Top = 3
        Width = 281
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 2
      end
      object BitBtn7: TButton
        Left = 363
        Top = 3
        Width = 24
        Height = 21
        Caption = '...'
        TabOrder = 3
        TabStop = False
        OnClick = BitBtn7Click
      end
      object BitBtn2: TBitBtn
        Left = 363
        Top = 30
        Width = 24
        Height = 25
        Glyph.Data = {
          06030000424D060300000000000036000000280000000F0000000F0000000100
          180000000000D002000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF2F773705640E03660C0F6212235521FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1D812A2BAE3B21
          A82E289A30185D15FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF1C812A26AE3A1BAB2E239C2E1A5D14FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1882292DB8451F
          B23627A536175F11FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF13842836BF5126BA442CAD400E630DFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF0000003D6D452C733C2779382679361D7E300A862638C65B2D
          C1512DB6480069070E630D175F111A5D14185D152355210000002D743D6EDA8C
          5BDB8055D57A4BD1733FCF6A36CC6330C75B2DC0522DB6482CAD4027A536239C
          2E289A300F621200000029793868E78C52E7814CE17B46DB7541D6703AD16835
          CC6330C75B2DC15126BA441FB2361BAB2E21A82E03660C00000028783774EB90
          61EC855BE67F55E0794CDB7343D66E3AD16836CC6338C65B36BF512DB84526AE
          3A2BAE3B05640E00000036723E267A341F7D30207E3118802D0586254BDD7341
          D6703FCF6B0C85281384281882291C812A1D812A2F7737000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF16812C55E27947DC764CD175217B34FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F7D305CE87F4C
          E17B57D57D2C753BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF1F7D3062EE8553E8825CDA822D763AFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2D78347BEB916F
          E78D76DC8F36723EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF4D6D3E3A75363876363D723B496945FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF000000}
        TabOrder = 4
        TabStop = False
        OnClick = BitBtn2Click
      end
      object BitBtn3: TBitBtn
        Left = 363
        Top = 61
        Width = 24
        Height = 25
        Hint = 'Clear'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF0005B70005B7FF00FF0005B70005B7FF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF0005B70005B7FF00FFFF00FF0005B7
          0005B70005B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0005
          B70005B7FF00FFFF00FFFF00FF0005B70005B60005B70005B7FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF0005B70005B7FF00FFFF00FFFF00FFFF00FFFF00FF
          0006D70005BA0005B70005B7FF00FFFF00FFFF00FFFF00FF0005B70005B7FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0005B70005B70005B6FF
          00FF0005B60005B70005B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF0005B60006C70006C70006CE0005B4FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0006C100
          05C10006DAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF0005B60006D70006CE0006DA0006E9FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0006E50006DA0006D3FF
          00FFFF00FF0006E50006EFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0006F80006DA0006EFFF00FFFF00FFFF00FFFF00FF0006F80006F6FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF0006F60006F60006F8FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF0006F60006F6FF00FFFF00FFFF00FFFF00FF0006F6
          0006F60006F6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF0006F6FF00FFFF00FF0006F60006F60006F6FF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0006F60006F6
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 5
        TabStop = False
        OnClick = BitBtn3Click
      end
      object BitBtn4: TBitBtn
        Left = 363
        Top = 92
        Width = 24
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF014203014203014A04025205014603014603FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF024C04024C04037B0803960A03
          9F0C039F0C039D0C038C0A036B0A036B0AFF00FFFF00FFFF00FFFF00FFFF00FF
          013402026A0603A70C03A50C03A10C03A00C03A00C07A51806A71609AF1C0A99
          1F06620FFF00FFFF00FFFF00FF014D0402690603A70C039F0C039E0C039E0CB1
          E6B6FFFFFF41BF570CA6270BA4200FB02D11A3301B9D3DFF00FFFF00FF014D04
          03A60C03A00C039E0C039E0C039E0CAFE5B4FFFFFF41BF580FAA2E0EA72912AA
          3423BC4F1B9D3DFF00FF013302027E0903A50C039E0C039E0C039E0C039E0CAD
          E5B2FFFFFF41BF5B0FAA3010A93113AC3C2FBC5D49C779138C2A014303039D0C
          03A00C039E0C16AA2007A010039E0CADE5B2FFFFFF41C05B11AB342DB8531FB4
          4E30BB6078D99F139923025104039F0C039F0C039E0CD5F2D882D589039E0CB4
          E7BDFFFFFF3EBF5E4FC675F4FCF7ABE6C12CBA5D90E0B1139923025104039F0C
          029E0A039D0AE9F8EAFFFFFF75D07DB7E9C5FFFFFF82D9A0E2F7EAFFFFFF95DE
          B038BD67A7E7C4139923014103039C0B03A00B029D0A48C052F4FCF6FCFEFCF7
          FCF8FCFFFEFAFEFBFFFFFF8EDCAB1CB24F50C77ABDEED4139923013002037808
          03A60C049E0D039E0F41BD4BF3FBF4FFFFFFFFFFFFFFFFFF95DEB01CB14D20B4
          529AE1B698E1B51DA435FF00FF01450304A30D07A41509A41C05A01341BD4EF0
          FBF3FFFFFFA4E3BC1DB24F16AF4866CF8CD0F4E3139923FF00FFFF00FF014503
          0365090AAB1F0DAB280EA92D11AB3470D392BAEACC2CBA5C22B65568D08EC5F0
          D86ACC88139923FF00FFFF00FFFF00FF034F09066B1110AC3017B64118B54A1E
          B7512ABA5C44C67483DDA7AAE7C556C573139923FF00FFFF00FFFF00FFFF00FF
          FF00FF044F09044F090D822317A34121B1513EBD6954C57A4CBD691399231399
          23FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF03570603570606
          680D08741206780E06780EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 6
        TabStop = False
        OnClick = BitBtn4Click
      end
      object BitBtn5: TBitBtn
        Left = 363
        Top = 123
        Width = 24
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF06780E06780E08741206680D035706035706FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1399231399234CBD6954C57A3E
          BD6921B15117A3410D8223044F09044F09FF00FFFF00FFFF00FFFF00FFFF00FF
          13992356C573AAE7C583DDA744C6742ABA5C1EB75118B54A17B64110AC30066B
          11034F09FF00FFFF00FFFF00FF1399236ACC88C5F0D868D08E22B6552CBA5CBA
          EACC70D39211AB340EA92D0DAB280AAB1F036509014503FF00FFFF00FF139923
          D0F4E366CF8C16AF481DB24FA4E3BCFFFFFFF0FBF341BD4E05A01309A41C07A4
          1504A30D014503FF00FF1DA43598E1B59AE1B620B4521CB14D95DEB0FFFFFFFF
          FFFFFFFFFFF3FBF441BD4B039E0F049E0D03A60C037808013002139923BDEED4
          50C77A1CB24F8EDCABFFFFFFFAFEFBFCFFFEF7FCF8FCFEFCF4FCF648C052029D
          0A03A00B039C0B014103139923A7E7C438BD6795DEB0FFFFFFE2F7EA82D9A0FF
          FFFFB7E9C575D07DFFFFFFE9F8EA039D0A029E0A039F0C02510413992390E0B1
          2CBA5DABE6C1F4FCF74FC6753EBF5EFFFFFFB4E7BD039E0C82D589D5F2D8039E
          0C039F0C039F0C02510413992378D99F30BB601FB44E2DB85311AB3441C05BFF
          FFFFADE5B2039E0C07A01016AA20039E0C03A00C039D0C014303138C2A49C779
          2FBC5D13AC3C10A9310FAA3041BF5BFFFFFFADE5B2039E0C039E0C039E0C039E
          0C03A50C027E09013302FF00FF1B9D3D23BC4F12AA340EA7290FAA2E41BF58FF
          FFFFAFE5B4039E0C039E0C039E0C03A00C03A60C014D04FF00FFFF00FF1B9D3D
          11A3300FB02D0BA4200CA62741BF57FFFFFFB1E6B6039E0C039E0C039F0C03A7
          0C026906014D04FF00FFFF00FFFF00FF06620F0A991F09AF1C06A71607A51803
          A00C03A00C03A10C03A50C03A70C026A06013402FF00FFFF00FFFF00FFFF00FF
          FF00FF036B0A036B0A038C0A039D0C039F0C039F0C03960A037B08024C04024C
          04FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01460301460302
          5205014A04014203014203FF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 7
        TabStop = False
        OnClick = BitBtn5Click
      end
      object ProgressBar2: TProgressBar
        Left = 76
        Top = 244
        Width = 281
        Height = 10
        Step = 1
        TabOrder = 8
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Options'
      ImageIndex = 2
      object CheckBox1: TCheckBox
        Left = 11
        Top = 47
        Width = 101
        Height = 17
        Caption = 'Sort befor Merge'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object CheckBox2: TCheckBox
        Left = 11
        Top = 88
        Width = 165
        Height = 17
        Caption = 'Remove duplicates Automatic'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 403
    Height = 52
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 399
    object Label8: TLabel
      Left = 15
      Top = 5
      Width = 272
      Height = 39
      Caption = 'File Splitter && Merger'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Impact'
      Font.Style = []
      ParentFont = False
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 373
    Width = 403
    Height = 19
    Panels = <
      item
        Text = 'Size :'
        Width = 35
      end
      item
        Text = '0 bytes'
        Width = 110
      end
      item
        Text = 'Parts :'
        Width = 45
      end
      item
        Text = '0'
        Width = 50
      end
      item
        Text = 'Progress :'
        Width = 55
      end
      item
        Text = 'ready.'
        Width = 50
      end>
    ExplicitTop = 372
    ExplicitWidth = 399
  end
  object OpenDialog2: TOpenDialog
    Filter = 'All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Title = 'Select Files to Join'
    Left = 150
    Top = 78
  end
  object SaveDialog1: TSaveDialog
    Filter = 'All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Title = 'Select Join Output File'
    Left = 277
    Top = 85
  end
  object OpenDialog1: TOpenDialog
    Filter = 'All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofFileMustExist, ofEnableSizing]
    Title = 'Select File to Split'
    Left = 276
    Top = 132
  end
  object PopUpMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 210
    Top = 81
    object OpenFiles1: TMenuItem
      Caption = 'Open Files'
      OnClick = OpenFiles1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object jpSort: TMenuItem
      Caption = 'Sort'
      OnClick = jpSortClick
    end
    object jpClear: TMenuItem
      Caption = 'Remove'
      OnClick = jpClearClick
    end
    object Moveup1: TMenuItem
      Caption = 'Move up..'
      OnClick = Moveup1Click
    end
    object Mocedown1: TMenuItem
      Caption = 'Move down..'
      OnClick = Mocedown1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object RemoveDuplicates1: TMenuItem
      Caption = 'Remove Duplicates'
      OnClick = RemoveDuplicates1Click
    end
  end
end
