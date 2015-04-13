/* File: 2bubbles-equal-sized-coalescence-2d.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: July 19th, 2013
 * Updated: October 25th, 2013
 * Description: Framework testing for head-on collision of equal-sized bubbles
 *		Bubble center axis parallel to x axis.
 *
 *
 */

/* 0. INITIAL SETTINGS */

// --- Refinement
bubble = 0.03;
wall = 0.04; 

// --- Geometry

// combination zone center (film)
x0 = 0; 
y0 = 0;
z0 = 0;

// Bubbles
D = 1; // bubble diameter
r = D/2; // radius

c1 = 0.08; // factor of thickness 
DeltaR = c1*D; // half of thin film

// Wall
c2 = 2; // factor of horizontal stretching of domain   
c3 = 2; // factor of vertical stretching of domain   
L = x0 + DeltaR + c2*D; // length
W = x0 + c3*D; // width

// --- Interfaces

// bubble 1
P1 = newp;
Point(P1) = {x0 + DeltaR + r, y0, z0, bubble};
Printf("xc1 = %f",x0+DeltaR+r); 
P2 = newp;
Point(P2) = {x0 + DeltaR + D, y0, z0, bubble}; 
P3 = newp;
Point(P3) = {x0 + DeltaR + r, y0 + r, z0, bubble}; 
P4 = newp;
Point(P4) = {x0 + DeltaR, y0, z0, bubble}; 
P5 = newp;
Point(P5) = {x0 + DeltaR + r, y0 - r, z0, bubble};

C1 = newc;
Circle(C1) = {P2,P1,P3};
C2 = newc;
Circle(C2) = {P3,P1,P4};
C3 = newc;
Circle(C3) = {P4,P1,P5};
C4 = newc;
Circle(C4) = {P5,P1,P2};

// bubble 2
P6 = newp;
Point(P6) = {x0 - DeltaR - r, y0, z0, bubble}; 
Printf("xc2 = %f",x0-DeltaR-r); 
P7 = newp;
Point(P7) = {x0 - DeltaR, y0, z0, bubble}; 
P8 = newp;
Point(P8) = {x0 - DeltaR - r, y0 + r, z0, bubble}; 
P9 = newp;
Point(P9) = {x0 - DeltaR - D, y0, z0, bubble}; 
P10 = newp;
Point(P10) = {x0 - DeltaR - r, y0 - r, z0, bubble};

C5 = newc;
Circle(C5) = {P7,P6,P8};
C6 = newc;
Circle(C6) = {P8,P6,P9};
C7 = newc;
Circle(C7) = {P9,P6,P10};
C8 = newc;
Circle(C8) = {P10,P6,P7};


// Hull
P11 = newp;
Point(P11) = {x0 + L, y0 + W, z0, wall};
P12 = newp;
Point(P12) = {x0 - L, y0 + W, z0, wall};
P13 = newp;
Point(P13) = {x0 - L, y0 - W, z0, wall};
P14 = newp;
Point(P14) = {x0 + L, y0 - W, z0, wall};

L1 = newl;
Line(L1) = {P11,P12};
L2 = newl;
Line(L2) = {P12,P13};
L3 = newl;
Line(L3) = {P13,P14};
L4 = newl;
Line(L4) = {P14,P11};

Physical Line("wallNoSlip") = {L1,L2,L3,L4};
Physical Line("bubble1") = {C1,C2,C3,C4};
Physical Line("bubble2") = {C5,C6,C7,C8};


