/* File: t-junction-2d.geo
* Created on Sep 27th, 2013
* Author: Gustavo Peixoto de Oliveira
* 
* Description: Adjustable T-junction 2D geometry for transverse flows. 
*/

// --- GEOMETRY ---
//                    L4
//        5----------------------------4      ---
//        |                            |       |
//     L5 |                            | L3    | d2
//        |                            |       |
//        6-------7   O  2-------------3      ---         O = (0,0,0) origin 
//           L6   |      |      L2             |
//                |      |                     |
//             L7 |      |L1                   | h
//                |      |                     |
//                |      |                     |
//                8------1                    ---
//            h1     d1         h2
//        |-------|------|--------------|
//
//

// --- SCRIPT ---


// Origin
x0 = 0; 
y0 = 0; 
z0 = 0;
wall = 0.1; // refinement level
 
// diameters
d1 = 1;
d2 = 1.5*d1;

// height and ``arms''
h = 1*d1;
h1 = 0.5*d1; 
h2 = 5*d1;

// points
P1 = newp;
Point(P1) = {x0 + 0.5 * d1, y0 - h, z0, wall};
P2 = newp;
Point(P2) = {x0 + 0.5 * d1, y0, z0, wall};
P3 = newp;
Point(P3) = {x0 + 0.5 * d1 + h2, y0, z0, wall};
P4 = newp;
Point(P4) = {x0 + 0.5 * d1 + h2, y0 + d2, z0, wall};
P5 = newp;
Point(P5) = {x0 - (0.5 * d1 + h1), y0 + d2, z0, wall};
P6 = newp;
Point(P6) = {x0 - (0.5 * d1 + h1), y0, z0, wall};
P7 = newp;
Point(P7) = {x0 - 0.5 * d1, y0, z0, wall};
P8 = newp;
Point(P8) = {x0 - 0.5 * d1, y0 - h, z0, wall};

// lines
L1 = newl;
Line(L1) = {P1,P2};
L2 = newl;
Line(L2) = {P2,P3};
L3 = newl;
Line(L3) = {P3,P4};
L4 = newl;
Line(L4) = {P4,P5};
L5 = newl;
Line(L5) = {P5,P6};
L6 = newl;
Line(L6) = {P6,P7};
L7 = newl;
Line(L7) = {P7,P8};
L8 = newl;
Line(L8) = {P8,P1};

// physical groups
Physical Line("define1") = {L1,L2,L4,L6,L7};
Physical Line("define2") = {L3};
Physical Line("define3") = {L5};
Physical Line("define4") = {L8};

