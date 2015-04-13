// *** File: two-phase-periodic-periodic-2d-annular-generator.geo
// *** Author: Gustavo Charles P. de Oliveira
// *** Date: Oct 19th, 2012
// *** Description: Channel separated by interface to simulate two-phase flows

/* --- BEGIN OF CODE --- */

// -- PARAMETERS --

w = 0.1; // wall characteristic length 
b = 0.08; // bubble characteristic length 

// ** epsilon2 > epsilon1 to work
epsilon1 = 0.5; // half-width of the inner channel 
Printf("Inner-Channel Width = %g", 2 * epsilon1);

epsilon2 = 2; // half-width of the outer channel
Printf("Outer-Channel Width = %g", 2* epsilon2);

xMin = 0; // begin of channel
Printf("Begin of the Channel: x = %g", xMin);

xMax = 4; // end of channel
Printf("End of the Channel: x = %g", xMax);

xc = epsilon2; // Mid-point y coordinate

/* --- LEFT 5 POINTS determining widths of the channels */

p1 = newp;
Point(p1) = {xMin,xc,w};
p2 = newp;
Point(p2) = {xMin,xc + epsilon1,w};
p3 = newp;
Point(p3) = {xMin,xc - epsilon1,w};
p4 = newp;
Point(p4) = {xMin,xc + epsilon2,w};
p5 = newp;
Point(p5) = {xMin,xc - epsilon2,w};

// Duplicating to RIGHT HAND SIDE
Translate {xMax,0,0}{ Duplicata {Point{p1,p2,p3,p4,p5};} }

/* --- BUILDING LINES --- */

// annulus
l1 = newl;
Line(l1) = {2,7};
l2 = newl;
Line(l2) = {7,8};
l3 = newl;
Line(l3) = {8,3};
l4 = newl;
Line(l4) = {3,2};

// refinement interface
nplw = 20; // number of points
Transfinite Line{l1} = nplw Using Bump 1.0;
Transfinite Line{l3} = nplw Using Bump 1.0;


/*
// ==== curved annulus
h = 0.1;
p11 = newp;
Point(p11) = {1.0,xc+epsilon1,b};
p12 = newp;
Point(p12) = {2.0,xc+epsilon1,b};
p13 = newp;
Point(p13) = {3.0,xc+epsilon1,b};
p21 = newp;
Point(p21) = {1.0,xc-epsilon1,b};
p22 = newp;
Point(p22) = {2.0,xc-epsilon1,b};
p23 = newp;
Point(p23) = {3.0,xc-epsilon1,b};

// interface up
l11 = newl;
Line(l11) = {2,p11};
l12 = newl;
Line(l12) = {p11,p12};
l13 = newl;
Line(l13) = {p12,p13};
l14 = newl;
Line(l14) = {p13,7};

// interface down
l21 = newl;
Line(l21) = {3,p21};
l22 = newl;
Line(l22) = {p21,p22};
l23 = newl;
Line(l23) = {p22,p23};
l24 = newl;
Line(l24) = {p23,8};

//side
l2 = newl;
Line(l2) = {2,3};
l4 = newl;
Line(l4) = {7,8};

// refinement interface
nplw = 15; // number of points
Transfinite Line{l11} = nplw Using Bump 1.0;
Transfinite Line{l12} = nplw Using Bump 1.0;
Transfinite Line{l13} = nplw Using Bump 1.0;
Transfinite Line{l14} = nplw Using Bump 1.0;

Transfinite Line{l21} = nplw Using Bump 1.0;
Transfinite Line{l22} = nplw Using Bump 1.0;
Transfinite Line{l23} = nplw Using Bump 1.0;
Transfinite Line{l24} = nplw Using Bump 1.0;

// ==== 
*/

// up |'''|
l5 = newl;
Line(l5) = {2,4};
l6 = newl;
Line(l6) = {4,9};
l7 = newl;
Line(l7) = {9,7};

// down |__|

l8 = newl;
Line(l8) = {3,5};
l9 = newl;
Line(l9) = {5,10};
l10 = newl;
Line(l10) = {10,8};

// refinement overlap
npla = 12; // number of points
Transfinite Line{l2} = npla Using Bump 1.0;
Transfinite Line{l4} = npla Using Bump 1.0;

// refinement periodic outer
npla = 14; // number of points
Transfinite Line{l5} = npla Using Bump 1.0;
Transfinite Line{l7} = npla Using Bump 1.0;
Transfinite Line{l8} = npla Using Bump 1.0;
Transfinite Line{l10} = npla Using Bump 1.0;

// Define physical groups manually
Physical Line("wallNoSlip") = {l6,l9};
Physical Line("wallLeft") = {l5,l8};
Physical Line("wallRight") = {l7,l10};
Physical Line("bubble1") = {l1,l2,l3,l4};
//Physical Line("bubble1") = {l2,l4,l11:l14,l21:l24};

