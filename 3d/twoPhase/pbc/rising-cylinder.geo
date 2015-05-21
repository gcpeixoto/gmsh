/* File: periodic-rectangular-3d-bubble-array-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: July 25th, 2013
 * Description: Generates a 3D channel with lateral periodicity
 *     and array of nb internal Taylor bubbles separated by slug. 
 */

// --- Refinement
b = 0.08; // bubble
wp = 0.7; // walls
wc = 0.7; // cylindrical wrapping

// --- Boundary Geometry
xMin = 0; // begin of channel
Printf("Begin of the Channel: z = %g", xMin);
yMin = 0;
zMin = 0;

r1 = 5; // channel semi-diameter

// --- Bubble Parameters

D = 2*r1; // channel diameter
DB = 1; // bubble diameter
rb = DB/2; // bubble radius

//g = 8*rb; // gap length - pbc+rising
g = 8*rb; // gap length - pnly rising
s = 2*g; // slug length

nb = 1; // number of bubbles

LM = nb*DB + (nb - 1)*s; // bubble array
L = LM + 2*g; // channel length
Printf("End of the Channel: z = %g", L);

// 1. PERIODIC SURFACES

// left end
p1 = newp;
Point(p1) = {xMin,yMin,zMin,wc}; // center
p2 = newp;
Point(p2) = {xMin,yMin - r1,zMin,wp}; 
p3 = newp;
Point(p3) = {xMin + r1,yMin,zMin,wp}; 
p4 = newp;
Point(p4) = {xMin,yMin + r1,zMin,wp};
p5 = newp;
Point(p5) = {xMin - r1,yMin,zMin,wp};

// right end
p6 = newp;
Point(p6) = {xMin,yMin,zMin + L,wp}; // center
p7 = newp;
Point(p7) = {xMin,yMin - r1,zMin + L,wp}; 
p8 = newp;
Point(p8) = {xMin + r1,yMin,zMin + L,wp}; 
p9 = newp;
Point(p9) = {xMin,yMin + r1,zMin + L,wp};
p10 = newp;
Point(p10) = {xMin - r1,yMin,zMin + L,wp};

/* --- BUILDING CIRCLES --- */
// left end
c1 = newc;
Circle(c1) = {p2,p1,p3};
c2 = newc;
Circle(c2) = {p3,p1,p4};
c3 = newc;
Circle(c3) = {p4,p1,p5};
c4 = newc;
Circle(c4) = {p5,p1,p2};

// right end
c5 = newc;
Circle(c5) = {p7,p6,p8};
c6 = newc;
Circle(c6) = {p8,p6,p9};
c7 = newc;
Circle(c7) = {p9,p6,p10};
c8 = newc;
Circle(c8) = {p10,p6,p7};

/* --- BUILDING EXTERNAL LINES --- */

l1 = newl;
Line(l1) = {p2,p7};
l2 = newl;
Line(l2) = {p3,p8};
l3 = newl;
Line(l3) = {p4,p9};
l4 = newl;
Line(l4) = {p5,p10};

// 2. INTERNAL DOMAIN - BUBBLES

// Origin
x0 = xMin; 
y0 = yMin;
//z0 = zMin; // pbc+rising
z0 = zMin - 6*rb; // only rising

For i In {1:nb} // BEGIN LOOP

// --- spherical bubble points

pp9 = newp;
Point(pp9) = {x0, y0, z0 + g + rb + (i - 1)*(DB + s), b};
pp10 = newp;
Point(pp10) = {x0, y0 - rb, z0 + g + rb + (i - 1)*(DB + s), b};
pp11 = newp;
Point(pp11) = {x0 + rb, y0, z0 + g + rb + (i - 1)*(DB + s), b};
pp12 = newp;
Point(pp12) = {x0, y0 + rb, z0 + g + rb + (i - 1)*(DB + s), b};
pp13 = newp;
Point(pp13) = {x0 - rb, y0, z0 + g + rb + (i - 1)*(DB + s), b};
pp14 = newp;
Point(pp14) = {x0, y0, z0 + g + (i - 1)*(DB + s), b};
pp15 = newp;
Point(pp15) = {x0, y0, z0 + g + DB + (i - 1)*(DB + s), b};

// --- BUILDING CIRCLES ---

// x-normal meridian 
cc11 = newc;
Circle(cc11) = {pp12,pp9,pp11};
cc12 = newc;
Circle(cc12) = {pp11,pp9,pp10};
cc13 = newc;
Circle(cc13) = {pp10,pp9,pp13};
cc14 = newc;
Circle(cc14) = {pp13,pp9,pp12};

// z-normal meridian
cc15 = newc;
Circle(cc15) = {pp11,pp9,pp14};
cc16 = newc;
Circle(cc16) = {pp14,pp9,pp13};
cc17 = newc;
Circle(cc17) = {pp13,pp9,pp15};
cc18 = newc;
Circle(cc18) = {pp15,pp9,pp11};

// --- DISCRETIZATION (THETA) CIRCLES --- 
nt2 = 14; // number of theta points per quarter of circle (total around circle is 4*nt) 
//Transfinite Line{cc11,cc12,cc13,cc14,cc15,cc16,cc17,cc18} = nt2 Using Bump 1;

// BUBBLES' SURFACES
// reference: central axis is Z-positive and theta counterclockwise

// 0:Pi/2
lb21 = newl;
Line Loop(lb21) = {cc12,cc13,-cc16,-cc15};
sb21 = news;
Ruled Surface(sb21) = {lb21};

// Pi/2:Pi
lb22 = newl;
Line Loop(lb22) = {-cc18,-cc17,-cc13,-cc12};
sb22 = news;
Ruled Surface(sb22) = {lb22};

// Pi:3*Pi/2
lb23 = newl;
Line Loop(lb23) = {-cc11,-cc14,cc17,cc18};
sb23 = news;
Ruled Surface(sb23) = {lb23};

// 3*Pi/2:2*Pi
lb24 = newl;
Line Loop(lb24) = {cc15,cc16,cc14,cc11};
sb24 = news;
Ruled Surface(sb24) = {lb24};

Printf("Data bubble: %f",i);  
Printf("Bubble's ruled surface - 0:Pi/2 = %f",sb21);
Printf("Bubble's ruled surface - Pi/2:Pi = %f",sb22);
Printf("Bubble's ruled surface - Pi:1.5*Pi = %f",sb23);
Printf("Bubble's ruled surface - 1.5*Pi:2*Pi = %f",sb24);

EndFor

// 4. BUILDING EXTERNAL SURFACES

// left end
ll15 = newl;
Line Loop(ll15) = {-c4,-c3,-c2,-c1};
s1 = news;
Plane Surface(s1) = {ll15};

// right end
ll16 = newl;
Line Loop(ll16) = {c5,c6,c7,c8};
s2 = news;
Plane Surface(s2) = {ll16}; 

// channel's surfaces

// y = ymax
ll17 = newl;
Line Loop(ll17) = {-l1,c1,l2,-c5};
s3 = news;
Ruled Surface(s3) = {ll17};

// z = zmax
ll18 = newl;
Line Loop(ll18) = {-l2,c2,l3,-c6};
s4 = news;
Ruled Surface(s4) = {ll18};

// y = ymin
ll19 = newl;
Line Loop(ll19) = {-l3,c3,l4,-c7};
s5 = news;
Ruled Surface(s5) = {ll19};

// z = zmin
ll20 = newl;
Line Loop(ll20) = {-l4,c4,l1,-c8};
s6 = news;
Ruled Surface(s6) = {ll20};

/* // Begin wrap

// 4.1 CYLINDRICAL WRAPPING 

dr = 0.2*wp; // increase
Dr = rb + dr; // extended radius

za = zMin;
zb = (zMin + L);

// Points x = xMin
p10 = newp;
Point(p10) = {x0 + Dr,yMin,za,wc};
p11 = newp;
Point(p11) = {x0,yMin + Dr,za,wc};
p12 = newp;
Point(p12) = {x0 - Dr,yMin,za,wc};
p13 = newp;
Point(p13) = {x0,yMin - Dr,za,wc};

// Points x = xMax
p15 = newp;
Point(p15) = {x0 + Dr,yMin,zb,wc};
p16 = newp;
Point(p16) = {x0,yMin + Dr,zb,wc};
p17 = newp;
Point(p17) = {x0 - Dr,yMin,zb,wc};
p18 = newp;
Point(p18) = {x0,yMin - Dr,zb,wc};

// centers
ppp1 = newp;
Point(ppp1) = {xMin,yMin,za,wc};
ppp2 = newp;
Point(ppp2) = {xMin,yMin,zb,wc};

// Circles x = xmin
c9 = newc;
Circle(c9) = {p10,ppp1,p11};
c10 = newc;
Circle(c10) = {p11,ppp1,p12};
c11 = newc;
Circle(c11) = {p12,ppp1,p13};
c12 = newc;
Circle(c12) = {p13,ppp1,p10};

// Circles x = xmax
c13 = newc;
Circle(c13) = {p15,ppp2,p16};
c14 = newc;
Circle(c14) = {p16,ppp2,p17};
c15 = newc;
Circle(c15) = {p17,ppp2,p18};
c16 = newc;
Circle(c16) = {p18,ppp2,p15};

// Lines
l5 = newl;
//Line(l5) = {p10,p15};
l6 = newl;
//Line(l6) = {p11,p16};
l7 = newl;
//Line(l7) = {p12,p17};
l8 = newl;
//Line(l8) = {p13,p18};

// Ruled surfaces

// 0:Pi/2
llc1 = newl;
//Line Loop(llc1) = {c9,l6,-c13,-l5};
sc1 = news;
//Ruled Surface(sc1) = {llc1};

// Pi/2:Pi
llc2 = newl;
//Line Loop(llc2) = {c10,l7,-c14,-l6};
sc2 = news;
//Ruled Surface(sc2) = {llc2};

// Pi:1.5Pi
llc3 = newl;
//Line Loop(llc3) = {c11,l8,-c15,-l7};
sc3 = news;
//Ruled Surface(sc3) = {llc3};

// 1.5Pi:2Pi
llc4 = newl;
//Line Loop(llc4) = {c12,l5,-c16,-l8};
sc4 = news;
//Ruled Surface(sc4) = {llc4};

// left end - inner
ll100 = newl;
Line Loop(ll100) = {-c9,-c10,-c11,-c12};
s100 = news;
Plane Surface(s100) = {ll100};

// right end - inner
ll200 = newl;
Line Loop(ll200) = {c13,c14,c15,c16};
s200 = news;
Plane Surface(s200) = {ll200}; 

// left end - ring
ll101 = newl;
Line Loop(ll101) = {-c4,-c3,-c2,-c1,-c9,-c10,-c11,-c12};
s101 = news;
Plane Surface(s101) = {ll101};

// right end - ring
ll201 = newl;
Line Loop(ll201) = {c5,c6,c7,c8,c13,c14,c15,c16};
s201 = news;
Plane Surface(s201) = {ll201}; 

*/ // End wrap


// --- LATERAL PERIODIC SURFACES MESHING s1 - Master :: s2 - Slave

Periodic Surface s1 {c1,c2,c3,c4} = s2 {c5,c6,c7,c8}; // default
//Periodic Surface s101 {c1,c2,c3,c4,c9,c10,c11,c12} = s201 {c5,c6,c7,c8,c13,c14,c15,c16}; // annulus
//Periodic Surface s100 {c9,c10,c11,c12} = s200 {c13,c14,c15,c16}; // inner


// 5. PHYSICAL SURFACES

// Wall's surfaces
Physical Surface("wallNoSlip") = {s1,s2,s3,s4,s5,s6};
//Physical Surface("wallNoSlip") = {s100,s101,s200,s201,s3,s4,s5,s6};
//Physical Surface("wallLeft") = {s100,s101};
//Physical Surface("wallRight") = {s200,s201};

// Bubbles' surfaces mounted according Printf of the loop
Physical Surface("bubble1") = {22,24,26,28};
//Physical Surface("bubble2") = {38,40,42,44};
//Physical Surface("bubble3") = {54,56,58,60};
//Physical Surface("bubble4") = {70,72,74,76};
//Physical Surface("bubble5") = {86,88,90,92};
//Physical Surface("bubble6") = {102,104,106,108};

