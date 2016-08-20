{$n+}
uses cysystem,cygraph;
const
  xp = 319;
  yp = 239;
var
  x,y,r,angle       : integer;
  d,z,fn,n1,n2      : real;
  r1,g1,b1,r2,g2,b2 : byte;

begin
  initgraph(v640x480x256);
  z:=63/41;
  n1:=0;
  n2:=63;
  for x:=1 to 42 do
  begin
    setrgbpalette(x,round(n2),round(n1),0);
    n1:=n1+z;
    n2:=n2-z;
  end;
  z:=63/42;
  n1:=0;
  n2:=63;
  for x:=43 to 85 do
  begin
    setrgbpalette(x,0,round(n2),round(n1));
    n1:=n1+z;
    n2:=n2-z;
  end;
  z:=63/41;
  n1:=0;
  n2:=63;
  for x:=86 to 127 do
  begin
    setrgbpalette(x,round(n1),round(n1),round(n2));
    n1:=n1+z;
    n2:=n2-z;
  end;
  z:=63/42;
  n1:=0;
  n2:=63;
  for x:=128 to 170 do
  begin
    setrgbpalette(x,63,round(n2),round(n1));
    n1:=n1+z;
    n2:=n2-z;
  end;
  z:=63/41;
  n1:=0;
  n2:=63;
  for x:=171 to 212 do
  begin
    setrgbpalette(x,round(n2),round(n1),63);
    n1:=n1+z;
    n2:=n2-z;
  end;
  z:=63/42;
  n1:=0;
  n2:=63;
  for x:=213 to 255 do
  begin
    setrgbpalette(x,round(n1),round(n2),round(n2));
    n1:=n1+z;
    n2:=n2-z;
  end;
  for x:=0 to getmaxx do
    for y:=0 to getmaxy do
      if x mod 64=0 then
        putpixel(x,y,x+1)
      else
        putpixel(x,y,x);
  for r:=0 to 225 do
    for angle:=0 to 360 do
    begin
      d:=angle*pi/180;
      fn:=sin(d*5);
      x:=round(cos(d)*r*fn);
      y:=round(sin(d)*r*fn);
      putpixel(xp+x,yp-y,r);
    end;
  while not keypressed do
  begin
    getrgbpalette(getmaxcolor,r2,g2,b2);
    for x:=1 to getmaxcolor do
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