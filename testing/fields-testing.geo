// file: fields-testing.geo
// Author: Gustavo Charles P. de Oliveira 
// Created on August 20th, 2013

// Description: File to test fields 'Attractor' and 'Threshold' in GMSH.

// -- Char. lengths

w = 1; // boundary
b = 1; // bubble

// Origins

x0 = 0;
y0 = 0;
z0 = 0;
L = 1; // size
r = L/5; // radius

// Midpoint
xm = (2*x0 + L)/2;
ym = (2*y0 + L)/2;
zm = (2*z0 + L)/2;

// Points
Point(1) = {x0,y0,z0,w};
Point(2) = {x0 + L,y0,z0,w};
Point(3) = {x0 + L,y0 + L,z0,w};
Point(4) = {x0,y0 + L,z0,w};

p1 = newp;
Point(p1) = {xm - r, y0,z0,w};
p2 = newp;
Point(p2) = {xm + r, y0,z0,w};
p3 = newp;
Point(p3) = {xm + r, y0 + L,z0,w};
p4 = newp;
Point(p4) = {xm - r, y0 + L,z0,w};


// Lines
l1 = newl;
//Line(l1) = {1,2};
l11 = newl;
Line(l11) = {1,p1};
l12 = newl;
Line(l12) = {p1,p2};
l13 = newl;
Line(l13) = {p2,2};

l2 = newl;
Line(l2) = {2,3};
l3 = newl;
//Line(l3) = {3,4};
l1 = newl;
//Line(l1) = {1,2};
l31 = newl;
Line(l31) = {3,p3};
l32 = newl;
Line(l32) = {p3,p4};
l33 = newl;
Line(l33) = {p4,4};

l4 = newl;
Line(l4) = {4,1};


// Bubble
p1 = newp; 
Point(p1) = {xm,ym,z0,b}; // center point
p2 = newp;
Point(p2) = {xm + r,ym,z0,b};
p3 = newp;
Point(p3) = {xm,ym + r,z0,b};
p4 = newp;
Point(p4) = {xm - r,ym,z0,b};
p5 = newp;
Point(p5) = {xm,ym - r,z0,b};

// Circles
c1 = newc;
Circle(c1) = {p2,p1,p3};
c2 = newc;
Circle(c2) = {p3,p1,p4};
c3 = newc;
Circle(c3) = {p4,p1,p5};
c4 = newc;
Circle(c4) = {p5,p1,p2};

// Surfaces
ll1 = newll;
//Line Loop(ll1) = {1,2,3,4,c1,c2,c3,c4};
Line Loop(ll1) = {l11,l12,l13,l2,l31,l32,l33,l4,c1,c2,c3,c4};
Plane Surface(1) = {ll1};

ll2 = newll;
Line Loop(ll2) = {c1,c2,c3,c4};
Plane Surface(2) = {ll2};

/* Local Refinement */

// Walls
Field[1] = Attractor;
Field[1].EdgesList = {l12,l32};
//Field[1].NNodesByEdge = {10}; // GMSH breaking with this option

// refinement parameters
lmw = w/45; 
lMw = w/10;
dmw = .01;
dMw = .05;

Field[2] = Threshold;
Field[2].IField = 1; // Index of the field to evaluate
Field[2].LcMin = lmw; 
Field[2].LcMax = lMw;
Field[2].DistMin = dmw;
Field[2].DistMax = dMw;

// Bubble
Field[3] = Attractor;
Field[3].EdgesList = {c1,c2,c3,c4};

lmb = b/25; 
lMb = b/10;
dmb = .01;
dMb = .05;

Field[4] = Threshold;
Field[4].IField = 3;
Field[4].LcMin = lmb;
Field[4].LcMax = lMb;
Field[4].DistMin = dmb;
Field[4].DistMax = dMb;

// Final result
Field[5] = Min; // Take the minimum value of the list of fields 'FieldsList'
Field[5].FieldsList = {2,4};
Background Field = 5;

