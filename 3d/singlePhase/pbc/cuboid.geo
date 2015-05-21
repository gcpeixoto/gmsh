/* File: single-phase-periodic-cuboid-3d.geo
 * Author: Gustavo Peixoto de Oliveira
 * e-mail: tavolesliv@gmail.com
 * Created on Nov 27th, 2013
 *
 * Description: generates a simple cuboid 3D with adjustable size 
 * 		and 2D periodic meshing toward each pair of opposite faces.   
 */

// GEOMETRY

// Origin
x0 = 0; 
y0 = 0;
z0 = 0;

// Dimensions
L = 1; // length
W = 1; // width
H = 0.2; // heigth

w = 0.05; // char. length

// POINTS

// Bottom
P1 = newp;
Point(P1) = {x0, y0, z0, w};
P2 = newp;
Point(P2) = {x0 + L, y0, z0, w};
P3 = newp;
Point(P3) = {x0 + L, y0 + W, z0, w};
P4 = newp;
Point(P4) = {x0, y0 + W ,z0, w};

// Top
P5 = newp;
Point(P5) = {x0, y0, z0 + H, w};
P6 = newp;
Point(P6) = {x0 + L, y0, z0 + H, w};
P7 = newp;
Point(P7) = {x0 + L, y0 + W, z0 + H, w};
P8 = newp;
Point(P8) = {x0, y0 + W ,z0 + H, w};

// EDGES 

// Bottom
L1 = newl;
Line(L1) = {P1,P2};
L2 = newl;
Line(L2) = {P2,P3};
L3 = newl;
Line(L3) = {P3,P4};
L4 = newl;
Line(L4) = {P4,P1};

// Top
L5 = newl;
Line(L5) = {P5,P6};
L6 = newl;
Line(L6) = {P6,P7};
L7 = newl;
Line(L7) = {P7,P8};
L8 = newl;
Line(L8) = {P8,P5};

// Stems
L9 = newl;
Line(L9) = {P1,P5};
L10 = newl;
Line(L10) = {P2,P6};
L11 = newl;
Line(L11) = {P3,P7};
L12 = newl;
Line(L12) = {P4,P8};

// FACES

// xMin
LL1 = newl;
Line Loop(LL1) = {-L4,L12,L8,-L9};
S1 = news;
Plane Surface(S1) = {-LL1};

// xMax
LL2 = newl;
Line Loop(LL2) = {L2,L11,-L6,-L10};
S2 = news;
Plane Surface(S2) = {LL2};

// yMin
LL3 = newl;
Line Loop(LL3) = {L1,L10,-L5,-L9};
S3 = news;
Plane Surface(S3) = {LL3};

// yMax
LL4 = newl;
Line Loop(LL4) = {-L3,L11,L7,-L12};
S4 = news;
Plane Surface(S4) = {-LL4};

// zMin
LL5 = newl;
Line Loop(LL5) = {L1,L2,L3,L4};
S5 = news;
Plane Surface(S5) = {-LL5};

// zMax
LL6 = newl;
Line Loop(LL6) = {L5,L6,L7,L8};
S6 = news;
Plane Surface(S6) = {LL6};


// PERIODIC MESHING
/* Comment lines below to remove the periodicity over each direction accordingly. */

// x
Periodic Surface S1 {-L4,L12,L8,-L9} = S2 {L2,L11,-L6,-L10};

// y 
Periodic Surface S3 {L1,L10,-L5,-L9} = S4 {-L3,L11,L7,-L12};

// z 
Periodic Surface S5 {L1,L2,L3,L4} = S6 {L5,L6,L7,L8};


// 3D MESH
//SL1 = news;
//Surface Loop(SL1) = {S1,S2,S3,S4,S5,S6};
//V1 = newreg;
//Volume(V1) = {SL1};
//Physical Surface("wallSlip") = {S1,S2,S3,S4,S5,S6};
//Physical Volume("volume") = {V1};

// PHYSICAL GROUPS

//Physical Surface("wallNoSlip") = {S3,S4,S5,S6};
Physical Surface("wallNormalV") = {S3,S4};
Physical Surface("wallNormalW") = {S5,S6};
Physical Surface("wallLeft") = {S1};
Physical Surface("wallRight") = {S2};

// Step
//Physical Surface("wallNoSlip") = {S1,S2,S3,S4,S5,S6};





