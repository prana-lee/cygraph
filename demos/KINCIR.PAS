{$n+}
{need math coprocessor}
{MICKY HANDOKO}
{read line 81 please}
uses cysystem,cygraph;
var
  colour,n                        : real;
  r1,g1,b1,r2,g2,b2               : byte;
  x,y                             : integer;
  xp1,yp1,xp2,yp2,xp3,yp3,xp4,yp4 : integer;
  first,second                    : integer;

begin
  initgraph(v800x600x256);
{  initgraph(v640x480x256);}
  for x:=0 to 63 do setrgbpalette(    x,   x,   0,    0);
  for x:=0 to 63 do setrgbpalette( x+64,63-x,   x,    0);
  for x:=0 to 63 do setrgbpalette(x+128,   0,63-x,    x);
  for x:=0 to 63 do setrgbpalette(x+192,   0,   0,63-x);
(*remove the brackets "{" and "}" to see different palettes*)
 setpalette(demopal); {- Very very cool colorz}
{ setpalette(gamepal); {- A donut in a blue plate}
{ setpalette(lifepal);}
{ setpalette(galaxypal); - Thick colorz }
{ setpalette(bluebrownpal);{ - multiple colorz}

  n:=(getmaxcolor shl 2)/(getmaxx+getmaxy);
  xp1:=getmaxx shr 2;
  yp1:=getmaxy shr 2;
  xp2:=getmaxx shr 2;
  yp2:=(getmaxy shl 2-getmaxy) shr 2;
  xp3:=(getmaxx shl 2-getmaxx) shr 2;
  yp3:=getmaxy shr 2;
  xp4:=(getmaxx shl 2-getmaxx) shr 2;
  yp4:=(getmaxy shl 2-getmaxy) shr 2;
  first  := 0;
  second := getmaxx shr 1;
  for x:=first to second do
  begin
    setcolor(round(colour));
    line(xp1,yp1,        x,      0);
    line(xp2,yp2,        x,getmaxy);
    line(xp3,yp3,getmaxx-x,      0);
    line(xp4,yp4,getmaxx-x,getmaxy);
    colour:=colour+n;
  end;
  first  := 0;
  second := getmaxy shr 1;
  for y:=first to second do
  begin
    setcolor(round(colour));
    line(xp1,yp1,getmaxx shr 1,        y);
    line(xp2,yp2,getmaxx shr 1,getmaxy-y);
    line(xp3,yp3,getmaxx shr 1,        y);
    line(xp4,yp4,getmaxx shr 1,getmaxy-y);
    colour:=colour+n;
  end;
  first  := getmaxx shr 1;
  second := 0;
  for x:=first downto second do
  begin
    setcolor(round(colour));
    line(xp1,yp1,x,getmaxy shr 1);
    line(xp2,yp2,x,getmaxy shr 1);
    line(xp3,yp3,getmaxx-x,getmaxy shr 1);
    line(xp4,yp4,getmaxx-x,getmaxy shr 1);
    colour:=colour+n;
  end;
  first  := getmaxy shr 1;
  second := 0;
  for y:=first downto second do
  begin
    setcolor(round(colour));
    line(xp1,yp1,0,y);
    line(xp2,yp2,x,getmaxy-y);
    line(xp3,yp3,getmaxx,y);
    line(xp4,yp4,getmaxx,getmaxy-y);
    colour:=colour+n;
  end;
  while not keypressed do
  begin
    getrgbpalette(getmaxcolor,r2,g2,b2);
{ waitforretrace; remove this for slower result}
    for x:=0 to getmaxcolor do
    begin
      r1:=r2;
      g1:=g2;
      b1:=b2;
      getrgbpalette(x,r2,g2,b2);
      setrgbpalette(x,r1,g1,b1);
    end;
  end;
  restorecrtmode;
end.