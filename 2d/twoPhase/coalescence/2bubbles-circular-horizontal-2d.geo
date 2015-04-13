// Gmsh project created on Wed May 15 12:43:09 2013


cl = 0.1;
x0 = 0;
y0 = 0;
z0 = 0;
D = 0.5; // diameter
r = D/2;

// bubble 1
P1 = newp;
Point(P1) = {x0 + D, y0, z0, cl}; 
P2 = newp;
Point(P2) = {x0 + D + r, y0, z0, cl}; 
P3 = newp;
Point(P3) = {x0 + D, y0 + r, z0, cl}; 
P4 = newp;
Point(P4) = {x0 + D/2, y0, z0, cl}; 
P5 = newp;
Point(P5) = {x0 + D, y0 - r, z0, cl};

C1 = newc;
Circle(C1) = {P2,P1,P3};
C2 = newc;
Circle(C2) = {P3,P1,P4};
C3 = newc;
Circle(C3) = {P4,P1,P5};
C4 = newc;
Circle(C4) = {P5,P1,P2};

LC1 = newc;
Line Loop(LC1) = {C1,C2,C3,C4};
S1 = newreg;
Plane Surface(S1) = {LC1};

// bubble 2
P6 = newp;
Point(P6) = {x0 - D, y0, z0, cl}; 
P7 = newp;
Point(P7) = {x0 - D - r, y0, z0, cl}; 
P8 = newp;
Point(P8) = {x0 - D, y0 + r, z0, cl}; 
P9 = newp;
Point(P9) = {x0 - D/2, y0, z0, cl}; 
P10 = newp;
Point(P10) = {x0 - D, y0 - r, z0, cl};

C5 = newc;
Circle(C5) = {P7,P6,P8};
C6 = newc;
Circle(C6) = {P8,P6,P9};
C7 = newc;
Circle(C7) = {P9,P6,P10};
C8 = newc;
Circle(C8) = {P10,P6,P7};

LC2 = newc;
Line Loop(LC2) = {C5,C6,C7,C8};
S2 = newreg;
Plane Surface(S2) = {LC2};

// boundaries

P11 = newp;
Point(P11) = {x0 + 4*D, y0 + 1.5*D, z0, cl};
P12 = newp;
Point(P12) = {x0 - 4*D, y0 + 1.5*D, z0, cl};
P13 = newp;
Point(P13) = {x0 - 4*D, y0 - 1.5*D, z0, cl};
P14 = newp;
Point(P14) = {x0 + 4*D, y0 - 1.5*D, z0, cl};

L1 = newl;
Line(L1) = {P11,P12};
L2 = newl;
Line(L2) = {P12,P13};
L3 = newl;
Line(L3) = {P13,P14};
L4 = newl;
Line(L4) = {P14,P11};

LL1 = newl;
Line Loop(LL1) = {L1,L2,L3,L4};

S3 = newreg;
Plane Surface(S3) = {LL1,LC1,LC2};

Physical Surface("bubble1") = {S1};
Physical Surface("bubble2") = {S2};
Physical Surface("wall") = {S3};

