/* File: crossflow-jet-3d.geo
* Created on Sep 27th, 2013
* Author: Gustavo Peixoto de Oliveira
* 
* Description: Adjustable 3D geometry for crossflow jet flows. 
*/

// --- GEOMETRY ---
//
//           o----------------------------------------o
//           |                                        |
//           |                                        |
//           |            o                           |
//           |            :                           |
//           |            :                           |
//   ---     x      o . . c . . o                     |
//    |      |            :                           |
//    |      |            :                           |
//    | L1   |            o  R                        |
//    |      |            |----->                     |
//    |      |                                        |
//   ---     o------------x---------------------------o
//
//                 L2                L - L2
//           |------------|---------------------------|
//
//
//
//




x0 = 0; 
y0 = 0; 
z0 = 0;
cl = 1;

R = 1;
L = 20;
L1 = 3;
L2 = L - L1;

H = 6;
W = 6;


// walls
P1 = newp;
Point(P1) = {x0, y0, z0, cl};
P2 = newp;
Point(P2) = {x0, y0 + W, z0, cl};
P3 = newp;
Point(P3) = {x0, y0 + W, z0 + H, cl};
P4 = newp;
Point(P4) = {x0, y0, z0 + H, cl};
P5 = newp;
Point(P5) = {x0 + L, y0, z0, cl};
P6 = newp;
Point(P6) = {x0 + L, y0 + W, z0, cl};
P7 = newp;
Point(P7) = {x0 + L, y0 + W, z0 + H, cl};
P8 = newp;
Point(P8) = {x0 + L, y0, z0 + H, cl};
P9 = newp;
Point(P9) = {x0 + L1, y0 + 0.5 * W, z0, cl};

// hole
P10 = newp;
Point(P10) = {x0 + L1 + R, y0 + 0.5 * W, z0, cl};
P11 = newp;
Point(P11) = {x0 + L1, y0 + 0.5 * W + R, z0, cl};
P12 = newp;
Point(P12) = {x0 + L1 - R, y0 + 0.5 * W, z0, cl};
P13 = newp;
Point(P13) = {x0 + L1, y0 + 0.5 * W - R, z0, cl};

// walls
L1 = newl;
Line(L1) = {P1,P2};
L2 = newl;
Line(L2) = {P2,P3};
L3 = newl;
Line(L3) = {P3,P4};
L4 = newl;
Line(L4) = {P4,P1};
L5 = newl;
Line(L5) = {P5,P6};
L6 = newl;
Line(L6) = {P6,P7};
L7 = newl;
Line(L7) = {P7,P8};
L8 = newl;
Line(L8) = {P8,P5};
L9 = newl;
Line(L9) = {P1,P5};
L10 = newl;
Line(L10) = {P2,P6};
L11 = newl;
Line(L11) = {P3,P7};
L12 = newl;
Line(L12) = {P4,P8};

// hole
C1 = newc;
Circle(C1) = {P10,P9,P11};
C2 = newc;
Circle(C2) = {P11,P9,P12};
C3 = newc;
Circle(C3) = {P12,P9,P13};
C4 = newc;
Circle(C4) = {P13,P9,P10};

// floor plane
LL1 = newl;
Line Loop(LL1) = {L1,L10,-L5,-L9,C1,C2,C3,C4};

// walls
LL2 = newl;
Line Loop(LL2) = {L2,L11,-L6,-L10};
LL3 = newl;
Line Loop(LL3) = {L3,L12,-L7,-L11};
LL4 = newl;
Line Loop(LL4) = {L4,L9,-L8,-L12};
LL5 = newl;
Line Loop(LL5) = {L5,L6,L7,L8};
LL6 = newl;
Line Loop(LL6) = {L1,L2,L3,L4};


// hole 
LL7 = newl;
Line Loop(LL7) = {C1,C2,C3,C4};


// floor surface
S1 = news;
Plane Surface(S1) = {LL1};

S2 = news;
Plane Surface(S2) = {LL2};
S3 = news;
Plane Surface(S3) = {LL3};
S4 = news;
Plane Surface(S4) = {LL4};
S5 = news;
Plane Surface(S5) = {LL5};
S6 = news;
Plane Surface(S6) = {LL6};


// hole surface
S7 = news;
Plane Surface(S7) = {LL7};

SL1 = newreg;
Surface Loop(SL1) = {S1,S2,S3,S4,S5,S6,S7};

V1 = newreg;
Volume(V1) = {SL1};

//Physical Surface("hole") = {S7};
//Physical Surface(" walls ") = {S1,S2,S3,S4,S5,S6};Compound Surface(1033) = {30};
Transfinite Line {15, 14, 13, 16} = 10 Using Bump 1;
