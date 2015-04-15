// file: poiseuillePBC.geo
// author: Gustavo Charles P. de Oliveira
// date: Apr 08th, 2013
// description: Generates a 2D channel with lateral periodicity.

// -- PARAMETERS --

CharLength = 0.1; // characteristic length

xMin = 0; // begin of channel
yMin = 0;
zMin = 0;

xMax = 2; // end of channel
Printf("channel length: %g", xMax);
yMax = 1; // width of channel
Printf("channel width: %g", yMax);
zMax = 0;

p1 = newp;
Point(p1) = {xMin,yMin,zMin,CharLength};

nyCenter = 12; // number of points "y" in between the channel
Printf("periodic points: %g", nyCenter);

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

/* --- ENTITIES BELOW NEED TO BE CREATED INTERACTIVELY --- */
Physical Line("wallNoSlip") = {ll2,ll3};
//Physical Line("wallMovingInf") = {ll2};
//Physical Line("wallMovingSup") = {ll3};
Physical Line("wallLeft") = {1,3,5,7,9,11,13,15,17,19,21};
Physical Line("wallRight") = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};

