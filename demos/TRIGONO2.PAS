{$n+}
{need math coprocessor}
{MICKY HANDOKO}
{TRIGONOMETRY}
Uses CyGraph,cysystem;
label RETURN;
Const Xp = 0;
  R  = 100;
Var
  X,Y      : Integer;
  Yp       : Integer;
  Colour,I : Integer;
Begin
  InitGraph(V640X480X256);
  For I:=0 To 63 Do Setrgbpalette(I,I,0,0);
  For I:=0 To 63 Do Setrgbpalette(I+64,63-I,I,0);
  For I:=0 To 63 Do Setrgbpalette(I+128,0,63-I,I);
  For I:=0 To 63 Do Setrgbpalette(I+192,0,0,63-I);
  For Yp:=0 To GetMaxY Do
  Begin
    Inc(Colour);
    For X:=0 To GetMaxX Do
    Begin
      If KeyPressed Then goto RETURN;
      Y:=Round(Sin(X*Pi/180)*Sin(X*Pi/180*2)*Cos(X*Pi/180*2)*R);
      PutPixel(Xp+X,Yp-Y,Colour);
    End;
  End;
  While Not KeyPressed Do
  Begin
    For I:=0 DownTo 63 Do
    Begin
      If KeyPressed Then goto RETURN;
      SetRGBPalette(I,63-I,0,0);
    End;
    For I:=0 To 63 Do Begin
      If KeyPressed Then goto RETURN;
      SetRGBPalette(I+64,0,63-I,0);
    End;
    For I:=0 To 63 Do Begin
      If KeyPressed Then goto RETURN;
      SetRGBPalette(I+128,0,0,63-I);
    End;
    For I:=0 To 63 Do
    Begin
      If KeyPressed Then goto RETURN;
      SetRGBPalette(I+192,0,0,I);
    End;
    For I:=0 To 63 Do
    Begin
      If KeyPressed Then goto RETURN;
      SetRGBPalette(I,I,0,0);
    End;
    For I:=0 To 63 Do
    Begin
      If KeyPressed Then goto RETURN;
      SetRGBPalette(I+64,63-I,I,0);
    End;
    For I:=0 To 63 Do
     Begin
      If KeyPressed Then goto RETURN;
      SetRGBPalette(I+128,0,63-I,I);
    End;
    For I:=0 To 63 Do
     Begin
      If KeyPressed Then goto RETURN;
      SetRGBPalette(I+192,0,0,63-I);
    End;
  End;
  RETURN:
  restorecrtmode;
End.