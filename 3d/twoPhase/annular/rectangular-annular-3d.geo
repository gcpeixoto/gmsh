/* File: periodic-rectangular-channel-3d-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * e-mail: tavolesliv@gmail.com
 * Description: it generates periodic mesh at inlet and outlet.
*/ 


// PARAMETERS

cl = 0.5;

xMin = 0;
yMin = 0;
zMin = 0;

Lx = 6;
Ly = 2;
Lz = 2;

// POINTS
Point(1) = {xMin, yMin, zMin,cl};
Point(2) = {xMin, yMin, zMin + Lz,cl};
Point(3) = {xMin, yMin + Ly, zMin + Lz,cl};
Point(4) = {xMin, yMin + Ly, zMin,cl};
Point(5) = {xMin + Lx, yMin, zMin,cl};
Point(6) = {xMin + Lx, yMin, zMin + Lz,cl};
Point(7) = {xMin + Lx, yMin + Ly, zMin + Lz,cl};
Point(8) = {xMin + Lx, yMin + Ly, zMin,cl};


// LINES
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};
Line(5) = {5, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Line(8) = {8, 5};
Line(9) = {1, 5};
Line(10) = {2, 6};
Line(11) = {3, 7};
Line(12) = {4, 8};

// SURFACES

// {xy, z = zMin}
Line Loop(1) = {1,2,3,4};
Plane Surface(1) = {1};

// {xy, z = zMin + Lz}
Line Loop(2) = {5,6,7,8};
Plane Surface(2) = {2};

// {xz, y = yMin}
Line Loop(3) = {4,9,-8,-12};
Plane Surface(3) = {3};

// {yz, x = xMin}
Line Loop(4) = {1,10,-5,-9};
Plane Surface(4) = {4};

// {xz, y = yMin + Ly}
Line Loop(5) = {2,11,-6,-10};
Plane Surface(5) = {5};

// {yz, x = xMin + Lx}
Line Loop(6) = {3,12,-7,-11};
Plane Surface(6) = {6};

/* PERIODICITY: it is imposed when the mesh is ordered and 
 *              the {.,.,.,.} indices should be counterpart lines! 
 */ 
Periodic Surface 2 {5,6,7,8} = 1 {1,2,3,4};

// VOLUME
Surface Loop(13) = {5, 1, 4, 2, 6, 3};
Volume(14) = {13};

//Transfinite Surface {1} Alternated;
//Transfinite Surface {2} Alternated;
Physical Volume(16) = {14};
Transfinite Line {2, 3, 4, 1, 5, 6, 7, 8} = 40 Using Progression 1;
