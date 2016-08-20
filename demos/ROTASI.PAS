{MICKY HANDOKO}
{DOC : code changed by PRANA}
{Need a math coprocessor}
{ROTATION}
{$N+}
uses cysystem,cygraph;
const
  r  = 100; {radius}
var
  xp,yp,x,y,i :longint;
  xv,yv : integer;

begin
  initsystem;
  initgraph(v640x480x256);
  yp:=getmaxy shr 1+1;
  xp:=getmaxx shr 1+1;
(*remove the brackets "{" and "}" to see different palettes*)
{ setpalette(demopal); {- Very very cool colorz}
 setpalette(gamepal); {- A donut in a blue plate}
{ setpalette(lifepal);}
{ setpalette(galaxypal); - Thick colorz }
{ setpalette(bluebrowpal); - multiple colorz}
{ setpalette(standardpal);}

  for i:=0 to 1440*2 do
    for x:=0 to getmaxx shr 1+1 do
    begin
      y:=round(sin(x*pi/1440)*r);
      xv:=round(x*cos(i*pi/1440)-y*sin(i*pi/1440));
      yv:=round(x*sin(i*pi/1440)+y*cos(i*pi/1440));
      putpixel(xp+xv,yp-yv,x {replace x with x*i} {- different picture in 640x480x64k});
    end;
  readkey;
  restorecrtmode;
end.