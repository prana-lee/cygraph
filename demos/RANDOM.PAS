{RANDOM}
{MICKY HANDOKO}
Uses Cysystem,CyGraph;
Var
  X,Y   : Integer;
  I,D   : Integer;

Begin
  InitGraph(V640X480X256);
  For X:=0 To 63 Do SetRGBPalette(X,X,X,0);
  For X:=0 To 63 Do SetRGBPalette(X+64,X,0,X);
  For X:=0 To 63 Do SetRGBPalette(X+128,0,X,X);
  Randomize;
  While Port[$60]>=128 Do
  Begin
    {yellow}
    For I:=1 To 16 Do
    Begin
      D:=Random(16);
      Case D Of
        0:
        Begin
          X:=Random(128);
          Y:=Random(96);
        End;
        1:
        Begin
          X:=Random(128)+128;
          Y:=Random(96);
        End;
        2:
        Begin
          X:=Random(128)+256;
          Y:=Random(96);
        End;
        3:
        Begin
          X:=Random(128)+384;
          Y:=Random(96);
        End;
        4:
        Begin
          X:=Random(128)+512;
          Y:=Random(96);
        End;
        5:
        Begin
          X:=Random(128);
          Y:=Random(96)+96;
        End;
        6:
        Begin
          X:=Random(128)+512;
          Y:=Random(96)+96;
        End;
        7:
        Begin
          X:=Random(128);
          Y:=Random(96)+192;
        End;
        8:
        Begin
          X:=Random(128)+512;
          Y:=Random(96)+192;
        End;
        9:
        Begin
          X:=Random(128);
          Y:=Random(96)+288;
        End;
        10:
        Begin
          X:=Random(128)+512;
          Y:=Random(96)+288;
        End;
        11:
        Begin
          X:=Random(128);
          Y:=Random(96)+384;
        End;
        12:
        Begin
          X:=Random(128)+128;
          Y:=Random(96)+384;
        End;
        13:
        Begin
          X:=Random(128)+256;
          Y:=Random(96)+384;
        End;
        14:
        Begin
          X:=Random(128)+384;
          Y:=Random(96)+384;
        End;
        15:
        Begin
          X:=Random(128)+512;
          Y:=Random(96)+384;
        End;
      End;
      D:=Random(64);
      PutPixel(X,Y,D);
    End;
    {pink}
    For I:=1 To 8 Do
    Begin
      D:=Random(8);
      Case D Of
        0:
        Begin
          X:=Random(128)+128;
          Y:=Random(96)+96;
        End;
        1:
        Begin
          X:=Random(128)+256;
          Y:=Random(96)+96;
        End;
        2:
        Begin
          X:=Random(128)+384;
          Y:=Random(96)+96;
        End;
        3:
        Begin
          X:=Random(128)+128;
          Y:=Random(96)+192;
        End;
        4:
        Begin
          X:=Random(128)+384;
          Y:=Random(96)+192;
        End;
        5:
        Begin
          X:=Random(128)+128;
          Y:=Random(96)+288;
        End;
        6:
        Begin
          X:=Random(128)+256;
          Y:=Random(96)+288;
        End;
        7:
        Begin
          X:=Random(128)+384;
          Y:=Random(96)+288;
        End;
      End;
      D:=Random(64)+64;
      PutPixel(X,Y,D);
    End;
    {cyan}
    X:=Random(128)+256;
    Y:=Random(96)+192;
    D:=Random(64)+128;
    PutPixel(X,Y,D);
  End;
  RestoreCRTMode;
End.