// *** File: periodic-cylinder-3d.geo
// *** Author: Gustavo Charles P. de Oliveira
// *** Date: Oct 24th, 2012
// *** Description: Tube separated by interface to simulate two-phase flows

/* --- BEGIN OF CODE --- */

cl = 1;

xc = 0; 
yc = 0;
zc = 0;

r1 = 1.2; // inner radius
Printf("Inner radius = %g",r1);
r2 = 1.5; // outer radius
Printf("Outer radius = %g",r2);

zMax = 10; // Length of tube
Printf("Tube Length = %g",zMax);

pc1 = newp;
Point(pc1) = {xc,yc,zc,cl}; // center of circumference

pc2 = newp; // idem translated
Point(pc2) = {xc,yc,zc + zMax,cl};

NThetaInner = 47; // number of inner angles
Printf("Number of Inner Angles = %g",NThetaInner);

ThetaInner = 2 * Pi / NThetaInner;
Printf("Inner Angle = %g rad",ThetaInner);

InitialThetaInner = 0;

For n In {1:NThetaInner}

AuxTheta = InitialThetaInner + (n - 1) * ThetaInner;

xnInner = r1 * Cos(AuxTheta);
ynInner = r1 * Sin(AuxTheta);

pp = newp;
Point(pp) = {xnInner,ynInner,zc,cl};
Translate {0,0,zMax}{ Duplicata { Point{pp}; } } 

EndFor

NThetaOuter = 24;
Printf("Number of Outer Angles = %g",NThetaOuter);

ThetaOuter = 2 * Pi / NThetaOuter;
Printf("Outer Angle = %g rad",ThetaOuter);

InitialThetaOuter = 0;

For n In {1:NThetaOuter}

AuxTheta = InitialThetaOuter + (n - 1) * ThetaOuter;
xnOuter = r2 * Cos(AuxTheta);
ynOuter = r2 * Sin(AuxTheta);

pp = newp;
Point(pp) = {xnOuter,ynOuter,zc,cl};
Translate {0,0,zMax}{ Duplicata { Point{pp}; } }

EndFor

/* Uncomment, because all the lines below are working! */

// Building arcs discretization 
//For k In {1:NThetaInner - 1}

//j = 2 * k + 1;
//cc = newc;
//Circle(cc) = {j,1,j+2};

//EndFor

//cc1 = newc;
//Circle(cc1) = {(2 * NThetaInner - 1),1,3};

//For k In {2:NThetaInner}

//j = 2 * k;
//cc = newc;
//Circle(cc) = {j,2,j+2};

//EndFor

//cc1 = newc;
//Circle(cc1) = {2 * NThetaInner + 2,2,4};


//index = 2 * (NThetaInner + 1) + 1;

//For k In {0:(NThetaOuter - 2)}

//j = 2 * k;
//cc = newc;
//Circle(cc) = {index + j,1,index + j + 2};

//EndFor

//cc2 = newc;
//index2 = 2 * (NThetaOuter - 1);
//Circle(cc2) = {index + index2,1,index};

For k In {0:(NThetaOuter - 2)}

//j = 2 * k + 1;
//cc = newc;
//Circle(cc) = {index + j,2,index + j + 2};

//EndFor

//cc3 = newc;
//index2 = 2 * (NThetaOuter - 1) + 1;
//Circle(cc3) = {index + index2,2,index + 1};



//For k In {1:NThetaInner}
//j = 2 * k + 1;
//ll = newl;
//Line(ll) = {j,j + 1};
//EndFor

//aux = 2*NThetaInner + 3;
//aux2 = aux + NThetaOuter - 1;

//Printf("aux = %g",aux);
//Printf("aux2 = %g",aux2);

//For k In {0:NThetaOuter - 1}
//j = 2 * k;
//ll = newl;
//Line(ll) = {aux + j,aux + j + 1};
//EndFor

//ll2 = newl;
//Line(ll2) = {aux2 + 2,aux};

//Line Loop(163) = {59, 149, -73, -147};
//Line Loop(214) = {199, 128, -200, -104};
//Ruled Surface(215) = {214};
