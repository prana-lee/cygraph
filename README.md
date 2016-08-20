Cyest Graph
--------------------------------------------------------------------------------
Uploaded to Github on Aug 19, 2016. This is an old Turbo Pascal 7.0 graphics library
Faster than Borland BGI. No longer updated, it belongs to a museum. Initially
uploaded to Garbo Uwasa Freeware & Shareware Archives in 1997.

Last Update: December 22, 1999

Requirement
--------------------------------------------------------------------------------
1. At least 386-machine, running DOS 6.x or Win95/98 or DOSEMU under Linux
2. Turbo Pascal 7.0 compiler (Real Mode)

Demos by Micky H

Info
--------------------------------------------------------------------------------
- Last version (I will no longer create DOS programs)
- No more runtime error if CYGRAPH.CSL is not available.
  It will display a friendlier message now.
- 16 Vesa Graphics mode available in 256 (8-bit), 32768 (15-bit),
  and 65536 (16-bit) colors
- 62 internal fonts
- 71 internal fillpatterns
- 14 internal palettes
-  6 internal line styles
-  4 Write Mode Method (Copy,XOr,Or,And)
- Library : CYGRAPH.CSL (CyGraph Standard Library)
- Added Arc procedure
- Optimized function & procedures : * DrawMouse
                                    * GetImage (386 instr.)
                                    * PutImage
                                    * ImageSize
                                    * Line
                                    * Circle (386 instr.)
                                    * FillEllipse
                                    * DrawPoly
                                    * OuttextXY

- Procedure ScrollUp,ScrollDown,ScrollLeft,ScrollRight replaced with Scroll(DX,DY)
- All Word parameters in basic drawing methods now replaced with Integer,
  considering the Point(X,Y) won't always greater than zero.
- Compiled executables are much smaller than before, no need BGI/CHR either
- Almost all procedures and functions written in assembly
- All procedures & functions made by myself, except for FillPoly & Ellipse.

Cyest Graph Unit Interface
--------------------------------------------------------------------------------
Note : M = Pascal & Assembly language mixed
       P = Pure Pascal language
       A = Pure Assembly Language (3=386 instruction)

- A : Procedure GetModeInfo(Mode:Word;Var Info:VesaModeInfo);
- A : Function GetActiveGraphMode:Word;
- A : Function GetGraphMode:Word;
- A : Function SetGraphMode(Mode:Word):Boolean;
- A : Function InitGraph(Mode:Word):Boolean;
- A : Procedure RestoreCRTMode;

- A : Procedure WaitForRetrace;
- A : Procedure GrayScale;
- A : Procedure SetRGBPalette(Color, RedValue, GreenValue, BlueValue:Word);
- A : Procedure GetRGBPalette(Color:Word;Var RedValue, GreenValue, BlueValue:byte);
- P : Procedure GetPalette(Pal:Longint;Var Palette:PaletteType);
- P : Procedure SetPalette(Pal:Longint);
- A : Procedure SetAllPalette(Var Palette:PaletteType);
- A : Procedure Getallpalette(Var Palette:PaletteType);
- A : Procedure SetColor(Color:Word);
- A : Procedure SetBkColor(Color:Byte);
- A : Function GetColor:Word;
- A : Function GetBkColor: Byte;
- A : Function GetMaxColor:Word;
- A : Function Rgbcolor(Red,Green,Blue:Word):Word;

- P : Procedure ClearDevice;
- P : Procedure ClearViewPort;
- A : Procedure SetViewPort(X1, Y1, X2, Y2: Integer);
- A : Procedure GetViewSettings(Var Viewport: ViewPortType);
- A : Procedure SetActivePage(Page:word);
- A : Procedure SetVisualPage(Page:word);
- A : Procedure Scroll(X,Y:Integer);
- A : Function GetMaxX:Integer;
- A : Function GetMaxY:Integer;
- A : Function GetX:Integer;
- A : Function GetY:Integer;

- A : Procedure PutPixel(X,Y:Integer;Color:Word);
- A : Function  GetPixel(X,Y:Integer):Word;

- A : Function  Getlinestyle:Word;
- A : Procedure SetLineStyle(LineStyle: Word);
- A : Procedure MoveTo(X, Y : Integer);
- A : Procedure MoveRel(DX, Dy : Integer);
- A : Procedure Line(X1,Y1,X2,Y2:Integer);
- A : Procedure LineTo(X,Y:Integer);
- A : Procedure LineRel(X,Y:Integer);
- A : Procedure Rectangle(X1,Y1,X2,Y2 : Integer);

- A : Procedure SetFillPattern(Var Pattern:FillPatternType;Color,Backcolor:Word);
- A : Procedure SetFillStyle(Pattern,Color,Backcolor:Word);
- A : Procedure GetFillSettings(Var Fillinfo:FillSettingsType);
- A : Procedure Bar(X1,Y1,X2,Y2:Integer);
- P : Procedure Bar3D(X1,Y1,X2,Y2:Integer;Depth:Word;Top:Boolean);
- P : Procedure Fillcircle(X,Y:Integer;Radius:Word);
- P : Procedure FillEllipse(X,Y:Integer;Xradius,Yradius:Word);
- M : Procedure FillPoly(Numpoints:Word;Var Polypoints);
- P : Procedure DrawPoly(Numpoints:Word;Var Polypoints);
- A3: Procedure Circle(X,Y:Integer;Radius:Word);
- P : Procedure GetArcCoords(Var Aarccoords: ArcCoordsType);
- P : Procedure Arc(X,Y:Integer;Stangle,Endangle,Radius:Word);
- P : Procedure Ellipse(X,Y:Integer;Xradius,Yradius : Word);

- A : Function  ImageSize(X1, Y1, X2, Y2: Integer):LongInt;
- A : Procedure SetWriteMode(Mode:Byte);
- A : Function  GetWriteMode:Byte;
- A3: Procedure GetImage(X1,Y1,X2,Y2:Integer;Var Bitmap);
- A3: Procedure PutImage (X,Y:Integer;Var Bitmap);

- A : Function TextHeight:Byte;
- A : Function TextWidth:Byte;
- A : Procedure GetTextSettings(Var Textinfo: TextSettingsType);
- M : Procedure SelectFont(Whichfont:LongInt);
- A : Procedure SetTextJustify(Horiz:Byte;Vert:Byte);
- A : Procedure settextdirection(Direction:Byte);
- A3: Procedure OutTextXY(X,Y:Integer;Text:String);
- P: Procedure OutTextXY(X,Y:Integer;Text:String);
- P : Procedure OutText(Textstring:String);
- A : Procedure SetMouseCursor(X,Y:Word);
- P : Procedure SetMouseShape(Shape : MouseShapeType);
- A : Procedure Drawmouse(X,Y:Integer);
- A : Procedure SetMouseWindow (X1, Y1, X2, Y2 : WORD);
