/* File: single-phase-periodic-bc-channel-2d-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: July 19th, 2013
 * Description: Generates a 2D channel with lateral periodicity
 *     and array of nb internal Taylor bubbles separated by slug. 
 *
 */

/*
 *
 *       o--------------------------------------------------------------o
 *       |    								    |
 *       +    _   b================b        b=================b         +
 *       |    |   |                 \       |                  \        |
 *       +    |   |                  \      |                   \       +
 *       |   DV   |       B1       r--c     |       B2       r--c . . . |
 *       +    |   |                  /      |                   /       +
 *       |    |   |                 /       |                  /        |
 *       +    _   b================b        b=================b         +
 *       |                                  				    |
 *       .-- g ---|------ DH ------|  |- s -|                           .
 *       .	                    |  |                                 .
 *       .                 rCap -->|--|				    .
 *       |								    |
 *       o--------------------------------------------------------------o
 *
 */



/* 0. INITIAL SETTINGS */

// --- Refinement
bubble = 0.06;
wallPeriodic = 0.1; 

// --- Boundary Geometry
xMin = 0; // begin of channel
Printf("Begin of the Channel: x = %g", xMin);
yMin = 0;
zMin = 0;
yMax = 1; // width of channel
zMax = 0;

ny = 16; // number of points "y" in between the channel 
Printf("Periodic Points = %g", ny);

Width = yMax - yMin; // channel width
Printf("Width of Channel: %g", Width);
D = Width; // channel diameter (reset)

/* 1. BUBBLE PARAMETERS */

// --- Film thickness initialisation 1 (Arbitrary)

//zeta = 5/6; // "void fraction" parameter
//DV = zeta*D; // bubble diameter
//Printf("Bubble Vertical Diameter: %g", DV);
//alpha = 0.0; // film ratio
//deltaL = (1 + alpha)*( D - DV )/2; // upper film width

// --- Film thickness initialisation 2 (Bretherton's correlation)

muL = 1.002E-3; // water viscosity
Printf("Liquid viscosity: %g", muL);
uL = 0.2927; // liquid velocity
Printf("Liquid velocity: %g", uL);
sigma = 0.0072; // sigma
Printf("Surface tension: %g", sigma);
Ca = muL*uL/sigma; // Capillary number
Printf("Capillary number: %g", Ca);
breth = (D/2)*1.34*Ca^(2/3); // Bretherton's correlation
deltaL = breth; // film thickness
Printf("Film thickness: %g", deltaL);
DV = D - 2*deltaL; // bubble vertical diameter
Printf("Bubble Vertical Diameter: %g", DV);

// --- Further parameters

rCap = DV/2; // bubble cap radius
B = 3*rCap; // body length
DH = B + rCap; 
Printf("Bubble Horizontal Length: %g", DH);
s = DH/2; // slug length 
g = s; // distance from inlet and outlet 
Printf("Slug Length: %g", s);

// --- Array formation

nb = 3; // number of bubbles
LM = nb*DH + (nb - 1)*s - 2*g; // elongated bubbles region 
L = LM + 2*g + 2*s; // channel length

// For Unique bubble, equal spacing 
If (nb == 1) 
L = 2*g + DH;
Printf("Length: %g", L);
EndIf

xMax = L; // end of channel (reset)
Printf("Channel Length: %g", xMax);


/* 2. PERIODIC WALLS */

p1 = newp;
Point(p1) = {xMin,yMin,zMin,wallPeriodic};

DeltaY = Width/(ny - 1); // discretization "y" center

// --- Building 1D uniform mesh

For y3 In {1:(ny - 1)}
pp3 = newp;
Point(pp3) = {xMin,yMin + DeltaY * y3 ,zMin,wallPeriodic};
//Translate {xMax,0,0}{ Duplicata {Point{pp3};} }
NodeCoord[y3] = pp3;
EndFor

// --- Building lines 

For i In {1:ny - 1}
ll = newl;
Line(ll) = {i,i+1};
Translate {xMax,0,0}{ Duplicata {Line{ll};} }
EndFor

ll2 = newl;
Line(ll2) = {1,ny + 1};
Translate {0,Width,0}{ Duplicata {Line{ll2};} }

//Periodic Line {ll} = {ll2};

/* 3. INTERNAL DOMAIN - BUBBLES */

// Origin
x0 = xMin;
y0 = yMin;
z0 = zMin;

For i In {1:nb}

// bubble body
pp11 = newp;
Point(pp11) = {x0 + g + (i - 1)*(DH + s), y0 + deltaL, z0, bubble};
pp12 = newp;
Point(pp12) = {x0 + g + B + (i - 1)*(DH + s), y0 + deltaL, z0, bubble};
pp13 = newp;
Point(pp13) = {x0 + g + B + (i - 1)*(DH + s), y0 + deltaL + DV, z0, bubble};
pp14 = newp;
Point(pp14) = {x0 + g + (i - 1)*(DH + s), y0 + deltaL + DV, z0, bubble};

// bubble cap
pp15 = newp;
Point(pp15) = {x0 + g + B + (i - 1)*(DH + s), y0 + deltaL + rCap, z0, bubble};
pp16 = newp;
Point(pp16) = {x0 + g + DH + (i - 1)*(DH + s), y0 + deltaL + rCap, z0, bubble};

ll1 = newl;
Line(ll1) = {pp11,pp12};
cc1 = newc;
Circle(cc1) = {pp12,pp15,pp16};
cc2 = newc;
Circle(cc2) = {pp16,pp15,pp13};
ll2 = newl;
Line(ll2) = {pp13,pp14};
ll3 = newl;
Line(ll3) = {pp14,pp11};

EndFor

/* 4. Physical Groups */
// OBS: ENTITIES BELOW NEED TO BE UPDATED MANUALLY BEFORE CREATING NEW MESHES --- 

//Physical Line('wallInflowZeroU') = {31,32};
Physical Line('wallMovingInf') = {31};
Physical Line('wallMovingSup') = {32};
Physical Line('wallL') = {1,3,5,7,9,11,13,15,17,19,21,23,25,27,29};
Physical Line('wallR') = {30,28,26,24,22,20,18,16,14,12,10,8,6,4,2};
Physical Line('bubble1') = {33,34,35,36,37};
Physical Line('bubble2') = {38,39,40,41,42};
Physical Line('bubble3') = {43,44,45,46,47};

Transfinite Line {31, 32} = 400 Using Bump 1;

