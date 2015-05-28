/* \file udftriangle.geo
   \author Gustavo Peixoto de Oliveira
   \email gustavo.oliveira@uerj.br

   \description Sample file for a Gmsh UDF

   \todo Stripes must be of dimension 2. Add boundary layers.

*/

If ( StrCmp(GetString("Hi! Let's try a UDF?", "yes"),"no") == 0 )
Exit;
EndIf

x0 = 0;
y0 = 0;
z0 = 0;

L = 20;
H = 4;

cl1 = 0.5;
cl2 = 0.1;

Point(1) = {x0,y0,z0,cl1};
Point(2) = {x0+L,y0,z0,cl1};
Point(3) = {x0+L,y0+H,z0,cl1};
Point(4) = {x0,y0+H,z0,cl1};
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,1};
Line Loop(5) = {1,2,3,4};

ns = 10;
dx = L/(ns-1);
dy = H/2.5;

Function BuildStripes

p1 =newp;
Point(p1) = {x0+(i+1)*dx,y0+H/2+dy,z0,cl2};
p2 =newp;
Point(p2) = {x0+(i+1)*dx,y0+(H-dy),z0,cl2};

l1 = newl;
Line(l1) = {p1,p2};
ll[i] = newl;

p1 =newp;
Point(p1) = {x0+dx/2+(i+1)*dx,y0+H/2-dy,z0,cl2};
p2 =newp;
Point(p2) = {x0+dx/2+(i+1)*dx,y0+dy,z0,cl2};
l1 = newl;
Line(l1) = {p1,p2};
ll2[i] = newl;

Return

For i In {0:ns-3}
Call BuildStripes;
EndFor


Physical Line("stripes") = {ll[],ll2[]};
