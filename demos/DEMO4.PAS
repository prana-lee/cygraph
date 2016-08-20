{$n+}
uses cysystem,cygraph;
const
  xp = 0;
  r  = 50;
var
  x,y,yp,colour,i   : integer;
  r1,g1,b1,r2,g2,b2 : byte;

begin
  initgraph(v640x480x256);
  for i:=0 to 63 do setrgbpalette(    i,i shr 1,   0,   0);
  for i:=0 to 63 do setrgbpalette( i+64,   63-i,   0,   i);
  for i:=0 to 63 do setrgbpalette(i+128,      i,   0,  63);
  for i:=0 to 63 do setrgbpalette(i+192,   63-i,   0,63-i);
  for yp:=-50 to getmaxy+50 do
  begin
    inc(colour);
    if colour=getmaxcolor then colour:=1;
    for x:=0 to getmaxx do
    begin
      if port[$60]<128 then halt;
      y:=round(sin(x*pi/180)*r);
      putpixel(xp+x,yp-y,colour+x);
    end;
  end;
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