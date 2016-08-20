horizdir equ 0
vertdir equ 1
false equ 0
true equ 1
LeftText   equ 0
CenterText equ 1
Bottomtext equ 0
TopText    equ 2
NormalPut     equ 0;    { MOV }
CopyPut       equ 0;    { MOV }
XORPut        equ 1;    { XOR }
OrPut         equ 2;    { OR  }
AndPut        equ 3;    { AND }

.model tpascal
.386

locals
extrn getmaxy:word
extrn getmaxx :word
extrn setbank     :near
extrn plotimage   :near
extrn plotcolor   :near
extrn vsetoffset  :near
extrn currentcolor:word
extrn segA000     :word
extrn bytesperline:word
extrn addx        :word
extrn actstart    :word
extrn linepattern :word
extrn fontbuf     :dword
extrn vp          :qword
extrn currentbank :byte
extrn hicolor     :byte
extrn textsettings

vpx1 equ word ptr vp+0
vpy1 equ word ptr vp+2
vpx2 equ word ptr vp+4
vpy2 equ word ptr vp+6

.data

;global outtextxy:proc
global circle:proc
global getimage:proc
global putimage:proc
global cleardevice:proc

.code

circle proc far x:word,y:word,radius:word
local incxx:dword,decxx:dword,incxy:dword,decxy:dword,incyy:dword,decyy:dword,incyx:dword,decyx:dword,radius2:dword
local plotc:word
local Evpx1:dword,Evpy1:dword,Evpx2:dword,Evpy2:dword,actstart2:dword
jmp @start

@callput:
cmp ecx,Evpy2
jg @done
cmp ecx,Evpy1
jl @done
cmp eax,Evpx1
jl @done
cmp eax,Evpx2
jg @done
cmp hicolor,false
je @skiphi
shl eax,1
@skiphi:

add eax,ecx
add eax,actstart2
mov di,ax
shr eax,16
mov dx,ax
call setbank
mov ax,currentcolor
call plotcolor
@done:
retn

@Start:
movzx eax,actstart
movzx ebx,bytesperline
mul ebx
mov actstart2,eax

movzx eax,vpx1
add x,ax
movzx ecx,vpx2
mov Evpx1,eax
mov Evpx2,ecx
movzx eax,vpy1
add y,ax
mul ebx
add eax,actstart2
mov Evpy1,eax

movzx eax,vpy2
mul ebx
add eax,actstart2
mov Evpy2,eax

movzx ecx,radius
inc ecx
;decxy:=x+1-radius
movzx eax,x
inc eax
sub eax,ecx
mov decxy,eax
;incxy:=x-1+radius
movzx eax,x
dec eax
add eax,ecx
mov incxy,eax
;incxx:=incxy-radius
sub eax,ecx
mov incxx,eax
;decxx:=incxx+2
add eax,2
mov decxx,eax
;decyx:=(y+1)*bpl;
movzx eax,y
inc eax
mul ebx
mov decyx,eax
;incyx:=decyx-bpl shl 1;
shl ebx,1
sub eax,ebx
mov incyx,eax
shr ebx,1
;incyy:=incyx+radius*bpl;
mov esi,eax
mov eax,ecx
mul ebx
add eax,esi
mov incyy,eax
;decyy:=incyy-(radius-1)*bpl shl 1;
mov esi,eax
shl ebx,1
mov eax,ecx
dec eax
mul ebx
sub esi,eax
mov decyy,esi
;Y :=Radius;
mov y,cx
;x :=1
mov x,-1
;Radius:=Radius*radius;
mov eax,ecx
mul eax
mov radius2,eax
;s:=1+radius-y
inc eax
movzx edx,y
sub eax,edx
mov esi,eax
movzx ebx,bytesperline
mov es,sega000

@plotloop:
;Inc(X)
inc x
;inc(incxx)
inc incxx
;dec(decxx)
dec decxx
;dec(decyx,bpl);
sub decyx,ebx
;inc(incyx,bpl);
add incyx,ebx
;inc(s,(x shl 1)+1);
movzx eax,x
shl eax,1
inc eax
add esi,eax
;If S > radius Then
cmp esi,radius2
jl @skipsrad
;     Dec(Y);
dec y
;     dec(s,(y shl 1)+1);
movzx eax,y
shl eax,1
inc eax
sub esi,eax
sub esi,2
;     dec(incxy);
dec incxy
;     inc(decxy);
inc decxy
;     inc(decyy,bpl);
add decyy,ebx
;dec(incyy,bpl);
sub incyy,ebx
@skipsrad:
  Add plotc,1
  Cmp plotc,16
  Jl @Ilower
  Mov plotc,0
  @Ilower:
  mov ax,plotc
  bt linepattern,ax
  jnc @nocircle
; mem[sega000:decxy+decyx]:=color;{X+1-Ys, Y+1-Xs, Color); {qdr II-2}
mov eax,decxy
mov ecx,decyx
call @callput
; mem[sega000:decxy+incyx]:=color;{X+1-Ys, Y-1+Xs, Color);} {qdr III-1}
mov eax,decxy
mov ecx,incyx
call @callput
; mem[sega000:incxy+decyx]:=color; {qdr I-1}
mov eax,incxy
mov ecx,decyx
call @callput
; mem[sega000:incxy+incyx]:=color; {qdr IV-2}
mov eax,incxy
mov ecx,incyx
call @callput
; mem[sega000:incxx+decyy]:=color; {qdr I-2}
mov eax,incxx
mov ecx,decyy
call @callput
; mem[sega000:decxx+decyy]:=color; {qdr II-1}
mov eax,decxx
mov ecx,decyy
call @callput
; mem[sega000:decxx+incyy]:=color; {qdr III-2}
mov eax,decxx
mov ecx,incyy
call @callput
; mem[sega000:incxx+incyy]:=color; {qdr IV-1}
mov eax,incxx
mov ecx,incyy
call @callput
;Until (X >= Y);

@nocircle:
mov ax,x
cmp ax,y
jnge @plotloop
ret
circle endp

vsetoffset386 proc near
 movzx edx,actstart
 movzx ecx,bytesperline
 add eax,edx
 mul ecx

 mov cl,hicolor
 shl ebx,cl

 add eax,ebx
 mov di,ax
 shr eax,16
 mov dl,al
 call setbank
ret
vsetoffset386 endp

cleardevice proc far
mov ax,getmaxy
mov bx,getmaxx
call vsetoffset
mov es,sega000
xor eax,eax
@clearbank:
call setbank
xor edi,edi
mov es,sega000
mov ecx,4000h
rep stosd
dec dl
jge @clearbank
ret
cleardevice endp

GetImage proc far x1:word,y1:word,x2:word,y2:word,bitmap:dword
local awidth:word,height:word

  mov cx,vpx1
  mov dx,vpy1
  add x1,cx
  add x2,cx
  add y1,dx
  add y2,dx

  Mov BX,X1
  Cmp BX,X2
  Jl @Xcok
  Xchg BX,X2
  Mov X1,BX
  @xcok:
  Mov AX,y1
  Cmp AX,y2
  Jl @ycok
  Xchg AX,y2
  Mov y1,AX
  @ycok:

  push bytesperline
  cld
  movzx edx,Actstart
  Movsx EAX,Y1
  Movsx Ebx,x1
  mov cl,hicolor
  shl ebx,cl
  add eax,edx
  movzx ecx,bytesperline
  mul ecx
  add eax,ebx

  Mov SI, AX
  shr eax,16
  mov dl,al
  call setbank
  mov cl,hicolor

  Mov AX, X2
  Sub AX, X1
  inc ax

  shl ax,cl
  sub bytesperline,ax
  Mov awidth, AX

  Mov gs, SegA000
  Les DI,Bitmap
  StosW       ;BITMAP[0..1]:=LEBAR

  Mov AX, Y2
  Sub AX, Y1
  Inc AX
  mov height,ax

  StosW       ;BITMAP[2..3]:=TINGGI

  @loop:
  mov cx,awidth
  @get:
  mov al,gs:[si]
  inc si
  jnz @@5
  inc dl
  call setbank
  @@5:
  stosb
  LOOP @GET
  @nosisa:
  Add SI, Bytesperline
  jnc @skipbank
  inc dl
  call setbank
  @skipbank:
  Dec height
  Jnz @Loop
  pop bytesperline
  @@done:
  ret
getimage endp

putimage proc far x1:Word,y1:word,bitmap:dword
local awidth: Word,height:word,addsi:word;
  cld
  xor eax,eax
  mov addsi,ax
  Mov ES,SegA000
  Lgs SI,Bitmap
  seggs Lodsw
  Mov awidth, AX

  seggs Lodsw
  mov height,ax

  Movsx eax, Y1
  movsx ebx, x1
  call vsetoffset386

  mov ax,awidth
  Sub Bytesperline,ax
  @PutLoopY:
  Mov CX, awidth
  @draw:
  seggs lodsb
  call plotimage
  inc di
  jnz @skipbank1
  inc dl
  call setbank
  @skipbank1:
  loop @draw
  Add DI,Bytesperline
  jnc @skipbankx
  inc dl
  call setbank
  @skipbankx:
  add si,addsi
  Dec height
  Jnz @PutLoopY
  mov ax,awidth
  add bytesperline,ax
@nggakada:
  ret
putimage endp

outtextxy proc far x:word,y:word,s:dword
@txcharsize equ textsettings+4
@tycharsize equ textsettings+6
@tsuby equ word ptr textsettings+8
@tdirection equ byte ptr textsettings+10
@thoriz equ byte ptr textsettings+11
@tvert equ byte ptr textsettings+12

local size:word,l:word,pat:byte

 cld
 mov ax,vpx1
 mov bx,vpy1
 add x,ax
 add y,bx
 push bytesperline
 les di,s
 mov cl,es:[di]
 mov ax,@tycharsize
 mov bx,@txcharsize
 xor ch,ch
 cmp @tdirection,horizdir
 je @horiz
 mul cx
 mov cx,1
 @horiz:
 cmp byte ptr @tvert,centertext
 jne @test1
 shr ax,1
 sub y,ax
 @test1:
 cmp @tvert,toptext
 jne @@oky
 sub y,ax
@@oky:
 cmp @thoriz,lefttext
 je @textx1
 shl bx,1
 @okx:
 mov ax,bx
 mul cx
 shr ax,1
 cmp @thoriz,centertext
 jne @@56
 shr ax,1
 @@56:
 sub x,ax
 @textx1:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START TEXT PLOT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 movsx ebx,x
 movsx eax,y
 call vsetoffset386

 @clipxok:
 mov ax,@txcharsize
 shl ax,cl
 add ax,addx
 sub bytesperline,ax

 lfs si,s               ;STRING ADA DI [FS:SI]
 lgs bx,fontbuf
 segfs lodsb            ;panjang dari string
 xor ah,ah
 mov L,ax
 add L,si               ;l:=l+si;
 mov es,sega000
 @loopwrite:
;;;;;;;;;;;;;;;;;;;;;;;;;;;writechar;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 @@startwrite:
 push bx
 segfs lodsb               ;dapat char dari S
 xor ah,ah
 mul @tycharsize  ;ycharsize*char(fs[si])
; dec al
 add bx,ax
 xor ch,ch                 ;ch:=0 untuk loop Y;
@loopy:
 inc bx                         ;fontbuf[bx]
 mov al,gs:[bx]
 mov pat,al
 mov cl,byte ptr @txcharsize
 inc cl
@loopx:
 mov ax,x
 cmp ax,vpx2   ;X > Vp.X2 ?
 jg @noplot
 cmp ax,vpx1   ;X > Vp.X1 ?
 jg @ok
 rcl pat,1
 jmp @noplot
 @ok:
 mov ax,y
 cmp ax,vpy2   ;Y > Vp.Y2 ?
 jg @noplot
 cmp ax,vpy1   ;Y > Vp.Y1 ?
 jl @noplot

 rcl pat,1
 jnc @noplot
 mov ax,currentcolor
 call plotcolor
@noplot:
 inc x
 add di,ADDX
 jnc @nobank6
 inc dl
 call setbank
 @nobank6:
 dec cl
 jnz @loopx                     ;LOOP X
 @ssss:
 mov ax,word ptr @txcharsize
 inc ax
 sub x,ax
 add di,bytesperline
 jnc @nobank2
 inc dl
 call setbank
 @nobank2:
 inc y
 inc ch
 cmp ch,byte ptr @tycharsize
 jb @loopy                    ;LOOP Y
 pop bx
 mov ax,@txcharsize
 mov cx,@tycharsize
 cmp @tdirection,horizdir
 je @@@3
 xor cx,cx
 xor ax,ax
 @@@3:
 sub y,cx
 add x,ax
 sub di,@tsuby
 jnc @nobank4
 dec dl
 call setbank
 @nobank4:

 add di,@txcharsize; x[char(S)]:=x+1;
 jnc @nobank3
 inc dl
 call setbank
 @nobank3:
 mov ax,vpy2
 cmp y,ax
 jg @txtdone
 cmp si,l
 jb @loopwrite
 @txtdone:
 pop bytesperline
 ret
outtextxy endp

end
outtextxy proc far x:word,y:word,s:dword
@txcharsize equ textsettings+4
@tycharsize equ textsettings+6
@tsuby equ word ptr textsettings+8
@tdirection equ byte ptr textsettings+10
@thoriz equ byte ptr textsettings+11
@tvert equ byte ptr textsettings+12

local l:word,pat:byte
 mov ax,vpx1
 mov bx,vpy1
 add x,ax
 add y,bx
 push bytesperline
 les di,s
 mov cl,es:[di]
 mov ax,@tycharsize
 mov bx,@txcharsize
 xor ch,ch
 cmp @tdirection,horizdir
 je @horiz
 mul cx
 mov cx,1
 @horiz:
 cmp byte ptr @tvert,centertext
 jne @test1
 shr ax,1
 sub y,ax
 @test1:
 cmp @tvert,toptext
 jne @@oky
 sub y,ax
@@oky:
 cmp @thoriz,lefttext
 je @textx1
 shl bx,1
 @okx:
 mov ax,bx
 mul cx
 shr ax,1
 cmp @thoriz,centertext
 jne @@56
 shr ax,1
 @@56:
 sub x,ax
 @textx1:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START TEXT PLOT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 movzx ax,byte ptr @tycharsize

 movsx ebx,x
 movsx eax,y
 call vsetoffset386

 @clipxok:
 mov ax,@txcharsize
 shl ax,cl
 add ax,addx
 sub bytesperline,ax

 cld
 lfs si,s
 lgs bx,fontbuf
 segfs lodsb      ;panjang dari s
 xor ah,ah
 mov L,ax
 add L,si         ;l:=l+si;
 mov es,sega000
 @loopwrite:
;;;;;;;;;;;;;;;;;;;;;;;;;;;writechar;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 @@startwrite:
 push bx
 segfs lodsb               ;dapat char dari S
 mul byte ptr @tycharsize  ;ycharsize*char(fs[si])
 dec al
 add bx,ax
 xor ch,ch                 ;ch:=0 untuk loop Y;
@loopy:
 inc bx                    ;fontbuf[bx]
 mov al,gs:[bx]
 mov pat,al
 mov cl,byte ptr @txcharsize
 inc cl
@loopx:
 mov ax,x
 cmp ax,vpx2   ;X > Vp.X2 ?
 jg @noplot
 cmp ax,vpx1   ;X > Vp.X1 ?
 jg @ok
 rcl pat,1
 jmp @noplot
 @ok:
 mov ax,y
 cmp ax,vpy2   ;Y > Vp.Y2 ?
 jg @noplot
 cmp ax,vpy1   ;Y > Vp.Y1 ?
 jl @noplot

 rcl pat,1
 jnc @noplot
 mov ax,currentcolor
 call plotcolor
@noplot:
 inc x
 add di,ADDX
 jnc @nobank6
 inc dl
 call setbank
 @nobank6:
 dec cl
 jnz @loopx                     ;LOOP X
 @ssss:
 mov ax,word ptr @txcharsize
 inc ax
 sub x,ax
 add di,bytesperline
 jnc @nobank2
 inc dl
 call setbank
 @nobank2:
 inc y
 inc ch
 cmp ch,byte ptr @tycharsize
 jb @loopy                    ;LOOP Y
 pop bx
 mov ax,@txcharsize
 mov cx,@tycharsize
 cmp @tdirection,horizdir
 je @@@3
 xor cx,cx
 xor ax,ax
 @@@3:
 sub y,cx
 add x,ax
 sub di,@tsuby
 jnc @nobank4
 dec dl
 call setbank
 @nobank4:

 add di,@txcharsize; x[char(S)]:=x+1;
 jnc @nobank3
 inc dl
 call setbank
 @nobank3:
 mov ax,vpy2
 cmp y,ax
 jg @txtdone
 cmp si,l
 jb @loopwrite
 @txtdone:
 pop bytesperline
 ret
outtextxy endp
