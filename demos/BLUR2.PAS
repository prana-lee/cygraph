{Simple Blur}
{20th Oct '97 by Prana}
uses cysystem,cygraph;
const
 v=90;
 w=2; {blur constant 2-10}

var x,y,x1,y1,x2,y2,c,r,i:integer;

begin
 randomize;
 initgraph($101);
 for i:=1 to 3*v do
  begin
   x:=random(getmaxx-random(v));
   y:=random(getmaxy-random(v));
   r:=random(v);
   c:=random(150);
   setcolor(c);
   circle(x,y,r);
 end;
 x2:=getmaxx;
 x1:=0;
 repeat
 inc(x1);
 dec(x2);
{ for x:=1 to getmaxx do
  begin}
   for y:= 1 to getmaxy do
    begin
      c:=getpixel(x1,y);
      if c <> 0 then putpixel(x1+random(w)-w,y+random(w)-w,c);
      if keypressed then break;
    end;
   for y:= 1 to getmaxy do
    begin
      c:=getpixel(x2,y);
      if c <> 0 then putpixel(x2+random(w)+w,y+random(w)+w,c);
      if keypressed then break;
    end;
  until x1=x2+1;
  readln;
end.