/* File: two-phase-periodic-spherical-bubbles-channel-2d.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: Nov 19th, 2014
 */

// --- Refinement
b = 0.06; // drop
<<<<<<< HEAD
w = 0.5;  // wall
=======
w = 0.1;  // wall
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614

x0 = 0;
y0 = 0;
z0 = 0;

Db = 1.0;
rb = Db/2.0;
<<<<<<< HEAD
g = 2*Db;
s = Db;

nb = 3;
=======
g = 3*Db;
s = Db;

nb = 1;
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614

LM = nb*Db + (nb - 1)*s;
L = LM + 2*g;
H = 6*Db;

Point(1) = {x0,y0,z0,w};
Point(2) = {x0 + L,y0,z0,w};
Point(3) = {x0 + L,y0 + H,z0,w};
Point(4) = {x0,y0 + H,z0,w};

Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,1};

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
Physical Line("wallInflowUParabolic") = {2,4};
Physical Line("wallNoSlipPressure") = {1,3};

k = 10000;
For i In {1:nb}
Physical Line(Sprintf("bubble%g",i)) = {k+1,k+2,k+3,k+4};
k = (i+1)*k;
EndFor
=======
//Physical Line("wallNormalU") = {2,4};
Physical Line("wallLeft") = {4};
Physical Line("wallRight") = {2};
Physical Line("wallOutflow") = {3};
Physical Line("wallInflowVTransverse") = {1};

k = 10000;
For i In {1:nb}
Physical Line(Sprintf("bubble%g",i)) = {-(k+1),-(k+2),-(k+3),-(k+4)};
k = (i+1)*k;
EndFor
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614
