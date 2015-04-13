/* File: sample-periodic-surface-thesis-.geo
 * Author: Peixoto de Oliveira, Gustavo
 * Date: December 31st, 2013
 * Description: Generates a 3D channel with periodicity
 *     and array of nb equally-spaced spherical bubbles. 
 */

// Characteristic Lengths
b = 0.08; // bubbles
wp = 0.2;  // walls

// Boundary Geometry
xMin = 0; 
yMin = 0;
zMin = 0;

r1 = 1;   // radius
D = 2*r1; // diameter

// Bubble Parameters
DB = 1;    // bubble diameter
rb = DB/2; // bubble radius

g = rb;  // gap length
s = 2*g; // slug length

nb = 3; // number of bubbles
LM = nb*DB + (nb - 1)*s; // bubble array
L = LM + 2*g; // channel length

// 1. PERIODIC SURFACES

// left end
p1 = newp;
Point(p1) = {xMin,yMin,zMin,wp}; // center
p2 = newp;
Point(p2) = {xMin,yMin,zMin - r1,wp}; 
p3 = newp;
Point(p3) = {xMin,yMin + r1,zMin,wp}; 
p4 = newp;
Point(p4) = {xMin,yMin,zMin + r1,wp};
p5 = newp;
Point(p5) = {xMin,yMin - r1,zMin,wp};

// right end
p6 = newp;
Point(p6) = {xMin + L,yMin,zMin,wp}; // center
p7 = newp;
Point(p7) = {xMin + L,yMin,zMin - r1,wp}; 
p8 = newp;
Point(p8) = {xMin + L,yMin + r1,zMin,wp}; 
p9 = newp;
Point(p9) = {xMin + L,yMin,zMin + r1,wp};
p10 = newp;
Point(p10) = {xMin + L,yMin - r1,zMin,wp};

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
z0 = zMin;

For i In {1:nb} // BEGIN LOOP

// --- spherical bubble points

pp9 = newp;
Point(pp9) = {x0 + g + rb + (i - 1)*(DB + s), y0, z0, b};
pp10 = newp;
Point(pp10) = {x0 + g + rb + (i - 1)*(DB + s), y0, z0 - rb, b};
pp11 = newp;
Point(pp11) = {x0 + g + rb + (i - 1)*(DB + s), y0 + rb, z0, b};
pp12 = newp;
Point(pp12) = {x0 + g + rb + (i - 1)*(DB + s), y0, z0 + rb, b};
pp13 = newp;
Point(pp13) = {x0 + g + rb + (i - 1)*(DB + s), y0 - rb, z0, b};
pp14 = newp;
Point(pp14) = {x0 + g + (i - 1)*(DB + s), y0, z0, b};
pp15 = newp;
Point(pp15) = {x0 + g + DB + (i - 1)*(DB + s), y0, z0, b};

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
// reference: central axis is X-positive and theta counterclockwise

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

Printf("Generating dispersed body %g…",i);  

Printf("Data bubble: %g",i);  
Printf("Bubble's ruled surface - 0:Pi/2 = %g",sb21);
Printf("Bubble's ruled surface - Pi/2:Pi = %g",sb22);
Printf("Bubble's ruled surface - Pi:1.5*Pi = %g",sb23);
Printf("Bubble's ruled surface - 1.5*Pi:2*Pi = %g",sb24);

// DISPERSED PHYSICAL SURFACES
//Physical Surface(Sprintf("dispersed%g",i)) = {sb21,sb22,sb23,sb24};

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

ll17 = newl;
Line Loop(ll17) = {-l1,c1,l2,-c5};
s3 = news;
Ruled Surface(s3) = {ll17};

ll18 = newl;
Line Loop(ll18) = {-l2,c2,l3,-c6};
s4 = news;
Ruled Surface(s4) = {ll18};

ll19 = newl;
Line Loop(ll19) = {-l3,c3,l4,-c7};
s5 = news;
Ruled Surface(s5) = {ll19};

ll20 = newl;
Line Loop(ll20) = {-l4,c4,l1,-c8};
s6 = news;
Ruled Surface(s6) = {ll20};

// --- PERIODIC SURFACES MESHING s1 - Master :: s2 - Slave 

Periodic Surface s1 {c1,c2,c3,c4} = s2 {c5,c6,c7,c8};

// 5. BOUNDARY PHYSICAL SURFACES

//Physical Surface("PeriodicLeftBoundary") = {s1};
//Physical Surface("PeriodicRightBoundary") = {s2};
//Physical Surface("NoSlipBoundary") = {s3,s4,s5,s6};
Physical Surface("wallLeft") = {s1};
Physical Surface("wallRight") = {s2};
Physical Surface("wallNoSlip") = {s3,s4,s5,s6};


For i In {1:nb}
//Physical Surface(Sprintf("dispersed%g",i)) = {sb21,sb22,sb23,sb24};
EndFor

Physical Surface("bubble1") = {22,24,26,28};
Physical Surface("bubble2") = {38,40,42,44};
Physical Surface("bubble3") = {54,56,58,60};
//Physical Surface("bubble4") = {70,72,74,76};
