{Blur by Prana}
uses cysystem,cygraph;
const
 v=90;
 w=3; {blur constant}

var x,y,c,r,i:integer;

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
   circle(x,y,r+1);
  end;
 for x:=1 to getmaxx do
  begin
   for y:= 1 to getmaxy do
    begin
      c:=getpixel(x,y);
      if c <> 0 then putpixel(x+random(w)-w,y+random(w)-w,c);
      if keypressed then break;
    end;
  end;
  readln;
end.