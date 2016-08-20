{MICKY HANDOKO}
{GALAXY}
uses cygraph,cysystem;
var
  x,y,rx,ry,cx,cy : integer;
  i,j             : byte;

begin
  initgraph(v640x480x256);
  for x:=0 to 63 do setrgbpalette(x,x,x,x);
  randomize;
  rx:=getmaxx;
  ry:=getmaxy;
  cx:=0;
  cy:=0;
  for i:=1 to 240 do
  begin
    for j:=0 to 255 do
    begin
      x:=random(rx)+cx;
      y:=random(ry)+cy;
      putpixel(x,y,random(64));
    end;
    dec(rx,2);
    dec(ry,2);
    inc(cx);
    inc(cy);
  end;
  readkey;
  restorecrtmode;
end.