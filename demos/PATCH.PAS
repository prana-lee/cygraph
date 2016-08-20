{Add this one after implementation section}
var
 winfuncptr  :pointer;

{Replace the 2 old functions in CyGraph 3.2 with
 this one}

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
