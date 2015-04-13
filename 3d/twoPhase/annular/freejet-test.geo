/* File: periodic-cylindrical-3d-annular-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * Date: September 17th, 2013
 * Description: Generates a 3D channel with lateral periodicity for annular flows
 */


// PARAMETERS

// --- Refinement
bIn = 0.1;

// --- Boundary Geometry
xMin = 0; // begin of channel
Printf("Begin of the Channel: x = %g", xMin);
yMin = 0;
zMin = 0;

r1 = 5; // inner radius

D1 = 2*r1; // inner diameter

// SURFACES

// INNER circumference

// --- left end

p1 = newp;
Point(p1) = {xMin,yMin,zMin,bIn}; // center
p2 = newp;
Point(p2) = {xMin,yMin,zMin - r1,bIn}; 
p3 = newp;
Point(p3) = {xMin,yMin + r1,zMin,bIn}; 
p4 = newp;
Point(p4) = {xMin,yMin,zMin + r1,bIn};
p5 = newp;
Point(p5) = {xMin,yMin - r1,zMin,bIn};

// BUILDING CIRCLES

// --- INNER circumference

// --- left end
c1 = newc;
Circle(c1) = {p2,p1,p3};
c2 = newc;
Circle(c2) = {p3,p1,p4};
c3 = newc;
Circle(c3) = {p4,p1,p5};
c4 = newc;
Circle(c4) = {p5,p1,p2};

// BUILDING INNER SURFACES

// --- left end
ll1 = newl;
Line Loop(ll1) = {-c4,-c3,-c2,-c1};
s1 = news;
Plane Surface(s1) = {ll1};

// DISCRETIZATION (THETA) CIRCLES 

//ntIn = 5; // number of theta points per semi-semi circle (total around circle is 4*nt) 
//Transfinite Line{c1,c2,c3,c4,c5,c6,c7,c8} = ntIn Using Bump 1;

Physical Surface("area") = {s1};
