
b1 = 0.06;
w = 0.1;

x0 = 0.0;
y0 = 0.0;
z0 = 0.0;

rr = 0.5;
R = 1;
L = 10*R;

xc = x0 + R;
yc = x0;
zc = z0;
body = 2*R;
r = rr - 0.1; 

t = 1;
Include "./bubble-shapes/taylor.geo";

Point(1) = {x0,y0,z0+rr,w};
Point(2) = {x0+L,y0,z0+R,w};
Line(1) = {1,2};
extr[] = Extrude{ {0,0,0}, {1,0,0}, {0,0,0}, Pi/2 }{ Line{1}; };
extr2[] = Extrude{ {0,0,0}, {1,0,0}, {0,0,0}, Pi/2 }{ Line{extr[0]}; };
extr3[] = Extrude{ {0,0,0}, {1,0,0}, {0,0,0}, Pi/2 }{ Line{extr2[0]}; };
extr4[] = Extrude{ {0,0,0}, {1,0,0}, {0,0,0}, Pi/2 }{ Line{extr3[0]}; };

Line Loop(263) = {253, 257, 261, 249};
Plane Surface(264) = {263};
Line Loop(265) = {260, 248, 252, 256};
Plane Surface(266) = {265};
