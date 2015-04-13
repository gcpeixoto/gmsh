
/* Defaults */

Geometry.Surfaces = 1; //
Geometry.Points = 0;
Geometry.Lines = 0;
Mesh.SurfaceNumbers = 0;
Mesh.Normals = 20;

/* Mesh parameters */ 

x0 = 0.0;
y0 = 0.0;
z0 = 0.0;
c1 = 0.08;  // refinement body
c2 = 0.005; // refinement pinch

/* alpha-lambda: depend on jet density, surface tension and R0 */

R0 = 0.5;   // jet initial radius
DeltaU = 0.001;                 // velocity disturbance amplitude
alpha = 0.0270;                 // max growth rate (Middleton)
lambda = 4.44;                  // wavelength of most unstable mode
amp = DeltaU*Pi/(alpha*lambda); // amplitude 
t0 = 30;                        // breakup time
r1 = 0.25*R0; 			// pinch radius
L = lambda;			// periodic length (drop) 

/* Discretization */

np = 50; 		          // number of evaluated points
nt = 10;                          // spline points (theta revolution)
Geometry.ExtrudeSplinePoints = nt;
dx = L/(np - 1);
nLayers = 20;			  // for structured meshing (Add 'Layers(nLayers);' as argument for 'Extrude'

// initial point
X[0] = x0 - lambda/2;
Y[0] = y0 + r1;
P0 = newp;
P[0] = P0;
Point(P0) = {X[0],Y[0],z0,c1};

// 'revolution' profile 
For p In {1:np-1}
X[p] = X[0] + p*dx;
Y[p] = Y[0] + R0*(1.0 + Cos(2*Pi*X[p]/lambda) );
Pp = newp;
Point(Pp) = {X[p],Y[p],z0,c1};
P[p] = Pp;
L = newl;
Line(L) = {P[p-1],P[p]};
extr11[] = Extrude{ {0,0,0}, {1,0,0}, {0,0,0}, -Pi }{ Line{L}; }; // -Pi to fix normal orientation
extr12[] = Extrude{ {0,0,0}, {1,0,0}, {0,0,0}, -Pi }{ Line{extr11[0]}; }; // entry 0 returns the "top" of extruded entity
idSurf11[p] = extr11[1]; 						 // entry 1 returns the extruded surface id
idSurf12[p] = extr12[1];
Printf("%g",idSurf11[p]);
Printf("%g",idSurf12[p]);
EndFor

// left pinch
P1 = newp;
Point(P1) = {X[0],y0,z0,c2};
P2 = newp;
Point(P2) = {X[0] - r1,y0,z0,c2};
C1 = newc;
Circle(C1) = {P0,P1,P2};
extrL[] = Extrude{ {0,0,0}, {1,0,0}, {0,0,0}, Pi }{ Line{C1}; };
extrL2[] = Extrude{ {0,0,0}, {1,0,0}, {0,0,0}, Pi }{ Line{extrL[0]}; };

// right pinch
P3 = newp;
Point(P3) = {X[np-1],y0,z0,c2};
P4 = newp;
Point(P4) = {X[np-1] + r1,y0,z0,c2};
C2 = newc;
Circle(C2) = {P[np-1],P3,P4};
extrR[] =  Extrude{ {0,0,0}, {1,0,0}, {0,0,0}, -Pi }{ Line{C2}; };
extrR2[] = Extrude{ {0,0,0}, {1,0,0}, {0,0,0}, -Pi }{ Line{extrR[0]}; };

/* Physical group */

Physical Surface("bubble1") = {idSurf11[],idSurf12[],extrL[1],extrL2[1],extrR[1],extrR2[1]};


