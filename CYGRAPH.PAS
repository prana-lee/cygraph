(************************************************)
{                                                }
{   Cyest Desk Graphic Library 3.6               }
{   Copyright (c) 1997 Prana's PC                }
{                                                }
(************************************************)

Unit CyGraph;

{$I flags}
{$F-,O-}

Interface

Uses CySystem;

Const
  Cylibrary:Fnamestr='CYGRAPH.CSL';

  Detect         = $000;
  Currentmode    = $000;

  V320X200X256   = $013;
  V320x200x32K   = $10D;
  V320x200x64K   = $10E;

  V640X400X256   = $100;

  V640X480X256   = $101;
  V640x480x32K   = $110;
  V640x480x64K   = $111;

  V800X600X256   = $103;
  V800x600x32K   = $113;
  V800x600x64K   = $114;

  V1024X768X256  = $105;
  V1024x768x32K  = $116;
  V1024x768x64K  = $117;

  V1280X1024X256 = $107;
  V1280x1024x32K = $119;
  V1280x1024x64K = $11A;

  BluebrownPal =0;
  DefaultPal   =768;
  DemoPal      =1536;
  GalaxyPal    =2304;
  GamePal      =3072;
  GlovePal     =3840;
  LifePal      =4608;
  Pal001Pal    =5376;
  Pal002Pal    =6144;
  SwordPal     =6912;

  Alps10Font               =7680;
  Georgianfont             =10242;
  Alps7Font                =13828;
  Alps8Font                =15622;
  Alps9Font                =17672;
  Antiquefont              =19978;
  Font36                   =23564;
  Courierfont              =26382;
  Blcksnsffont             =29968;
  Blockfont                =32530;
  Lcdfont                  =36116;
  Boldfont                 =39702;
  Alps11Font               =43288;
  Bigseriffont             =46106;
  Font8X8                  =49692;
  Modernfont               =51742;
  Ocrfont                  =55840;
  Cntdownfont              =59426;
  Computerfont             =63012;
  Futurefont               =66598;
  Gaelicfont               =70184;
  Font44                   =73770;
  Font8X10                 =76076;
  Alpsfont                 =78638;
  Cyrillicfont             =82224;
  Alps6Font                =85810;
  Scribblefont             =87348;
  Scriptfont               =91446;
  Script2Font              =95032;
  Dragonfont               =98618;
  Font30                   =102716;
  Sidefont                 =106046;
  Font3Q                   =108608;
  Similitefont             =111682;
  Italicfont               =115268;
  Font8X11Sns              =118854;
  Font8X14                 =121672;
  Sanseriffont             =125258;
  Font8X16                 =128844;
  Medievalfont             =132942;
  Font8X8Thin              =136528;
  Hollowfont               =138578;
  Frankfrtfont             =142164;
  Fresnofont               =145750;
  Oldengfont               =149336;
  Broadwayfont             =152922;
  Hebrewfont               =156508;
  Italicsfont              =160094;
  Ittfont                  =163680;
  Superfont                =167266;
  Greekfont                =169316;
  Romanfont                =172902;
  Thaifont                 =176488;
  Thinfont                 =180074;
  Hugefont                 =183660;
  Hylasfont                =187758;
  Ocr2Font                 =191344;
  Smallfont                =194930;
  Font8X14Thi              =196468;
  Smalcapsfont             =200054;
  Stretchfont              =203640;
  Senaplfont               =207226;
  Decofont                 =210812;
  Hearstfont               =214910;

 {Mouse beams}
  ArrowBeam             =0;
  PointinghandBeam      =1;
  SelectBeam            =2;
  CheckBeam             =3;
  HourglassBeam         =4;
  ClockBeam             =5;
  PencilBeam            =6;
  IBeam                 =7;
  HelpBeam              =8;
  SplithorizBeam        =9;
  SplitvertBeam         =10;
  MoveBeam              =11;
  ResizediagforwardBeam =12;
  ResizediagbackBeam    =13;
  ResizehorizBeam       =14;
  ResizevertBeam        =15;

  {settextdirection constants: }
  HorizDir=0;
  VertDir =1;

  { Horizontal and vertical justification for SetTextJustify: }
  LeftText   = 0;
  CenterText = 1;
  RightText  = 2;

  Bottomtext = 0;
  { CenterText = 1; already defined above }
  TopText    = 2;

  { Colors }
  Black        = 0;
  Blue         = 1;
  Green        = 2;
  Cyan         = 3;
  Red          = 4;
  Magenta      = 5;
  Brown        = 6;
  LightGray    = 7;
  DarkGray     = 8;
  LightBlue    = 9;
  LightGreen   = 10;
  LightCyan    = 11;
  LightRed     = 12;
  LightMagenta = 13;
  Yellow       = 14;
  White        = 15;
  Orange       = 43;
  Lime         = 46;
  SkyBlue      = 53;
  Pink         = 63;
  Cream        = 90;
  Khaki        = 115;
  DarkGreen    = 119;
  Lavender     = 131;
  Lilac        = 132;
  PrussianBlue = 176;
  OliveGreen   = 190;

  hiblack      = $0000;
  hicyan       = $0FFF;
  hiwhite      = $FFFF;

  GetMaxRed    = 63;
  GetMaxGreen  = 63;
  GetMaxBlue   = 63;
  { Fill patterns for Get/SetFillStyle: }
  Archsfill           =1;
  Asteriskfill        =2;
  Bigsmallhatchesfill =3;
  Biscuitfill         =4;
  Bkltslashfill       =5;
  BkSlashFill         =6;
  Blackholesfill      =7;
  BrickFill           =8;
  Cellsfill           =9;
  Centerexplotionfill =10;
  Chainfieldfill      =11;
  CheckerBoardFill    =12;
  Chessboard1Fill     =13;
  Chessboard2Fill     =14;
  CloseDotFill        =15;
  Connectedcirclesfill=16;
  Crittersfill        =17;
  Cyfill              =18;
  Darkbonesfill       =19;
  Diagonalbrickfill   =20;
  Diagonalstarsfill   =21;
  Diagonaltilesfill   =22;
  Diamonds1Fill       =23;
  Diamonds2Fill       =24;
  Diamondsballsfill   =25;
  Diamondsbwfill      =26;
  Digitfill           =27;
  Flowerfieldfill     =28;
  Greekfill           =29;
  HalfGrayFill        =30;
  HalfshadowFill      =31;
  HatchFill           =32;
  HorizlinesFill      =33;
  InterleaveFill      =34;
  Largexweave         =35;
  LightbonesFill      =36;
  LineFill            =37;
  LoopinglinesFill    =38;
  LoveFill            =39;
  LtSlashFill         =40;
  Net1Fill            =41;
  Net2Fill            =42;
  PaisleyFill         =43;
  PatternFill         =44;
  PlusFill            =45;
  PyramidFill         =46;
  QuiltFill           =47;
  RandomblocksFill    =48;
  RandomtrianglesFill =49;
  RivetsFill          =50;
  ScottieFill         =51;
  ShadowboxFill       =52;
  SlashFill           =53;
  SmallboxesFill      =54;
  SmallxcornerFill    =55;
  SmallxweaveFill     =56;
  SolidFill           =57;
  SpinnerFill         =58;
  Sunflower1Fill      =59;
  Sunflower2Fill      =60;
  ThatchesFill        =61;
  TulipFill           =62;
  WaffleFill          =63;
  WeaveFill           =64;
  WideDotFill         =65;
  XFill               =66;
  XHatchFill          =67;
  ZappedcirclesFill   =68;

  { Line styles for SetLineStyle: }
  SolidLn      = $FFFF;
  DashedLn     = $C3C3;
  DottedLn     = $9999;
  Closedottedln= $AAAA;
  Ropeln       = $FCCF;
  Borderln     = $FAAF;

  { BitBlt operators for PutImage: }
  NormalPut     = $88;    { MOV }
  CopyPut       = $88;    { MOV }
  XORPut        = $30;    { XOR }
  OrPut         = $08;    { OR  }
  AndPut        = $20;    { AND }

  TopOn         = TRUE;
  TopOFF        = FALSE;

Type
  Modelist=Array[1..32] Of Word;  { List of VESA mode numbers }
  Vesainfo=Record
    Signature    :Array[1..4] Of Char;   { Signature - "VESA"               }
    Version      :Word;      { VESA Version number              }
    Oemname      :Pchar;     { Pointer to manufacturer name     }
    Capabilities :LongInt;   { Capabilities       (Not used)    }
    List         :^Modelist; { Pointer to list of VESA modes    }
    Totalmemory  :Word;      { Number of 64k memory blocks on card }
    Oemversion   :Word;
    VendorName   :Pchar;
    ProductName  :Pchar;
    ProductRevStr:Pchar;
    Reserved     :Array[0..221] Of Byte;
    OemScratchPad:Array[0..255] Of Char;
  End;

  VesaModeInfo=Record
    Modeattributes        : Word;         { Mode Attributes                   }
    WinAAttributes        : Byte;         { Window A attributes               }
    WinBAttributes        : Byte;         { Window B attributes               }
    Granularity           : Word;         { Window granularity in K bytes     }
    WindowSize            : Word;         { Size of window in K bytes         }
    WinASegment           : Word;         { Segment address of window A       }
    WinBSegment           : Word;         { Segment address of window B       }
    WinFuncPtr            : Pointer;      { Windows positioning function      }
    BytesPerScanLine      : Word;         { Number of bytes per scan line     }
    screenwidth           : Word;         { Number of horizontal pixels       }
    ScreenHeight          : Word;         { Number of vertical pixels         }
    CharWidth             : Byte;         { Width of character cell           }
    CharHeight            : Byte;         { Height of character cell          }
    Planes                : Byte;         { Number of memory planes           }
    BitsWordPerPixel      : Byte;         { Number of BitsWord per pixel      }
    NumOfBanks            : Byte;         { Number of banks        (not used) }
    Model                 : Byte;         { Memory model type                 }
    BankSize              : Byte;         { Size of bank           (not used) }
    Pages                 : Byte;         { Number of image pages             }
    Reserved              : Byte;         { The following are for 15,16,24,32 bit colour modes }
    RedMaskSize           : Byte;         { Size of Red mask in BitsWord      }
    Redfieldpos           : Byte;         { Bit position of LSB of Red mask   }
    GreenMaskSize         : Byte;         { Size of Green mask in BitsWord    }
    GreenFieldPosition    : Byte;         { Bit position of LSB of Green mask }
    BlueMaskSize          : Byte;         { Size of Blue mask in BitsWord     }
    BlueFieldPosition     : Byte;         { Bit position of LSB of Blue mask  }
    ReservedMaskSize      : Byte;         { Size of Reserved mask in BitsWord }
    Reservedfieldposition : Byte;         { Bit pos. of LSB of Reserved mask  }
    Directcolormodeinfo   : Byte;
    Filler                : Array[0..215] Of Byte;
  End;

  PointType = record
   X, Y : integer;
  end;

  ArcCoordsType = record
   X, Y,
   Xstart, Ystart,
   Xend, Yend : integer;
  end;

  RGBType = Record
    RedValue   : Byte;
    GreenValue : Byte;
    BlueValue  : Byte;
  End;

  PaletteType = Array[0..255] Of RGBType;

  ViewPortType = Record
    X1, Y1, X2, Y2 :Integer;
  End;

  FillPatternType = Array [0..7] Of Byte;

  FillSettingsType = Record
    Pattern  : FillPatternType;
    Color    : Word;
    Backcolor: Word;
  End;

  TextSettingsType = record
   Font      : longint;{0 }
   XCharSize : Word;   {4 }
   YCharSize : Word;   {6 }
   SubY      : Word;   {8 }
   Direction : byte;   {10}
   Horiz     : Byte;   {11}
   Vert      : Byte;   {12}
   Size      : byte;   {13}
   Separator : shortint;{14}
  end;

  MouseShapeType = Record
    Hotspot:pointtype;
    Shape:Array[0..1,0..15] Of Word;
  End;

Function VideoStateSize:Word;
Procedure Savevideostate(Var State);
Procedure Restorevideostate(Var State);
Procedure Getvesainfo(Var Info:vesainfo);
Procedure GetModeInfo(Mode:Word;Var Info:VesaModeInfo);
Function GetActiveGraphMode:Word;
Function GetGraphMode:Word;
Function SetGraphMode(Mode:Word):Boolean;
Function InitGraph(Mode:Word):Boolean;
Procedure RestoreCRTMode;

Procedure WaitForRetrace;
Procedure GrayScale;
Procedure SetRGBPalette(Color, RedValue, GreenValue, BlueValue:Word);
Procedure GetRGBPalette(Color:Word;Var RedValue, GreenValue, BlueValue:byte);
Procedure GetPalette(Pal:Longint;Var Palette:PaletteType);
Procedure SetPalette(Pal:Longint);
Procedure SetAllPalette(Var Palette:PaletteType);
Procedure Getallpalette(Var Palette:PaletteType);
Procedure SetColor(Color:Word);
Procedure SetBkColor(Color:Byte);
Function GetColor:Word;
Function GetBkColor: Byte;
Function GetMaxColor:Word;
Function Rgbcolor(Red,Green,Blue:Word):word;

Procedure ClearDevice;
Procedure ClearViewPort;
Procedure SetViewPort(X1, Y1, X2, Y2: Integer);
Procedure GetViewSettings(Var Viewport: ViewPortType);
Procedure SetActivePage(Page:word);
Procedure SetVisualPage(Page:word);
Procedure Scroll(X,Y:Integer);
Function GetX:Integer;
Function GetY:Integer;

Procedure PutPixel(X,Y:Integer;Color:Word);
Function GetPixel(X,Y:Integer):Word;

Function Getlinestyle:Word;
Procedure SetLineStyle(LineStyle: Word);
Procedure MoveTo(X, Y : Integer);
Procedure MoveRel(DX, Dy : Integer);
Procedure Line(X1,Y1,X2,Y2:Integer);
Procedure LineTo(X,Y:Integer);
Procedure LineRel(X,Y:Integer);
Procedure Rectangle(X1,Y1,X2,Y2 : Integer);

Procedure SetFillPattern(Var Pattern:FillPatternType;Color,Backcolor:Word);
Procedure SetFillStyle(Pattern,Color,Backcolor:Word);
Procedure GetFillSettings(Var Fillinfo:FillSettingsType);
Procedure Bar(X1,Y1,X2,Y2:Integer);
Procedure Bar3D(X1,Y1,X2,Y2:Integer;Depth:Word;Top:Boolean);
Procedure Fillcircle(X,Y:Integer;Radius:Word);
Procedure FillEllipse(X,Y:Integer;Xradius,Yradius:Word);
Procedure FillPoly(Numpoints:Word;Var Polypoints);
Procedure DrawPoly(Numpoints:Word;Var Polypoints);

Procedure Circle(X,Y:Integer;Radius:Word);
Procedure GetArcCoords(Var Aarccoords: ArcCoordsType);
Procedure Arc(X,Y:Integer;Stangle,Endangle,Radius:Word);
Procedure Ellipse(X,Y:Integer;Xradius,Yradius : Word);

Function ImageSize(X1, Y1, X2, Y2: Integer):LongInt;
Procedure SetWriteMode(Mode:Byte);
Function GetWriteMode:Byte;
Procedure GetImage(X1,Y1,X2,Y2:Integer;Var Bitmap);
Procedure PutImage (X,Y:Integer;Var Bitmap);

Function TextHeight:Byte;
Function TextWidth:byte;
Procedure GetTextSettings(Var Textinfo: TextSettingsType);
Procedure SelectFont(Whichfont:LongInt;size:byte;separator:shortint);
Procedure SetTextJustify(Horiz:Byte;Vert:Byte);
Procedure settextdirection(Direction:Byte);
Procedure OutTextXY(X,Y:Integer;Text:String);
Procedure OutText(Textstring:String);

Procedure SetMouseCursor(X,Y:Word);
Procedure SetMouseStyle(shape:byte);
Procedure SetMousePattern(Shape : MouseShapeType);
Procedure Drawmouse(X,Y:Integer);
Procedure SetMouseWindow(X1,Y1,X2,Y2:word);

type
 ptype=^ftype;
 ftype=array[1..4096] of byte;

var
  MouseShape  :MouseShapeType;
  getmaxy     :Word;
  getmaxx     :Word;
  BytesPerLine:Word;
  Fontbuf     :Ptype;
  Vp          :ViewPortType;
  Textsettings:TextSettingsType;
  Hicolor     :Boolean;


const
  CurShape    :Byte=$FF;

Implementation

Var
  Grmode      :Word;
  Addx        :Word;
  Cpx,Cpy     :Word;
  Sdx,Scx     :Word;
  Actstart    :Word;
  Saveexit    :Pointer;
  Currentfill :FillSettingsType;
  Arccoords   :ArcCoordsType;
  maxcolor    :Byte;
  Backcolor   :Byte;
  Patterns    :Array[0..67] Of FillPatternType;
  Mouses      :Array[0..15] of MouseShapeType;
  winfuncptr  :pointer;

Const
  Linepattern :Word=SolidLn;
  Currentcolor:Word=White;
  Currentbank :Byte=$FF;

{$L 286}
Procedure WaitForRetrace;External;
Procedure GrayScale;External;
Procedure SetColor(Color:Word);External;
Function GetColor:Word;External;
Function GetMaxColor:Word;External;
Procedure SetAllPalette(Var Palette:PaletteType);External;
Procedure Getallpalette(Var Palette:PaletteType);External;
Procedure SetRGBPalette(Color, RedValue, GreenValue, BlueValue:Word);External;
Function GetX:Integer;External;
Function GetY:Integer;External;
Procedure MoveTo(X,Y:Integer);External;
Procedure MoveRel(DX,Dy:Integer);External;
Procedure SetViewPort(X1, Y1, X2, Y2: Integer);External;

Procedure SetLineStyle(LineStyle:Word);External;
Function Getlinestyle:Word;External;
Procedure LineTo(X,Y:Integer);External;
Procedure LineRel(X,Y:Integer);External;
Function GetPixel(X,Y:Integer):Word;External;

Procedure GetModeInfo(Mode:Word;Var Info:VesaModeInfo);External;
Function GetActiveGraphMode:Word;External;
Function GetGraphMode:Word;External;
Function SetGraphMode(Mode:Word):Boolean;External;

Function TextHeight:Byte;External;
Function TextWidth:Byte;External;

Procedure Plotcolor;Near;external;
Procedure SetWriteMode(Mode:Byte);external;
Function GetWriteMode:Byte;external;
Function GetBkColor:Byte;external;

{$L 386}
procedure cleardevice;external;
{Procedure OutTextXY(X,Y:Integer;Text:String);External;}
Procedure Circle(X,Y:Integer;Radius:Word);External;
Procedure GetImage(X1,Y1,X2,Y2:Integer;Var Bitmap);External;
Procedure PutImage(X,Y:Integer;Var Bitmap);External;
Procedure PutPixel(X,Y:Integer;Color:Word);External;

procedure loadpatterns;
const
PATpos=219008; {pattern position}

var f:file;

begin
  if not fileexist(cylibrary) then
  begin
   writeln('CYGRAPH.CSL does not exist'#10#13'This file has to be in the same directory as the executable');
   halt;
  end;
  textsettings.font:=1;
  getmem(fontbuf,4096);
  assign(f,cylibrary);
  reset(F,1);
  seek(f,patpos);
  blockread(F,patterns,sizeof(patterns));
  blockread(F,mouses,sizeof(mouses));
  close(F);
  setmousestyle(arrowbeam);
end;

procedure dummy;far;assembler;
asm
end;


Function InitGraph(Mode:Word):Boolean;Assembler;
Var
  Info:VesaModeInfo;

Asm
  call loadpatterns
  Push Mode
  Call SetGraphMode
  or al,al
  Je @Error
  Cmp Mode,V320X200X256
  Jne @Vesamode
  Mov BytesPerLine,320
  Mov getmaxx,319
  Mov getmaxy,199
  inc addx
  Jmp @Done
  @Vesamode:
  Cmp Mode,0
  Jne @Init
  Call GetActiveGraphMode
  Mov Mode,AX
  @Init:
  Push Mode
  Lea SI,Info
  Push Ss
  Push SI
  Call GetModeInfo
  mov al,info.bitswordperpixel
  mov maxcolor,al
  Mov AX,Info.screenheight
  Mov getmaxy,AX
  Dec getmaxy
  Mov AX,Info.screenwidth
  Mov getmaxx,AX
  Dec getmaxx
  Mov AX,Info.BytesPerScanLine
  Mov BytesPerLine,AX
  Mov AX,Info.WinASegment
  Mov SegA000,AX

  mov ax,info.winfuncptr.word[0]
  mov winfuncptr.word[0],ax

  mov ax,info.winfuncptr.word[2]
  mov winfuncptr.word[2],ax

  xor cx,cx
  mov bh,ch
  inc cl
  mov bl,info.bitswordperpixel
  sub bl,8
  jz @error
  inc bh
  inc cl
  @Error:
  mov addx,cx
  mov hicolor,bh
  mov ax,true
  @Done:
  Push SolidFill
  Push White
  Push 0
  Call SetFillStyle

  Push 0
  Push 0
  Push getmaxx
  Push getmaxy
  Call SetViewPort

  push normalput
  call setwritemode
  push 0
  push 7680
  push 0
  push 0
  call selectfont
End;

Procedure Setbank;Near;Assembler;
Asm
  Cmp DL,Currentbank
  Je @@Nochange
  Mov Currentbank,DL
  Pusha
  XOr BX,BX     {write bank - MOV}
  call winfuncptr
  mov dl,currentbank
  Mov BL,0001H  {read bank - AND, OR , XOR}
  call winfuncptr
  @Noread:
  Popa
  @@Nochange:
End;

Procedure RestoreCRTMode;Assembler;
Asm
  Mov AX,3H
  Int 10H
End;

Procedure Vsetoffset;Near;assembler;
asm
  Add  AX,Actstart
  Mov CL,Hicolor
  ShL BX,CL
  Mul  BytesPerLine
  Add  AX,BX
  adc dx,0
  Call Setbank
end;

Procedure Rectangle(X1,Y1,X2,Y2 : Integer);Assembler;
Asm
  Push X1
  Push Y1
  Push X2
  Push Y1
  Call Line
  Push X1
  Push Y2
  Push X2
  Push Y2
  Call Line
  Inc Y1
  dec y2
  Push X1
  Push Y1
  Push X1
  Push Y2
  Call Line
  Push X2
  Push Y1
  Push X2
  Push Y2
  Call Line
End;

Procedure Line(X1,Y1,X2,Y2:Integer);Assembler;
Const
  Left  = $07;
  Right = $0B;
  Upper = $0D;
  Lower = $0E;

Var
  I,D,Dtx,Dty,Windowy2,Incx2,Incx,Incy,E:Integer;
  Interchange:Byte;
  Pattern:Word;

Asm
  Mov BX,Vp.X1
  Add X1,BX
  Add X2,BX
  Mov SI,Vp.X2
  Mov DI,Vp.Y1
  Add Y1,DI
  Add Y2,DI
  Mov AX,Vp.Y2
  @Start:
  Mov Windowy2,AX
  {BX|SI|DI|WindowY2 = vp.x1|vp.x2|vp.y1|vp.y2}

  Mov CL,0Fh        {start with %1111  }
  Cmp X2,BX         {x2 < WindowX1 ?}
  Jl @v1point2     {yes, don't change flag for "point is left of window"}
  And CL,Left       {no, reset flag       }
  @v1point2:
  Cmp X2,SI         {x2 > WindowX2 ?}
  Jg @v2point2     {yes, don't change flag for "point is right of window"}
  And CL,Right      {no, reset flag       }
  @v2point2:
  Mov AX,Y2
  Cmp AX,DI         {y2 < WindowY1 ?}
  Jl @v3point2     {yes, don't change flag for "point is above window"}
  And CL,Upper      {no, reset flag       }
  @v3point2:
  Cmp AX,Windowy2   {y2 > WindowY2 ?}
  Jg @point1        {yes, don't change flag for "point is below window"}
  And CL,Lower
  @point1:
  Mov CH,0Fh        {start with %1111  }
  Cmp X1,BX         {x1 < WindowX1 ?}
  Jl @v1point1     {yes, don't change flag for "point is left of window"}
  And CH,Left  {no, reset flag      }
  @v1point1:
  Cmp X1,SI         {x1 > WindowX2 ?}
  Jg @v2point1     {yes, don't change flag for "point is right of window"}
  And CH,Right      {no, reset flag       }
  @v2point1:
  Mov AX,Y1
  Cmp AX,DI         {y1 < WindowY1 ?}
  Jl @v3point1      {yes, don't change flag for "point is above window"}
  And CH,Upper      {no, reset flag       }
  @v3point1:
  Cmp AX,Windowy2   {y1 > WindowY2 ?}
  Jg @v4point1      {yes, don't change flag for "point is below window"}
  And CH,Lower
  @v4point1:        {CH holds the area code for point 1          }
                    {CL holds the area code for point 2, CH the one for point 1}
  Mov AX,CX
  And AL,AH         {Code1 AND Code2 <> 0 ?}
  Jnz @Done         {yes, line is completely outside the window}
  Mov AX,CX
  Or AL,AH          {Code1 OR Code2 = 0 ?}
  Jz @Drawline      {yes, line is completely inside the window}
                    {Now do the clipping itself: }
  Mov AX,CX
  Or AH,AH          {Code1 =0 ?}
  Jnz @Cl3          {no, everything ok lah yauow !}
  Mov AX,X1         {yes, swap points!}
  Xchg AX,X2
  Mov X1,AX
  Mov AX,Y1
  Xchg AX,Y2
  Mov Y1,AX
  Xchg CL,CH
  @Cl3:
  Mov AX,X2
  Sub AX,X1
  Mov Dtx,AX                {dtx := x2 - x1}
  Mov AX,Y2
  Sub AX,Y1
  Mov Dty,AX                {dty := y2 - y1}
  Mov AL,CH                 {AL := Code1}
  Test AL,Not Left          {point1 left of window?   }
  Jz @Cl4                   {no  }
                            {yes, compute new coordinates:}
                            { y1 := y1 + (y2 - y1) / (x2 - x1) * (WindowX1 - X1) }
                            { and x1 := WindowX1}
  Mov AX,BX
  Sub AX,X1                 {AX := WindowX1-x1}
  Imul Dty
  Idiv Dtx
  Add Y1,AX
  Mov X1,BX
  Jmp @point1
  @Cl4:
  Test AL,Not Right         {point1 right of window?   }
  Jz @Cl5                   {no  }
  {yes, compute:}
  { y1 := y1 + (y2 - y1) / (x2 - x1) * (WindowX2 - X1), x1 := WindowX2}
  Mov AX,SI                 {SI = WindowX2}
  Sub AX,X1
  Imul Dty
  Idiv Dtx
  Add Y1,AX
  Mov X1,SI
  Jmp @point1

  @Cl5:
  Test AL,Not Upper         {point1 above window?        }
  Jz @Cl6                   {no  }
                            {yes, compute:}
                            { x1 := x1 + (x2 - x1) / (y2 - y1) * (WindowY1 - y1), y1 := WindowY1 }
  Mov AX,DI                 {DI = WindowY1}
  Sub AX,Y1
  Imul Dtx
  Idiv Dty
  Add X1,AX
  Mov Y1,DI
  Jmp @point1

  @Cl6:
  Test AL,Not Lower         {point below window?         }
  Jz @point1                {no  }
  {yes, compute:}
  { x1 := x1 + (x2 - x1) / (y2 - y1) * (WindowY2 - y1), y1 := WindowY2 }
  Mov AX,Windowy2
  Push AX
  Sub AX,Y1
  Imul Dtx
  Idiv Dty
  Add X1,AX
  Pop AX
  Mov Y1,AX
  Jmp @point1

  @Yincr:
  Cmp Incy,0
  Jl @Negy2
  Add DI,BytesPerLine            {y:=y+incy}
  Jmp @Skip73
  @Negy2:
  Sub DI,BytesPerLine            {y:=y-incy}
  @Skip73:
  Jnc @Nobanky
  Add DX,Incy
  Call Setbank
  @Nobanky:
  Retn

  @Drawline:
  mov ax,linepattern
  mov pattern,ax
  Mov AX,Y1
  Mov BX,X1
  Call Vsetoffset
  Mov DI,AX
  Mov SI,X2                     {SI=_DX}
  Sub SI,X1
  Mov Incx,1
  Mov AX,Addx
  Mov Incx2,AX
  Jns @Bx_To_Dy
  Neg Incx
  Neg Incx2
  Neg SI
  @Bx_To_Dy:
  Mov bX,Y2                     {AX=_DY}
  Sub bX,Y1
  Mov Incy,1
  Jns @Skip2
  Neg Incy
  Neg bX
  @Skip2:
  Mov Interchange,FALSE
  Cmp bX,SI                     {_DY compare _DX [SI] }
  Jl @Dy_Lower_Than_Dx
  Inc Interchange
  Xchg bX,SI
  @Dy_Lower_Than_Dx:
  Mov CX,SI                     {loop i:=_DX;  ;initialization}
  inc cx
  ShL SI,1                      {_DX * 2}
  ShL bX,1                      {_DY * 2}
  Mov E,bX
  Sub E,SI
  Mov ES,SegA000
  Mov AX,Currentcolor
  @Mainloop:                    {main loop}
  ror pattern,1
  Jnc @Noplot
  call plotcolor

  @Noplot:
  Cmp E,0
  Jnge @Skipe                   {while e >= 0}
  Cmp Interchange,FALSE
  Je @Itfalse1
  Add DI,Incx2                   {x:=x+incx}
  Jnz @Nobank1                  {DI=bankend ?}
  Add DX,Incx
  Call Setbank
  Jmp @Nobank1
  @Itfalse1:
  Call @Yincr
  @Nobank1:
  Sub E,SI
  @Skipe:
  Cmp Interchange,FALSE
  Je @Itfalse2
  Call @Yincr
  Jmp @Ittrue2
  @Itfalse2:
  Add DI,Incx2                    {x:=x+incx}
  Jnz @Ittrue2                   {DI=bankend ?}
  Add DX,Incx
  Call Setbank
  @Ittrue2:
  Add E,bX
  Loop @Mainloop
  @Done:
End;

Procedure GetRGBPalette(Color:word;Var RedValue, GreenValue, BlueValue:Byte);Assembler;
Asm
  Mov DX, 3C7H
  Mov Ax, Color
  Out DX,al
  Add DX, 2
  In  AL, DX
  Les DI, RedValue
  StosB
  In  AL, DX
  Les DI, GreenValue
  StosB
  In  AL, DX
  Les DI, BlueValue
  StosB
End;

Procedure settextdirection(Direction:Byte);Assembler;
Asm
  mov ax,word ptr direction
  mov textsettings.direction,al
  Cmp ax,HorizDir
  Je @Vert
  Mov AX,Textsettings.Xcharsize
  Jmp @Exit
  @Vert:
  Mov AX,Textsettings.Ycharsize
  Mul BytesPerLine
  @Exit:
  Mov Textsettings.Suby,ax
End;

Procedure SelectFont(Whichfont:LongInt;size:byte;separator:shortint);
Var
  F:File;
  W:Word;

Begin
asm
    mov al,size
    mov textsettings.size,al
    mov al,separator
    mov textsettings.separator,al
end;
 if whichfont=textsettings.font then exit;
 TextSettings.Font:=WhichFont;
  Assign(F,Cylibrary);
  Reset(F,1);
  Seek(F,Whichfont);
  BlockRead(F,W,2);
  Asm
    XOr AX,AX
    Mov AL,Byte Ptr W+1
    Mov Textsettings.Ycharsize,AX
    Mov AL,Byte Ptr W
    Mov Textsettings.Xcharsize,AX
{    mov cl,hicolor
    ShL Textsettings.Xcharsize,cl}
    Push HorizDir
    Call settextdirection
  End;
  BlockRead(F,Fontbuf^,textsettings.ycharsize shl 8);
  Close(F);
End;

Procedure Hline(X1,X2,Y:Word);Assembler;
Asm
  Mov AX,Vp.x1
  Mov BX,Vp.y1
  Mov CX,Vp.x2
  Mov DX,Vp.y2
  Add X1,AX
  Add X2,AX
  Add Y,BX
  Cmp X1,AX
  Jg @@2
  Cmp X2,AX
  Jl @done
  Mov X1,AX
  @@2:
  Cmp Y,BX
  Jl @Done
  Cmp X2,CX
  Jl @@4
  Cmp X1,CX
  Jg @Done
  Mov X2,CX
  @@4:
  Cmp Y,DX
  Jg @Done

  Mov AX,Y
  Mov BX,X1
  Call Vsetoffset
  Mov DI,AX
  Mov BX,Y
  Mov SI,BX
  ShR SI,3
  ShL SI,3
  Sub BX,SI
  XOr AH,AH
  Mov bl,Byte Ptr Currentfill+BX
  Mov CX,X1
  Mov aX,CX
  ShR CX,3
  ShL CX,3
  Sub aX,CX
  Mov CX,aX
  ROl bl,CL

  Mov ES,SegA000
  Mov CX,X2
  Sub CX,X1
  inc cx
  mov dx,addx
  @Plotloop:
  ROl bl,1
  JNC @Noplot
  Mov AX,Currentfill.Color
  Jmp @Plotit
  @Noplot:
  Mov AX,Currentfill.Backcolor
  @Plotit:
  call plotcolor
  Add DI,dx
  Jnc @Noneedbank
  mov dl,currentbank
  Inc DL
  Call Setbank
  mov dx,addx
  @Noneedbank:
  Loop @Plotloop
  @Done:
End;

Procedure Bar(X1,Y1,X2,Y2:Integer);assembler;
Var
  I,Iy:Word;
  Height,Width:Word;
  ssi:word;

asm
  Mov AX,X1
  Cmp AX,X2
  Jl @Xok
  Xchg AX,X2
  Mov X1,AX
  @xok:

  Mov AX,y1
  Cmp AX,y2
  Jl @yok
  Xchg AX,y2
  Mov y1,AX
  @yok:

  Mov AX,Vp.X1
  Mov BX,Vp.Y1
  Mov CX,Vp.X2
  Mov DX,Vp.Y2

  Add X1,AX
  Add X2,AX
  Add Y1,BX
  Add Y2,BX

  Cmp X1,AX
  Jg @@2
  Cmp X2,AX
  Jl @@Done
  Mov X1,AX
  @@2:
  Cmp Y1,BX
  Jg @@3
  cmp y2,bx
  jl @@done
  mov y1,bx

 @@3:
  Cmp X2,CX
  Jl @@4
  Cmp X1,CX
  Jg @@Done
  Mov X2,CX

  @@4:
  Cmp Y2,DX
  jl @ok
  cmp y1,dx
  jg @@done
  mov y2,dx
  @ok:

  Mov CX,X2
  Sub CX,X1
  Inc CX
  Mov Width,CX

  Mov AX,Y2
  Sub AX,Y1
  Inc AX
  Mov Height,AX

  call getwritemode
  mov byte ptr @pm,al
  Mov AX,Y1
  Mov BX,X1

  Call Vsetoffset
  mov dx,addx
  Mov DI,AX
  add byte ptr @pm,cl
  Mov AX,Width
  ShL AX,CL
  Sub BytesPerLine,AX
  Mov ES,SegA000

  Mov BX,X1
  Mov SI,BX
  ShR BX,3
  ShL BX,3
  Sub SI,BX
  mov ssi,si

  Mov AX,Y1
  Mov si,AX
  ShR AX,3
  ShL AX,3
  Sub si,AX

  @Loopy:
  Mov bl,Byte Ptr Currentfill+si
  mov cl,byte ptr ssi
  rol bl,cl
  Mov CX,Width
  @Plotloop:
  rol bl,1
  Jc @Noplot
  Mov AX,Currentfill.backColor
  Jmp @Plotit
  @Noplot:
  Mov AX,Currentfill.color
  @Plotit:
  db $26
  @pm:db 00
  db $05
  Add DI,dx
  Jnc @Noneedbank
  mov dl,currentbank
  Inc DL
  Call Setbank
  mov dx,addx
  @Noneedbank:
  Loop @Plotloop
  Add DI,BytesPerLine
  Jnc @Nobanky
  mov dl,currentbank
  Inc DL
  Call Setbank
  mov dx,addx
  @Nobanky:
  Inc sI
  Cmp si,8
  Jl @Skip
  Mov si,0
  @Skip:
  Dec Height
  Jnz @Loopy
  Mov AX,Width
  Mov CL,Hicolor
  ShL AX,CL
  Add BytesPerLine,AX
  @@done:
End;

Procedure Bar3D(X1, Y1, X2, Y2:Integer;Depth: Word; Top: Boolean);
Var
  B:Byte;

Begin
  B:=getWriteMode;
  SetWriteMode(CopyPut);
  Bar(X1+1,Y1+1,X2-1,Y2-1);
  Rectangle(X1,Y1,X2,Y2);
  If Top Then
  Begin
    Line(X1,Y1,X1+Depth,Y1-Depth);
    Line(X2,Y1,X2+Depth,Y1-Depth);
    Line(X1+Depth,Y1-Depth,X2+Depth+1,Y1-Depth);
  End;
  Line(X2,Y2,X2+Depth,Y2-Depth);
  Inc(X2,Depth);
  Line(X2,Y2-Depth,X2,Y1-Depth);
  SetWriteMode(B);
End;

Function ImageSize(X1, Y1, X2, Y2: Integer):LongInt;Assembler;
{4+(x2-x1)*(y2-y1) untuk mode 256 warna
 4+2*(x2-x1)*(y2-y1) untuk mode 64k warna
^^->_DeltaX dan _DeltaY}
Asm
  Cwd
  Mov CL,Hicolor
  Mov BX,X2
  Sub BX,X1
  Inc BX
  ShL BX,CL
  Mov AX,Y2
  Sub AX,Y1
  Inc AX
  Mul BX
  Add AX,4
End;

Procedure GetTextSettings(Var Textinfo: TextSettingsType);Assembler;
Asm
  cld
  Push DS
  Lea SI,Textsettings
  LES DI,Textinfo
  Mov CX,Type TextSettingstype / 2
  Rep Movsw
  Pop DS
End;

Procedure SetFillPattern(Var Pattern:FillPatternType;Color,Backcolor:Word);
Begin
  Currentfill.Pattern:=Pattern;
  Currentfill.Color:=Color;
  Currentfill.Backcolor:=Backcolor;
End;

Procedure SetFillStyle(Pattern,Color,Backcolor:Word);Assembler;
Asm
  dec pattern
  Lea SI,Patterns
  Mov BX,Pattern
  ShL BX,3
  Add SI,BX
  Push DS
  Push SI
  Push Color
  Push Backcolor
  Call SetFillPattern
End;

Procedure GetFillSettings(Var Fillinfo:FillSettingsType);Assembler;
Asm
  cld
  Lea SI,Currentfill
  LES DI,Fillinfo
  Mov CX,(Type FillSettingsType)/2
  Rep Movsw
End;

Procedure GetViewSettings(Var Viewport: ViewPortType);Assembler;
Asm
  cld
  Lea SI,Vp
  LES DI,Viewport
  Mov CX,(Type ViewPortType)/2
  Rep Movsw
End;

Procedure SetActivePage(Page:word);Assembler;
Asm
  Mov AX,getmaxy
  Inc AX
  Mul Page
  Mov Actstart,AX
End;

Procedure SetVisualPage(Page:word);Assembler;
Asm
  Mov AX,getmaxy
  Inc AX
  Mul Page
  push 0
  push ax
  call scroll
End;

Procedure Scroll(X,Y:Integer);Assembler;
Asm
  Mov CX,Scx
  Mov DX,Sdx
  Add DX,Y
  Add CX,X
  Mov Scx,CX
  Mov Sdx,DX
  Mov AX,04F07H
  XOr BX,BX
  Int 10H
End;

Procedure SetTextJustify(Horiz:Byte;Vert:Byte);assembler;
asm
 mov al,horiz
 mov bl,vert
 mov textsettings.horiz,al
 mov textsettings.vert,bl
end;

Procedure OutText(Textstring:String);assembler;
asm
 push cpx
 push cpy
 les di,textstring
 push es
 push di
 call outtextxy
End;

Procedure Getvesainfo(Var Info:vesainfo);Assembler;
Asm
  Mov AX,4F00H
  LES DI,Info
  Int 10H
End;

Function VideoStateSize:Word;assembler;
asm
 mov ax,4f04h
 xor dx,dx
 mov cl,0fh
 int 10h
 xchg ax,bx
End;

Procedure Savevideostate(Var State);Assembler;
Asm
  Mov CL,0Fh
  Mov AX,4F04H
  Mov DL,001
  LES BX,State
  Int 10H
End;

Procedure Restorevideostate(Var State);Assembler;
Asm
  Mov CL,0Fh
  Mov AX,4F04H
  Mov DL,002
  LES BX,State
  Int 10H
End;

Procedure SetBkColor(Color:Byte);
Var
  R,G,B:byte;

Begin
  Backcolor:=Color;
  GetRGBPalette(Color,R,G,B);
  SetRGBPalette(0,R,G,B);
End;

Procedure ClearViewPort;
Var
  Fill:FillSettingsType;
  B:Byte;

Begin
  B:=GetWritemode+byte(hicolor);
  SetWritemode(Normalput);
  GetFillSettings(Fill);
  SetFillStyle(SolidFill,Black,Black);
  With Vp Do
    Bar(0,0,X2-X1,Y2-Y1);
  SetFillPattern(Fill.Pattern,Fill.Color,Fill.Backcolor);
  setwritemode(B-(byte(hicolor)));
End;

Procedure Arc(X,Y:Integer;Stangle,Endangle,Radius:Word);
Type
  Qdrtype=Record
    Startx:Integer;
    Starty:Integer;
    Endx:Integer;
    Endy:Integer;
    Flag:Boolean;
  End;

Const
  Stdangle=90;

Var
  S,Ys,Xs:Integer;
  I:Integer;
  Qdr:Array[0..3] Of Qdrtype;

Procedure Putpixel1(X,Y:Integer);
Begin
  With Qdr[0] Do If Flag And
  (((X<=Startx) And (X>=Endx)) And ((Y<=Starty) And (Y>=Endy)))
  Then CyGraph.PutPixel(X,Y,GetColor);
End;

Procedure Putpixel2(X,Y:Integer);
Begin
  With Qdr[1] Do If Flag And
  (((X <= Startx) And (X >= Endx)) And ((Y>=Starty) And (Y<=Endy)))
  Then PutPixel(X,Y,GetColor);
End;

Procedure Putpixel3(X,Y:Integer);
Begin
  With Qdr[2] Do If Flag And
  (((X >= Startx) And (X <= Endx)) And ((Y >= Starty) And (Y<=Endy)))
  Then
    PutPixel(X,Y,GetColor);
End;

Procedure Putpixel4(X,Y:Integer);
Begin
  With Qdr[3] Do If Flag And
  (((X >= Startx) And (X <= Endx)) And ((Y <= Starty) And (Y >= Endy)))
  Then
    PutPixel(X,Y,GetColor);
End;

Begin
  If (Radius = 0) Then Exit;
  If (Radius = 1) Then
  Begin
    PutPixel(X, Y,Currentcolor);
    Exit;
  End;
  If Stangle > Endangle Then SwapWord(Stangle,Endangle);
  If Endangle >360 Then
  Begin
    Arc(X,Y,0,Endangle Mod 360,Radius);
    Endangle:=360;
  End;
  For I:=0 To 3 Do
  Begin
    With Qdr[I] Do
    Begin
      Flag:=FALSE;
      Startx:=I*Stdangle;
      Endx:=90+Startx;
      If (Stangle >=Startx) And (Stangle <=Endx) Then
      Begin
        Startx:=Stangle;
        Flag:=TRUE;
      End;
      If (Endangle >=Startx) And (Endangle <=Endx) Then
      Begin
        Endx:=Endangle;
        Flag:=TRUE;
      End;
      If Not Flag Then
      Begin
        If ((Stangle >=Startx) And (Endangle >=Endx))
           Or ((Stangle <=Startx) And (Endangle <=Endx))
        Then Startx:=Endx Else Flag:=TRUE;
      End;
      If Startx=Endx Then Flag:=FALSE;
      Starty:=Y+Round(Radius*Cosdeg(Startx+90));
      Endy  :=Y+Round(Radius*Cosdeg(Endx+90));
      Startx:=X+Round(Radius*Cosdeg(Startx));
      Endx  :=X+Round(Radius*Cosdeg(Endx));
    End;
  End;
  Arccoords.X:=X;
  Arccoords.Y:=Y;
  With Arccoords Do
  Begin
    Xstart:=X+Round(Radius*Cosdeg(Stangle));
    Ystart:=Y+Round(Radius*Cosdeg(Stangle+90));
    Xend  :=X+Round(Radius*Cosdeg(Endangle));
    Yend  :=Y+Round(Radius*Cosdeg(Endangle+90));
  End;
  Xs := 0;
  Ys := Radius;
  Radius:=Radius*Radius;
  Repeat
    Inc(Xs);
    S:=(Xs*Xs+Ys*Ys)-Radius;
    If S > 0 Then Dec(Ys);
    Putpixel1(X-1+Ys, Y+1-Xs); {qdr I-1}
    Putpixel1(X-1+Xs, Y+1-Ys); {qdr I-2}
    Putpixel2(X+1-Xs, Y+1-Ys); {qdr II-1}
    Putpixel2(X+1-Ys, Y+1-Xs); {qdr II-2}
    Putpixel3(X+1-Ys, Y-1+Xs); {qdr III-1}
    Putpixel3(X+1-Xs, Y-1+Ys); {qdr III-2}
    Putpixel4(X-1+Xs, Y-1+Ys); {qdr IV-1}
    Putpixel4(X-1+Ys, Y-1+Xs); {qdr IV-2}
    {Biar lambat asal selamat !}
  Until (Xs >= Ys);
End;

Procedure GetArcCoords(Var Aarccoords: ArcCoordsType);
Begin
  Aarccoords:=Arccoords;
End;

Procedure Ellipse(X,Y:Integer;Xradius,Yradius:Word);
Var
  I,Ex,Ey: Integer;
  Yradsqr,Yradsqr2,Xradsqr,Xradsqr2,D,DX,Dy: LongInt;

Procedure Plotpoints;
Begin
  PutPixel(X+Ex,Y+Ey,Currentcolor);
  PutPixel(X-Ex,Y+Ey,Currentcolor);
  PutPixel(X+Ex,Y-Ey,Currentcolor);
  PutPixel(X-Ex,Y-Ey,Currentcolor);
End;

Begin
  Ex:=0;
  Ey:=Yradius;
  Yradsqr:=LongInt(Xradius)*Xradius;
  Yradsqr2:=Yradsqr ShL 1;
  Xradsqr:=LongInt(Yradius)*Yradius;
  Xradsqr2:=Xradsqr ShL 1;
  D:=Xradsqr-Yradsqr*Yradius+Yradsqr ShR 2;
  DX:=0;
  Dy:=Yradsqr2*Yradius;
  PutPixel(X,Y-Ey,Currentcolor);
  PutPixel(X,Y+Ey,Currentcolor);
  PutPixel(X-Xradius,Y,Currentcolor);
  PutPixel(X+Xradius,Y,Currentcolor);
  While (DX<Dy) Do
  Begin
    If (D>0) Then
    Begin
      Dec(Ey);
      Dec(Dy,Yradsqr2);
      Dec(D,Dy);
    End;
    Inc(Ex);
    Inc(DX,Xradsqr2);
    Inc(D,Xradsqr+DX);
    Plotpoints;
  End;
  Inc(D,(3*(Yradsqr-Xradsqr) Div 2 - (DX+Dy)) Div 2);
  For I:=Ey DownTo 1 Do
  Begin
    If(D < 0) Then
    Begin
      Inc(Ex);
      Inc(DX,Xradsqr2);
      Inc(D,Xradsqr+DX);
    End;
    Dec(Ey);
    Dec(Dy,Yradsqr2);
    Inc(D,Yradsqr-Dy);
    Plotpoints;
  End;
End;

Procedure FillEllipse(X,Y:Integer;Xradius,Yradius:Word);
Var
  I,Ex,Ey: Integer;
  Yradsqr,Yradsqr2,Xradsqr,Xradsqr2,D,DX,Dy: LongInt;

Procedure Plotpoints;
Var
  Minx,Plusx:Integer;

Begin
  Minx:=X-Ex;
  Plusx:=X+Ex;
  Hline(Minx,Plusx,Y-Ey);
  Hline(Minx,Plusx,Y+Ey);
End;

Begin
  Ex:=0;
  Ey:=Yradius;
  Yradsqr:=LongInt(Xradius)*Xradius;
  Yradsqr2:=Yradsqr ShL 1;
  Xradsqr:=LongInt(Yradius)*Yradius;
  Xradsqr2:=Xradsqr ShL 1;
  D:=Xradsqr-Yradsqr*Yradius+Yradsqr ShR 2;
  DX:=0;
  Dy:=Yradsqr2*Yradius;
  While (DX<Dy) Do
  Begin
    If (D>0) Then
    Begin
      Dec(Ey);
      Dec(Dy,Yradsqr2);
      Dec(D,Dy);
    End;
    Inc(Ex);
    Inc(DX,Xradsqr2);
    Inc(D,Xradsqr+DX);
    Plotpoints;
  End;
  Inc(D,(3*(Yradsqr-Xradsqr) Div 2 - (DX+Dy)) Div 2);
  For I:=Ey DownTo 1 Do
  Begin
    If(D < 0) Then
    Begin
      Inc(Ex);
      Inc(DX,Xradsqr2);
      Inc(D,Xradsqr+DX);
    End;
    Dec(Ey);
    Dec(Dy,Yradsqr2);
    Inc(D,Yradsqr-Dy);
    Plotpoints;
  End;
  Ellipse(X,Y,Xradius,Yradius);
End;

Procedure GetPalette(Pal:Longint;Var Palette:PaletteType);
var
 f:file;

begin
assign(F,cylibrary);
reset(F,1);
seek(F,pal);
blockread(f,palette,sizeof(palettetype));
close(F);
end;

Procedure SetPalette(Pal:Longint);
var
 apal:palettetype;

begin
 getpalette(pal,apal);
 setallpalette(apal);
end;

Procedure Fillcircle(X,Y:Integer;Radius:Word);assembler;
asm
 push x
 push y
 push radius
 push radius
 call fillellipse
End;

Procedure DrawPoly(Numpoints: Word; Var Polypoints);
Var
  Points:Array[0..16000] Of PointType Absolute Polypoints;
  I:Word;

Begin
  For I:=0 To Numpoints-2 Do with points[I] do
  Line(X,Y,Points[I+1].X,Points[I+1].Y);
End;

Procedure FillPoly(Numpoints:Word;Var Polypoints);

Procedure Scanedge(X1,Y1,X2,Y2,Setxstart:Integer;Var Edgepointptr); Assembler;
Var
  Advanceamt,Height:Word;
  Skipfirst:Integer;

Asm
  Mov Skipfirst,0
  Les DI,Edgepointptr
  Les DI,ES:[DI]
  Cmp Setxstart,1
  Jz @@Hlineptrset
  Add DI,2
  @@Hlineptrset:
  Mov BX,Y2
  Sub BX,Y1
  Jle @@Toscanedgeexit
  Mov Height,BX
  Sub CX,CX
  Mov DX,1
  Mov AX,X2
  Sub AX,X1
  Jz  @@Isvertical
  Jns @@Setadvanceamt
  Mov CX,1
  Sub CX,BX
  Neg DX
  Neg AX
  @@Setadvanceamt:
  Mov Advanceamt,DX
  Cmp AX,BX
  Jz @@Isdiagonal
  Jb @@Ymajor
  Sub DX,DX
  Div BX
  Mov SI,AX
  Test Advanceamt,8000H
  Jz @@Xmajoradvanceamtset
  Neg SI
  @@Xmajoradvanceamtset:
  Mov AX,X1
  Cmp Skipfirst,1
  Jz @@Xmajorskipentry
  @@Xmajorloop:
  Mov ES:[DI],AX
  Add DI,4
  @@Xmajorskipentry:
  Add AX,SI
  Add CX,DX
  Jle @@Xmajornoadvance
  Add AX,Advanceamt
  Sub CX,Height
  @@Xmajornoadvance:
  Dec BX
  Jnz @@Xmajorloop
  Jmp @@Scanedgedone
  @@Toscanedgeexit:
  Jmp @@Scanedgeexit
  @@Isvertical:
  Mov AX,X1
  Sub BX,Skipfirst
  Jz @@Scanedgeexit
  @@Verticalloop:
  Mov ES:[DI],AX
  Add DI,4
  Dec BX
  Jnz @@Verticalloop
  Jmp @@Scanedgedone
  @@Isdiagonal:
  Mov AX,X1
  Cmp Skipfirst,1
  Jz @@Diagonalskipentry
  @@Diagonalloop:
  stosw
  add di,2
  @@Diagonalskipentry:
  Add AX,DX
  Dec BX
  Jnz @@Diagonalloop
  Jmp @@Scanedgedone
  @@Ymajor:
  Push BP
  Mov SI,X1
  Cmp Skipfirst,1
  Mov BP,BX
  Jz @@Ymajorskipentry
  @@Ymajorloop:
  Mov ES:[DI],SI
  Add DI,4
  @@Ymajorskipentry:
  Add CX,AX
  Jle @@Ymajornoadvance
  Add SI,DX
  Sub CX,BP
  @@Ymajornoadvance:
  Dec BX
  Jnz @@Ymajorloop
  Pop BP
  @@Scanedgedone:
  Cmp Setxstart,1
  Jz @@Updatehlineptr
  Sub DI,2
  @@Updatehlineptr:
  Mov BX,Word Ptr Edgepointptr
  Mov Ss:[BX],DI
  @@Scanedgeexit:
End;

Procedure Drawhorizontallinelist(Var List);Assembler;
Asm
  LES SI,List
  Mov CX,ES:[SI]
  Mov AX,ES:[SI+2]
  LES SI,ES:[SI+4]

  @@Loop:
  Mov BX,ES:[SI]
  Mov DX,ES:[SI+2]
  Push CX
  Push AX
  Push SI
  Push ES
  Push BX

  Push DX
  Push AX
  Call Hline

  Pop ES
  Pop SI
  Pop AX
  Pop CX
  Inc AX
  Add SI,4
  Loop @@Loop
End;

Type
  Ppointtypeslist = ^Pointtypeslist;
  Pointtypeslist = Array[0..16000] Of PointType;
  Thline =Record
    Xstart,Xend:Word;
  End;

  Phlinearray = ^Thlinearray;
  Thlinearray = Array[0..16000] Of Thline;
  Thlinelist = Record
    Length,Ystart:Integer;
    Hlineptr : Phlinearray;
  End;

Var
  I,Minindex,Maxindex,Minpoint_Y,Maxpoint_Y,Nextindex,
  Currentindex,Previousindex:Integer;
  Workinghlinelist:Thlinelist;
  Edgepointptr:Phlinearray;
  Vertexptr:Ppointtypeslist;
  Body:Ppointtypeslist;
  Need:Word;
  Wm:Byte;

Begin
  If Numpoints=0 Then Exit;
  Need:=Numpoints ShL 2;
  GetMem(Vertexptr,Need);
  if not inmemory(vertexptr) then exit;
  Vertexptr^:=Pointtypeslist(Polypoints);
  Maxpoint_Y:=Vertexptr^[0].Y;
  Minpoint_Y:=Maxpoint_Y;
  Minindex:=0;
  Maxindex:=0;
  For I:=1 To Numpoints-1 Do
    With Vertexptr^[I] Do
      If Y<Minpoint_Y Then
      Begin
        Minpoint_Y:=Y;
        Minindex:=I;
      End
      Else
        If Y>Maxpoint_Y Then
        Begin
          Maxpoint_Y:=Y;
          Maxindex:=I;
        End;
  With Workinghlinelist Do
  Begin
    Length:=Maxpoint_Y-Minpoint_Y;
    If Length<=0 Then Exit;
    Ystart:=Minpoint_Y;
    GetMem(Hlineptr,Length ShL 2);
    Edgepointptr:=Hlineptr;
  End;
  Currentindex:=Minindex;
  Previousindex:=Minindex;
  Repeat
    Currentindex:=(Currentindex+Numpoints-1) Mod Numpoints;
    Scanedge(Vertexptr^[Previousindex].X,Vertexptr^[Previousindex].Y,
      Vertexptr^[Currentindex].X,Vertexptr^[Currentindex].Y,1,Edgepointptr);
    Previousindex:=Currentindex;
  Until Currentindex=Maxindex;
  Edgepointptr:=Workinghlinelist.Hlineptr;
  Currentindex:=Minindex;
  Previousindex:=Minindex;
  Repeat
    Currentindex:=(Currentindex+1) Mod Numpoints;
    Scanedge(Vertexptr^[Previousindex].X,Vertexptr^[Previousindex].Y,Vertexptr^[Currentindex].X,
             Vertexptr^[Currentindex].Y,0,Edgepointptr);
    Previousindex:=Currentindex;
  Until Currentindex=Maxindex;
  Drawhorizontallinelist(Workinghlinelist);
  With Workinghlinelist Do FreeMem(Hlineptr,Length ShL 2);
  FreeMem(Vertexptr,Need);
End;

function rgbcolor(red,green,blue:word):word;assembler;
const
 shift=3;
 shiftmask=255;

asm
 mov bx,green
 and bx,0ffh
 shl bx,5
 mov ax,blue
 and ax,0ffh
 add ax,bx
 mov dx,red
 and dx,0ffh
 shl dx,shift
 add dl,bh
 and dx,shiftmask
 mov ah,dl
end;

procedure outtextxy(x,y:integer;text:string);
var
 k,i,j:integer;
 c:char;
 b:byte;
 sx,sy:byte;

begin
case textsettings.vert of
 centertext:dec(y,(textsettings.size+1)*textsettings.ycharsize shr 1);
 toptext:dec(y,(textsettings.size+1)*textsettings.ycharsize);
end;
case textsettings.horiz of
 centertext:dec(x,(textsettings.size+1)*(textsettings.xcharsize shr 1)*word(length(text)));
 righttext:dec(x,(textsettings.size+1)*textsettings.xcharsize*word(length(text)));
end;
for k:=1 to length(text) do
 begin
  c:=text[k];
  for j:=1 to textsettings.ycharsize do
  begin
   b:=byte(fontbuf^[ord(c)*textsettings.ycharsize+j]);
   for i:=1 to textsettings.xcharsize+1 do
    begin
     if b and $80 <> 0 then
     for sy:=0 to textsettings.size do
       for sx:=0 to textsettings.size do
         putpixel(x+i+sx,y+j+sy,currentcolor);
      b:=b shl 1;
      inc(x,textsettings.size);
    end;
    dec(x,textsettings.size*(textsettings.xcharsize+1));
    inc(Y,textsettings.size);
  end;
   dec(y,textsettings.size*textsettings.ycharsize);
   inc(x,(textsettings.size+1)*(textsettings.xcharsize+textsettings.separator));
 end;
end;

Procedure Drawmouse(X,Y:Integer);Assembler;
Var
  Width,Height:Word;
  AndPattern,Xorpattern:Word;
  Nhorshift:Word;
  savebank:byte;

Asm
    cld
    Mov Nhorshift,0
    Mov Height,16
    Mov Width,16
    mov bx,x
    mov dx,y
    Lea SI,MouseShape
    Lodsw
    sub bx,ax   {x-hotspot.x}
    cmp bx,0
    jge @xg
    neg bx
    mov nhorshift,bx
    neg bx
    add bx,16
    mov width,bx
    xor bx,bx
    jmp @xdone
    @xg:
    mov ax,bx
    add ax,16
    cmp ax,getmaxx
    jle @xdone
    mov cx,getmaxx
    inc cx
    sub cx,bx
    mov width,cx
    @Xdone:
    Lodsw
    Sub dx,ax
    Cmp dx,0
    Jge @Yg
    mov ax,dx
    neg ax
    shl ax,1
    add si,ax
    add dx,16
    mov height,dx
    xor dx,dx
    jmp @ydone
    @Yg:
    Mov AX,dx
    Add AX,16
    Cmp AX,getmaxy
    Jle @Ydone
    Mov AX,getmaxy
    Sub AX,dx
    Inc AX
    Mov Height,AX
    @Ydone:
    mov al,20h
    add al,hicolor
    mov byte ptr @p1,al
    mov al,30h
    add al,hicolor
    mov byte ptr @p2,al
    Mov AX,dx
    call vsetoffset
    Mov DI,AX
    Push bytesperline
    Mov AX,Width
    shl ax,cl
    Sub bytesperline,AX
    Mov BL,White
    Mov ES,SegA000
    Mov Bx,white
    cmp cl,false
    je @puty
    mov bx,0ffffh

    @Puty:
    LODSW              {AND}
    mov andpattern,ax
    Mov ax,DS:[SI+30]  {XOR}
    mov xorpattern,ax
    Mov CX,nhorshift
    Rol andpattern,CL
    Rol xorpattern,CL
    Mov CX,Width
    @Putx:
    XOr aX,aX
    Rol andpattern,1
    Jc @Noandput
    db $26
@p1:db $20
    db $05
    @Noandput:
    Rol Xorpattern,1
    Jnc @Noxorput
    db $26
@p2:db $30
    db $1d   {ada warnaan}
    @Noxorput:
    add DI,addx
    jnz @nobank
    inc dl
    call setbank
    @nobank:
    Loop @Putx
    Add DI,bytesperline
    jnc @nobank2
    inc dl
    call setbank
    @nobank2:
    Dec Height
    Jnz @Puty
    @@Done:
    Pop bytesperline
End;

Procedure SetMouseCursor(X,Y:Word);Assembler;
Asm
  Mov AX,4
  Mov CX,X
  Mov DX,Y
  Int 33H
End;

Procedure SetMouseStyle(shape:byte);
begin
 if curshape <> shape then
 begin
  curshape:=shape;
  setmousepattern(mouses[shape]);
 end;
end;

Procedure SetMousePattern(Shape:MouseShapeType);assembler;
asm
 cld
 mov dx,ds
 lds si,shape
 lea di,mouseshape
 mov ax,ds
 mov es,ax
 mov cx,type(mouseshapetype)/4
 Db 0F3H, 066H, 0A5H
 mov ds,dx
End;

PROCEDURE SetMouseWindow(X1,Y1,X2,Y2:Word);assembler;
asm
  mov ax,07h
  mov cx,x1
  mov dx,x2
  int 33h
  mov ax,08h
  mov cx,y1
  mov dx,y2
  int 33h

END;

Procedure Cygraphexit;Far;
Begin
  FreeMem(Fontbuf,4096);
  ExitProc:=Saveexit;
End;

Begin
  {203008}
  loadpatterns;
  Saveexit:=ExitProc;
  ExitProc:=@Cygraphexit;
End.
