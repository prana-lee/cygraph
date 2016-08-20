
uses cysystem,cygraph;
var
  xp,yp,x,y         : integer;
  dc,dx,dy          : integer;
  colour,n          : real;
  r1,g1,b1,r2,g2,b2 : byte;

begin
  initgraph(v640x480x256);
  xp:=getmaxx shr 1;
  yp:=getmaxy shr 1;
  dc:=getmaxcolor shl 3;
  dx:=getmaxx shl 1;
  dy:=getmaxy shl 1;
  n:=dc/(dx+dy);
  for x:=0 to getmaxcolor do
    setrgbpalette(x,0,0,0);
  for x:=0 to getmaxx do
  begin
    setcolor(round(colour));
    line(x,0,xp,yp);
    colour:=colour+n;
  end;
  for y:=0 to getmaxy do
  begin
    setcolor(round(colour));
    line(getmaxx,y,xp,yp);
    colour:=colour+n;
  end;
  for x:=getmaxx downto 0 do
  begin
    setcolor(round(colour));
    line(x,getmaxy,xp,yp);
    colour:=colour+n;
  end;
  for y:=getmaxy downto 0 do
  begin
    setcolor(round(colour));
    line(0,y,xp,yp);
    colour:=colour+n;
  end;
  for x:=0 to 63 do setrgbpalette(    x,   x,   0,   x);
  for x:=0 to 63 do setrgbpalette( x+64,  63,   x,63-x);
  for x:=0 to 63 do setrgbpalette(x+128,63-x,63-x,   x);
  for x:=0 to 63 do setrgbpalette(x+192,   0,   0,63-x);
  while not keypressed do
  begin
    getrgbpalette(getmaxcolor,r2,g2,b2);
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
