false equ 0
true  equ 1
NormalPut     equ 88h;    { MOV }
CopyPut       equ 88h;    { MOV }
XORPut        equ 30h;    { XOR }
OrPut         equ 08h;    { OR  }
AndPut        equ 20h;    { AND }

p286
locals

assume cs:code

extrn hicolor:Byte
extrn bytesperline:word
extrn getmaxy:word
extrn getmaxx:word
extrn linepattern:word
extrn currentcolor:word
extrn cpx:word
extrn cpy:word
extrn grmode:word
extrn sega000:word

extrn vp:qword
extrn vsetoffset:near
extrn setbank:near
extrn line:far

extrn textsettings
extrn backcolor:Byte
extrn maxcolor :byte

extrn mouseshape

code            segment para public 'code'

done macro size
 leave
 retf size*2
endm

public getwritemode
public setwritemode

public plotcolor
public plotimage
public lineto
public linerel
public moveto
public moverel
public setcolor
public getcolor
public getbkcolor
public getmaxcolor
public grayscale
public setallpalette
public getallpalette
public setrgbpalette

public getx
public gety
public setlinestyle
public getlinestyle
public getpixel
public putpixel

public getactivegraphmode
public getgraphmode
public getmodeinfo
public setgraphmode
public setviewport

public textheight
public textwidth

public waitforretrace

setcolor proc far color:Word
enter 0,0
mov ax,color
mov currentcolor,ax
done 1
setcolor endp

getcolor proc far
mov ax,currentcolor
ret
getcolor endp

textheight proc far
 mov ax,word ptr textsettings+6
 mov bl,byte ptr textsettings+13
 cmp bl,0
 je @zerosize2
 inc bl
 mul bl
 @zerosize2:
 ret
textheight endp

textwidth proc far
 mov ax,word ptr textsettings+4
 mov bl,byte ptr textsettings+13
 cmp bl,0
 je @zerosize
 inc bl
 mul bl
 @zerosize:
 ret
textwidth endp

GrayScale proc far
  Mov AX,101BH
  XOr BX,BX
  Mov CX,00Ffh
  Int 10H
  ret
grayscale endp

getx proc far
mov ax,cpx
ret
getx endp

gety proc far
mov ax,cpy
ret
gety endp

moveto proc far y:word,x:word
enter 0,0
  Mov AX,X
  Mov BX,Y
  Mov Cpx,AX
  Mov Cpy,BX
  done 2
moveto endp

moverel proc far addy:word,addx:word
enter 0,0
  Mov AX,addX
  Mov BX,addy
  Add Cpx,AX
  Add Cpy,BX
  done 2
moverel endp

lineto proc far y:word,x:word
  enter 0,0
  Push Cpx
  Push Cpy
  Push X
  push y
  Call Line
  Push X
  push y
  Call MoveTo
  done 2
lineto endp

linerel proc far y:Word,x:word
  enter 0,0
  Push Cpx
  Push Cpy
  Mov AX,X
  Add Cpx,AX
  Push AX
  Mov AX,Y
  Add Cpy,AX
  Push AX
  Call Line
  done 2
linerel endp

setlinestyle proc far linestyle:word
 enter 0,0
 mov ax,linestyle
 mov linepattern,ax
 done 1
setlinestyle endp

getlinestyle proc far
 mov ax,linepattern
 ret
getlinestyle endp

getpixel proc far y:Word,x:word
  enter 0,0
  Mov AX,Y
  ADD AX,word ptr [VP+2] ;y:=y+vp.y1;
  Mov BX,X
  ADD BX,word ptr [vp+0] ;x:=x+vp.x1;
  CMP BX,word ptr [vp+4] ;x > vp.x2?
  Jg @NOget
  CMP AX,word ptr [vp+6] ;y > vp.y2?
  Jg @NOget
  Call Vsetoffset
  Mov DI,AX
  Mov es,SegA000
  cmp hicolor,true
  je @higet
  mov al,es:[di]
  xor ah,ah
  jmp @noget
  @higet:
  mov ax,es:[DI]
  @noget:
  done 2
getpixel endp

getmaxcolor proc far
 mov cl,maxcolor
 mov ax,1
 shl ax,cl
 dec ax
 ret
getmaxcolor endp

getactivegraphmode proc far
  Mov AX,4F03H
  Int 10H
  Mov AX,BX
  ret
getactivegraphmode endp

getgraphmode proc far
 mov ax,grmode
 ret
getgraphmode endp

getmodeinfo proc far info:dword,mode:word
  enter 0,0
  Mov AX,4F01H
  Mov CX,Mode
  Les DI,Info
  Int 10H
  done 6
getmodeinfo endp

setgraphmode proc far mode:word
 enter 0,0
  Mov AX, 4F02H
  Mov BX, Mode
  Mov Grmode,BX
  Int 10H
  Cmp AX, 004Fh
  Je @TRUE
  XOr AX,AX
  @TRUE:
  done 1
setgraphmode endp

setallpalette proc far palette:dword
  enter 0,0
  Mov AX,1012H
  XOr BX,BX
  Mov CX,00Ffh
  Les DX,Palette
  Int 10H
 done 2
setallpalette endp

getallpalette proc far palette:dword
  enter 0,0
  Mov AX,1017H
  XOr BX,BX
  Mov CX,00Ffh
  Les DX,Palette
  Int 10H
  done 2
getallpalette endp

setrgbpalette proc far bluevalue:word,greenvalue:word,redvalue:word,color:word
  enter 0,0
  Mov DX,03C8H
  Mov AX,Color
  Out DX,Al
  Inc DX
  Mov AX,RedValue
  Out DX,Al
  Mov AX,GreenValue
  Out DX,Al
  Mov AX,BlueValue
  Out DX,al
  done 2
setrgbpalette endp

plotcolor proc near
;  $26/$89/$05/           {es:mov [di],ax}
;  $26/$31/$05/           {es:xor [di],ax}
;  $26/$21/$05/           {es:and [di],ax}
;  $26/$09/$05/           {es:or [di],ax}
;
;  $26/$88/$05/           {es:mov [di],al}
;  $26/$30/$05/           {es:xor [di],al}
;  $26/$20/$05/           {es:and [di],al}
;  $26/$08/$05/           {es:or [di],al}
  db 026h
  putmethod db 88h
  db 05h
  retn
plotcolor endp

plotimage proc near
  db 026h
  imageput db 88h
  db 05h
  retn
plotimage endp

getwritemode proc far
mov al,putmethod
sub al,hicolor
retf
getwritemode endp

setwritemode proc far mode:word
  enter 0,0
  Mov Ax,Mode
  mov imageput,al
  add al,hicolor
  mov putmethod,al
  leave
  retf 2
setwritemode endp

getbkcolor proc far
  Mov AL,Backcolor
  retf
getbkcolor endp

waitforretrace proc far
  Mov DX,3Dah
  @@1:
  In  AL,DX
  Test AL,8
  Jz @@1
  @@2:
  In  AL,DX
  Test AL,8
  Jnz @@2
  retf
waitforretrace endp

setviewport proc far y2:word,x2:word,y1:word,x1:word
 enter 0,0
 mov ax,x1
 mov bx,y1
 mov cx,x2
 mov dx,y2

  Cmp AX,cx
  Jl @Xok
  Xchg AX,cx
  @xok:

  Cmp bX,dx
  Jl @yok
  Xchg bx,dx
  @yok:

 mov si,getmaxy
 mov di,getmaxx
 cmp ax,0
 jge @nx1
 xor ax,ax
@nx1:
 cmp ax,di
 jle @nx11
 mov ax,di
@nx11:
 cmp bx,0
 jge @ny1
 xor bx,bx
@ny1:
 cmp bx,si
 jle @ny11
 mov bx,si
@ny11:
 cmp cx,0
 jge @nx2
 xor cx,cx
@nx2:
 cmp cx,di
 jle @nx22
 mov cx,di
@nx22:
 cmp dx,0
 jge @ny2
 xor dx,dx
@ny2:
 cmp dx,si
 jle @ny22
 mov dx,si
@ny22:
 mov word ptr [vp+0],ax
 mov word ptr [vp+2],bx
 mov word ptr [vp+4],cx
 mov word ptr [vp+6],dx
 done 4
setviewport endp

putpixel proc far color:word,y:word,x:word
  enter 0,0
  Mov AX,Y
  ADD AX,word ptr [VP+2] ;y:=y+vp.y1;
  Mov BX,X
  ADD BX,word ptr [vp+0] ;x:=x+vp.x1;

  CMP BX,word ptr [vp+4] ;x > vp.x2?
  Jg @NOPutpixel
  CMP BX,word ptr [vp+0] ;x > vp.x1?
  Jl @NOPutpixel
  CMP AX,word ptr [vp+6] ;y > vp.y2?
  Jg @NOputpixel
  CMP AX,word ptr [vp+2] ;y > vp.y1?

  Jl @NOputpixel
  Call Vsetoffset
  mov di,ax
  Mov es,SegA000
  mov ax,color
  call plotcolor
  @NOPutpixel:
  done 3
putpixel endp

code ends

end