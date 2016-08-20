{MICKY HANDOKO}
{COOL ART}
uses cygraph;

var
  constant1,constant2 : real;
  d1,d2,d3,i,n        : integer;

begin
  write('Masukkan jumlah langkah (Enter steps - the best is 100) : ');readln(n);
  initgraph(v640x480x256);
(*remove the brackets "{" and "}" to see different palettes*)
{ setpalette(gamepal);} {the best}
{ setpalette(lifepal);} {the best}
 setpalette(galaxypal); {cool !}
{ setpalette(pal002pal);} {cool ! Best steps : 120}
{ setpalette(standardpal);}
{ setpalette(bluebrowpal);}
{ setpalette(demopal);}

  constant1:=getmaxx/n;
  constant2:=getmaxy/n;
  for i:=0 to n do
  begin
    d1:=round(constant1*i);
    d2:=round(getmaxx-d1);
    d3:=round(constant2*i);
    line(d1,0,d2,d3);
    d1:=round(constant1*(n-i));
    d2:=round(getmaxx-d1);
    d3:=round(constant2*(n-i));
    setcolor(i);
    line(d1,getmaxy,d2,d3);
  end;
  readln;
  restorecrtmode;
end.