/* File: periodic-cylindrical-3d-include.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: August 13th, 2013
 * Description: Generates a 3D channel with lateral periodicity
 *     and include capability for Taylor bubbles. 
 */

// --- Refinement
b = 0.1; // bubble
w = 0.3; // wall

// --- Origin (center of biggest bubble's circumference)
xc = 0; 
yc = 0;
zc = 0;

// --- Channel Parameters
r1 = 0.5; // channel radius
D = 2*r1; // channel diameter

nb = 1; // number of bubbles
j = 3; // field counter

For i In {1:nb}

/* 0. INCLUDE (full path to '.geo' file) */

Include "/Users/gustavo/meshes/3d/bubble-shapes/3d-sepideh-bubble.geo";

// --- Parameters of distance
DH = rt + LB + rn; // horizontal bubble diameter 
g = DH/2; // distance from inlet and outlet 
s = DH/2; // slug length

// --- Parameters of array 
LM = nb*DH + (nb - 1)*s - 2*g; // elongated bubbles region 
L = LM + 2*g + 1.5*s; // channel length

// For Unique bubble, equal spacing 
If (nb == 1) 
L = 2*g + DH;
Printf("Length: %g", L);
EndIf

If (nb != 1)
Printf("Length: %g", L);
EndIf

//EndFor


/* 1. PERIODIC SURFACES */

// left end
pp1 = newp;
Point(pp1) = {xc - rt - g,yc,zc,w}; // center
pp2 = newp;
Point(pp2) = {xc - rt - g,yc,zc - r1,w}; 
pp3 = newp;
Point(pp3) = {xc - rt - g,yc + r1,zc,w}; 
pp4 = newp;
Point(pp4) = {xc - rt - g,yc,zc + r1,w};
pp5 = newp;
Point(pp5) = {xc - rt - g,yc - r1,zc,w};

// right end
pp6 = newp;
Point(pp6) = {xc - rt - g + L,yc,zc,w}; // center
pp7 = newp;
Point(pp7) = {xc - rt - g + L,yc,zc - r1,w}; 
pp8 = newp;
Point(pp8) = {xc - rt - g + L,yc + r1,zc,w}; 
pp9 = newp;
Point(pp9) = {xc - rt - g + L,yc,zc + r1,w};
pp10 = newp;
Point(pp10) = {xc - rt - g + L,yc - r1,zc,w};

/* --- BUILDING CIRCLES --- */
// left end
cc1 = newc;
Circle(cc1) = {pp2,pp1,pp3};
cc2 = newc;
Circle(cc2) = {pp3,pp1,pp4};
cc3 = newc;
Circle(cc3) = {pp4,pp1,pp5};
cc4 = newc;
Circle(cc4) = {pp5,pp1,pp2};

// right end
cc5 = newc;
Circle(cc5) = {pp7,pp6,pp8};
cc6 = newc;
Circle(cc6) = {pp8,pp6,pp9};
cc7 = newc;
Circle(cc7) = {pp9,pp6,pp10};
cc8 = newc;
Circle(cc8) = {pp10,pp6,pp7};

/* --- BUILDING EXTERNAL LINES --- */

lc1 = newl;
Line(lc1) = {pp2,pp7};
lc2 = newl;
Line(lc2) = {pp3,pp8};
lc3 = newl;
Line(lc3) = {pp4,pp9};
lc4 = newl;
Line(lc4) = {pp5,pp10};

/* --- DISCRETIZATION (THETA) CIRCLES --- */
nt = 10; // number of theta points per semi-semi circle (total around circle is 4*nt) 
Transfinite Line{cc1,cc2,cc3,cc4,cc5,cc6,cc7,cc8} = nt Using Bump 1;


/* 4. BUILDING EXTERNAL SURFACES  */

// left end
ll15 = newl;
Line Loop(ll15) = {-cc4,-cc3,-cc2,-cc1};
sc1 = news;
Plane Surface(sc1) = {ll15};

// right end
ll16 = newl;
Line Loop(ll16) = {cc5,cc6,cc7,cc8};
sc2 = news;
Plane Surface(sc2) = {ll16};

/* --- LATERAL PERIODIC SURFACES MESHING--- */

// sc1 - Master :: sc2 - Slave
Periodic Surface sc1 {cc1,cc2,cc3,cc4} = sc2 {cc5,cc6,cc7,cc8};

// channel's surfaces

// Pi/2
ll17 = newl;
Line Loop(ll17) = {-lc1,cc1,lc2,-cc5};
sc3 = news;
Ruled Surface(sc3) = {ll17};

// Pi
ll18 = newl;
Line Loop(ll18) = {-lc2,cc2,lc3,-cc6};
sc4 = news;
Ruled Surface(sc4) = {ll18};

// 3*Pi/2
ll19 = newl;
Line Loop(ll19) = {-lc3,cc3,lc4,-cc7};
sc5 = news;
Ruled Surface(sc5) = {ll19};

// 2*Pi
ll20 = newl;
Line Loop(ll20) = {-lc4,cc4,lc1,-cc8};
sc6 = news;
Ruled Surface(sc6) = {ll20};


// Local Refinement by Fields (inside bubble file)

// Final result
Field[j+2] = Min;
Field[j+2].FieldsList = {j+1};
Background Field = j+2;

j*=i+1; // add field number each 3

EndFor

/* 5. PHYSICAL SURFACES */

// Wall's surfaces
Physical Surface("wallMoving") = {sc3,sc4,sc5,sc6};
Physical Surface("wallP") = {sc1,sc2};

Physical Surface("bubble1") = {s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12};
//Physical Surface(Sprintf("bubble%g",i)) = {s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12};

