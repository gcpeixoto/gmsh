// *** File: single-phase-periodic-bc-channel-2d-generator.geo
// *** Author: Gustavo Charles P. de Oliveira
// *** Date: Apr 08th, 2013
// *** Description: Generates a 2D channel with lateral periodicity.


/* --- BEGIN OF CODE --- */

// -- PARAMETERS --

CharLength = 0.1; // characteristic length

xMin = 0; // begin of channel
Printf("Begin of the Channel: x = %g", xMin);
yMin = 0;
zMin = 0;

xMax = 2; // end of channel
Printf("End of the Channel: x = %g", xMax);
yMax = 1; // width of channel
Printf("Width of Channel: x = %g", xMax);
zMax = 0;

p1 = newp;
Point(p1) = {xMin,yMin,zMin,CharLength};

nyCenter = 12; // number of points "y" in between the channel 
Printf("Discretization Points over /Gamma_2^center = %g", nyCenter);

Width = yMax - yMin;

DeltaY = Width/(nyCenter - 1); // discretization "y" center

/* --- BUILDING UNIFORM 1D MESH --- */

For y3 In {1:(nyCenter - 1)}
pp3 = newp;
Point(pp3) = {xMin,yMin + DeltaY * y3 ,zMin,CharLength};
//Translate {xMax,0,0}{ Duplicata {Point{pp3};} }
NodeCoord[y3] = pp3;
EndFor

/* --- BUILDING LINES --- */

k = 0;
For i In {1:nyCenter - 1}
ll = newl;
Line(ll) = {i,i+1};
Translate {xMax,0,0}{ Duplicata {Line{ll};} }
indxLines[k] = ll;
k+=1;
EndFor

ll2 = newl;
Line(ll2) = {1,nyCenter + 1};
Translate {0,Width,0}{ Duplicata {Line{ll2};} }
ll3 = ll2 + 1;

/*
// ******** delete after

r = 0.1;

b1 = 0.06;

// bubble's coordinates
xc = 0.5;
yc = 0.5;

// variables
i=100;
j=200;
Point(i+1) = {xc, yc, 0,b1}; // center
Point(i+2) = {xc, yc+r, 0,b1}; // up
Point(i+3) = {xc, yc-r, 0,b1}; // down
Point(i+4) = {xc-r, yc, 0,b1}; // left
Point(i+5) = {xc+r, yc, 0,b1}; // right
Ellipse(j+1) = {i+2, i+1, i+1, i+5};
Ellipse(j+2) = {i+5, i+1, i+1, i+3};
Ellipse(j+3) = {i+3, i+1, i+1, i+4};
Ellipse(j+4) = {i+4, i+1, i+1, i+2};
// ********
*/

//Transfinite Line {ll2, ll3} = 105 Using Bump 1;

/* --- ENTITIES BELOW NEED TO BE CREATED INTERACTIVELY --- */
Physical Line("wallNoSlip") = {ll2,ll3};
//Physical Line("wallMovingInf") = {ll2};
//Physical Line("wallMovingSup") = {ll3};
Physical Line("wallLeft") = {1,3,5,7,9,11,13,15,17,19,21};
Physical Line("wallRight") = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};

// ******** delete after
//j=200*0;
//t=1;
//Physical Line(Sprintf("bubble%g",t)) = {j+1, j+2, j+3, j+4};
// j=200*t;
// ********

