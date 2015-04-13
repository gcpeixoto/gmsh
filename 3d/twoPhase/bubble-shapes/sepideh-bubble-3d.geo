/* File: 3d-sepideh-bubble.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: August 12th, 2013
 * Description: Generates a Taylor bubble as imagery by Sepideh Khodaparast
 *		for low Ca number and air/water flow. 
 */


// Comment, if not used as "Include" only to view the bubble 
//b = 0.1;
//D = 3; // tube diameter
//xc = 0;
//yc = 0;
//zc = 0;

// Bubble geometry parameters (experimental values)
rn = 0.86*(D/2); // nose radius
rt = 0.95*(D/2); //tail radius
LB = 0.395*D; // body length

nEdges = 100; // number of nodes by edge

/* ======= BUBBLE ("3 ZONE MODEL"): TAIL /\ BODY /\ NOSE ======= */

/* --- 1. TAIL */

// -- Circumference r-theta - Points
p1 = newp;
Point(p1) = {xc, yc, zc, b}; // center 
p2 = newp;
Point(p2) = {xc, yc, zc + rt, b};
p3 = newp;
Point(p3) = {xc, yc - rt, zc, b};
p4 = newp;
Point(p4) = {xc, yc, zc - rt, b};
p5 = newp;
Point(p5) = {xc, yc + rt, zc, b};
p6 = newp;
Point(p6) = {xc - rt, yc, zc, b}; // dome apex  


// -- Circles
c1 = newc;
Circle(c1) = {p5,p1,p2};
c2 = newc;
Circle(c2) = {p2,p1,p3};
c3 = newc;
Circle(c3) = {p3,p1,p4};
c4 = newc;
Circle(c4) = {p4,p1,p5};


// -- Dome
c5 = newc;
Circle(c5) = {p5,p1,p6};
c6 = newc;
Circle(c6) = {p2,p1,p6};
c7 = newc;
Circle(c7) = {p3,p1,p6};
c8 = newc;
Circle(c8) = {p4,p1,p6};


// -- Line Loops 
// - Wedge Pi/2
ll1 = newll; 
Line Loop(ll1) = {c5,-c6,-c1};

// - Wedge Pi
ll2 = newll;
Line Loop(ll2) = {c6,-c7,-c2};

// - Wedge 3*Pi/2
ll3 = newll;
Line Loop(ll3) = {c7,-c8,-c3};

// - Wedge 2*Pi
ll4 = newll;
Line Loop(ll4) = {c8,-c5,-c4};


// -- Ruled Surfaces 
s1 = news;
Ruled Surface(s1) = {ll1};
s2 = news;
Ruled Surface(s2) = {ll2};
s3 = news;
Ruled Surface(s3) = {ll3};
s4 = news;
Ruled Surface(s4) = {ll4};


/* --- 2. NOSE */


// -- Circumference r-theta - Points
p7 = newp;
Point(p7) = {xc + LB, yc, zc, b}; // center 
p8 = newp;
Point(p8) = {xc + LB, yc, zc + rn, b};
p9 = newp;
Point(p9) = {xc + LB, yc - rn, zc, b};
p10 = newp;
Point(p10) = {xc + LB, yc, zc - rn, b};
p11 = newp;
Point(p11) = {xc + LB, yc + rn, zc, b};
p12 = newp;
Point(p12) = {xc + LB + rn, yc, zc, b}; // dome apex  


// -- Circles
c9 = newc;
Circle(c9) = {p11,p7,p8};
c10 = newc;
Circle(c10) = {p8,p7,p9};
c11 = newc;
Circle(c11) = {p9,p7,p10};
c12 = newc;
Circle(c12) = {p10,p7,p11};


// -- Dome
c13 = newc;
Circle(c13) = {p11,p7,p12};
c14 = newc;
Circle(c14) = {p8,p7,p12};
c15 = newc;
Circle(c15) = {p9,p7,p12};
c16 = newc;
Circle(c16) = {p10,p7,p12};


// -- Line Loops 
// - Wedge Pi/2
ll5 = newll; 
Line Loop(ll5) = {-c13,c14,c9};

// - Wedge Pi
ll6 = newll;
Line Loop(ll6) = {-c14,c15,c10};

// - Wedge 3*Pi/2
ll7 = newll;
Line Loop(ll7) = {-c15,c16,c11};

// - Wedge 2*Pi
ll8 = newll;
Line Loop(ll8) = {-c16,c13,c12};


// -- Ruled Surfaces 
s5 = news;
Ruled Surface(s5) = {ll5};
s6 = news;
Ruled Surface(s6) = {ll6};
s7 = news;
Ruled Surface(s7) = {ll7};
s8 = news;
Ruled Surface(s8) = {ll8};


/* --- 3. BODY --- */

// -- Lines
l1 = newl;
Line(l1) = {p5,p11};
l2 = newl;
Line(l2) = {p2,p8};
l3 = newl;
Line(l3) = {p3,p9};
l4 = newl;
Line(l4) = {p4,p10};

// -- Line Loops
// - Wedge Pi/2
ll9 = newll; 
Line Loop(ll9) = {-l1,-c9,l2,c1};

// - Wedge Pi
ll10 = newll;
Line Loop(ll10) = {-l2,-c10,l3,c2};

// - Wedge 3*Pi/2
ll11 = newll;
Line Loop(ll11) = {-l3,-c11,l4,c3};

// - Wedge 2*Pi
ll12 = newll;
Line Loop(ll12) = {-l4,-c12,l1,c4};

// -- Ruled Surfaces 
s9 = news;
Ruled Surface(s9) = {ll9};
s10 = news;
Ruled Surface(s10) = {ll10};
s11 = news;
Ruled Surface(s11) = {ll11};
s12 = news;
Ruled Surface(s12) = {ll12};


/* --- 4. BUBBLE REFINEMENT --- */

// Bubble
Field[j] = Attractor;
//Field[j].EdgesList = {s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12};
Field[j].EdgesList = {c1,c2,c3,c4,c5,c6,c7,c8,l1,l2,l3,l4,c9,c10,c11,c12,c13,c14,c15,c16}; 

lmb = b/2; 
lMb = b;
dmb = .1;
dMb = .2;

Field[j+1] = Threshold;
Field[j+1].IField = j;
Field[j+1].LcMin = lmb;
Field[j+1].LcMax = lMb;
Field[j+1].DistMin = dmb;
Field[j+1].DistMax = dMb;

//Physical Surface(Sprintf("bubble%g",i)) = {s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12};



