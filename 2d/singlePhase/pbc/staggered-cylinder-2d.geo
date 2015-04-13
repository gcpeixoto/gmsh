// *** File: staggered—tube-2d.geo
// *** Author: Gustavo Charles P. de Oliveira
// *** Date: Feb 26th, 2014
// *** Description: Generates a channel with lateral periodicity and semi-circular lobes.


/*

	Geometry sketch
        ===============


             P6                     P5   
    P12 o    o——————————————————————o    o P11
              
          arc C4                  arc C3
     P7 o                o P15           o P4
        |                                |
        |          P16  P17  P14         |
   L2   | —.—.—.—.—. o   o   o —.—.—.—.— | —.—.—.—.—. symmetry line   
        |                                |
        |        arc C5      arc C6      |
     P8 o                o P13           o P3
           arc C1                arc C2

     P9	o    o——————————————————————o    o P10 
             P1                     P2   
             
			L1             r
             |——————————————————————|—————|


*/ 


/* --- BEGIN OF CODE --- */

// -- PARAMETERS --

w = 0.08; // characteristic length

xMin = 0;
yMin = -1;
zMin = 0;

r = 0.5;
L1 = 4*r;
L2 = 2*r; 
Lz = 0;


// outer wrapper 
P1 = newp;
Point(P1) = {xMin +r,yMin,zMin,w};
P2 = newp;
Point(P2) = {xMin + r + L1,yMin,zMin,w};
P3 = newp;
Point(P3) = {xMin + L1 + 2*r,yMin + r,zMin,w};
P4 = newp;
Point(P4) = {xMin + L1 + 2*r,yMin + L2 + r,zMin,w};
P5 = newp;
Point(P5) = {xMin + r + L1,yMin + L2 + 2*r ,zMin,w};
P6 = newp;
Point(P6) = {xMin + r,yMin + L2 + 2*r,zMin,w}; 
P7 = newp;
Point(P7) = {xMin,yMin + r + L2,zMin,w};
P8 = newp;
Point(P8) = {xMin,yMin + r,zMin,w};

l1 = newl;
Line(l1) = {P1,P2};
l2 = newl;
Line(l2) = {P3,P4};
l3 = newl;
Line(l3) = {P5,P6};
l4 = newl;
Line(l4) = {P7,P8};



// arc centres
xMax = xMin + 2*r + L1;
yMax = yMin + 2*r + L2;

P9 = newp;
Point(P9) = {xMin,yMin,zMin,w}; 
P10 = newp;
Point(P10) = {xMax,yMin,zMin,w};
P11 = newp;
Point(P11) = {xMax,yMax,zMin,w}; 
P12 = newp;
Point(P12) = {xMin,yMax,zMin,w}; 

C1 = newc;
Circle(C1) = {P8,P9,P1};
C2 = newc;
Circle(C2) = {P2,P10,P3};
C3 = newc;
Circle(C3) = {P4,P11,P5};
C4 = newc;
Circle(C4) = {P6,P12,P7};



/*
// central circle: uncomment entire block for non-staggered mesh and correct physical groups definition
xc = 0.5*(xMax + xMin);
yc = 0.5*(yMax + yMin);

P13 = newp;
Point(P13) = {xc,yc-r,zMin,w}; 
P14 = newp;
Point(P14) = {xc+r,yc,zMin,w}; 
P15 = newp;
Point(P15) = {xc,yc+r,zMin,w}; 
P16 = newp;
Point(P16) = {xc-r,yc,zMin,w}; 
P17 = newp;
Point(P17) = {xc,yc,zMin,w}; 

C5 = newc;
Circle(C5) = {P16,P17,P13};
C6 = newc;
Circle(C6) = {P13,P17,P14};
C7 = newc;
Circle(C7) = {P14,P17,P15};
C8 = newc;
Circle(C8) = {P15,P17,P16};
*/

// periodic
Periodic Line {l4} = {l2};

// physics     
Line Loop(1) = {C1,l1,C2,l2,C3,l3,C4,l4}; // non staggered
Plane Surface(1) = {1}; // non staggered

//Line Loop(2) = {C5,C6,C7,C8}; // staggered 
//Plane Surface(1) = {1,2}; // staggered

Physical Surface("domain") = {1};


// local refinement
Field[1] = BoundaryLayer;
//Field[1].NodesList = {P13,P14,P15,P16};
//Field[1].EdgesList = {C1,C2,C3,C4,C5,C6,C7,C8};
Field[1].EdgesList = {C1,C2,C3,C4};
Field[1].thickness = w/5;
Field[1].hfar = w;
Field[1].hwall_n = w/3;
Field[1].hwall_t = w/5;
Field[1].ratio = 1.1;
Background Field = 1;


//physical groups
//Physical Line("wallNoSlip") = {C1,C2,C3,C4,C5,C6,C7,C8}; // staggered
//Physical Line("wallNormalV") = {l1,l3};
//Physical Line("wallNoSlip") = {C1,l1,C2,C3,l3,C4}; // non-staggered 
//Physical Line("wallPeriodic11") = {l4}; 
//Physical Line("wallPeriodic12") = {l2};

