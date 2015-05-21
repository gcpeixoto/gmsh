/* File: periodic-rectangular-3d-annular-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: March 14th, 2014
 * Description: Generates a 3D channel with lateral periodicity for annular flows and jets.
 */


// PARAMETERS

// --- Refinement
bIn = 0.1;
bOut = 0.2; 

// --- Boundary Geometry
xMin = 0; // begin of channel
Printf("Begin of the Channel: x = %g", xMin);
yMin = 0;
zMin = 0;

r1 = 1; // inner radius

D1 = 3*r1; // y-length
D2 = 3*r1; // z-length

L = 2*D1; // length
Printf("Length: %g", L);


// SURFACES

// INNER circumference

// --- left end

p1 = newp;
Point(p1) = {xMin,yMin,zMin,bIn}; // center
p2 = newp;
Point(p2) = {xMin,yMin,zMin - r1,bIn}; 
p3 = newp;
Point(p3) = {xMin,yMin + r1,zMin,bIn}; 
p4 = newp;
Point(p4) = {xMin,yMin,zMin + r1,bIn};
p5 = newp;
Point(p5) = {xMin,yMin - r1,zMin,bIn};

// --- right end

p6 = newp;
Point(p6) = {xMin + L,yMin,zMin,bIn}; // center
p7 = newp;
Point(p7) = {xMin + L,yMin,zMin - r1,bIn}; 
p8 = newp;
Point(p8) = {xMin + L,yMin + r1,zMin,bIn}; 
p9 = newp;
Point(p9) = {xMin + L,yMin,zMin + r1,bIn};
p10 = newp;
Point(p10) = {xMin + L,yMin - r1,zMin,bIn};


// --- OUTER rectangle

// --- left end

p11 = newp;
Point(p11) = {xMin,yMin + D1,zMin - D2,bOut}; 
p12 = newp;
Point(p12) = {xMin,yMin + D1,zMin + D2,bOut}; 
p13 = newp;
Point(p13) = {xMin,yMin - D1,zMin + D2,bOut};
p14 = newp;
Point(p14) = {xMin,yMin - D1,zMin - D2,bOut};

// --- right end

p15 = newp;
Point(p15) = {xMin + L,yMin + D1,zMin - D2,bOut}; 
p16 = newp;
Point(p16) = {xMin + L,yMin + D1,zMin + D2,bOut}; 
p17 = newp;
Point(p17) = {xMin + L,yMin - D1,zMin + D2,bOut};
p18 = newp;
Point(p18) = {xMin + L,yMin - D1,zMin - D2,bOut};


// BUILDING CIRCLES

// --- INNER circumference

// --- left end
c1 = newc;
Circle(c1) = {p2,p1,p3};
c2 = newc;
Circle(c2) = {p3,p1,p4};
c3 = newc;
Circle(c3) = {p4,p1,p5};
c4 = newc;
Circle(c4) = {p5,p1,p2};

// --- right end
c5 = newc;
Circle(c5) = {p7,p6,p8};
c6 = newc;
Circle(c6) = {p8,p6,p9};
c7 = newc;
Circle(c7) = {p9,p6,p10};
c8 = newc;
Circle(c8) = {p10,p6,p7};


// BUILDING LINES

// --- INNER lines

l1 = newl;
Line(l1) = {p2,p7};
l2 = newl;
Line(l2) = {p3,p8};
l3 = newl;
Line(l3) = {p4,p9};
l4 = newl;
Line(l4) = {p5,p10};

// --- OUTER lines

// --- length
l5 = newl;
Line(l5) = {p11,p15};
l6 = newl;
Line(l6) = {p12,p16};
l7 = newl;
Line(l7) = {p13,p17};
l8 = newl;
Line(l8) = {p14,p18};

// --- left end
l9 = newl;
Line(l9) = {p11,p12};
l10 = newl;
Line(l10) = {p12,p13};
l11 = newl;
Line(l11) = {p13,p14};
l12 = newl;
Line(l12) = {p14,p11};

// --- right end

l13 = newl;
Line(l13) = {p15,p16};
l14 = newl;
Line(l14) = {p16,p17};
l15 = newl;
Line(l15) = {p17,p18};
l16 = newl;
Line(l16) = {p18,p15};

// BUILDING INNER SURFACES

// --- left end
ll1 = newl;
Line Loop(ll1) = {-c4,-c3,-c2,-c1};
s1 = news;
Plane Surface(s1) = {ll1};

// --- right end
ll2 = newl;
Line Loop(ll2) = {c5,c6,c7,c8};
s2 = news;
Plane Surface(s2) = {ll2};


// BUILDING CROWN SURFACES

// --- left end
ll3 = newl;
Line Loop(ll3) = {-c4,-c3,-c2,-c1,-l9,-l10,-l11,-l12};
s3 = news;
Plane Surface(s3) = {ll3};

// --- right end
ll4 = newl;
Line Loop(ll4) = {c5,c6,c7,c8,l13,l14,l15,l16};
s4 = news;
Plane Surface(s4) = {ll4};


// DISCRETIZATION (THETA) CIRCLES 

ntIn = 10; // number of theta points per semi-semi circle (total around circle is 4*nt) 
Transfinite Line{c1,c2,c3,c4,c5,c6,c7,c8} = ntIn Using Bump 1;

// PERIODIC SURFACES MESHING 

// s1 - Master :: s2 - Slave
Periodic Surface s1 {c1,c2,c3,c4} = s2 {c5,c6,c7,c8};

// s3 - Master :: s4 - Slave
Periodic Surface s3 {c1,c2,c3,c4,l9,l10,l11,l12} = s4 {c5,c6,c7,c8,l13,l14,l15,l16};


// RULED SURFACES

// --- inner tube

// Pi/2
ll5 = newl;
Line Loop(ll5) = {-l1,c1,l2,-c5};
s5 = news;
Ruled Surface(s5) = {ll5};

// Pi
ll6 = newl;
Line Loop(ll6) = {-l2,c2,l3,-c6};
s6 = news;
Ruled Surface(s6) = {ll6};

// 3*Pi/2
ll7 = newl;
Line Loop(ll7) = {-l3,c3,l4,-c7};
s7 = news;
Ruled Surface(s7) = {ll7};

// 2*Pi
ll8 = newl;
Line Loop(ll8) = {-l4,c4,l1,-c8};
s8 = news;
Ruled Surface(s8) = {ll8};

// --- outer rectangle

// ymax
ll9 = newl;
Line Loop(ll9) = {-l5,l9,l6,-l13};
s9 = news;
Ruled Surface(s9) = {ll9};

// zmax
ll10 = newl;
Line Loop(ll10) = {-l6,l10,l7,-l14};
s10 = news;
Ruled Surface(s10) = {ll10};

// ymin
ll11 = newl;
Line Loop(ll11) = {-l7,l11,l8,-l15};
s11 = news;
Ruled Surface(s11) = {ll11};

// zmin
ll12 = newl;
Line Loop(ll12) = {-l8,l12,l5,-l16};
s12 = news;
Ruled Surface(s12) = {ll12};


// PHYSICAL SURFACES

// Wall's surfaces
Physical Surface("wallSlip") = {s9,s11};
Physical Surface("wallP") = {s3,s4};
Physical Surface("wallInflow") = {s10,s12};
Physical Surface("bubble") = {s1,s2,s5,s6,s7,s8};

