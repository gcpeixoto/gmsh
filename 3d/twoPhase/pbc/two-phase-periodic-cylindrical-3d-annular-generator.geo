/* File: periodic-cylindrical-3d-annular-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: September 17th, 2013
 * Description: Generates a 3D channel with lateral periodicity for annular flows
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

r1 = 0.35; // inner radius
r2 = 0.5; // outer radius

D1 = 2*r1; // inner diameter
D2 = 2*r2; // outer diameter

L = 3*D2; // length
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


// --- OUTER circumference

// --- left end

p11 = newp;
Point(p11) = {xMin,yMin,zMin - r2,bOut}; 
p12 = newp;
Point(p12) = {xMin,yMin + r2,zMin,bOut}; 
p13 = newp;
Point(p13) = {xMin,yMin,zMin + r2,bOut};
p14 = newp;
Point(p14) = {xMin,yMin - r2,zMin,bOut};

// --- right end

p15 = newp;
Point(p15) = {xMin + L,yMin,zMin - r2,bOut}; 
p16 = newp;
Point(p16) = {xMin + L,yMin + r2,zMin,bOut}; 
p17 = newp;
Point(p17) = {xMin + L,yMin,zMin + r2,bOut};
p18 = newp;
Point(p18) = {xMin + L,yMin - r2,zMin,bOut};


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


// --- OUTER circumference

// --- left end
c9 = newc;
Circle(c9) = {p11,p1,p12};
c10 = newc;
Circle(c10) = {p12,p1,p13};
c11 = newc;
Circle(c11) = {p13,p1,p14};
c12 = newc;
Circle(c12) = {p14,p1,p11};

// --- right end
c13 = newc;
Circle(c13) = {p15,p6,p16};
c14 = newc;
Circle(c14) = {p16,p6,p17};
c15 = newc;
Circle(c15) = {p17,p6,p18};
c16 = newc;
Circle(c16) = {p18,p6,p15};


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

l5 = newl;
Line(l5) = {p11,p15};
l6 = newl;
Line(l6) = {p12,p16};
l7 = newl;
Line(l7) = {p13,p17};
l8 = newl;
Line(l8) = {p14,p18};


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


// BUILDING RING SURFACES

// --- left end
ll3 = newl;
Line Loop(ll3) = {-c4,-c3,-c2,-c1,-c9,-c10,-c11,-c12};
s3 = news;
Plane Surface(s3) = {ll3};

// --- right end
ll4 = newl;
Line Loop(ll4) = {c5,c6,c7,c8,c13,c14,c15,c16};
s4 = news;
Plane Surface(s4) = {ll4};


// DISCRETIZATION (THETA) CIRCLES 

ntIn = 5; // number of theta points per semi-semi circle (total around circle is 4*nt) 
Transfinite Line{c1,c2,c3,c4,c5,c6,c7,c8} = ntIn Using Bump 1;

ntOut = 5; // number of theta points per semi-semi circle (total around circle is 4*nt) 
Transfinite Line{c9,c10,c11,c12,c13,c14,c15,c16} = ntOut Using Bump 1;


// PERIODIC SURFACES MESHING 

// s1 - Master :: s2 - Slave
Periodic Surface s1 {c1,c2,c3,c4} = s2 {c5,c6,c7,c8};

// s3 - Master :: s4 - Slave
Periodic Surface s3 {c1,c2,c3,c4,c9,c10,c11,c12} = s4 {c5,c6,c7,c8,c13,c14,c15,c16};


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

// --- outer tube

// Pi/2
ll9 = newl;
Line Loop(ll9) = {-l5,c9,l6,-c13};
s9 = news;
Ruled Surface(s9) = {ll9};

// Pi
ll10 = newl;
Line Loop(ll10) = {-l6,c10,l7,-c14};
s10 = news;
Ruled Surface(s10) = {ll10};

// 3*Pi/2
ll11 = newl;
Line Loop(ll11) = {-l7,c11,l8,-c15};
s11 = news;
Ruled Surface(s11) = {ll11};

// 2*Pi
ll12 = newl;
Line Loop(ll12) = {-l8,c12,l5,-c16};
s12 = news;
Ruled Surface(s12) = {ll12};

// LOCAL REFINEMENT

// Walls
Field[1] = Attractor;
Field[1].EdgesList = {s9,s10,s11,s12};

// refinement parameters
lmw = bOut/10; 
lMw = bOut/10;
dmw = .01;
dMw = .05;

Field[2] = Threshold;
Field[2].IField = 1; // Index of the field to evaluate
Field[2].LcMin = lmw; 
Field[2].LcMax = lMw;
Field[2].DistMin = dmw;
Field[2].DistMax = dMw;

// annulus
Field[3] = Attractor;
Field[3].EdgesList = {s5,s6,s7,s8};

lmb = bIn/30; 
lMb = bIn/10;
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
//Background Field = 5;

// DEFINING TRANSFINITE 

// Inner lines

//bLineIn = 0.1; 
//npl = 20; // number of points
//Transfinite Line{l1} = npl Using Bump bLineIn;
//Transfinite Line{l2} = npl Using Bump bLineIn;
//Transfinite Line{l3} = npl Using Bump bLineIn;
//Transfinite Line{l4} = npl Using Bump bLineIn;

// Inner Ruled Surfaces (produces a more uniform mesh on the surfaces)
// options: Left, Right, Alternate, AlternateRight

//Transfinite Surface {s5} Alternate;
//Transfinite Surface {s6} Alternate;
//Transfinite Surface {s7} Alternate;
//Transfinite Surface {s8} Alternate;

// PHYSICAL SURFACES

// Wall's surfaces
Physical Surface("wallMoving") = {s9,s10,s11,s12};
Physical Surface("wallP") = {s1,s2,s3,s4};
Physical Surface("bubble1") = {s5,s6,s7,s8};

