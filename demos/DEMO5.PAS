{$n+}
uses cysystem,cygraph;
const
  xp = 319;
  yp = 239;
var
  x,y,r             : integer;
  angle             : 0..360;
  d,fn              : real;
  r1,g1,b1,r2,g2,b2 : byte;

begin
  initgraph(v640x480x256);
  rectangle(0,0,getmaxx,getmaxy);
  for x:=0 to 63 do setrgbpalette(x,x,x,x);
  for x:=0 to 63 do setrgbpalette(x+64,63-x,63,63);
  for x:=0 to 63 do setrgbpalette(x+128,x,63,63-x);
  for x:=0 to 63 do setrgbpalette(x+192,63-x,63-x,0);
  for x:=0 to getmaxx do
    for y:=0 to getmaxy do
      putpixel(x,y,y);
  for r:=0 to 600 do
    for angle:=0 to 360 do
    begin
      d:=angle*pi/180;
      fn:=sin(d)*cos(d);
      x:=round(cos(d)*r*fn);
      y:=round(sin(d)*r*fn);
      putpixel(xp+x,yp-y,r);
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