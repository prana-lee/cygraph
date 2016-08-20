{BROKEN TV}
{MICKY HANDOKO}
Uses CyGraph,CySystem;

Var
  I                 : LongInt;
  R1,G1,B1,R2,B2,G2 : Byte;

Const
  Maxdot=150000;

Begin
  Randomize;
  WriteLn('Please wait for about 30 seconds after you press a key...');
  WriteLn('Hit any key to continue....');
  ReadKey;
  clearkbbuffer;
  InitGraph(V640X480X256);
  For I:=0 To 63 Do SetRGBPalette(I,0,0,0);
  For I:=1 To Maxdot Do PutPixel(Random(640),Random(480),Random(64));
  For I:=1 To 63 Do SetRGBPalette(I,I,I,I);
  While not keypressed Do
  Begin
    GetRGBPalette(63,R1,G1,B1);
    For I:=1 To 63 Do
    Begin
      R2:=R1;
      G2:=G1;
      B2:=B1;
      GetRGBPalette(I,R1,G1,B1);
      SetRGBPalette(I,R2,G2,B2);
      Sound(Random(20001));
    End;
  End;
  NoSound;
  RestoreCRTMode;
End.