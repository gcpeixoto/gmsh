/* File: two-phase-periodic-spherical-bubbles-channel-2d.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: Nov 19th, 2014
 */

// --- Refinement
<<<<<<< HEAD
b = 0.06; // drop
=======
b = 0.05; // drop
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614
w = 0.2;  // wall

x0 = 0;
y0 = 0;
z0 = 0;

Db = 1.0;
rb = Db/2.0;
<<<<<<< HEAD
g = 0.5*Db;
s = Db;

nb = 3;
=======
g = 3*Db;
s = Db;

nb = 1;
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614

LM = nb*Db + (nb - 1)*s;
L = LM + 2*g;
H = 5*Db;

<<<<<<< HEAD
N = 12; // number of divisions
=======
N = 15; // number of divisions
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614

dx = L/N;

// points
For i In {1:N+1}
Point(i) = {x0 + (i-1)*dx,y0+H,z0,w};
Point(i+N+1) = {x0 + (i-1)*dx,y0,z0,w};
EndFor // close for

// lines
n = 1000;
For i In {1:2*(N+1)}
If ( i < N+1 )
Line(n+i) = {i,i+1};
EndIf

If ( i > N+1 && i < 2*(N+1) )
Line(n+i-1) = {i,i+1};
EndIf

EndFor // close for

Line(2*(N+1)+1) = {N+1,2*(N+1)}; // right
Line(2*(N+1)+2) = {(N+1)+1,1}; // left

xb = x0;
yb = 0.5*(y0 + H);
zb = z0;

// drops
k = 10000;
For i In {1:nb}
P1 = newp;
Point(P1) = {xb + g + rb + (i - 1)*(Db + s), yb, zb, b}; // center
P2 = newp;
Point(P2) = {xb + g + rb + (i - 1)*(Db + s) + rb, yb, zb, b};
P3 = newp;
Point(P3) = {xb + g + rb + (i - 1)*(Db + s), yb + rb, zb, b};
P4 = newp;
Point(P4) = {xb + g + rb + (i - 1)*(Db + s) - rb, yb, zb, b};
P5 = newp;
Point(P5) = {xb + g + rb + (i - 1)*(Db + s), yb - rb, zb, b};

Circle(k+1) = {P2,P1,P3};
Circle(k+2) = {P3,P1,P4};
Circle(k+3) = {P4,P1,P5};
Circle(k+4) = {P5,P1,P2};

k = (i+1)*k;
EndFor


<<<<<<< HEAD
Physical Line("wallLeft") = {2*(N+1)+2};
Physical Line("wallRight") = {2*(N+1)+1};
Physical Line("wallNoSlip") = {1001,1004,1005,1008,1009,1012,1013,1016,1017,1020,1021,1024};
Physical Line("wallInflowVTransverse") = {1014,1015,1018,1019,1022,1023};
//Physical Line("wallInflowVTransverseA") = {1014,1015,1018,1019,1022,1023};
Physical Line("wallOutflow") = {1002,1003,1006,1007,1010,1011};
=======
//Physical Line("wallNormalU") = {2*(N+1)+1,2*(N+1)+2};
Physical Line("wallLeft") = {2*(N+1)+2};
Physical Line("wallRight") = {2*(N+1)+1};
//Physical Line("wallNoSlip") = {1001,1003,1004,1006};
//Physical Line("wallNoSlip") = {1030,1016};
Physical Line("wallInflowVTransverse") = {1016:1030};
//Physical Line("wallOutflow") = {1002};
Physical Line("wallOutflow") = {1001:1015};
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614


k = 10000;
For i In {1:nb}
Physical Line(Sprintf("bubble%g",i)) = {-(k+1),-(k+2),-(k+3),-(k+4)};
k = (i+1)*k;
<<<<<<< HEAD
EndFor
=======
EndFor
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614
