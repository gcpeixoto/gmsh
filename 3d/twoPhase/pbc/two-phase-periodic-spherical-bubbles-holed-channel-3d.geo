/* File: two-phase-periodic-spherical-bubbles-channel-2d.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: Nov 19th, 2014
 */

// --- Refinement
<<<<<<< HEAD
b = 0.2; // drop
w = 0.6;  // wall
=======
b = 0.06; // drop
w = 0.3;  // wall
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614

x0 = 0;
y0 = 0;
z0 = 0;

Db = 1.0;
rb = Db/2.0;
<<<<<<< HEAD
g = Db;
s = Db;

nb = 3;
=======
g = 0.25*Db;
s = Db;

nb = 1;
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614

LM = nb*Db + (nb - 1)*s;
L = LM + 2*g;
H = 5*Db;
W = 5*Db;

<<<<<<< HEAD
N = 3; // number of divisions
=======
N = 1; // number of divisions
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614

dx = L/N;

// points
For i In {1:N+1}
Point(i) = {x0 + (i-1)*dx,y0,z0,w};
Point(i+N+1) = {x0 + (i-1)*dx,y0+H,z0,w};
Point(i+2*(N+1)) = {x0 + (i-1)*dx,y0,z0+W,w};
Point(i+3*(N+1)) = {x0 + (i-1)*dx,y0+H,z0+W,w};
EndFor // close for

// lines
n = 1000;

For i In {1:4*(N+1)}

// x-parallel; y = ymin; z = zmin 
If ( i < N+1 )
Line(n+i) = {i,i+1};
linesA[i] = n+i; // array line indices
Printf("border A %g",linesA[i]);
EndIf

// x-parallel; y = ymax; z = zmin 
If ( i > N+1 && i < 2*(N+1) )
Line(n+i-1) = {i,i+1};
linesB[i-(N+1)] = n+i-1; // array line indices
Printf("border B %g",linesB[i-(N+1)]);
EndIf

// x-parallel; y = ymin; z = zmax
If ( i > 2*(N+1) && i < 3*(N+1) )
Line(n+i-2) = {i,i+1};
linesC[i-2*(N+1)] = (n+i)-2;
Printf("border C %g",linesC[i-2*(N+1)]);
EndIf

// x-parallel; y = ymax; z = max
If ( i > 3*(N+1) && i < 4*(N+1) )
Line(n+i-3) = {i,i+1};
linesD[i-3*(N+1)] = (n+i)-3;
Printf("border D %g",linesD[i-3*(N+1)]);
EndIf

// internal y-parallel, z-parallel; anchored at border y=ymin; z=zmin
If ( i > 1 && i < (N+1) )
Line(i) = {i,i+N+1}; 
Line(2*i) = {i,i+2*(N+1)}; 
linesE[i-1] = i;
Printf("internal E %g",linesE[i-1]);
linesF[2*i-1] = 2*i;
Printf("internal F %g",linesF[2*i-1]);
EndIf

// internal y-parallel, z-parallel; anchored at border y=ymax; z=zmax
If ( i > 1+3*(N+1) && i < 4*(N+1) )
Line(i) = {i,i-(N+1)}; 
Line(2*i) = {i,i-(2*(N+1))}; 
linesG[i-1] = i;
Printf("internal G %g",linesG[i-1]);
linesH[2*i-1] = 2*i;
Printf("internal H %g",linesH[2*i-1]);
EndIf

EndFor // close for - lines

// external borders
// left
kk = 4*(N+1);
Line(kk+1) = {(N+1)+1,1}; 
Line(kk+2) = {1,2*(N+1)+1}; 
Line(kk+3) = {2*(N+1)+1,3*(N+1)+1}; 
Line(kk+4) = {3*(N+1)+1,(N+1)+1};

// right
Line(kk+5) = {2*(N+1),N+1}; 
Line(kk+6) = {N+1,3*(N+1)}; 
Line(kk+7) = {3*(N+1),4*(N+1)}; 
Line(kk+8) = {4*(N+1),2*(N+1)};

Line Loop(kk+9) = {kk+1,kk+2,kk+3,kk+4};
Line Loop(kk+10) = {-(kk+5),-(kk+6),-(kk+7),-(kk+8)};

// external surfaces
Plane Surface(kk+11) = {kk+9};
Plane Surface(kk+12) = {kk+10};

// periodic mesh
Periodic Surface kk+11 {kk+1,kk+2,kk+3,kk+4} = kk+12 {kk+5,kk+6,kk+7,kk+8}; 

// 1st. drop center
xb = x0;
yb = 0.5*(y0 + H);
zb = 0.5*(y0 + W);

// drops
k = 10000;

For i In {1:nb} // 

P1 = newp;
Point(P1) = {xb + g + rb + (i - 1)*(Db + s), yb, zb, b}; // center
P2 = newp;
Point(P2) = {xb + g + rb + (i - 1)*(Db + s), yb, zb - rb, b};
P3 = newp;
Point(P3) = {xb + g + rb + (i - 1)*(Db + s), yb + rb, zb, b};
P4 = newp;
Point(P4) = {xb + g + rb + (i - 1)*(Db + s), yb, zb + rb, b};
P5 = newp;
Point(P5) = {xb + g + rb + (i - 1)*(Db + s), yb - rb, zb, b};
P6 = newp;
Point(P6) = {xb + g + (i - 1)*(Db + s), yb, zb, b};
P7 = newp;
Point(P7) = {xb + g + Db + (i - 1)*(Db + s), yb, zb, b};

// --- BUILDING CIRCLES ---

// x-normal meridian 
cc11 = k+1;
Circle(cc11) = {P4,P1,P3};
cc12 = k+2;
Circle(cc12) = {P3,P1,P2};
cc13 = k+3;
Circle(cc13) = {P2,P1,P5};
cc14 = k+4;
Circle(cc14) = {P5,P1,P4};

// z-normal meridian
cc15 = newc;
Circle(cc15) = {P3,P1,P6};
cc16 = newc;
Circle(cc16) = {P6,P1,P5};
cc17 = newc;
Circle(cc17) = {P5,P1,P7};
cc18 = newc;
Circle(cc18) = {P7,P1,P3};

// --- DISCRETIZATION (THETA) CIRCLES --- 
nt2 = 14; // number of theta points per quarter of circle (total around circle is 4*nt) 
//Transfinite Line{cc11,cc12,cc13,cc14,cc15,cc16,cc17,cc18} = nt2 Using Bump 1;

// drop's surface
// reference: central axis is X-positive and theta counterclockwise

// 0:Pi/2
lb21 = newl;
Line Loop(lb21) = {cc12,cc13,-cc16,-cc15};
Ruled Surface(k+1) = {lb21};

// Pi/2:Pi
lb22 = newl;
Line Loop(lb22) = {-cc18,-cc17,-cc13,-cc12};
Ruled Surface(k+2) = {lb22};

// Pi:3*Pi/2
lb23 = newl;
Line Loop(lb23) = {-cc11,-cc14,cc17,cc18};
Ruled Surface(k+3) = {lb23};

// 3*Pi/2:2*Pi
lb24 = newl;
Line Loop(lb24) = {cc15,cc16,cc14,cc11};
Ruled Surface(k+4) = {lb24};

k = (i+1)*k;

EndFor // close for - drops

<<<<<<< HEAD
Physical Surface("wallLeft") = {kk+11};
Physical Surface("wallRight") = {kk+12};


Line Loop(60013) = {-19, -1010, -14, +1007};
Plane Surface(60014) = {60013};
Line Loop(60015) = {14, 1008, -15, -1011};
Plane Surface(60016) = {60015};
Line Loop(60017) = {15, 1009, 23, -1012};
Plane Surface(60018) = {60017};
Line Loop(60019) = {-18, -1007, +4, +1001};
Plane Surface(60020) = {60019};
Line Loop(60021) = {-4, -1008, +6, +1002};
Plane Surface(60022) = {60021};
Line Loop(60023) = {-6, -1009, +22, +1003};
Plane Surface(60024) = {60023};
Line Loop(60025) = {-17, -1001, -2, +1004};
Plane Surface(60026) = {60025};
Line Loop(60027) = {2, 1005, -3, -1002};
Plane Surface(60028) = {60027};
Line Loop(60029) = {3, 1006, 21, -1003};
Plane Surface(60030) = {60029};
Line Loop(60031) = {-20, -1004, +28, +1010};
Plane Surface(60032) = {60031};
Line Loop(60033) = {1011, 30, -1005, -28};
Plane Surface(60034) = {60033};
Line Loop(60035) = {1012, 24, -1006, -30};
Plane Surface(60036) = {60035};

Physical Surface("wallNoSlip") = {60020,60022,60024,60032,60034,60036,60014,60018,60028};
Physical Surface("wallInflowW") = {60026,60030};
Physical Surface("wallInflowWNeg") = {60016};

k = 10000;
For i In {1:nb}
Physical Surface(Sprintf("bubble%g",i)) = {k+1,k+2,k+3,k+4};
=======
// Manual setting
Line Loop(10013) = {1004, 16, -1002, -12};
Plane Surface(10014) = {10013};
Line Loop(10015) = {9, 1001, -13, -1002};
Plane Surface(10016) = {10015};
Line Loop(10017) = {1004, -15, -1003, 11};
Plane Surface(10018) = {10017};
Line Loop(10019) = {10, 1003, -14, -1001};
Plane Surface(10020) = {10019};


Physical Surface("wallLeft") = {kk+11};
Physical Surface("wallRight") = {kk+12};
//Physical Surface("wallOutflow") = {10014};
Physical Surface("wallInflowVTransverse") = {-10020};
Physical Surface("wallNormalW") = {-10016,-10018};
Physical Surface("wallOutflow") = {10014};
//Physical Surface("wallInflowWTransverse") = {-10016};
//Physical Surface("wallNormalV") = {-10020,10014};


k = 10000;
For i In {1:nb}
Physical Surface(Sprintf("bubble%g",i)) = {(k+1),(k+2),(k+3),(k+4)};
>>>>>>> 775bb17736a0fa4105bccbe1c2522a016bf21614
k = (i+1)*k;
EndFor

