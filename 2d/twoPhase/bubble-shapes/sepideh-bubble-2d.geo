/* File: 2d-sepideh-bubble.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: August 13th, 2013
 * Description: Generates a Taylor bubble as imagery by Sepideh Khodaparast
 *		for low Ca number and air/water flow. 
 */


// Comment, if not used as "Include" only to view the bubble 
//b = 0.1;
//D = 3; // tube diameter
//xc = 0;
//yc = 0;
//zc = 0;

// Bubble geometry parameters (experimental values ratios)
rn = 0.86*(D/2); // nose radius
rt = 0.95*(D/2); //tail radius
LB = 0.395*D; // body length

// Bubble geometry parameters (chosen by convenience)
//rn = 0.9*(D/2); // nose radius
//rt = 0.9*(D/2); //tail radius
//LB = 0.4*D; // body length


/* ======= BUBBLE ("3 ZONE MODEL"): TAIL /\ BODY /\ NOSE ======= */

/* --- 1. TAIL */

p1 = newp;
Point(p1) = {xc, yc, zc, b}; // center 
p2 = newp;
Point(p2) = {xc, yc + rt, zc, b};
p3 = newp;
Point(p3) = {xc, yc - rt, zc, b};
p4 = newp;
Point(p4) = {xc - rt, yc, zc, b}; // arc apex  

// -- Circles
c1 = newc;
Circle(c1) = {p2,p1,p4};
c2 = newc;
Circle(c2) = {p4,p1,p3};


/* --- 2. NOSE */

p5 = newp;
Point(p5) = {xc + LB, yc, zc, b}; // center 
p6 = newp;
Point(p6) = {xc + LB, yc + rn, zc, b};
p7 = newp;
Point(p7) = {xc + LB, yc - rn, zc, b};
p8 = newp;
Point(p8) = {xc + LB + rn, yc, zc, b}; // arc apex  


// -- Circles
c3 = newc;
Circle(c3) = {p7,p5,p8};
c4 = newc;
Circle(c4) = {p8,p5,p6};

/* --- 3. BODY --- */

// -- Lines
l1 = newl;
Line(l1) = {p2,p6};
l2 = newl;
Line(l2) = {p3,p7};

/* --- 4. BUBBLE REFINEMENT --- */

// Bubble
Field[j] = Attractor;
//Field[j].EdgesList = {l1,l2,p2,p3,p6,p7};
Field[j].EdgesList = {c1,c2,c3,c4,l1,l2};
//Field[j].EdgesList = {p2};

lmb = b/30; 
lMb = b;
dmb = .1;
dMb = .2;

Field[j+1] = Threshold;
Field[j+1].IField = j;
Field[j+1].LcMin = lmb;
Field[j+1].LcMax = lMb;
Field[j+1].DistMin = dmb;
Field[j+1].DistMax = dMb;
