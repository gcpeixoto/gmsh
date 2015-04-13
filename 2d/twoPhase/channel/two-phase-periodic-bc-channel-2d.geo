// *** File: inner-outer-channel.geo
// *** Author: Gustavo Charles P. de Oliveira
// *** Date: Oct 19th, 2012
// *** Description: Channel separated by interface to simulate two-phase flows

/* --- BEGIN OF CODE --- */

// -- PARAMETERS --

CharLength = 1; // characteristic length

// ** epsilon2 > epsilon1 to work
epsilon1 = 1.2; // half-width of the inner channel 
Printf("Inner-Channel Width = %g", 2 * epsilon1);

epsilon2 = 1.5; // half-width of the outer channel
Printf("Outer-Channel Width = %g", 2* epsilon2);

xMin = 0; // begin of channel
Printf("Begin of the Channel: x = %g", xMin);

xMax = 10; // end of channel
Printf("End of the Channel: x = %g", xMax);

xc = epsilon2; // Mid-point y coordinate

/* --- LEFT 5 POINTS determining widths of the channels */

p1 = newp;
Point(p1) = {xMin,xc,CharLength};
p2 = newp;
Point(p2) = {xMin,xc + epsilon1,CharLength};
p3 = newp;
Point(p3) = {xMin,xc - epsilon1,CharLength};
p4 = newp;
Point(p4) = {xMin,xc + epsilon2,CharLength};
p5 = newp;
Point(p5) = {xMin,xc - epsilon2,CharLength};

// Duplicating to RIGHT HAND SIDE
Translate {xMax,0,0}{ Duplicata {Point{p1,p2,p3,p4,p5};} }

nyLower = 6; // number of points "y" below the inner channel
Printf("Discretization Points over /Gamma_2^bot = %g", nyLower);
nyUpper = nyLower; // number of points "y" above the inner channel
Printf("Discretization Points over /Gamma_2^top = %g", nyUpper);
nyCenter = 9; // number of points "y" in between the inner channel - Choose an "ODD" number!
Printf("Discretization Points over /Gamma_2^center = %g", nyCenter);

RingWidth = epsilon2 - epsilon1; // ring width
Printf("Film Width = %g", RingWidth);

CenterWidth = 2 * epsilon1;

DeltaYLower = RingWidth/(nyLower - 1); // discretization "y" lower ring
DeltaYUpper = RingWidth/(nyUpper - 1); // discretization "y" upper ring
DeltaYCenter = CenterWidth/(nyCenter - 1); // discretization "y" center

/* --- BUILDING UNIFORM 1D MESH --- */

// -- LOWER RING  
For y1 In {1:(nyLower - 2)}
pp = newp;
Point(pp) = {xMin,xc - epsilon2 + DeltaYLower * y1 ,CharLength};
NodeNumberGamma21Bottom[y1] = pp; // lower left boundary nodes
Translate {xMax,0,0}{ Duplicata {Point{pp};} }
NodeNumberGamma22Bottom[y1] = pp + 1; // lower right boundary nodes
EndFor

// -- UPPER RING
For y2 In {1:(nyUpper - 2)}
pp2 = newp;
Point(pp2) = {xMin,xc + epsilon1 + DeltaYUpper * y2 ,CharLength};
NodeNumberGamma21Top[y2] = pp2; // upper left boundary nodes
Translate {xMax,0,0}{ Duplicata {Point{pp2};} }
NodeNumberGamma22Top[y2] = pp2 + 1; // upper right boundary nodes
EndFor

// -- IN BETWEEN OF THE INNER CHANNEL
For y3 In {1:(nyCenter - 2)}
pp3 = newp;
Point(pp3) = {xMin,xc - epsilon1 + DeltaYCenter * y3 ,CharLength};
NodeNumberGamma21Center[y3] = pp3; // center left boundary nodes
Translate {xMax,0,0}{ Duplicata {Point{pp3};} }
NodeNumberGamma22Center[y3] = pp3 + 1; // center left boundary nodes
EndFor


/* --- BUILDING LINES --- */

/* LEFT HAND SIDE */

NodeNumberGamma21Bottom[0] = p5; // Node 5
NodeNumberGamma21Bottom[nyLower - 1] = p3; // Node 3

NodeNumberGamma21Top[0] = p2; // Node 2
NodeNumberGamma21Top[nyUpper - 1] = p4; // Node 4

NodeNumberGamma21Center[0] = p3; // Node 3
NodeNumberGamma21Center[nyCenter - 1] = p2; // Node 2


// Line joining Node 5 to Node p_1(Gamma_21^bottom)
l1 = newl; 
Line(l1) = {NodeNumberGamma21Bottom[0],NodeNumberGamma21Bottom[1]};

// Line joining Node p_last(Gamma_21^bottom) to Node 3
l2 = newl;
Line(l2) = {NodeNumberGamma21Bottom[nyLower - 2],NodeNumberGamma21Bottom[nyLower - 1]};

// Line joining Node 3 to p_1(Gamma_21^center)
l3 = newl; 
Line(l3) = {NodeNumberGamma21Center[0],NodeNumberGamma21Center[1]};

// Line joining p_last(Gamma_21^center,bottom) to Node 1
l4 = newl; 
aux = (nyCenter - 3) / 2;
Line(l4) = {NodeNumberGamma21Center[aux],p1};

// Line joining Node 1 to p_1(Gamma_21^center,top)
l5 = newl; 
aux2 = aux + 1;
Line(l5) = {p1, NodeNumberGamma21Center[aux2]};

// Line joining p_last(Gamma_21^center) to Node 1
l6 = newl; 
Line(l6) = {NodeNumberGamma21Center[nyCenter - 2],NodeNumberGamma21Center[nyCenter - 1]};

// Line joining Node 2 to p_1(Gamma_21^top) 
l7 = newl; 
Line(l7) = {NodeNumberGamma21Top[0],NodeNumberGamma21Top[1]};

// Line joining Node p_last(Gamma_21^top) to Node 4
l8 = newl; 
Line(l8) = {NodeNumberGamma21Top[nyUpper - 2],NodeNumberGamma21Top[nyUpper - 1]};

// Lines joining nodes in between Gamma_21^bottom
For i In {1:nyLower - 3}
ll = newl;
Line(ll) = {NodeNumberGamma21Bottom[i],NodeNumberGamma21Bottom[i + 1]};
LineNumberGamma21Bottom[i] = ll;
EndFor

// Lines joining nodes in between Gamma_21^top
For i In {1:nyUpper - 3}
ll = newl;
Line(ll) = {NodeNumberGamma21Top[i],NodeNumberGamma21Top[i + 1]};
LineNumberGamma21Top[i] = ll;
EndFor

// Lines joining nodes in between Gamma_21^center,bottom
For i In {1:aux - 1}
ll = newl;
Line(ll) = {NodeNumberGamma21Center[i],NodeNumberGamma21Center[i + 1]};
LineNumberGamma21CenterBottom[i] = ll;
EndFor

// Lines joining nodes in between Gamma_21^center,top
For i In {aux2:nyCenter - 3}
ll = newl;
Line(ll) = {NodeNumberGamma21Center[i],NodeNumberGamma21Center[i + 1]};
LineNumberGamma21CenterTop[i] = ll;
EndFor

/* RIGHT HAND SIDE */


NodeNumberGamma22Bottom[0] = 10; // Node 10
NodeNumberGamma22Bottom[nyLower - 1] = 8; // Node 8

NodeNumberGamma22Top[0] = 7; // Node 7
NodeNumberGamma22Top[nyUpper - 1] = 9; // Node 9

NodeNumberGamma22Center[0] = 8; // Node 8
NodeNumberGamma22Center[nyCenter - 1] = 7; // Node 7


// Line joining Node 10 to Node p_1(Gamma_22^bottom)
ll1 = newl; 
Line(ll1) = {NodeNumberGamma22Bottom[0],NodeNumberGamma22Bottom[1]};

// Line joining Node p_last(Gamma_22^bottom) to Node 8
ll2 = newl;
Line(ll2) = {NodeNumberGamma22Bottom[nyLower - 2],NodeNumberGamma22Bottom[nyLower - 1]};

// Line joining Node 8 to p_1(Gamma_22^center)
ll3 = newl; 
Line(ll3) = {NodeNumberGamma22Center[0],NodeNumberGamma22Center[1]};

// Line joining p_last(Gamma_22^center,bottom) to Node 6
ll4 = newl; 
aux3 = (nyCenter - 3) / 2;
Line(ll4) = {NodeNumberGamma22Center[aux3],6};

// Line joining Node 6 to p_1(Gamma_22^center,top)
ll5 = newl; 
aux4 = aux3 + 1;
Line(ll5) = {6, NodeNumberGamma22Center[aux4]};

// Line joining p_last(Gamma_22^center) to Node 6
ll6 = newl; 
Line(ll6) = {NodeNumberGamma22Center[nyCenter - 2],NodeNumberGamma22Center[nyCenter - 1]};

// Line joining Node 7 to p_1(Gamma_22^top) 
ll7 = newl; 
Line(ll7) = {NodeNumberGamma22Top[0],NodeNumberGamma22Top[1]};

// Line joining Node p_last(Gamma_22^top) to Node 9
ll8 = newl; 
Line(ll8) = {NodeNumberGamma22Top[nyUpper - 2],NodeNumberGamma22Top[nyUpper - 1]};

// Lines joining nodes in between Gamma_22^bottom
For i In {1:nyLower - 3}
ll = newl;
Line(ll) = {NodeNumberGamma22Bottom[i],NodeNumberGamma22Bottom[i + 1]};
LineNumberGamma22Bottom[i] = ll;
EndFor

// Lines joining nodes in between Gamma_22^top
For i In {1:nyUpper - 3}
ll = newl;
Line(ll) = {NodeNumberGamma22Top[i],NodeNumberGamma22Top[i + 1]};
LineNumberGamma22Top[i] = ll;
EndFor

// Lines joining nodes in between Gamma_22^center,bottom
For i In {1:aux3 - 1}
ll = newl;
Line(ll) = {NodeNumberGamma22Center[i],NodeNumberGamma22Center[i + 1]};
LineNumberGamma22CenterBottom[i] = ll;
EndFor

// Lines joining nodes in between Gamma_22^center,top
For i In {aux4:nyCenter - 3}
ll = newl;
Line(ll) = {NodeNumberGamma22Center[i],NodeNumberGamma22Center[i + 1]};
LineNumberGamma22CenterTop[i] = ll;
EndFor

// Horizontal Lines
Gamma2Bottom = newl;
Line(Gamma2Bottom) = {5,10};

Gamma2Top = newl;
Line(Gamma2Top) = {4,9};

Gamma12Bottom = newl;
Line(Gamma12Bottom) = {3,8};

Gamma12Top = newl;
Line(Gamma12Top) = {2,7};

 
// Transfinite Lines 

//Transfinite Line{Gamma2Bottom} = 50 Using Bump 0.2;
//Transfinite Line{Gamma2Top} = 50 Using Bump 0.2;
//Transfinite Line{Gamma12Bottom} = 50 Using Bump 0.2;
//Transfinite Line{Gamma12Top} = 50 Using Bump 0.2;



//Physical Surface("Liquid Film") = {32,36};
//Physical Surface("Gas") = {34};

//Line Loop(31) = {28, -21, -23, -20, -30, 7, 10, 8};
//Plane Surface(32) = {31};
//Line Loop(33) = {29, -15, -22, -14, -27, 1, 9, 2};
//Plane Surface(34) = {33};
//Line Loop(35) = {30, -19, -26, -18, -17, -24, -16, -29, 3, 11, 4, 5, 13, 6};
//Plane Surface(39) = {31, 33};
//Plane Surface(40) = {35};
//Plane Surface(41) = {31, 33};
//Plane Surface(42) = {35};
//Physical Surface(43) = {32, 34};
//Physical Surface(44) = {40};
Line Loop(43) = {42, -25, -38, -37, -24, -23, -35, -34, -22, -41, 3, 15, 16, 4, 5, 18, 19, 6};
Plane Surface(44) = {43};
Line Loop(45) = {40, -27, -33, -32, -31, -26, -42, 7, 12, 13, 14, 8};
Plane Surface(46) = {45};
Line Loop(47) = {2, 41, -21, -30, -29, -28, -20, -39, 1, 9, 10, 11};
Plane Surface(48) = {47};
