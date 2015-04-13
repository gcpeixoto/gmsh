/* File: periodic-triangular-channel-3d-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * e-mail: tavolesliv@gmail.com
 * Description: it generates triangular periodic mesh at inlet and outlet.
*/ 


// PARAMETERS

cl = 0.4;

xMin = 0;
yMin = 0;
zMin = 0;

h = 1; // height
b = 2.5; // basis
Lx = 6; // channel length

// POINTS
Point(1) = {xMin, yMin, 0};
Point(2) = {xMin, yMin - b/2, h};
Point(3) = {xMin, yMin + b/2, h};

Point(4) = {xMin + Lx, yMin, 0};
Point(5) = {xMin + Lx, yMin - b/2, h};
Point(6) = {xMin + Lx, yMin + b/2, h};

Line(1) = {2, 3};
Line(2) = {3, 1};
Line(3) = {1, 2};
Line(4) = {5, 6};
Line(5) = {6, 4};
Line(6) = {4, 5};
Line(7) = {1, 4};
Line(8) = {2, 5};
Line(9) = {3, 6};

Line Loop(10) = {2, 7, -5, -9};
Plane Surface(11) = {10};
Line Loop(12) = {1, 9, -4, -8};
Plane Surface(13) = {12};
Line Loop(14) = {3, 8, -6, -7};
Plane Surface(15) = {14};
Line Loop(16) = {3, 1, 2};
Plane Surface(17) = {16};
Line Loop(18) = {6, 4, 5};
Plane Surface(19) = {18};

// PERIODICITY
Periodic Surface 19 {4,5,6} = 17 {1,2,3};

Surface Loop(20) = {13, 17, 15, 19, 11};
Volume(21) = {20};
Physical Volume(22) = {21};
