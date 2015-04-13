/* File: two-phase-periodic-cylindrical-3d-stratified-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * Created on December 5th, 2013
 * e-mail: tavolesliv@gmail.com
 *
 * Description: it builds setup for stratified flow with adjustable geometry and
 *	        periodic meshing.	
 *		
 *
 *                  
 *                       ------
 *              gas     /      \     
 *                     o________o     _  <--- interface
 *                    /          \    | 
 *           liquid   \          /    | h        z  x
 *                     \___ o___/     _          | /
 *                                               |/__ y
 */

//* PARAMETERS        
        
//** Char. lengths

bUp = 0.3;  
bDown = 0.1;

//** Origin

xMin = 0;
yMin = 0;
zMin = 0;

//* User input
r = 0.5; // radius
h = 0.65; // height of stratification
D = 2*r; // diameter
L = 1*D; // length 

c = Sqrt( h*(D - h) ); // length of the half-chord

//** Checking

Printf("Diameter = %f",D);
Printf("Stratification height= %f",h);
If ( h <= 0 || h >= D )  
Error("Error: height %f of stratification is invalid.",h);
EndIf

//* POINTS

//** xMin

P1 = newp;
Point(P1) = {xMin, yMin, zMin, bDown};
P2 = newp;
Point(P2) = {xMin, yMin, zMin - r, bDown};
P3 = newp;
Point(P3) = {xMin, yMin - c, zMin - r + h, bDown};
P4 = newp;
Point(P4) = {xMin, yMin, zMin + r, bUp};
P5 = newp;
Point(P5) = {xMin, yMin + c, zMin - r + h, bDown};

//** xMax

P6 = newp;
Point(P6) = {xMin + L, yMin, zMin, bDown};
P7 = newp;
Point(P7) = {xMin + L, yMin, zMin - r, bDown};
P8 = newp;
Point(P8) = {xMin + L, yMin - c, zMin - r + h, bDown};
P9 = newp;
Point(P9) = {xMin + L, yMin, zMin + r, bUp};
P10 = newp;
Point(P10) = {xMin + L, yMin + c, zMin - r + h, bDown};

//* ARCS

//** face xMin

C1 = newc;
Circle(C1) = {P2,P1,P3};
C2 = newc;
Circle(C2) = {P3,P1,P4};
C3 = newc;
Circle(C3) = {P4,P1,P5};
C4 = newc;
Circle(C4) = {P5,P1,P2};

//** face xMax

C5 = newc;
Circle(C5) = {P7,P6,P8};
C6 = newc;
Circle(C6) = {P8,P6,P9};
C7 = newc;
Circle(C7) = {P9,P6,P10};
C8 = newc;
Circle(C8) = {P10,P6,P7};

//* LINES

L1 = newc;
Line(L1) = {P2,P7};  // down
L2 = newc;
Line(L2) = {P3,P8};  // yMin edge
L3 = newc;
Line(L3) = {P5,P10}; // yMax edge
L4 = newc;
Line(L4) = {P4,P9};  // up
L5 = newc;
Line(L5) = {P3,P5};  // chord xMin 
L6 = newc;
Line(L6) = {P8,P10}; // chord xMax 

//* SURFACES

//** liquid region

//*** face xMin
LL1 = newc;
Line Loop(LL1) = {C1,L5,C4};
S1 = news;
Plane Surface(S1) = {LL1};

//*** face xMax
LL2 = newc;
Line Loop(LL2) = {C5,L6,C8};
S2 = news;
Plane Surface(S2) = {LL2};

//*** yMin border
LL3 = newc;
Line Loop(LL3) = {L1,C5,-L2,-C1};
S3 = news;
Ruled Surface(S3) = {LL3};

//*** yMax border
LL4 = newc;
Line Loop(LL4) = {L1,C4,-L3,-C8};
S4 = news;
Ruled Surface(S4) = {LL4};

//*** plane of interface
LL5 = newc;
Line Loop(LL5) = {L2,L6,-L3,-L5};
S5 = news;
Plane Surface(S5) = {LL5};

//** gas region

//*** face xMin
LL6 = newc;
Line Loop(LL6) = {C2,C3,-L5};
S6 = news;
Plane Surface(S6) = {LL6};

//*** face xMax
LL7 = newc;
Line Loop(LL7) = {C6,C7,-L6};
S7 = news;
Plane Surface(S7) = {LL7};

//*** yMin border
LL8 = newc;
Line Loop(LL8) = {L2,C6,-L4,-C2};
S8 = news;
Ruled Surface(S8) = {LL8};

//*** yMax border
LL9 = newc;
Line Loop(LL9) = {L4,C7,-L3,-C3};
S9 = news;
Ruled Surface(S9) = {LL9};

//* PERIODICITY

//** xMin,xMax faces: liquid
Periodic Surface S1 {C1,L5,C4} = S2 {C5,L6,C8};

//** xMin,xMax faces: gas
Periodic Surface S6 {C2,C3,-L5} = S7 {C6,C7,-L6};

//* ADAPTIVE REFINEMENT

//** transfinite mesh

//*** xMin,xMax interface line 

//npix = 10; // number of points
//npixs = bDown/2; // local refinement
//Transfinite Line{L5,L6} = npix Using Bump npixs;

//*** xMin,xMax interface surface 
// Tranfinite args: Left, Right, Alternate
//Transfinite Surface {S1,S2} Right;
//Transfinite Surface {S6,S7} Right;

//* PHYSICAL GROUPS 

Physical Surface("wallMoving") = {S8,S9};
Physical Surface("wallP") = {S6,S7};
Physical Surface("bubble1") = {S1,S2,S3,S4,S5};

