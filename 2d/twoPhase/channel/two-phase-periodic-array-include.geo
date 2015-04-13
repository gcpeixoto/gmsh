/* File: single-phase-periodic-bc-channel-2d-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: August 13th, 2013
 * Description: Generates a 2D channel with lateral periodicity
 *     and include capability for internal bubbles.
 */


/* INITIAL SETTINGS */

// --- Refinement

b = 0.4;
w = 0.1; 

// --- top and bottom walls intermediary points (local refinement); 0: for 'not', 1: for 'yes'

intermed = 0; 

// --- Boundary Geometry

xMin = 0; // begin of channel
yMin = -0.5;
zMin = 0;
yMax = 0.5; // width of channel
zMax = 0;

ny = 15; // number of points "y"
Width = yMax - yMin; // channel width
Printf("Width of Channel: x = %g", Width);
D = Width;

nb = 1; // number of bubbles
j = 3; // field counter

For i In {1:nb}

/* 0. INCLUDE (full path to '.geo' file) */

xc = xMin + 1.1*D; // constant 1.1 only to centralize the unique bubble in the channel.
yc = 0;
zc = zMin;

Include "/Users/gustavo/meshes/2d/bubble-shapes/2d-sepideh-bubble.geo";

// --- Parameters of distance
DH = rt + LB + rn; // horizontal bubble diameter 
g = DH/2; // distance from inlet and outlet 
s = DH/2; // slug length

// --- Parameters of array 
LM = nb*DH + (nb - 1)*s - 2*g; // elongated bubbles region 
L = LM + 2*g + 2*s; // channel length

// For Unique bubble, equal spacing 
If (nb == 1) 
L = 2*g + DH;
Printf("Length: %g", L);
EndIf

xMax = L; // end of channel (reset)
Printf("End of the Channel: x = %g", xMax);


/* 1. PERIODIC WALLS */

// --- Building 1D uniform mesh

DeltaY = Width/(ny - 1); // discretization "y"

For y3 In {0:(ny - 1)}
pc3 = newp;
Point(pc3) = {xMin,yMin + DeltaY * y3 ,zMin,w};
Translate {xMax,0,0}{ Duplicata {Point{pc3};} }
NodeCoord[y3] = pc3;
EndFor

// --- Building lines

m = NodeCoord[0]; // first index after the bubble insertion
Printf("m: %g",m);
n = m + 2*(ny - 1) - 1;
Printf("n: %g",n);

i = 0;
For k In {m:n}
lc1 = newl;
Line(lc1) = {k,k+2};
indxLines[i] = lc1;
i+=1; 
EndFor

// --- Strategy to impose local refinement over the bubbles. Not so good… 

If (intermed == 1)
// Intermediary points 

pb1 = newp;
Point(pb1) = {xc - rt,yMin,zMin,w};
pb2 = newp;
Point(pb2) = {xc - rt + DH,yMin,zMin,w};

lc21 = newl;
Line(lc21) = {m,pb1};
lc22 = newl;
Line(lc22) = {pb1,pb2};
lc23 = newl;
Line(lc23) = {pb2,m+1};

Translate {0,Width,0}{ Duplicata {Line{lc21};} }
lc31 = lc23 + 1;
Translate {0,Width,0}{ Duplicata {Line{lc22};} }
lc32 = lc31 + 1;
Translate {0,Width,0}{ Duplicata {Line{lc23};} }
lc33 = lc32 + 1;

EndIf


// --- Without intermediary points
lc2 = newl;
Line(lc2) = {m,m+1};
Translate {0,Width,0}{ Duplicata {Line{lc2};} }
lc3 = lc2 + 1;

/* 2. REFINEMENT */

// Transfinite 
//np = 800;
//Transfinite Line {lc2,lc3} = np Using Bump 1; 
//np = 200;
//Transfinite Line {lc22,lc32} = np Using Bump 1; 
//np2 = 100;
//Transfinite Line {lc21,lc23,lc31,lc33} = np2 Using Bump 1; 


// --- Local Refinement by Fields (inside bubble file)

// Final result
Field[j+2] = Min; // Take the minimum value of the list of fields 'FieldsList'
Field[j+2].FieldsList = {j+1};
Background Field = j+2;

j*=i+1; // add field number each 3


/* 3. PHYSICAL GROUPS */

Physical Line("wallP") = {indxLines[0]:indxLines[i-1]};

EndFor

If (intermed == 1)
Physical Line("wallMoving") = {lc21,lc22,lc23,lc31,lc32,lc33}; // with intermediary points
EndIf

If (intermed == 0)
Physical Line("wallMoving") = {lc2,lc3};
EndIf

Physical Line("bubble1") = {c1,c2,l2,c3,c4,-l1};

// END FILE

/* meshing test */
//LL1 = newll;
//Line Loop(LL1) = {c1,c2,l2,c3,c4,-l1};
//S1 = news;
//Plane Surface(S1) = {LL1};

