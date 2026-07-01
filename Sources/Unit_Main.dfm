object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MotoGP Telemetry Simulator - TeeChart'
  ClientHeight = 691
  ClientWidth = 1104
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
    Width = 1104
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 408
      Top = 13
      Width = 53
      Height = 15
      Caption = 'Total laps:'
    end
    object CurrentLap: TLabel
      Left = 560
      Top = 13
      Width = 54
      Height = 15
      Caption = 'Lap: 0 of 0'
    end
    object Label1: TLabel
      Left = 660
      Top = 13
      Width = 74
      Height = 15
      Caption = 'Race Ellapsed:'
    end
    object LRaceEllapsed: TLabel
      Left = 744
      Top = 13
      Width = 57
      Height = 15
      Caption = '0:00:00.000'
    end
    object BStart: TButton
      Left = 5
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
    object Edit1: TEdit
      Left = 467
      Top = 10
      Width = 52
      Height = 23
      TabOrder = 3
      Text = '12'
    end
    object TotalLaps: TUpDown
      Left = 519
      Top = 10
      Width = 16
      Height = 23
      Associate = Edit1
      Min = 1
      Position = 12
      TabOrder = 4
    end
    object Semaphor: TChart
      Left = 101
      Top = 12
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
      TabOrder = 5
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
  end
  object PanelFull: TPanel
    Left = 0
    Top = 41
    Width = 1104
    Height = 650
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 321
      Top = 0
      Height = 650
      ExplicitLeft = 560
      ExplicitTop = 312
      ExplicitHeight = 100
    end
    object Splitter2: TSplitter
      Left = 773
      Top = 0
      Height = 650
      Align = alRight
      ExplicitLeft = 560
      ExplicitTop = 312
      ExplicitHeight = 100
    end
    object PageControl2: TPageControl
      Left = 0
      Top = 0
      Width = 321
      Height = 650
      ActivePage = TabCircuits
      Align = alLeft
      TabOrder = 0
      object TabCircuits: TTabSheet
        Caption = 'Circuit'
        object PanelCircuit: TPanel
          Left = 0
          Top = 0
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
            Gradient.Visible = True
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
          Top = 305
          Width = 313
          Height = 315
          ActivePage = TabSheet2
          Align = alClient
          TabOrder = 1
          object TabSheet1: TTabSheet
            Caption = 'Circuits'
            object Circuits: TTeeGrid
              Left = 0
              Top = 0
              Width = 305
              Height = 285
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
          end
          object TabSheet2: TTabSheet
            Caption = 'Front View'
            ImageIndex = 1
            object FrontView: TChart
              Left = 0
              Top = 0
              Width = 305
              Height = 285
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
              Frame.Visible = False
              LeftAxis.Axis.Color = 4210752
              LeftAxis.Grid.Color = clDarkgray
              LeftAxis.LabelsFormat.Font.Name = 'Verdana'
              LeftAxis.MinorTickLength = 6
              LeftAxis.TickLength = 14
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
              OnAfterDraw = FrontViewAfterDraw
              OnBeforeDrawSeries = FrontViewBeforeDrawSeries
              Align = alClient
              TabOrder = 0
              OnResize = FrontViewResize
              DefaultCanvas = 'TGDIPlusCanvas'
              ColorPaletteIndex = 13
              object SpeedGauge: TNumericGauge
                Legend.Visible = False
                ShowInLegend = False
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
                Value = 58.450000000000000000
                InternalMarkers = {
                  03000000545046300E544E756D657269634D61726B65720008506F736974696F
                  6E0708707043656E7465720B53686170652E436F6C6F7204DBDBC80010536861
                  70652E466F6E742E436F6C6F7204282828001153686170652E466F6E742E4865
                  6967687402D00F53686170652E466F6E742E4E616D65060A44532D4469676974
                  616C1353686170652E4672616D652E56697369626C65081453686170652E5368
                  61646F772E56697369626C65080A53686170652E54657874060535382C343513
                  53686170652E54657874416C69676E6D656E74070E746152696768744A757374
                  6966791153686170652E5472616E73706172656E74090000545046300E544E75
                  6D657269634D61726B65720008506F736974696F6E070A70705269676874546F
                  700F53686170652E416C69676E6D656E740708746143656E7465720B53686170
                  652E436F6C6F7204DBDBC8001053686170652E466F6E742E436F6C6F72042828
                  28001153686170652E466F6E742E48656967687402E80F53686170652E466F6E
                  742E4E616D65060A44532D4469676974616C1353686170652E4672616D652E56
                  697369626C65081453686170652E536861646F772E56697369626C65080A5368
                  6170652E5465787406046B6D2F681153686170652E5472616E73706172656E74
                  090000545046300E544E756D657269634D61726B6572000B53686170652E436F
                  6C6F7204282828001053686170652E466F6E742E436F6C6F7204DBDBC8001153
                  686170652E466F6E742E48656967687402F10F53686170652E466F6E742E4E61
                  6D65060A44532D4469676974616C1353686170652E4672616D652E5669736962
                  6C65081453686170652E536861646F772E56697369626C65080A53686170652E
                  54657874060553706565640000}
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
                EndPoint.Style = psCircle
                EndPoint.VertSize = 3
                EndPoint.Visible = False
                Maximum = 70.000000000000000000
                Minimum = -70.000000000000000000
                RotationAngle = 160
                ShapeStyle = gsPolygon
                TotalAngle = 140.000000000000000000
                Value = -20.159130245447160000
              end
            end
          end
        end
      end
      object TabPilots: TTabSheet
        Caption = 'Pilots'
        ImageIndex = 1
        object Pilots: TTeeGrid
          Left = 0
          Top = 0
          Width = 313
          Height = 620
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
          Height = 620
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
      Width = 449
      Height = 650
      ActivePage = TabLap
      Align = alClient
      TabOrder = 1
      object TabLap: TTabSheet
        Caption = 'Current Lap'
        object LapChart: TChart
          Left = 0
          Top = 0
          Width = 441
          Height = 620
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
          Legend.CheckBoxes = True
          Legend.Font.Name = 'Verdana'
          Legend.Shadow.Transparency = 0
          RightWall.Color = clLightyellow
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
            end>
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
          OnAfterDraw = LapChartAfterDraw
          Align = alClient
          TabOrder = 0
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object CurveSeries: TPointSeries
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
      end
      object TabLaps: TTabSheet
        Caption = 'All Laps'
        ImageIndex = 1
        object Chart2: TChart
          Left = 0
          Top = 0
          Width = 441
          Height = 620
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
          Align = alClient
          TabOrder = 0
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object TowerLapRider: TTowerSeries
            Pen.Visible = False
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
          Width = 441
          Height = 620
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
        object LBBikes: TListBox
          Left = 0
          Top = 0
          Width = 121
          Height = 620
          Align = alLeft
          ItemHeight = 15
          Items.Strings = (
            'Default'
            'Ducati 26'
            'Aprilia'
            'Honda'
            'KTM'
            'Yamaha')
          TabOrder = 0
          OnClick = LBBikesClick
        end
        object PageControl5: TPageControl
          Left = 121
          Top = 0
          Width = 320
          Height = 620
          ActivePage = TabSheet4
          Align = alClient
          TabOrder = 1
          object TabSheet4: TTabSheet
            Caption = 'Parameters'
            object BikeGrid: TTeeGrid
              Left = 0
              Top = 0
              Width = 312
              Height = 590
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
          object TabTorqueCurve: TTabSheet
            Caption = 'Torque Curve'
            ImageIndex = 1
          end
        end
      end
    end
    object PanelPole: TPanel
      Left = 776
      Top = 0
      Width = 328
      Height = 650
      Align = alRight
      TabOrder = 2
      object PageControl3: TPageControl
        Left = 1
        Top = 1
        Width = 326
        Height = 648
        ActivePage = TabRace
        Align = alClient
        TabOrder = 0
        object TabRace: TTabSheet
          Caption = 'Race'
          object PoleGrid: TTeeGrid
            Left = 0
            Top = 0
            Width = 318
            Height = 577
            Columns = <>
            OnSelect = PoleGridSelect
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
          object Panel4: TPanel
            Left = 0
            Top = 577
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
          end
        end
        object TabPole: TTabSheet
          Caption = 'Pole'
          ImageIndex = 1
          object PoleChart: TChart
            Left = 0
            Top = 0
            Width = 318
            Height = 618
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
            Title.Font.Name = 'Verdana'
            Title.Text.Strings = (
              'TChart')
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
    end
  end
end
