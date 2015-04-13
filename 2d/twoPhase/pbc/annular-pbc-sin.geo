// *** File: two-phase-periodic-periodic-2d-annular-generator.geo
// *** Author: Gustavo Charles P. de Oliveira
// *** Date: Oct 19th, 2012
// *** Description: Channel separated by interface to simulate two-phase flows

/* --- BEGIN OF CODE --- */

// -- PARAMETERS --

w = 0.08; // wall characteristic length 
b = 0.06; // bubble characteristic length 

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
Point(p1) = {xMin,xc + epsilon2,w};
p2 = newp;
Point(p2) = {xMin,xc - epsilon2,w};

// Duplicating to RIGHT HAND SIDE
Translate {xMax,0,0}{ Duplicata {Point{p1,p2};} }

/* --- BUILDING LINES --- */


// sinusoidal annulus

// up
A = 0.1;
k = 1;
stretch=4;
phase = 0;
nCycles = 2;
nPoints = 31;
nTheta = 4;

k = 10000;
j = 1+k;
shift = 0;
// top line
For i In {1:nPoints}
 X = stretch*( (i-1)/(nPoints-1) );
 Y = A*Cos(nCycles*2*Pi/stretch*X-phase);
 Point(j) = {X, Y+xc+epsilon1, 0, b};
 j = j + 1;
EndFor

j = 1+k;
// lines
For i In {1:nPoints-1}
 Line(j) = {j, j+1};
 j = j + 1;
EndFor

k = 20000;
j = 1+k;
shift = 0;
// top line
For i In {1:nPoints}
 X = stretch*( (i-1)/(nPoints-1) );
 Y = A*Cos(nCycles*2*Pi/stretch*X-phase);
 Point(j) = {X, Y+xc-epsilon1, 0, b};
 j = j + 1;
EndFor

j = 1+k;
// lines
For i In {1:nPoints-1}
 Line(j) = {j, j+1};
 j = j + 1;
EndFor


//side
l2 = newl;
Line(l2) = {10001,20001};
l4 = newl;
Line(l4) = {10031,20031};

// up |'''|
l5 = newl;
Line(l5) = {10001,1};
l6 = newl;
Line(l6) = {1,3};
l7 = newl;
Line(l7) = {3,10031};

// down |__|

l8 = newl;
Line(l8) = {20001,2};
l9 = newl;
Line(l9) = {2,4};
l10 = newl;
Line(l10) = {4,20031};


// refinement overlap
npla = 10; // number of points
Transfinite Line{l2} = npla Using Bump 1.0;
Transfinite Line{l4} = npla Using Bump 1.0;


// refinement periodic outer
npla = 10; // number of points
Transfinite Line{l5} = npla Using Bump 1.0;
Transfinite Line{l7} = npla Using Bump 1.0;
Transfinite Line{l8} = npla Using Bump 1.0;
Transfinite Line{l10} = npla Using Bump 1.0;

// Define physical groups manually
Physical Line("wallNoSlip") = {l6,l9};
Physical Line("wallLeft") = {l5,l8};
Physical Line("wallRight") = {l7,l10};
//Physical Line("bubble1") = {l1,l2,l3,l4};
Physical Line("bubble1") = {l2,l4,10001:10030,20001:20030};
