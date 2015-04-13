/* File: bubbles-elongated-2d.geo 
*  Author: Gustavo Charles P. de Oliveira, tavolesliv@gmail.com
*  Created on: July, 8th, 2013
*  Description: File to generate array of n sequential elongated Taylor
*               bubbles separated by slug inside a 2D channel. 
*		However, lateral walls are not periodic. 
*/


// Refinement 
bubble = 0.01; 
wall = 0.05;

// Origin
x0 = 0.0;
y0 = 0.0;
z0 = 0.0;

// Parameters
D = 1.0; // channel diameter
zeta = 3/4; // "void fraction" parameter
DV = zeta*D; // bubble diameter
rCap = DV/2;
alpha = 0.2;
deltaL = (1 + alpha)*( D - DV )/2; // upper film width
B = 3*rCap; // body length
DH = B + rCap; 
g = DH/3; // distance from inlet and outlet 
s = DH/2; // slug length

nb = 3; // number of bubbles
LM = nb*DH + (nb - 1)*s - 2*g; // elongated bubbles region 
L = LM + 2*g + 1.5*s; // channel length


// channel
Point(1) = {x0,y0,z0,wall};
Point(2) = {x0 + L,y0,z0,wall};
Point(3) = {x0 + L,y0 + D,z0,wall};
Point(4) = {x0,y0 + D,z0,wall};
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,1};

For i In {1:nb}
// bubble body
pp1 = newp;
Point(pp1) = {x0 + g + (i - 1)*(DH + s), y0 + deltaL, z0, bubble};
pp2 = newp;
Point(pp2) = {x0 + g + B + (i - 1)*(DH + s), y0 + deltaL, z0, bubble};
pp3 = newp;
Point(pp3) = {x0 + g + B + (i - 1)*(DH + s), y0 + deltaL + DV, z0, bubble};
pp4 = newp;
Point(pp4) = {x0 + g + (i - 1)*(DH + s), y0 + deltaL + DV, z0, bubble};
// bubble cap
pp5 = newp;
Point(pp5) = {x0 + g + B + (i - 1)*(DH + s), y0 + deltaL + rCap, z0, bubble};
pp6 = newp;
Point(pp6) = {x0 + g + DH + (i - 1)*(DH + s), y0 + deltaL + rCap, z0, bubble};

ll1 = newl;
Line(ll1) = {pp1,pp2};
cc1 = newc;
Circle(cc1) = {pp2,pp5,pp6};
cc2 = newc;
Circle(cc2) = {pp6,pp5,pp3};
ll2 = newl;
Line(ll2) = {pp3,pp4};
ll3 = newl;
Line(ll3) = {pp4,pp1};

/* Temporary Printf to know the geometrical elements of boundary in order to 
 * create the physical groups */   
Printf("Physical Line Bubble = %f",i);
Printf("l1 = %f",ll1);
Printf("l2 = %f",cc1);
Printf("l3 = %f",cc2);
Printf("l4 = %f",ll2);
Printf("l5 = %f",ll3);
EndFor

Physical Line("bubble1") = {5,6,7,8,9};
Physical Line("wallInvU") = {1,3};
Physical Line("wallInflowU") = {4};
Physical Line("wallOutflowU") = {2};
Printf("Physical Line Wall = %f",i);



