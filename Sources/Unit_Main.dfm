object MainForm: TMainForm
  Left = 0
  Top = 0
  ActiveControl = LapTimesGrid
  Caption = 'MotoGP Telemetry Simulator - TeeChart'
  ClientHeight = 878
  ClientWidth = 1330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 1330
    Height = 41
    Align = alTop
    TabOrder = 0
    object CurrentLap: TLabel
      Left = 771
      Top = 13
      Width = 54
      Height = 15
      Caption = 'Lap: 0 of 0'
    end
    object Label1: TLabel
      Left = 844
      Top = 13
      Width = 46
      Height = 15
      Caption = 'Ellapsed:'
    end
    object LRaceEllapsed: TLabel
      Left = 896
      Top = 13
      Width = 57
      Height = 15
      Caption = '0:00:00.000'
    end
    object BStart: TButton
      Left = 4
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Start !'
      TabOrder = 0
      OnClick = BStartClick
    end
    object BPause: TButton
      Left = 170
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Pause'
      Enabled = False
      TabOrder = 1
      OnClick = BPauseClick
    end
    object BStop: TButton
      Left = 264
      Top = 10
      Width = 75
      Height = 25
      Caption = 'STOP'
      Enabled = False
      TabOrder = 2
      OnClick = BStopClick
    end
    object Semaphor: TChart
      Left = 101
      Top = 13
      Width = 61
      Height = 22
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      LeftWall.Color = clLightyellow
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      RightWall.Color = clLightyellow
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      AxisVisible = False
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = clDarkgray
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.TicksInner.Color = clDarkgray
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = clDarkgray
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.TicksInner.Color = clDarkgray
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = clDarkgray
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.TicksInner.Color = clDarkgray
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = clDarkgray
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.TicksInner.Color = clDarkgray
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = clDarkgray
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.TicksInner.Color = clDarkgray
      RightAxis.Title.Font.Name = 'Verdana'
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = clDarkgray
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.TicksInner.Color = clDarkgray
      TopAxis.Title.Font.Name = 'Verdana'
      View3DWalls = False
      OnAfterDraw = SemaphorAfterDraw
      TabOrder = 3
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object CBSeasons: TComboBox
      Left = 369
      Top = 12
      Width = 80
      Height = 23
      Style = csDropDownList
      DropDownCount = 30
      TabOrder = 4
      OnChange = CBSeasonsChange
    end
    object CBRounds: TComboBox
      Left = 473
      Top = 12
      Width = 193
      Height = 23
      Style = csDropDownList
      DropDownCount = 30
      DropDownWidth = 260
      TabOrder = 5
      OnChange = CBRoundsChange
    end
    object CBRace: TComboBox
      Left = 672
      Top = 12
      Width = 73
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 6
      Text = 'Sprint'
      OnChange = CBRaceChange
      Items.Strings = (
        'Sprint'
        'Full Race')
    end
  end
  object PanelFull: TPanel
    Left = 0
    Top = 41
    Width = 1330
    Height = 837
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 321
      Top = 0
      Height = 837
      ExplicitLeft = 560
      ExplicitTop = 312
      ExplicitHeight = 100
    end
    object SplitterPole: TSplitter
      Left = 999
      Top = 0
      Height = 837
      Align = alRight
      ExplicitLeft = 1001
      ExplicitTop = 6
    end
    object PageControl2: TPageControl
      Left = 0
      Top = 0
      Width = 321
      Height = 837
      ActivePage = TabCircuits
      Align = alLeft
      TabOrder = 0
      object TabCircuits: TTabSheet
        Caption = 'Circuit'
        object Splitter3: TSplitter
          Left = 0
          Top = 418
          Width = 313
          Height = 3
          Cursor = crVSplit
          Align = alTop
          ExplicitTop = 305
          ExplicitWidth = 315
        end
        object PanelCircuit: TPanel
          Left = 0
          Top = 113
          Width = 313
          Height = 305
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Circuit: TChart
            Left = 0
            Top = 41
            Width = 313
            Height = 264
            BackWall.Brush.Gradient.Direction = gdBottomTop
            BackWall.Brush.Gradient.EndColor = clWhite
            BackWall.Brush.Gradient.StartColor = 15395562
            BackWall.Brush.Gradient.Visible = True
            BackWall.Transparent = False
            Foot.Font.Color = clBlue
            Foot.Font.Name = 'Verdana'
            Gradient.Direction = gdBottomTop
            Gradient.EndColor = clWhite
            Gradient.MidColor = 15395562
            Gradient.StartColor = 15395562
            LeftWall.Color = clLightyellow
            Legend.Font.Name = 'Verdana'
            Legend.Shadow.Transparency = 0
            RightWall.Color = clLightyellow
            Title.Font.Name = 'Verdana'
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            AxisVisible = False
            BottomAxis.Axis.Color = 4210752
            BottomAxis.Grid.Color = clDarkgray
            BottomAxis.LabelsFormat.Font.Name = 'Verdana'
            BottomAxis.TicksInner.Color = clDarkgray
            BottomAxis.Title.Font.Name = 'Verdana'
            DepthAxis.Axis.Color = 4210752
            DepthAxis.Grid.Color = clDarkgray
            DepthAxis.LabelsFormat.Font.Name = 'Verdana'
            DepthAxis.TicksInner.Color = clDarkgray
            DepthAxis.Title.Font.Name = 'Verdana'
            DepthTopAxis.Axis.Color = 4210752
            DepthTopAxis.Grid.Color = clDarkgray
            DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
            DepthTopAxis.TicksInner.Color = clDarkgray
            DepthTopAxis.Title.Font.Name = 'Verdana'
            LeftAxis.Axis.Color = 4210752
            LeftAxis.Grid.Color = clDarkgray
            LeftAxis.LabelsFormat.Font.Name = 'Verdana'
            LeftAxis.TicksInner.Color = clDarkgray
            LeftAxis.Title.Font.Name = 'Verdana'
            RightAxis.Axis.Color = 4210752
            RightAxis.Grid.Color = clDarkgray
            RightAxis.LabelsFormat.Font.Name = 'Verdana'
            RightAxis.TicksInner.Color = clDarkgray
            RightAxis.Title.Font.Name = 'Verdana'
            TopAxis.Axis.Color = 4210752
            TopAxis.Grid.Color = clDarkgray
            TopAxis.LabelsFormat.Font.Name = 'Verdana'
            TopAxis.TicksInner.Color = clDarkgray
            TopAxis.Title.Font.Name = 'Verdana'
            View3D = False
            View3DWalls = False
            OnAfterDraw = CircuitAfterDraw
            Align = alClient
            TabOrder = 0
            DefaultCanvas = 'TGDIPlusCanvas'
            ColorPaletteIndex = 13
          end
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 313
            Height = 41
            Align = alTop
            TabOrder = 1
            object CBMap: TComboBox
              Left = 13
              Top = 12
              Width = 145
              Height = 23
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 0
              Text = 'None'
              OnChange = CBMapChange
              Items.Strings = (
                'None'
                'Standard OSM'
                'Esri Satellit'
                'Carto Dark'
                'Carto Positron'
                'Carto Voyager')
            end
            object Button1: TButton
              Left = 192
              Top = 10
              Width = 75
              Height = 25
              Caption = 'FULL'
              TabOrder = 1
              OnClick = Button1Click
            end
          end
        end
        object PageControl4: TPageControl
          Left = 0
          Top = 421
          Width = 313
          Height = 386
          ActivePage = TabFrontView
          Align = alClient
          TabOrder = 1
          object TabFrontView: TTabSheet
            Caption = 'Front View'
            ImageIndex = 1
            object FrontView: TChart
              Left = 0
              Top = 137
              Width = 305
              Height = 137
              BackWall.Brush.Gradient.Direction = gdBottomTop
              BackWall.Brush.Gradient.EndColor = clWhite
              BackWall.Brush.Gradient.StartColor = 15395562
              BackWall.Brush.Gradient.Visible = True
              BackWall.Pen.Visible = False
              BackWall.Transparent = False
              Foot.Font.Color = clBlue
              Foot.Font.Name = 'Verdana'
              Gradient.Direction = gdBottomTop
              Gradient.EndColor = clWhite
              Gradient.MidColor = 15395562
              Gradient.StartColor = 14076576
              Gradient.Visible = True
              LeftWall.Color = clLightyellow
              Legend.Font.Name = 'Verdana'
              Legend.Shadow.Transparency = 0
              RightWall.Color = clLightyellow
              Title.Font.Name = 'Verdana'
              Title.Margins.Top = 3
              Title.Text.Strings = (
                'TChart')
              Title.VertMargin = 2
              AxisVisible = False
              BottomAxis.Axis.Color = 4210752
              BottomAxis.Grid.Color = clDarkgray
              BottomAxis.LabelsFormat.Font.Color = 6579300
              BottomAxis.LabelsFormat.Font.Style = [fsBold]
              BottomAxis.TicksInner.Color = clDarkgray
              BottomAxis.Title.Font.Color = 6579300
              BottomAxis.Title.Font.Name = 'Verdana'
              DepthAxis.Axis.Color = 4210752
              DepthAxis.Grid.Color = clDarkgray
              DepthAxis.LabelsFormat.Font.Name = 'Verdana'
              DepthAxis.TicksInner.Color = clDarkgray
              DepthAxis.Title.Font.Name = 'Verdana'
              DepthTopAxis.Axis.Color = 4210752
              DepthTopAxis.Grid.Color = clDarkgray
              DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
              DepthTopAxis.TicksInner.Color = clDarkgray
              DepthTopAxis.Title.Font.Name = 'Verdana'
              Frame.Visible = False
              LeftAxis.Automatic = False
              LeftAxis.AutomaticMaximum = False
              LeftAxis.AutomaticMinimum = False
              LeftAxis.Axis.Color = 4210752
              LeftAxis.Grid.Color = clDarkgray
              LeftAxis.LabelsFormat.Font.Color = 6579300
              LeftAxis.LabelsFormat.Font.Style = [fsBold]
              LeftAxis.Maximum = 100.000000000000000000
              LeftAxis.MinorTickLength = 1
              LeftAxis.MinorTicks.Color = 13408767
              LeftAxis.TickLength = 10
              LeftAxis.Ticks.Color = 13408767
              LeftAxis.TicksInner.Color = clDarkgray
              LeftAxis.Title.Font.Color = 6579300
              LeftAxis.Title.Font.Name = 'Verdana'
              RightAxis.Axis.Color = 4210752
              RightAxis.Grid.Color = clDarkgray
              RightAxis.LabelsFormat.Font.Name = 'Verdana'
              RightAxis.TicksInner.Color = clDarkgray
              RightAxis.Title.Font.Name = 'Verdana'
              TopAxis.Axis.Color = 4210752
              TopAxis.Grid.Color = clDarkgray
              TopAxis.LabelsFormat.Font.Name = 'Verdana'
              TopAxis.TicksInner.Color = clDarkgray
              TopAxis.Title.Font.Name = 'Verdana'
              View3D = False
              View3DWalls = False
              OnAfterDraw = FrontViewAfterDraw
              Align = alClient
              TabOrder = 0
              DefaultCanvas = 'TGDIPlusCanvas'
              ColorPaletteIndex = 13
            end
            object Dashboard: TChart
              Left = 0
              Top = 0
              Width = 305
              Height = 137
              BackWall.Brush.Gradient.Direction = gdBottomTop
              BackWall.Brush.Gradient.EndColor = clWhite
              BackWall.Brush.Gradient.StartColor = 15395562
              BackWall.Brush.Gradient.Visible = True
              BackWall.Transparent = False
              Foot.Font.Color = clBlue
              Foot.Font.Name = 'Verdana'
              Gradient.Direction = gdBottomTop
              Gradient.EndColor = clWhite
              Gradient.MidColor = 15395562
              Gradient.StartColor = 15395562
              Gradient.Visible = True
              LeftWall.Color = clLightyellow
              Legend.Font.Name = 'Verdana'
              Legend.Shadow.Transparency = 0
              Legend.Visible = False
              RightWall.Color = clLightyellow
              Title.Font.Name = 'Verdana'
              Title.Text.Strings = (
                'TChart')
              Title.Visible = False
              AxisVisible = False
              BottomAxis.Axis.Color = 4210752
              BottomAxis.Grid.Color = clDarkgray
              BottomAxis.LabelsFormat.Font.Name = 'Verdana'
              BottomAxis.TicksInner.Color = clDarkgray
              BottomAxis.Title.Font.Name = 'Verdana'
              DepthAxis.Axis.Color = 4210752
              DepthAxis.Grid.Color = clDarkgray
              DepthAxis.LabelsFormat.Font.Name = 'Verdana'
              DepthAxis.TicksInner.Color = clDarkgray
              DepthAxis.Title.Font.Name = 'Verdana'
              DepthTopAxis.Axis.Color = 4210752
              DepthTopAxis.Grid.Color = clDarkgray
              DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
              DepthTopAxis.TicksInner.Color = clDarkgray
              DepthTopAxis.Title.Font.Name = 'Verdana'
              LeftAxis.Automatic = False
              LeftAxis.AutomaticMaximum = False
              LeftAxis.AutomaticMinimum = False
              LeftAxis.Axis.Color = 4210752
              LeftAxis.Grid.Color = clDarkgray
              LeftAxis.LabelsFormat.Font.Color = 6579300
              LeftAxis.LabelsFormat.Font.Style = [fsBold]
              LeftAxis.Maximum = 100.000000000000000000
              LeftAxis.MinorTickLength = 1
              LeftAxis.MinorTicks.Color = 13408767
              LeftAxis.TickLength = 10
              LeftAxis.Ticks.Color = 13408767
              LeftAxis.TicksInner.Color = clDarkgray
              LeftAxis.Title.Font.Color = 6579300
              LeftAxis.Title.Font.Name = 'Verdana'
              RightAxis.Axis.Color = 4210752
              RightAxis.Grid.Color = clDarkgray
              RightAxis.LabelsFormat.Font.Name = 'Verdana'
              RightAxis.TicksInner.Color = clDarkgray
              RightAxis.Title.Font.Name = 'Verdana'
              TopAxis.Axis.Color = 4210752
              TopAxis.Grid.Color = clDarkgray
              TopAxis.LabelsFormat.Font.Name = 'Verdana'
              TopAxis.TicksInner.Color = clDarkgray
              TopAxis.Title.Font.Name = 'Verdana'
              View3D = False
              View3DWalls = False
              OnAfterDraw = DashboardAfterDraw
              Align = alTop
              TabOrder = 1
              OnResize = DashboardResize
              DefaultCanvas = 'TGDIPlusCanvas'
              ColorPaletteIndex = 13
              object SpeedGauge: TNumericGauge
                Legend.Visible = False
                ShowInLegend = False
                ValueFormat = '#,##0#'
                XValues.Name = 'X'
                XValues.Order = loAscending
                YValues.Name = 'Y'
                YValues.Order = loNone
                Face.Transparent = True
                Frame.InnerBrush.BackColor = clRed
                Frame.InnerBrush.Gradient.EndColor = clRed
                Frame.MiddleBrush.BackColor = clYellow
                Frame.OuterBrush.BackColor = clGreen
                Frame.OuterBrush.Gradient.EndColor = clGreen
                Value = 49.350000000000000000
                InternalMarkers = {
                  02000000545046300E544E756D657269634D61726B65720008506F736974696F
                  6E0708707043656E7465720B53686170652E436F6C6F7204DBDBC80010536861
                  70652E466F6E742E436F6C6F7204282828001153686170652E466F6E742E4865
                  6967687402D00F53686170652E466F6E742E4E616D65060A44532D4469676974
                  616C1353686170652E4672616D652E56697369626C65081453686170652E5368
                  61646F772E56697369626C65080A53686170652E546578740602343913536861
                  70652E54657874416C69676E6D656E74070E746152696768744A757374696679
                  1153686170652E5472616E73706172656E74090000545046300E544E756D6572
                  69634D61726B65720008506F736974696F6E070A70705269676874546F700F53
                  686170652E416C69676E6D656E740708746143656E7465720B53686170652E43
                  6F6C6F7204DBDBC8001053686170652E466F6E742E436F6C6F72042828280011
                  53686170652E466F6E742E48656967687402E80F53686170652E466F6E742E4E
                  616D65060A44532D4469676974616C1353686170652E4672616D652E56697369
                  626C65081453686170652E536861646F772E56697369626C65080A5368617065
                  2E5465787406046B6D2F681153686170652E5472616E73706172656E74090000}
              end
              object LeanGauge: TGaugeSeries
                Legend.Visible = False
                XValues.Name = 'Angle'
                XValues.Order = loAscending
                YValues.Name = 'Y'
                YValues.Order = loNone
                Frame.InnerBrush.BackColor = clRed
                Frame.InnerBrush.Gradient.EndColor = clGray
                Frame.InnerBrush.Gradient.MidColor = clWhite
                Frame.InnerBrush.Gradient.StartColor = 4210752
                Frame.InnerBrush.Gradient.Visible = True
                Frame.MiddleBrush.BackColor = clYellow
                Frame.MiddleBrush.Gradient.EndColor = 8553090
                Frame.MiddleBrush.Gradient.MidColor = clWhite
                Frame.MiddleBrush.Gradient.StartColor = clGray
                Frame.MiddleBrush.Gradient.Visible = True
                Frame.OuterBrush.BackColor = clGreen
                Frame.OuterBrush.Gradient.EndColor = 4210752
                Frame.OuterBrush.Gradient.MidColor = clWhite
                Frame.OuterBrush.Gradient.StartColor = clSilver
                Frame.OuterBrush.Gradient.Visible = True
                Frame.Width = 4
                Shadow.Visible = False
                Center.Brush.Color = clBlack
                Center.Brush.Gradient.EndColor = clBlack
                Center.Brush.Gradient.Visible = True
                Center.Gradient.EndColor = clBlack
                Center.Gradient.Visible = True
                Center.HorizSize = 8
                Center.InflateMargins = True
                Center.Style = psCircle
                Center.VertSize = 8
                CirclePen.Visible = False
                EndPoint.HorizSize = 3
                EndPoint.InflateMargins = True
                EndPoint.Pen.Mode = pmNotXor
                EndPoint.Style = psCircle
                EndPoint.VertSize = 3
                EndPoint.Visible = False
                Maximum = 70.000000000000000000
                Minimum = -70.000000000000000000
                RotationAngle = 160
                ShapeStyle = gsPolygon
                TotalAngle = 140.000000000000000000
                Value = -67.717556329444050000
              end
              object FuelGauge: TLinearGauge
                Legend.Visible = False
                XValues.Name = 'X'
                XValues.Order = loAscending
                YValues.Name = 'Y'
                YValues.Order = loNone
                Frame.InnerBrush.BackColor = clRed
                Frame.InnerBrush.Gradient.EndColor = clRed
                Frame.MiddleBrush.BackColor = clYellow
                Frame.OuterBrush.BackColor = clGreen
                Frame.OuterBrush.Gradient.EndColor = clGreen
                Horizontal = False
                Maximum = 100.000000000000000000
                MaxValueIndicator.Brush.Color = clRed
                MaxValueIndicator.Draw3D = False
                MaxValueIndicator.InflateMargins = True
                MaxValueIndicator.Style = psLeftTriangle
                MaxValueIndicator.VertSize = 5
                MaxValueIndicator.GaugeStyle = gpHand
                MinorTicks.Brush.Color = clNone
                MinorTicks.HorizSize = 1
                MinorTicks.InflateMargins = True
                MinorTicks.Pen.Color = 13408767
                MinorTicks.Style = psRectangle
                MinorTicks.VertSize = 1
                MinorTicks.GaugeStyle = gpMinorTick
                Ranges = <
                  item
                    Format.Brush.Color = clAqua
                    Format.Brush.Gradient.Direction = gdBottomTop
                    Format.Brush.Gradient.EndColor = clAqua
                    Format.Brush.Gradient.MidColor = clYellow
                    Format.Brush.Gradient.StartColor = clFuchsia
                    Format.Brush.Gradient.Visible = True
                    Format.Gradient.Direction = gdBottomTop
                    Format.Gradient.EndColor = clAqua
                    Format.Gradient.MidColor = clYellow
                    Format.Gradient.StartColor = clFuchsia
                    Format.Gradient.Visible = True
                    Format.InflateMargins = True
                    Format.Style = psRectangle
                    Format.VertSize = 5
                    Format.GaugeStyle = gpColorLine
                    Format.EndValue = 40.000000000000000000
                  end
                  item
                    Format.Brush.Color = clNavy
                    Format.Brush.Gradient.Direction = gdBottomTop
                    Format.Brush.Gradient.EndColor = clNavy
                    Format.Brush.Gradient.MidColor = 16764108
                    Format.Brush.Gradient.StartColor = 13395456
                    Format.Brush.Gradient.Visible = True
                    Format.Gradient.Direction = gdBottomTop
                    Format.Gradient.EndColor = clNavy
                    Format.Gradient.MidColor = 16764108
                    Format.Gradient.StartColor = 13395456
                    Format.Gradient.Visible = True
                    Format.InflateMargins = True
                    Format.Style = psRectangle
                    Format.VertSize = 5
                    Format.GaugeStyle = gpColorLine
                    Format.EndValue = 100.000000000000000000
                    Format.StartValue = 80.000000000000000000
                  end>
                Ticks.Brush.Style = bsClear
                Ticks.InflateMargins = True
                Ticks.Pen.Color = 13408767
                Ticks.Style = psRectangle
                Ticks.VertSize = 10
                Ticks.GaugeStyle = gpTick
                Value = 36.000000000000000000
                ValueArea.Transparent = True
              end
            end
            object DebugLean: TPanel
              Left = 0
              Top = 315
              Width = 305
              Height = 41
              Align = alBottom
              TabOrder = 2
              Visible = False
              object TBLean: TTrackBar
                Left = 9
                Top = 6
                Width = 280
                Height = 32
                LineSize = 10
                Max = 70
                Min = -70
                Frequency = 5
                TabOrder = 0
                OnChange = TBLeanChange
              end
            end
            object Panel2: TPanel
              Left = 0
              Top = 274
              Width = 305
              Height = 41
              Align = alBottom
              TabOrder = 3
              ExplicitLeft = 2
              object Label4: TLabel
                Left = 9
                Top = 10
                Width = 25
                Height = 15
                Caption = 'Bike:'
              end
              object FrontTire: TPaintBox
                Left = 205
                Top = 3
                Width = 32
                Height = 32
                OnPaint = FrontTirePaint
              end
              object BackTire: TPaintBox
                Left = 248
                Top = 3
                Width = 32
                Height = 32
                OnPaint = BackTirePaint
              end
              object CBSelectedBike: TComboBox
                Left = 40
                Top = 6
                Width = 145
                Height = 23
                Style = csDropDownList
                TabOrder = 0
                OnChange = CBSelectedBikeChange
              end
            end
          end
        end
        object SiteWeather: TChart
          Left = 0
          Top = 0
          Width = 313
          Height = 113
          BackWall.Brush.Gradient.Direction = gdBottomTop
          BackWall.Brush.Gradient.EndColor = clWhite
          BackWall.Brush.Gradient.StartColor = 15395562
          BackWall.Brush.Gradient.Visible = True
          BackWall.Transparent = False
          Foot.Font.Color = clBlue
          Foot.Font.Name = 'Verdana'
          Gradient.Direction = gdBottomTop
          Gradient.EndColor = clWhite
          Gradient.MidColor = 15395562
          Gradient.StartColor = 15395562
          Gradient.Visible = True
          LeftWall.Color = clLightyellow
          Legend.Font.Name = 'Verdana'
          Legend.Shadow.Transparency = 0
          Legend.Visible = False
          RightWall.Color = clLightyellow
          Title.Font.Name = 'Verdana'
          Title.Text.Strings = (
            'TChart')
          Title.Visible = False
          AxisVisible = False
          BottomAxis.Axis.Color = 4210752
          BottomAxis.Grid.Color = clDarkgray
          BottomAxis.LabelsFormat.Font.Name = 'Verdana'
          BottomAxis.TicksInner.Color = clDarkgray
          BottomAxis.Title.Font.Name = 'Verdana'
          DepthAxis.Axis.Color = 4210752
          DepthAxis.Grid.Color = clDarkgray
          DepthAxis.LabelsFormat.Font.Name = 'Verdana'
          DepthAxis.TicksInner.Color = clDarkgray
          DepthAxis.Title.Font.Name = 'Verdana'
          DepthTopAxis.Axis.Color = 4210752
          DepthTopAxis.Grid.Color = clDarkgray
          DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
          DepthTopAxis.TicksInner.Color = clDarkgray
          DepthTopAxis.Title.Font.Name = 'Verdana'
          LeftAxis.Axis.Color = 4210752
          LeftAxis.Grid.Color = clDarkgray
          LeftAxis.LabelsFormat.Font.Name = 'Verdana'
          LeftAxis.TicksInner.Color = clDarkgray
          LeftAxis.Title.Font.Name = 'Verdana'
          RightAxis.Axis.Color = 4210752
          RightAxis.Grid.Color = clDarkgray
          RightAxis.LabelsFormat.Font.Name = 'Verdana'
          RightAxis.TicksInner.Color = clDarkgray
          RightAxis.Title.Font.Name = 'Verdana'
          TopAxis.Axis.Color = 4210752
          TopAxis.Grid.Color = clDarkgray
          TopAxis.LabelsFormat.Font.Name = 'Verdana'
          TopAxis.TicksInner.Color = clDarkgray
          TopAxis.Title.Font.Name = 'Verdana'
          View3DWalls = False
          OnAfterDraw = SiteWeatherAfterDraw
          Align = alTop
          TabOrder = 2
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
        end
      end
      object TabPilots: TTabSheet
        Caption = 'Pilots'
        ImageIndex = 1
        object Pilots: TTeeGrid
          Left = 0
          Top = 0
          Width = 313
          Height = 807
          Columns = <>
          Align = alClient
          UseDockManager = False
          ParentBackground = False
          ParentColor = False
          TabOrder = 0
          _Headers = (
            1
            'TColumnHeaderBand'
            <
              item
              end>)
        end
      end
      object TabSensors: TTabSheet
        Caption = 'Sensors'
        ImageIndex = 2
        object Sensors: TTeeGrid
          Left = 0
          Top = 0
          Width = 313
          Height = 807
          Cells.Format.Font.Name = 'Segoe UI'
          Cells.Format.Font.Size = 9.000000000000000000
          Columns = <>
          Header.Format.Font.Name = 'Segoe UI'
          Header.Format.Font.Size = 9.000000000000000000
          Rows.Format.Font.Name = 'Segoe UI'
          Rows.Format.Font.Size = 9.000000000000000000
          Rows.Hover.Format.Font.Name = 'Segoe UI'
          Rows.Hover.Format.Font.Size = 9.000000000000000000
          Selected.Format.Font.Name = 'Segoe UI'
          Selected.Format.Font.Size = 9.000000000000000000
          Selected.UnFocused.Format.Font.Name = 'Segoe UI'
          Selected.UnFocused.Format.Font.Size = 9.000000000000000000
          Align = alClient
          ParentFont = True
          UseDockManager = False
          ParentBackground = False
          ParentColor = False
          TabOrder = 0
          _Headers = (
            1
            'TColumnHeaderBand'
            <
              item
                Format.Font.Name = 'Segoe UI'
                Format.Font.Size = 9.000000000000000000
              end>)
        end
      end
    end
    object PageControl1: TPageControl
      Left = 324
      Top = 0
      Width = 675
      Height = 837
      ActivePage = TabLap
      Align = alClient
      TabOrder = 1
      OnChange = PageControl1Change
      object TabLap: TTabSheet
        Caption = 'Current Lap'
        object LapChart: TChart
          Left = 121
          Top = 41
          Width = 546
          Height = 766
          BackWall.Brush.Gradient.Direction = gdBottomTop
          BackWall.Brush.Gradient.EndColor = clWhite
          BackWall.Brush.Gradient.StartColor = 15395562
          BackWall.Brush.Gradient.Visible = True
          BackWall.Transparent = False
          Foot.Font.Color = clBlue
          Foot.Font.Name = 'Verdana'
          Gradient.Direction = gdBottomTop
          Gradient.EndColor = clWhite
          Gradient.MidColor = 15395562
          Gradient.StartColor = 15395562
          LeftWall.Color = clLightyellow
          Legend.CheckBoxes = True
          Legend.Font.Name = 'Verdana'
          Legend.Shadow.Transparency = 0
          Legend.Title.Font.Height = -16
          Legend.Visible = False
          RightWall.Color = clLightyellow
          Title.Font.Height = -13
          Title.Font.Name = 'Verdana'
          Title.Text.Strings = (
            'Lap')
          BottomAxis.Axis.Color = 4210752
          BottomAxis.Grid.Color = clDarkgray
          BottomAxis.LabelsFormat.Font.Name = 'Verdana'
          BottomAxis.TicksInner.Color = clDarkgray
          BottomAxis.Title.Font.Name = 'Verdana'
          DepthAxis.Axis.Color = 4210752
          DepthAxis.Grid.Color = clDarkgray
          DepthAxis.LabelsFormat.Font.Name = 'Verdana'
          DepthAxis.TicksInner.Color = clDarkgray
          DepthAxis.Title.Font.Name = 'Verdana'
          DepthTopAxis.Axis.Color = 4210752
          DepthTopAxis.Grid.Color = clDarkgray
          DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
          DepthTopAxis.TicksInner.Color = clDarkgray
          DepthTopAxis.Title.Font.Name = 'Verdana'
          CustomAxes = <
            item
              Horizontal = False
              OtherSide = True
              StartPosition = 75.000000000000000000
            end
            item
              Automatic = False
              AutomaticMaximum = False
              Horizontal = False
              OtherSide = False
              Maximum = 100.000000000000000000
              EndPosition = 19.000000000000000000
            end>
          LeftAxis.Axis.Color = 4210752
          LeftAxis.Grid.Color = clDarkgray
          LeftAxis.LabelsFormat.Font.Name = 'Verdana'
          LeftAxis.StartPosition = 20.000000000000000000
          LeftAxis.TicksInner.Color = clDarkgray
          LeftAxis.Title.Font.Name = 'Verdana'
          RightAxis.Axis.Color = 4210752
          RightAxis.Grid.Color = clDarkgray
          RightAxis.LabelsFormat.Font.Name = 'Verdana'
          RightAxis.TicksInner.Color = clDarkgray
          RightAxis.Title.Font.Name = 'Verdana'
          TopAxis.Axis.Color = 4210752
          TopAxis.Grid.Color = clDarkgray
          TopAxis.LabelsFormat.Font.Name = 'Verdana'
          TopAxis.TicksInner.Color = clDarkgray
          TopAxis.Title.Font.Name = 'Verdana'
          View3D = False
          OnAfterDraw = LapChartAfterDraw
          Align = alClient
          TabOrder = 0
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object CurveSeries: TPointSeries
            Title = 'Curves'
            VertAxis = aCustomVertAxis
            ClickableLine = False
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
            CustomVertAxis = 0
          end
          object CurveSpeeds: TPointSeries
            Title = 'Entry Speed'
            ClickableLine = False
            Pointer.InflateMargins = True
            Pointer.Pen.Visible = False
            Pointer.Style = psRectangle
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object CursorLap: TColorLineTool
            Pen.Color = 1918068724
            Pen.Width = 2
            AxisID = 0
            object TAnnotationTool
              Shape.Alignment = taCenter
              Shape.Shadow.Visible = False
            end
          end
        end
        object SeriesList: TCheckListBox
          Left = 0
          Top = 41
          Width = 121
          Height = 766
          Align = alLeft
          ItemHeight = 15
          TabOrder = 1
          OnClickCheck = SeriesListClickCheck
        end
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 667
          Height = 41
          Align = alTop
          TabOrder = 2
          object Label2: TLabel
            Left = 11
            Top = 11
            Width = 50
            Height = 15
            Caption = 'View Lap:'
          end
          object Label3: TLabel
            Left = 256
            Top = 13
            Width = 34
            Height = 15
            Caption = 'Mode:'
          end
          object CBViewLastLap: TCheckBox
            Left = 155
            Top = 10
            Width = 84
            Height = 17
            Caption = 'Last Lap'
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = CBViewLastLapClick
          end
          object CBViewMode: TComboBox
            Left = 303
            Top = 10
            Width = 145
            Height = 23
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 1
            Text = 'Single Rider'
            Items.Strings = (
              'Single Rider'
              'Compare Riders'
              'Compare Laps')
          end
          object EViewLap: TEdit
            Left = 67
            Top = 8
            Width = 51
            Height = 23
            Enabled = False
            TabOrder = 2
            Text = '0'
            OnChange = EViewLapChange
          end
          object UDViewLap: TUpDown
            Left = 118
            Top = 8
            Width = 16
            Height = 23
            Associate = EViewLap
            Enabled = False
            TabOrder = 3
          end
        end
      end
      object TabLaps: TTabSheet
        Caption = 'All Laps'
        ImageIndex = 1
        object AllLaps: TChart
          Left = 0
          Top = 0
          Width = 667
          Height = 807
          BackWall.Brush.Gradient.Direction = gdBottomTop
          BackWall.Brush.Gradient.EndColor = clWhite
          BackWall.Brush.Gradient.StartColor = 15395562
          BackWall.Brush.Gradient.Visible = True
          BackWall.Transparent = False
          Foot.Font.Color = clBlue
          Foot.Font.Name = 'Verdana'
          Gradient.Direction = gdBottomTop
          Gradient.EndColor = clWhite
          Gradient.MidColor = 15395562
          Gradient.StartColor = 15395562
          Gradient.Visible = True
          LeftWall.Color = clLightyellow
          Legend.Font.Name = 'Verdana'
          Legend.Shadow.Transparency = 0
          Legend.Visible = False
          RightWall.Color = clLightyellow
          Title.Font.Name = 'Verdana'
          Title.Text.Strings = (
            'By Lap')
          BottomAxis.Axis.Color = 4210752
          BottomAxis.Grid.Color = clDarkgray
          BottomAxis.LabelsFormat.Font.Name = 'Verdana'
          BottomAxis.TicksInner.Color = clDarkgray
          BottomAxis.Title.Caption = 'Lap'
          BottomAxis.Title.Font.Name = 'Verdana'
          Chart3DPercent = 74
          DepthAxis.Axis.Color = 4210752
          DepthAxis.Grid.Color = clDarkgray
          DepthAxis.LabelsFormat.Font.Name = 'Verdana'
          DepthAxis.TicksInner.Color = clDarkgray
          DepthAxis.Title.Caption = 'Rider'
          DepthAxis.Title.Font.Name = 'Verdana'
          DepthTopAxis.Axis.Color = 4210752
          DepthTopAxis.Grid.Color = clDarkgray
          DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
          DepthTopAxis.TicksInner.Color = clDarkgray
          DepthTopAxis.Title.Font.Name = 'Verdana'
          LeftAxis.Axis.Color = 4210752
          LeftAxis.Grid.Color = clDarkgray
          LeftAxis.LabelsFormat.Font.Name = 'Verdana'
          LeftAxis.TicksInner.Color = clDarkgray
          LeftAxis.Title.Caption = 'Lap Time'
          LeftAxis.Title.Font.Name = 'Verdana'
          RightAxis.Axis.Color = 4210752
          RightAxis.Grid.Color = clDarkgray
          RightAxis.LabelsFormat.Font.Name = 'Verdana'
          RightAxis.TicksInner.Color = clDarkgray
          RightAxis.Title.Font.Name = 'Verdana'
          TopAxis.Axis.Color = 4210752
          TopAxis.Grid.Color = clDarkgray
          TopAxis.LabelsFormat.Font.Name = 'Verdana'
          TopAxis.TicksInner.Color = clDarkgray
          TopAxis.Title.Font.Name = 'Verdana'
          OnGetAxisLabel = AllLapsGetAxisLabel
          Align = alClient
          TabOrder = 0
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object TowerLapRider: TTowerSeries
            PercentDepth = 50
            Transparency = 40
            PercentWidth = 50
            Pen.Visible = False
            UseColorRange = False
            XValues.Name = 'X'
            XValues.Order = loNone
            YValues.Name = 'Y'
            YValues.Order = loNone
            ZValues.Name = 'Z'
            ZValues.Order = loNone
          end
        end
      end
      object TabChampionShip: TTabSheet
        Caption = 'ChampionShip'
        ImageIndex = 2
        object ChampionGrid: TTeeGrid
          Left = 0
          Top = 0
          Width = 667
          Height = 807
          Columns = <>
          Align = alClient
          UseDockManager = False
          ParentBackground = False
          ParentColor = False
          TabOrder = 0
          _Headers = (
            1
            'TColumnHeaderBand'
            <
              item
              end>)
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Bikes'
        ImageIndex = 3
        object PageControl5: TPageControl
          Left = 0
          Top = 0
          Width = 667
          Height = 807
          ActivePage = TabSheet4
          Align = alClient
          TabOrder = 0
          object TabSheet4: TTabSheet
            Caption = 'Parameters'
            object BikeGrid: TTeeGrid
              Left = 0
              Top = 0
              Width = 659
              Height = 777
              Columns = <>
              OnSelect = BikeGridSelect
              Align = alClient
              UseDockManager = False
              ParentBackground = False
              ParentColor = False
              TabOrder = 0
              _Headers = (
                1
                'TColumnHeaderBand'
                <
                  item
                  end>)
            end
          end
          object TabTires: TTabSheet
            Caption = 'Tires'
            ImageIndex = 2
            object TiresGrid: TTeeGrid
              Left = 0
              Top = 0
              Width = 659
              Height = 777
              Columns = <>
              Align = alClient
              UseDockManager = False
              ParentBackground = False
              ParentColor = False
              TabOrder = 0
              _Headers = (
                1
                'TColumnHeaderBand'
                <
                  item
                  end>)
            end
          end
        end
      end
      object TabData: TTabSheet
        Caption = 'Data'
        ImageIndex = 4
        object DataGrid: TTeeGrid
          Left = 0
          Top = 0
          Width = 667
          Height = 807
          Cells.Format.Font.Name = 'Segoe UI'
          Cells.Format.Font.Size = 9.000000000000000000
          Columns = <>
          Header.Format.Font.Name = 'Segoe UI'
          Header.Format.Font.Size = 9.000000000000000000
          Rows.Format.Font.Name = 'Segoe UI'
          Rows.Format.Font.Size = 9.000000000000000000
          Rows.Hover.Format.Font.Name = 'Segoe UI'
          Rows.Hover.Format.Font.Size = 9.000000000000000000
          Selected.Format.Font.Name = 'Segoe UI'
          Selected.Format.Font.Size = 9.000000000000000000
          Selected.UnFocused.Format.Font.Name = 'Segoe UI'
          Selected.UnFocused.Format.Font.Size = 9.000000000000000000
          Align = alClient
          ParentFont = True
          UseDockManager = False
          ParentBackground = False
          ParentColor = False
          TabOrder = 0
          _Headers = (
            1
            'TColumnHeaderBand'
            <
              item
                Format.Font.Name = 'Segoe UI'
                Format.Font.Size = 9.000000000000000000
              end>)
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Circuits'
        ImageIndex = 5
        object Splitter5: TSplitter
          Left = 0
          Top = 368
          Width = 667
          Height = 3
          Cursor = crVSplit
          Align = alBottom
          ExplicitTop = 0
          ExplicitWidth = 370
        end
        object Circuits: TTeeGrid
          Left = 0
          Top = 0
          Width = 667
          Height = 368
          Columns = <>
          OnSelect = CircuitsSelect
          Align = alClient
          UseDockManager = False
          ParentBackground = False
          ParentColor = False
          TabOrder = 0
          _Headers = (
            1
            'TColumnHeaderBand'
            <
              item
              end>)
        end
        object CurvesGrid: TTeeGrid
          Left = 0
          Top = 371
          Width = 667
          Height = 436
          Columns = <>
          Align = alBottom
          UseDockManager = False
          ParentBackground = False
          ParentColor = False
          TabOrder = 1
          _Headers = (
            1
            'TColumnHeaderBand'
            <
              item
              end>)
        end
      end
      object TabAllPilots: TTabSheet
        Caption = 'All Pilots'
        ImageIndex = 6
        object AllPilotsGrid: TTeeGrid
          Left = 0
          Top = 0
          Width = 667
          Height = 807
          Columns = <>
          Align = alClient
          UseDockManager = False
          ParentBackground = False
          ParentColor = False
          TabOrder = 0
          _Headers = (
            1
            'TColumnHeaderBand'
            <
              item
              end>)
        end
      end
    end
    object PanelPole: TPanel
      Left = 1002
      Top = 0
      Width = 328
      Height = 837
      Align = alRight
      TabOrder = 2
      object PageControl3: TPageControl
        Left = 1
        Top = 1
        Width = 326
        Height = 835
        ActivePage = TabRace
        Align = alClient
        TabOrder = 0
        object TabRace: TTabSheet
          Caption = 'Race'
          object Splitter4: TSplitter
            Left = 0
            Top = 424
            Width = 318
            Height = 3
            Cursor = crVSplit
            Align = alBottom
            ExplicitTop = 0
            ExplicitWidth = 384
          end
          object PoleGrid: TTeeGrid
            Left = 0
            Top = 0
            Width = 318
            Height = 383
            Columns = <>
            OnSelect = PoleGridSelect
            Align = alClient
            UseDockManager = False
            ParentBackground = False
            ParentColor = False
            TabOrder = 0
            ExplicitLeft = 1
            _Headers = (
              1
              'TColumnHeaderBand'
              <
                item
                end>)
          end
          object Panel4: TPanel
            Left = 0
            Top = 383
            Width = 318
            Height = 41
            Align = alBottom
            TabOrder = 1
            object BRandomPole: TButton
              Left = 9
              Top = 6
              Width = 75
              Height = 25
              Caption = 'Random'
              TabOrder = 0
              OnClick = BRandomPoleClick
            end
            object CBSingleRider: TCheckBox
              Left = 112
              Top = 10
              Width = 97
              Height = 17
              Caption = 'Single Rider'
              TabOrder = 1
              OnClick = CBSingleRiderClick
            end
          end
          object PageControl6: TPageControl
            Left = 0
            Top = 427
            Width = 318
            Height = 378
            ActivePage = TabLapTimes
            Align = alBottom
            TabOrder = 2
            object TabLapTimes: TTabSheet
              Caption = 'Lap Times'
              object LapTimesGrid: TTeeGrid
                Left = 0
                Top = 0
                Width = 310
                Height = 348
                Cells.Format.Font.Name = 'Segoe UI'
                Cells.Format.Font.Size = 9.000000000000000000
                Columns = <>
                Header.Format.Font.Name = 'Segoe UI'
                Header.Format.Font.Size = 9.000000000000000000
                Rows.Format.Font.Name = 'Segoe UI'
                Rows.Format.Font.Size = 9.000000000000000000
                Rows.Hover.Format.Font.Name = 'Segoe UI'
                Rows.Hover.Format.Font.Size = 9.000000000000000000
                Selected.Format.Font.Name = 'Segoe UI'
                Selected.Format.Font.Size = 9.000000000000000000
                Selected.UnFocused.Format.Font.Name = 'Segoe UI'
                Selected.UnFocused.Format.Font.Size = 9.000000000000000000
                Align = alClient
                ParentFont = True
                UseDockManager = False
                ParentBackground = False
                ParentColor = False
                TabOrder = 0
                _Headers = (
                  1
                  'TColumnHeaderBand'
                  <
                    item
                      Format.Font.Name = 'Segoe UI'
                      Format.Font.Size = 9.000000000000000000
                    end>)
              end
            end
          end
        end
        object TabPole: TTabSheet
          Caption = 'Pole'
          ImageIndex = 1
          object PoleChart: TChart
            Left = 0
            Top = 0
            Width = 318
            Height = 805
            BackWall.Brush.Gradient.Direction = gdBottomTop
            BackWall.Brush.Gradient.EndColor = clWhite
            BackWall.Brush.Gradient.StartColor = clBlack
            BackWall.Brush.Gradient.Visible = True
            BackWall.Transparent = False
            Foot.Font.Color = clBlue
            Foot.Font.Name = 'Verdana'
            Gradient.Balance = 40
            Gradient.EndColor = clBlack
            Gradient.MidColor = 8388672
            Gradient.Visible = True
            LeftWall.Color = clLightyellow
            Legend.Font.Name = 'Verdana'
            Legend.Shadow.Transparency = 0
            RightWall.Color = clLightyellow
            Title.Font.Color = 2854101
            Title.Font.Height = -31
            Title.Font.Name = 'Verdana'
            Title.Text.Strings = (
              'Pole')
            AxisVisible = False
            BottomAxis.Axis.Color = 4210752
            BottomAxis.Grid.Color = clDarkgray
            BottomAxis.LabelsFormat.Font.Name = 'Verdana'
            BottomAxis.TicksInner.Color = clDarkgray
            BottomAxis.Title.Font.Name = 'Verdana'
            DepthAxis.Axis.Color = 4210752
            DepthAxis.Grid.Color = clDarkgray
            DepthAxis.LabelsFormat.Font.Name = 'Verdana'
            DepthAxis.TicksInner.Color = clDarkgray
            DepthAxis.Title.Font.Name = 'Verdana'
            DepthTopAxis.Axis.Color = 4210752
            DepthTopAxis.Grid.Color = clDarkgray
            DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
            DepthTopAxis.TicksInner.Color = clDarkgray
            DepthTopAxis.Title.Font.Name = 'Verdana'
            LeftAxis.Axis.Color = 4210752
            LeftAxis.Grid.Color = clDarkgray
            LeftAxis.LabelsFormat.Font.Name = 'Verdana'
            LeftAxis.TicksInner.Color = clDarkgray
            LeftAxis.Title.Font.Name = 'Verdana'
            RightAxis.Axis.Color = 4210752
            RightAxis.Grid.Color = clDarkgray
            RightAxis.LabelsFormat.Font.Name = 'Verdana'
            RightAxis.TicksInner.Color = clDarkgray
            RightAxis.Title.Font.Name = 'Verdana'
            TopAxis.Axis.Color = 4210752
            TopAxis.Grid.Color = clDarkgray
            TopAxis.LabelsFormat.Font.Name = 'Verdana'
            TopAxis.TicksInner.Color = clDarkgray
            TopAxis.Title.Font.Name = 'Verdana'
            View3D = False
            OnAfterDraw = PoleChartAfterDraw
            Align = alClient
            TabOrder = 0
            DefaultCanvas = 'TGDIPlusCanvas'
            ColorPaletteIndex = 13
          end
        end
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 544
    Top = 352
  end
  object TimerStart: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerStartTimer
    Left = 104
    Top = 152
  end
  object MainMenu1: TMainMenu
    Left = 128
    Top = 232
    object File1: TMenuItem
      Caption = '&File'
      object Exit1: TMenuItem
        Caption = '&Exit'
        ShortCut = 32883
        OnClick = Exit1Click
      end
    end
    object View1: TMenuItem
      Caption = '&View'
      object Dashboard1: TMenuItem
        Caption = '&Dashboard'
        Checked = True
        OnClick = Dashboard1Click
      end
      object FrontView1: TMenuItem
        Caption = '&Front View'
        object rack1: TMenuItem
          Caption = '&Track'
          Checked = True
          OnClick = rack1Click
        end
        object Bike1: TMenuItem
          Caption = '&Bike'
          OnClick = Bike1Click
        end
      end
      object Pole1: TMenuItem
        Caption = '&Pole'
        Checked = True
        OnClick = Pole1Click
      end
      object Circuit1: TMenuItem
        Caption = '&Circuit'
        Checked = True
        OnClick = Circuit1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object heme1: TMenuItem
        Caption = '&Theme'
        object Clear1: TMenuItem
          AutoCheck = True
          Caption = '&Light'
          Checked = True
          Default = True
          RadioItem = True
          OnClick = Clear1Click
        end
        object Dark1: TMenuItem
          AutoCheck = True
          Caption = 'D&ark'
          RadioItem = True
          OnClick = Dark1Click
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Render1: TMenuItem
        Caption = '&Render'
        object GDI1: TMenuItem
          Caption = 'GDI+'
          Checked = True
          Default = True
          RadioItem = True
          OnClick = GDI1Click
        end
        object Skia1: TMenuItem
          Caption = 'Skia'
          RadioItem = True
          OnClick = Skia1Click
        end
        object OpenGL1: TMenuItem
          Caption = 'OpenGL'
          RadioItem = True
          OnClick = OpenGL1Click
        end
      end
      object Debug1: TMenuItem
        Caption = 'Debug'
        object Lean1: TMenuItem
          Caption = 'Lean'
          OnClick = Lean1Click
        end
      end
    end
    object About1: TMenuItem
      Caption = '&About...'
      OnClick = About1Click
    end
  end
end
