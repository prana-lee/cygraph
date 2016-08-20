uses cysystem,cygraph;
var
  x,y                : integer;
  colour             : byte;
  r1,g1,b1,r2,g2,b2  : byte;

begin
  initgraph(v640x480x256);
  for x:=0 to 63 do setrgbpalette(    x,   x,   0,   0);
  for x:=0 to 63 do setrgbpalette( x+64,  63,   x,   0);
  for x:=0 to 63 do setrgbpalette(x+128,63-x,63-x,   x);
  for x:=0 to 63 do setrgbpalette(x+192,   0,   0,63-x);
  colour:=1;
  for x:=0 to getmaxx do
  begin
    setcolor(colour);
    line(0,0,x,getmaxy);
    if colour=getmaxcolor then
      colour:=1
    else
      inc(colour);
  end;
  for y:=getmaxy downto 0 do
  begin
    setcolor(colour);
    line(0,0,getmaxx,y);
    if colour=getmaxcolor-1 then
      colour:=1
    else
      inc(colour);
  end;
  while not keypressed do
  begin
    getrgbpalette(getmaxcolor,r2,g2,b2);
    for x:=0 to getmaxcolor do
    begin
      r1:=r2;g1:=g2;b1:=b2;
      getrgbpalette(x,r2,g2,b2);
      setrgbpalette(x,r1,g1,b1);
    end;
  end;
  restorecrtmode;
end.