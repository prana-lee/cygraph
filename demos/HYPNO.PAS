{By Prana}
uses cysystem,cygraph;

const
 w=4;
 color=2;
 limit=57;

var
x1,y1,x2,y2,x,y,c:integer;
mode:byte;
b:byte;

begin
randomize;
initgraph($101);
for c:=color to 256 do setrgbpalette(c,c,0,0);
x2:=getmaxx-80;
x1:=80;
c:=2;
for y:=1 to getmaxy div 2 do
 begin
  inc(x1);
  line(x1,y,x2,y);
  setcolor(c);
  if c < 256 then inc(c);

  dec(x2);
 end;
x2:=getmaxx-80;
x1:=80;
c:=2;
for y:=getmaxy downto getmaxy div 2 do
 begin
  inc(x1);
  line(x1,y,x2,y);
  setcolor(c);
  if c < 256 then inc(c);
  dec(x2);
 end;
y2:=getmaxy;
y1:=0;
c:=2;
for x:=getmaxx-80 downto getmaxx div 2 do
 begin
  inc(y1);
  line(x,y1,x,y2);
  setcolor(c);
  if c < 256 then inc(c);
  dec(y2);
 end;
y2:=getmaxy;
y1:=0;
c:=2;
for x:=getmaxx-80 downto getmaxx div 2 do
 begin
  inc(y1);
  line(x,y1,x,y2);
  setcolor(c);
  if c < 256 then inc(c);
  dec(y2);
 end;
y2:=getmaxy;
y1:=0;
c:=2;
for x:=80 to getmaxx div 2 do
 begin
  inc(y1);
  line(x,y1,x,y2);
  setcolor(c);
  if c < 256 then inc(c);
  dec(y2);
 end;
selectfont(dragonfont,4,0);
settextjustify(centertext,centertext);
setcolor(1);
{outtextxy(getmaxx div 2,getmaxy div 2,'Cyest Graph 3.25');}
 for x:=1 to getmaxx do
  begin
   for y:= 1 to getmaxy do
    begin
      c:=getpixel(x,y);
      if c <> 0 then putpixel(x+random(w)-w,y+random(w)-w,c);
    end;
  end;
clearkbbuffer;
c:=color;
mode:=1;
repeat
inc(b);
if b=0 then
begin
 inc(b);
 inc(mode);
 if mode=4 then mode:=1;
end;
{case mode of
 1:for c:=color to 255 do setrgbpalette(c,c+b,0,0);
 2:for c:=color to 255 do setrgbpalette(c,0,c+b,0);
 3:for c:=color to 255 do setrgbpalette(c,0,0,c+b);
end;}
for c:=color to 255 do setrgbpalette(c,0,c+b,0);
setrgbpalette(1,c*b,b,b*b+c*b);
waitforretrace;
until keypressed;
sound(200);
delay(50);
nosound;
readln;
restorecrtmode;
end.