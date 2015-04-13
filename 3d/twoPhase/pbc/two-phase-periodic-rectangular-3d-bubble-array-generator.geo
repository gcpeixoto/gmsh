/* File: periodic-rectangular-3d-bubble-array-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: July 25th, 2013
 * Description: Generates a 3D channel with lateral periodicity
 *     and array of nb internal Taylor bubbles separated by slug. 
 */

// --- Refinement
bubble = 0.05;
wallPeriodic = 0.08; 

// --- Boundary Geometry
xMin = 0; // begin of channel
Printf("Begin of the Channel: x = %g", xMin);
yMin = 0;
zMin = 0;

r1 = 0.5; // channel semi-diameter

// --- Bubble Parameters

D = 2*r1; // channel diameter
zeta = 3/4; // "void fraction" parameter
DV = zeta*D; // bubble diameter
rCap = DV/2; // bubble (cap) radius
alpha = 0.2; // film ratio
deltaL = (1 + alpha)*( D - DV )/2; // upper film width
B = 4*rCap; // body length
DH = B + rCap; 
g = DH/2; // distance from inlet and outlet 
s = DH/2; // slug length

nb = 3; // number of bubbles

LM = nb*DH + (nb - 1)*s - 2*g; // elongated bubbles region 
L = LM + 2*g + 2*s; // channel length

// For Unique bubble, equal spacing 
If (nb == 1) 
L = 2*g + DH;
Printf("Length: %g", L);
EndIf

xMax = L; // end of channel (reset)
Printf("End of the Channel: x = %g", xMax);

/* 1. PERIODIC SURFACES */

// left end
p1 = newp;
//Point(p1) = {xMin,yMin,zMin,wallPeriodic}; // center
p2 = newp;
Point(p2) = {xMin,yMin + r1,zMin - r1,wallPeriodic}; 
p3 = newp;
Point(p3) = {xMin,yMin + r1,zMin + r1,wallPeriodic}; 
p4 = newp;
Point(p4) = {xMin,yMin - r1,zMin + r1,wallPeriodic};
p5 = newp;
Point(p5) = {xMin,yMin - r1,zMin - r1,wallPeriodic};

// right end
p6 = newp;
//Point(p6) = {xMin + L,yMin,zMin,wallPeriodic}; // center
p7 = newp;
Point(p7) = {xMin + L,yMin + r1,zMin - r1,wallPeriodic}; 
p8 = newp;
Point(p8) = {xMin + L,yMin + r1,zMin + r1,wallPeriodic}; 
p9 = newp;
Point(p9) = {xMin + L,yMin - r1,zMin + r1,wallPeriodic};
p10 = newp;
Point(p10) = {xMin + L,yMin - r1,zMin - r1,wallPeriodic};

/* --- BUILDING LINES --- */
// left end
c1 = newc;
Line(c1) = {p2,p3};
c2 = newc;
Line(c2) = {p3,p4};
c3 = newc;
Line(c3) = {p4,p5};
c4 = newc;
Line(c4) = {p5,p2};

// right end
c5 = newc;
Line(c5) = {p7,p8};
c6 = newc;
Line(c6) = {p8,p9};
c7 = newc;
Line(c7) = {p9,p10};
c8 = newc;
Line(c8) = {p10,p7};

/* --- BUILDING EXTERNAL LINES --- */

l1 = newl;
Line(l1) = {p2,p7};
l2 = newl;
Line(l2) = {p3,p8};
l3 = newl;
Line(l3) = {p4,p9};
l4 = newl;
Line(l4) = {p5,p10};

/* --- DISCRETIZATION LINES --- */
nt = 10; // number points per segment (total around circle is 4*nt) 
Transfinite Line{c1,c2,c3,c4,c5,c6,c7,c8} = nt Using Bump 1;

/* 2. INTERNAL DOMAIN - BUBBLES */

// Origin
x0 = xMin;
y0 = yMin;
z0 = zMin;

For i In {1:nb} // BEGIN LOOP
// --- Bubble body
// left end
pp11 = newp;
Point(pp11) = {x0 + g + (i - 1)*(DH + s), y0, z0, bubble};
pp12 = newp;
Point(pp12) = {x0 + g + (i - 1)*(DH + s), y0, z0 - rCap, bubble};
pp13 = newp;
Point(pp13) = {x0 + g + (i - 1)*(DH + s), y0 + rCap, z0, bubble};
pp14 = newp;
Point(pp14) = {x0 + g + (i - 1)*(DH + s), y0, z0 + rCap, bubble};
pp15 = newp;
Point(pp15) = {x0 + g + (i - 1)*(DH + s), y0 - rCap, z0, bubble};

// right end
pp16 = newp;
Point(pp16) = {x0 + g + B + (i - 1)*(DH + s), y0, z0, bubble};
pp17 = newp;
Point(pp17) = {x0 + g + B + (i - 1)*(DH + s), y0, z0 - rCap, bubble};
pp18 = newp;
Point(pp18) = {x0 + g + B + (i - 1)*(DH + s), y0 + rCap, z0, bubble};
pp19 = newp;
Point(pp19) = {x0 + g + B + (i - 1)*(DH + s), y0, z0 + rCap, bubble};
pp20 = newp;
Point(pp20) = {x0 + g + B + (i - 1)*(DH + s), y0 - rCap, z0, bubble};

// bubble cap
pp21 = newp;
Point(pp21) = {x0 + g + B + (i - 1)*(DH + s) + rCap, y0, z0, bubble};


/* --- BUILDING CIRCLES --- */
// left end
cc11 = newc;
Circle(cc11) = {pp12,pp11,pp13};
cc12 = newc;
Circle(cc12) = {pp13,pp11,pp14};
cc13 = newc;
Circle(cc13) = {pp14,pp11,pp15};
cc14 = newc;
Circle(cc14) = {pp15,pp11,pp12};

// right end
cc15 = newc;
Circle(cc15) = {pp17,pp16,pp18};
cc16 = newc;
Circle(cc16) = {pp18,pp16,pp19};
cc17 = newc;
Circle(cc17) = {pp19,pp16,pp20};
cc18 = newc;
Circle(cc18) = {pp20,pp16,pp17};

// cap
cc19 = newc;
Circle(cc19) = {pp17,pp16,pp21};
cc20 = newc;
Circle(cc20) = {pp18,pp16,pp21};
cc21 = newc;
Circle(cc21) = {pp19,pp16,pp21};
cc22 = newc;
Circle(cc22) = {pp20,pp16,pp21};

/* --- DISCRETIZATION (THETA) CIRCLES --- */
nt2 = 15; // number of theta points per semi-semi circle (total around circle is 4*nt) 
Transfinite Line{cc11,cc12,cc13,cc14,cc15,cc16,cc17,cc18} = nt2 Using Bump 1;

/* --- BUILDING INTERNAL LINES --- */

ll11 = newl;
Line(ll11) = {pp12,pp17};
ll12 = newl;
Line(ll12) = {pp13,pp18};
ll13 = newl;
Line(ll13) = {pp14,pp19};
ll14 = newl;
Line(ll14) = {pp15,pp20};


/* 3. BUILDING BUBBLES' SURFACES  */

// -- left end
lb1 = newl;
Line Loop(lb1) = {-cc14,-cc13,-cc12,-cc11};
sb1 = news;
Plane Surface(sb1) = {lb1};

// -- cap
// Pi/2
lb21 = newl;
Line Loop(lb21) = {cc15,cc20,-cc19};
sb21 = news;
Ruled Surface(sb21) = {lb21};

// Pi
lb22 = newl;
Line Loop(lb22) = {cc16,cc21,-cc20};
sb22 = news;
Ruled Surface(sb22) = {lb22};

// 3*Pi/2
lb23 = newl;
Line Loop(lb23) = {cc17,cc22,-cc21};
sb23 = news;
Ruled Surface(sb23) = {lb23};

// 2*Pi
lb24 = newl;
Line Loop(lb24) = {cc18,cc19,-cc22};
sb24 = news;
Ruled Surface(sb24) = {lb24};

// -- body
// Pi/2
lb25 = newl;
Line Loop(lb25) = {-ll11,cc11,ll12,-cc15};
sb25 = news;
Ruled Surface(sb25) = {lb25};

// Pi
lb26 = newl;
Line Loop(lb26) = {-ll12,cc12,ll13,-cc16};
sb26 = news;
Ruled Surface(sb26) = {lb26};

// 3*Pi/2
lb27 = newl;
Line Loop(lb27) = {ll14,-cc17,-ll13,cc13};
sb27 = news;
Ruled Surface(sb27) = {lb27};

// 2*Pi
lb28 = newl;
Line Loop(lb28) = {ll11,-cc18,-ll14,cc14};
sb28 = news;
Ruled Surface(sb28) = {lb28};

// --- Physical Surfaces for bubbles

/* Temporary Printf to know the geometrical elements of boundary in order to 
 * create the physical groups (surfaces). */   
Printf("Physical Surface Bubble: %f",i);
Printf("Bubble's end surface = %f",lb1);
Printf("Bubble's body surface - Pi/2 = %f",lb21);
Printf("Bubble's body surface - Pi = %f",lb22);
Printf("Bubble's body surface - 3*Pi/2 = %f",lb23);
Printf("Bubble's body surface - 2*Pi = %f",lb24);
Printf("Bubble's cap ruled surface - Pi/2 = %f",lb25);
Printf("Bubble's cap ruled surface - Pi = %f",lb26);
Printf("Bubble's cap ruled surface - 3*Pi/2 = %f",lb27);
Printf("Bubble's cap ruled surface - 2*Pi = %f",lb28);

EndFor // END LOOP

/* 4. BUILDING EXTERNAL SURFACES  */

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

/* --- LATERAL PERIODIC SURFACES MESHING--- */

// s1 - Master :: s2 - Slave
Periodic Surface s1 {c1,c2,c3,c4} = s2 {c5,c6,c7,c8};

// channel's surfaces

// Pi/2
ll17 = newl;
Line Loop(ll17) = {-l1,c1,l2,-c5};
s3 = news;
Ruled Surface(s3) = {ll17};

// Pi
ll18 = newl;
Line Loop(ll18) = {-l2,c2,l3,-c6};
s4 = news;
Ruled Surface(s4) = {ll18};

// 3*Pi/2
ll19 = newl;
Line Loop(ll19) = {-l3,c3,l4,-c7};
s5 = news;
Ruled Surface(s5) = {ll19};

// 2*Pi
ll20 = newl;
Line Loop(ll20) = {-l4,c4,l1,-c8};
s6 = news;
Ruled Surface(s6) = {ll20};


/* 5. PHYSICAL SURFACES */

// Wall's surfaces
Physical Surface("wallMoving") = {s3,s4,s5,s6};
Physical Surface("wallP") = {s1,s2};

// Bubbles' surfaces mounted according Printf of the loop
Physical Surface("bubble1") = {42, 44, 34, 36, 30, 46, 38, 40, 32};
Physical Surface("bubble2") = {74, 80, 66, 72, 68, 76, 64, 78, 70};
Physical Surface("bubble3") = {98, 100, 102, 104, 106, 108, 110, 112, 114};
