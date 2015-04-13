/* File: periodic-triangular-channel-3d-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * e-mail: tavolesliv@gmail.com
 * Description: it generates triangular periodic mesh at inlet and outlet.
*/ 


// PARAMETERS

cl = 0.5;

xMin = 0;
yMin = 0;
zMin = 0;

h = 1; // height
b = 2; // smaller basis
B = 3.5; // bigger basis
Lx = 5; // channel length

// POINTS
Point(1) = {xMin, yMin - b/2, zMin,cl};
Point(2) = {xMin, yMin + b/2, zMin,cl};
Point(3) = {xMin, yMin + B/2, h,cl};
Point(4) = {xMin, yMin - B/2, h,cl};
Point(5) = {xMin + Lx, yMin - b/2, zMin,cl};
Point(6) = {xMin + Lx, yMin + b/2, zMin,cl};
Point(7) = {xMin + Lx, yMin + B/2, h,cl};
Point(8) = {xMin + Lx, yMin - B/2, h,cl};


Line(1) = {3, 4};
Line(2) = {4, 1};
Line(3) = {1, 2};
Line(4) = {2, 3};
Line(5) = {7, 8};
Line(6) = {8, 5};
Line(7) = {5, 6};
Line(8) = {6, 7};
Line(9) = {1, 5};
Line(10) = {2, 6};
Line(11) = {3, 7};
Line(12) = {4, 8};

Line Loop(13) = {2, 9, -6, -12};
Plane Surface(14) = {13};
Line Loop(15) = {1, 12, -5, -11};
Plane Surface(16) = {15};
Line Loop(17) = {11, -8, -10, 4};
Plane Surface(18) = {17};
Line Loop(19) = {10, -7, -9, 3};
Plane Surface(20) = {19};
Line Loop(21) = {5, 6, 7, 8};
Plane Surface(22) = {21};
Line Loop(23) = {1, 2, 3, 4};
Plane Surface(24) = {23};

// PERIODICITY
Periodic Surface 22 {5,6,7,8} = 24 {1,2,3,4};

Surface Loop(25) = {16, 24, 14, 20, 18, 22};
Volume(26) = {25};

Physical Volume(27) = {26};

Transfinite Line {2, 4, 6, 8} = 10 Using Progression 1;
Transfinite Line {3, 7} = 15 Using Progression 1;
Transfinite Line {1, 5} = 25 Using Progression 1;
