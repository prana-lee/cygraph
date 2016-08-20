(*******************************************************)
{                                                       }
{       Cyest Desk version 3.0                          }
{       Cyest Desk Enhanced Run Time Library            }
{                                                       }
{       Copyright (c) 1996 Prana's PC Corp.             }
{                                                       }
(*******************************************************)

Unit CySystem;
{$i flags}
{$DEFINE USE386}

Interface

Uses Objects;

Const
  Pi=3.14159265358979;

  MaxWord    =$FFFF;
  MaxByte    =$FF;
  FMRead     =0;
  FMWrite    =1;
  FMReadWrite=2;

(********************************[MEMORY]**********************************)

type
  FNameStr = string[79];

{ Typed-file and untyped-file record }

  TFileRec = record
    Handle: Word;
    Mode: Word;
    RecSize: Word;
    Private: array[1..26] of Byte;
    UserData: array[1..16] of Byte;
    Name: array[0..79] of Char;
  end;

{ Textfile record }

type
  PTextBuf = ^TTextBuf;
  TTextBuf = array[0..127] of Char;
  TTextRec = record
    Handle: Word;
    Mode: Word;
    BufSize: Word;
    Private: Word;
    BufPos: Word;
    BufEnd: Word;
    BufPtr: PTextBuf;
    OpenFunc: Pointer;
    InOutFunc: Pointer;
    FlushFunc: Pointer;
    CloseFunc: Pointer;
    UserData: array[1..16] of Byte;
    Name: array[0..79] of Char;
    Buffer: TTextBuf;
  end;

Function InMemory(P:Pointer):Boolean;
Function LowMemory:Boolean;
Function GetLowMemSize:Word;
Procedure SetLowMemSize(Size:Word);
Procedure GetMem(var P; Size: Word);
Procedure FreeMem(Var P; Size: Word);
Procedure DisposeObj(P:Pobject);

(********************************[SYSTEM]**********************************)

function max(i,j:integer):integer;
function min(i,j:integer):integer;
Procedure Move(Var Source, Dest;Count: Word);
Procedure SwapWord(Var Bit1,Bit2);
Procedure SwapByte(Var Bit1,Bit2);
Procedure InitSystem;
function DayOfWeek(Day, Month, Year: Integer) : Integer;

(**********************************[CRT]***********************************)

Function ReadKey:Char;
Function KeyPressed:Boolean;
Function WhereX:Byte;
Function WhereY:Byte;
Procedure GotoXY(X,Y:Byte);
Procedure Delay(Ms : Word);
Procedure Sound(Hertz : Word);
Procedure NoSound;
Procedure ClearKBBuffer;

(*********************************[MATHS]**********************************)

function SinDeg(Degree:real):real;
function cosDeg(Degree:real):real;

(*******************************[STRINGS]**********************************)

Function Value(Const Code:String):LongInt;
Function RealValue(Const Code:String):Real;
Function Comma(R:Real):String;
Function Hex(Argument:LongInt):String;
Function HexWord(Argument:Word):String;
Function Binary(num: Word): String;
Function Copy(Source: String;Index,Count: Byte): String;
Function CPos (C:Char;Const S:String):Byte;
Function CLastPos(C:Char;S:String):Byte;
Function CLowcase (C:Char):Char ;
Function FancyStr(S:String):String;
procedure FormatStr(var Result: String; Format: String; var Params);
Procedure DisposeStr(P: PString);
Procedure Reverse(Var Str:String);
Procedure UpCase(Var Str:String);
Procedure Locase(Var Str:String);
Inline(
  $8C/$Da/$Bb/65/25/$5E/$1F/$Fc/$Ac/$88/$C1/$30/$Ed/$D1/$E9/$73/$0B/$Ac/
  $28/$D8/$38/$F8/$77/$04/$80/$44/$Ff/32/$E3/$14/$Ad/$28/$D8/$38/$F8/
  $77/$04/$80/$44/$Fe/32/$49/$28/$Dc/$38/$Fc/$77/$Ec/$Eb/$E6/$8E/$Da);

(**********************************[DOS]***********************************)

Function DosVersion:Word;
Function Erase(Filename:FNameStr):Byte;
Function MkDir(Filename:FNameStr):Byte;
Function RmDir(Filename:FNameStr):Byte;
Function FileExist(Filename:FNameStr):Boolean;

Function GetCBreak:Boolean;
Function GetVerify:Boolean;
procedure GetDate(var Year : word; var Month, Day, DayOfWeek : byte);
procedure GetTime(var Hour, Minute, Second, Sec100 : byte);
Procedure SetFileMode(Mode:byte);
Procedure CySetintvec(Num:Word;Vec:Pointer);
Procedure CyGetintvec(Num:Word;Var Vec:Pointer);

Implementation

const
  LowMemSize:Word=5;

(********************************[MEMORY]**********************************)

Procedure SetLowMemSize(Size:Word);assembler;
asm
 mov ax,size
 mov lowmemsize,ax
end;

Function GetLowMemSize:Word;assembler;
asm
 mov ax,lowmemsize
end;

Procedure GetMem(var P; Size: Word);
begin
 if (not LowMemory) then system.getmem(pointer(p),size) else pointer(p):=nil;
end;

Procedure FreeMem(Var P; Size: Word);
Begin
  If InMemory(Pointer(P)) Then System.FreeMem(Pointer(P),Size);
  Pointer(P):=Nil;
End;

Function LowMemory:Boolean;
Begin
  LowMemory:=MaxAvail <= (LowMemSize*1024);
End;

Function InMemory(P:Pointer):Boolean;
Begin
  InMemory:=(Seg(P^) > SSeg) And (Seg(P^) <= Seg(HeapEnd^));
End;

Procedure DisposeObj(P:Pobject);
Begin
  If InMemory(P) Then System.Dispose(P,Done);
End;

Procedure DisposeStr(P: PString);
Begin
  FreeMem(P,Length(P^));
End;

(********************************[SYSTEM]**********************************)

function Min(I, J: Integer): Integer;
begin
  if I < J then Min := I else Min := J;
end;

function Max(I, J: Integer): Integer;
begin
  if I > J then Max := I else Max := J;
end;

{Function Min(A,B:Word):Boolean;Assembler;
asm
 xor ax,ax
 mov bx,b
 cmp a,bx
 jge @@done
 inc ax
@@done:
end;}

Procedure SwapWord(Var Bit1,Bit2);Assembler;
Asm
  push ds
  Les DI,Bit1
  Lds SI,Bit2
  Mov AX,DS:[SI]
  Mov BX,ES:[DI]
  Mov ES:[DI],AX
  Mov DS:[SI],BX
  pop ds
End;

Procedure SwapByte(Var Bit1,Bit2);Assembler;
Asm
  push ds
  Les DI,Bit1
  Lds SI,Bit2
  Mov Al,DS:[SI]
  Mov Bl,ES:[DI]
  Mov ES:[DI],Al
  Mov DS:[SI],Bl
  pop ds
End;

Procedure Move(Var Source, Dest;Count: Word); Assembler;
const
  D32 = $66;                  { 32 bit data }

 asm
 push ds
    CLD                       { Copy Forward }
    DB   D32
    XOR  SI, SI               { XOR ESI, ESI to clear high word }

    DB   D32
    XOR  DI, DI               { XOR EDI, EDI to clear high word }

    DB   D32
    DB   $0F, $B7             { MOVZX ECX, Count }
    DB   $4E, $06

    LDS  SI,  Source          { Load Source address }
    LES  DI,  Dest            { Load Destination Address }

    SHR  CX, 2                { Convert to DWORDS }
    DB   D32
    REP  MOVSW                { REP MOVSD }
    MOV  CX, Count            { Get count again }
    AND  CX, 3                { Get last 0-3 bytes }
    REP MOVSB                 { Move odd bytes, if they exist }
 pop ds
end;

(********************************[STRINGS]*********************************)
{$L FMT}
procedure FormatStr(var Result: String; Format: String; var Params);external;

Function CLastPos(C:Char;S:String):Byte;Assembler;
Asm
  Mov   AL,C       {Put char to look for in AL}
  Les   DI,S       {Set ES:DI to start of Src_str}
  XOr   CX,CX      {0 CX }
  Mov   CL,[ES:DI] {Move length of Src_str to CL }
  Add   DI,CX      {Set ES:DI to end of Src_str }
  Inc   CX         {Add one to CX (correct for string length }
  Std              {Set direction flag}
  Repnz Scasb      {Look for character in string }
  Mov   AX,CX      {If found CX indicates position, else 0 }
End;

Procedure UpCase(Var Str:String);
Begin
  Inline(                  {Assembly by Inline 02/23/88 21:28}
    $1E/                   {          push ds}
    $C5/$B6/>Str/          {          lds  si, >str[bp]}
    $8A/$0C/               {          mov  cl,[si]}
    $Fe/$C1/               {          inc  cl}
    $Fe/$C9/               {l1:       dec  cl}
    $74/$10/               {          jz   l2}
    $46/                   {          inc  si}
    $80/$3C/$61/           {          cmp  by[si],'a'}
    $72/$F6/               {          jb   l1}
    $80/$3C/$7A/           {          cmp  by[si],'z'}
    $77/$F1/               {          ja   l1}
    $80/$2C/$20/           {          sub  by[si],$20}
    $Eb/$Ec/               {          jmp  short l1}
    $1F);                  {l2:       pop  ds}
End;

Function Comma(R:Real):String;
Var
  S: String;
  X: Integer;
Begin
  Str(R:0:16,S);
  X := Pos('.',S)-3;
  While X > 1 Do Begin
    Insert(',', S,X);
    dec(x,3);
  End;
  For X:=Length(S) Downto (Pos('.',S)) Do
    If S[X] <> '0'  Then Break;
  S:=Copy(S,1,X);
  X:=Length(S);
  If S[X]='.' Then Delete(S,X,1);
  if (r < 0) and (s[2]=',') then delete(s,2,1);
  Comma:=S;
End;

Function Value(Const Code:String):LongInt;
Var
  L:LongInt;
  I:Integer;

Begin
  Val(Code,L,I);
  Value:=L;
End;

Function RealValue(Const Code:String):Real;
Var
  R:Real;
  I:Integer;

Begin
  Val(Code,R,I);
  RealValue:=R;
End;

Function Hex (Argument : LongInt) : String; Assembler;
Asm
  Cld
  Les    DI, @Result
  Mov    AL, 8                   { store string length }
  Stosb
  Mov    DX, Word Ptr Argument+2 { hi word }
  Call   @@1                     { convert dh to ascii }
  Mov    DH, DL                  { lo byte of hi word }
  Call   @@1                     { convert dh to ascii }
  Mov    DX, Word Ptr Argument   { lo word }
  Call   @@1                     { convert dh to ascii }
  Mov    DH, DL                  { lo byte of lo word }
  Call   @@1                     { convert dh to ascii }
  Jmp    @@2
  @@1 :
  Mov    AL, DH                 { 1 byte }
  And    AL, 0Fh                { low nybble }
  Add    AL, 90H
  Daa
  Adc    AL, 40H
  Daa
  Mov    AH, AL                 { store }
  Mov    AL, DH                 { 1 byte }
  ShR    AL, 4                  { get high nybble }
  Add    AL, 90H
  Daa
  Adc    AL, 40H
  Daa
  Stosw                         { move characters to result }
  Retn                          { return near }
  @@2:
End;

Function HexWord(Argument: Word): String; Assembler;
ASM
      LES  DI, @Result
      XOR  CH, CH
      MOV  CL, 4
      MOV  ES:[DI], CL
      JCXZ @@3
      ADD  DI, CX
      MOV  BX, Argument
      STD
@@1:  MOV  AL, BL
      AND  AL, 0Fh
      OR   AL, 30h
      CMP  AL, 3Ah
      JB   @@2
      ADD  AL, 7
@@2:  STOSB
      SHR  BX, 4
      LOOP @@1
@@3:
End;

Function Binary(num: Word): String; Assembler;
ASM
      LES  DI, @Result
      XOR  CH, CH
      MOV  CL,16
      MOV  ES:[DI], CL
      JCXZ @@3
      ADD  DI, CX
      MOV  BX, num
      STD
@@1:  MOV  AL, BL
      AND  AL, $01
      OR   AL, $30
      STOSB
      SHR  BX, 1
      LOOP @@1
@@3:
End;

Procedure Reverse(Var Str:String);Assembler;
Asm
  Push DS
  Cld
  Lds SI,Str
  Mov DI,SI
  Lodsb
  XOr AH,AH
  Add DI,AX               { DI points to end of s }
  @Reverseloop:
  Cmp SI,DI               { while SI=DI do ... }
  Jae @Reverseexit
  Mov AL,[SI]
  Mov AH,[DI]
  Mov [SI],AH
  Mov [DI],AL
  Inc SI
  Dec DI
  Jmp @Reverseloop
  @Reverseexit:
  Pop DS
End;

Function CPos (C:Char;Const S:String):Byte ;Assembler;
Asm
  Mov AL ,C
  Cld
  Les DI ,S
  Mov CL ,ES:[DI]
  Mov AH ,CL
  XOr CH ,CH
  Jcxz @Done
  Inc DI
  Repne Scasb
  Jnz @Done
  Neg CL
  Add CL , AH
  @Done :
  Mov AL , CL
End;

Function Copy(Source: String;Index,Count: Byte): String;Assembler;
Asm
  Push    DS
  Push    ES
  Lds     SI, Source
  Les     DI, @Result
  XOr     AX, AX
  Mov     BX, AX
  Mov     CX, AX
  Mov     BL, Index
  Mov     CL, Count
  Cld
  Stosb
  Lodsb
  Cmp     AX, BX
  Jb      @Done
  Add     SI, BX
  Dec     SI
  Sub     AX, BX
  Cmp     AX, CX
  Jnb     @Docop
  Xchg    AX, CX
  Inc     CX
  @Docop: Push    CX
  ShR     CX, 1
  Jnc     @Word1
  Movsb
  @Word1:
  {$IFDEF USE386}
  ShR     CX, 1
  Jnc     @Word2
  Movsw
  @Word2: Db 0F3H, 066H, 0A5H  { rep movsd }
  {$ELSE}
  Rep     Movsw
  {$ENDIF}
  Pop     AX
  Les     DI, @Result
  Stosb
  @Done:
  Pop     ES
  Pop     DS
End;

Function CLowcase (C:Char):Char ;
Begin
  If C In ['A'.. 'Z'] Then CLowcase:=Chr(Ord(C)+(97-65))
  Else CLowcase:=C;
End;

Function FancyStr(S:String ):String ;
Const
  Charset:Set Of Char=
  ([#32..#64,#91..#96,#123..#106]);
Var I:Byte;

Begin
  S [1] := System.UpCase(S[1]);
  For I := 2 To Length (S) Do If (S[I-1] In Charset) Then S [I]:=System.UpCase(S[I])
  Else S[I]:= CLowcase (S[I]);
  FancyStr := S ;
End;

(**********************************[CRT]***********************************)

Procedure Sound(Hertz : Word); Assembler;
Asm
  Mov    BX,Sp
  Mov    BX,&Hertz
  Mov    AX,34Ddh
  Mov    DX,0012H
  Cmp    DX,BX
  Jnb    @J1
  Div    BX
  Mov    BX,AX
  In     AL,61H
  Test   AL,03H
  Jnz    @J2
  Or     AL,03H
  Out    61H,AL
  Mov    AL,-4AH
  Out    43H,AL
  @J2:
  Mov    AL,BL
  Out    42H,AL
  Mov    AL,BH
  Out    42H,AL
  @J1:
End;

Procedure Delay(Ms : Word); Assembler;
Asm
  Mov AX, 1000
  Mul Ms
  Mov CX, DX
  Mov DX, AX
  Mov AH, 86H
  Int $15
End;

Procedure NoSound; Assembler;
Asm
  In     AL,61H
  And    AL,0Fch
  Out    61H,AL
End;

Procedure ClearKBBuffer;Assembler;
Asm
 Call KeyPressed
 Cmp AL,TRUE
 Jne @Done
 Call ReadKey
 @Done:
End;

Function ReadKey:Char; Assembler;
Asm
  XOR AH,AH
  Int 16H
End;

Function KeyPressed: Boolean; Assembler;
Asm
  Mov    AH, 1
  Int    16H
  Mov    AL, FALSE
  Jz     @Notpressed
  Mov    AL, TRUE
  @Notpressed:
End;

Procedure GotoXY(X,Y : Byte); Assembler;
Asm
  Mov DH, Y
  Mov DL, X
  Dec DH
  Dec DL
  Mov BH,0
  Mov AH,2
  Int 10H
End;

Function  WhereX : Byte;  Assembler;
Asm
  Mov     AH,3
  Mov     BH,0
  Int     10H
  Inc     DL
  Mov     AL, DL
End;

Function WhereY : Byte; Assembler;
Asm
  Mov     AH,3
  Mov     BH,0
  Int     10H
  Inc     DH
  Mov     AL, DH
End;

(*********************************[MATHS]**********************************)

function SinDeg(Degree:real):real;
begin
 sindeg:=sin(1.7453292520E-02*degree);
end;

function cosDeg(Degree:real):real;
begin
 cosdeg:=cos(1.7453292520E-02*degree);
end;

(***********************************DOS************************************)

Function DosVersion:Word;Assembler;
Asm
  Mov AX,3306H
  Int 21H
  Mov AX,BX
End;

Function Erase(Filename :FNameStr):Byte; Assembler;
Asm
  Push DS
  Lds SI,Filename
  Inc Byte Ptr [SI]
  Mov BL,Byte Ptr [SI]
  XOr BH,BH
  Mov DX,SI
  Inc DX
  Mov Byte Ptr [SI+BX],0
  Mov AH,41H
  Int 21H
  Jc  @Error
  XOr AX,AX
  @Error:
  Dec Byte Ptr [SI]
  Pop DS
End;

Function MkDir(Filename:FNameStr):Byte;Assembler;
Asm
  Push DS
  Lds SI,Filename
  Inc Byte Ptr [SI]
  Mov BL,Byte Ptr [SI]
  XOr BH,BH
  Mov DX,SI
  Inc DX
  Mov Byte Ptr [SI+BX],0
  Mov AH,39H
  Int 21H
  Jc  @Error
  XOr AX,AX
  @Error:
  Dec Byte Ptr [SI]
  Pop DS
End;

Function RmDir(Filename:FNameStr):Byte;Assembler;
Asm
  Push DS
  Lds SI,Filename
  Inc Byte Ptr [SI]
  Mov BL,Byte Ptr [SI]
  XOr BH,BH
  Mov DX,SI
  Inc DX
  Mov Byte Ptr [SI+BX],0
  Mov AH,3AH
  Int 21H
  Jc  @Error
  XOr AX,AX
  @Error:
  Dec Byte Ptr [SI]
  Pop DS
End;

Function FileExist(Filename:FNameStr) : Boolean; Assembler;
Asm
  Push   DS
  Lds    SI, [Filename]
  XOr    AH, AH
  Lodsb
  Xchg   AX, BX
  Mov    Byte Ptr [SI+BX], 0
  Mov    DX, SI
  Mov    AX, 4300H           { get file attributes }
  Int    21H
  Mov    AL, FALSE
  Jc     @@1                  { fail? }
  Inc    AX
  @@1:     Pop    DS
End;

Function Lastdrive: Char; Assembler;
Asm
  Mov   AH, 19H
  Int   21H
  Push  AX            { save default drive }
  Mov   AH, 0Eh
  Mov   DL, 19H
  Int   21H
  Mov   CL, AL
  Dec   CX
  @@Checkdrive:
  Mov   AH, 0Eh       { check if drive valid }
  Mov   DL, CL
  Int   21H
  Mov   AH, 19H
  Int   21H
  Cmp   CL, AL
  Je    @@Valid
  Dec   CL            { check next lovest drive number }
  Jmp   @@Checkdrive
  @@Valid:
  Pop   AX
  Mov   DL, AL
  Mov   AH, 0Eh
  Int   21H           { restore default drive }
  Mov   AL, CL
  Add   AL, 'A'
End;

Procedure GetDate;assembler;
Asm
  MOV AH,2AH
  INT 21h
  XOR AH,AH
  LES DI,DayOfWeek
  STOSB
  MOV AL,DL
  LES DI,Day
  STOSB
  MOV AL,DH
  LES DI,Month
  STOSB
  XCHG AX,CX
  LES DI,Year
  STOSW
End; { GetDate }

Procedure GetTime; assembler;
Asm
  MOV AH,2CH
  INT 21h
  XOR AH,AH
  MOV AL,DL
  LES DI,Sec100
  STOSB
  MOV AL,DH
  LES DI,Second
  STOSB
  MOV AL,CL
  LES DI,Minute
  STOSB
  MOV AL,CH
  LES DI,Hour
  STOSB
End; { GetTime }

Function GetCBreak; assembler;
Asm
  MOV AX,3300h
  INT 21h
  MOV AL,DL
End; { GetCBreak }

Function GetVerify; assembler;
Asm
  MOV AH,54H
  INT 21h
End; { GetVerify }

Procedure Cygetintvec(Num:Word;Var Vec:Pointer); Assembler;
Asm
  Mov   DX,DS
  Sub   AX,AX
  Mov   DS,AX
  Mov   SI,Num
  ShL   SI,2
  Les   DI,Vec
  Cld
  Movsw
  Movsw
  Mov  DS,DX
End;

Procedure Cysetintvec(Num:Word;Vec:Pointer); Assembler;
Asm
  Sub   AX,AX
  Mov   ES,AX
  Mov   DI,Num
  ShL   DI,2
  Cld
  Mov   AX,Word Ptr [Vec]
  Stosw
  Mov   AX,Word Ptr [Vec+2]
  Stosw
End;

Procedure SetFileMode(Mode:byte);assembler;
asm
 Mov AL,Mode
 Mov FileMode,AL
end;

Function Cyheaperror(Size:Word):Integer;Far;Assembler;
Asm
  Mov AX,1
End;

function DayOfWeek(Day, Month, Year: Integer) : Integer;
var
  century, yr, dw: Integer;

begin
  if Month < 3 then
  begin
    Inc(Month, 10);
    Dec(Year);
  end
  else
     Dec(Month, 2);
  century := Year div 100;
  yr := year mod 100;
  dw := (((26 * month - 2) div 10) + day + yr + (yr shr 2) +
    (century shr 4) - (century shr 1)) mod 7;
  if dw < 0 then inc(dw,7);
  DayOfWeek := dw;
end;

Procedure Cyintr0(Flags, Cs, Ip, AX, BX,CX, DX, SI, DI, DS, ES, BP: Word);Interrupt;Assembler;
Const
 Inslen:Array[0..3] Of Byte=(2,3,4,2);

Asm
  Les DI,DWord Ptr [Ip]  { Get address of instruction }
  XOr AX,AX              { Test for 808x }
  Push AX
  Popf
  Pushf
  Pop AX
  And AX,0F000H
  Cmp AX,0F000H
  Je @Fixed              { Jump if it's a 808x, no update needed }
  Mov BL,[ES:DI+1]       { Get address mode byte }
  And BX,0C7H
  Cmp BL,6
  Jne @Noimm
  Add Ip,4
  Jmp @Fixed
  @Noimm:
  ShR BX,6
  Mov BL,Byte Ptr [Inslen+BX]
  Add Ip,BX
  @Fixed:
  Mov &AX,0
  Cmp Byte Ptr [ES:DI],0F7H  {Change DX only if word operand }
  Jne @Noword
  Mov &DX,0
  @Noword:
End;

Type
  SystemProc=Procedure;
  SystemCall=^SystemProc;

Var
  CallAddr:^SystemCall;

Function Iptr : Word;
Inline($8B/$46/$02);

Procedure CyDiv386;
Const
 PatchCode    : Array[0..27] of Byte = (
  $52,$50,$83,$F9,$00,$75,$01,$41,$66,$58,$66,$99,$53,$51,
  $66,$5E,$66,$F7,$FE,$66,$52,$59,$5B,$66,$50,$58,$5A,$CB);

Begin
  Calladdr := Ptr(CSeg, Iptr-14);
  Move(Patchcode, Calladdr^^,28);
end;

Procedure CyMul386;
Const
 Patchcode:Array[0..15] Of Byte=
 ($52,$50,$66,$58,$53,$51,$66,$5A,$66,$F7,$EA,$66,$50,$58,$5A,$CB);
Begin
  Calladdr := Ptr(CSeg, Iptr-14);
  Move(Patchcode, Calladdr^^,16);
End;

Procedure InitSystem;
var
 Dummy:longint;

Begin
  {$IFDEF USE386}
  If Test8086 < 2 Then
  Begin
    WriteLn('Requires at least 386 CPU to run this program !');
    Halt(1);
  End;
   Dummy:=1;
   Dummy:=Dummy Div Dummy;
   CyDiv386;
   Dummy:=Dummy*Dummy;
   CyMul386;
  {$ENDIF}
  HeapError:=@Cyheaperror;
  CySetIntVec(0,@CyIntr0);
  InOutRes:=0;
End;

End.