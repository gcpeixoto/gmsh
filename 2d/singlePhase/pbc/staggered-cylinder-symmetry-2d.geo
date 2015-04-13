// *** File: staggered-half-tube-2d.geo
// *** Author: Gustavo Charles P. de Oliveira
// *** Date: Feb 26th, 2014
// *** Description: Generates a channel with lateral periodicity and semi-circular lobes.


/*

	Geometry sketch
        ===============
				

        P12  P9                     P8   P11
	o    o——————————————————————o    o
              
          arc C4        P3       arc C3
    P10 o                o               o P7
        |        arc C1    arc C2        |
     L2 |                                |
        o____________o   o   o___________o —.—.—.—.—. symmetry line for staggered   
        P1          P2   P6  P4          P5 

	      L1       r   r       L1
	|————————————|———|———|———————————|		

*/





/* --- BEGIN OF CODE --- */

// -- PARAMETERS --

w = 0.03; // characteristic length

xMin = 0;
yMin = -1;
zMin = 0;

L1 = 1;
L2 = 0.5; 
Lz = 0;

r = 0.5;
 
P1 = newp;
Point(P1) = {xMin,yMin,zMin,w};
P2 = newp;
Point(P2) = {xMin + L1,yMin,zMin,w};
P3 = newp;
Point(P3) = {xMin + L1 + r,yMin + r,zMin,w};
P4 = newp;
Point(P4) = {xMin + L1 + 2*r,yMin,zMin,w};
P5 = newp;
Point(P5) = {xMin + 2*(L1 + r),yMin,zMin,w};
P6 = newp;
Point(P6) = {xMin + L1 + r,yMin,zMin,w}; // center mid-lobe
P7 = newp;
Point(P7) = {xMin + 2*(L1 + r),yMin + L2,zMin,w};
P8 = newp;
Point(P8) = {xMin + 2*L1 + r,yMin +L2 + r,zMin,w};
P9 = newp;
Point(P9) = {xMin + r,yMin + L2 + r,zMin,w};
P10 = newp;
Point(P10) = {xMin,yMin + L2,zMin,w};
P11 = newp;
Point(P11) = {xMin + 2*(L1 + r),yMin + L2 + r,zMin,w}; // center half-lobe right
P12 = newp;
Point(P12) = {xMin,yMin + L2 + r,zMin,w}; // center half-lobe left

L1 = newl;
Line(L1) = {P1,P2};
L2 = newl;
Line(L2) = {P4,P5};
L3 = newl;
Line(L3) = {P5,P7};
L4 = newl;
Line(L4) = {P8,P9};
L5 = newl;
Line(L5) = {P10,P1};


// center mid-lobe
C1 = newc;
Circle(C1) = {P2,P6,P3};
C2 = newc;
Circle(C2) = {P3,P6,P4};

C3 = newc;
Circle(C3) = {P7,P11,P8};
C4 = newc;
Circle(C4) = {P9,12,P10};

Periodic Line {3} = {5};

Physical Line("wallNormalV") = {L1,L2,L4};
//Physical Line("wallNoSlip") = {L1,C1,C2,L2,C3,L4,C4};
Physical Line("wallPeriodic11") = {L5}; 
Physical Line("wallPeriodic12") = {L3};
Physical Line("wallNoSlip") = {C1,C2,C3,C4};




