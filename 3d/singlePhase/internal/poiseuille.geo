/* File: periodic-cylindrical-3d-generator.geo
 * Author: Gustavo Charles P. de Oliveira
 * e-mail: tavolesliv@gmail.com
 * Description: it generates periodic surfaces meshing at inlet and outlet. 
 *		Theta discretization over the boundaries can be done by 
 *		using Transfinite Line.
*/ 


// PARAMETERS

cl = 0.1;

xMin = 0;
yMin = 0;
zMin = 0;

r = 0.5;
D = 2*r;
Lx = 0.5*D;

// POINTS
Point(1) = {xMin, yMin, zMin, cl};
Point(2) = {xMin, yMin + r, zMin, cl};
Point(3) = {xMin, yMin, zMin + r, cl};
Point(4) = {xMin, yMin - r, zMin, cl};
Point(5) = {xMin, yMin, zMin - r, cl};

Point(6) = {xMin + Lx, yMin, zMin, cl};
Point(7) = {xMin + Lx, yMin + r, zMin, cl};
Point(8) = {xMin + Lx, yMin, zMin + r, cl};
Point(9) = {xMin + Lx, yMin - r, zMin, cl};
Point(10) = {xMin + Lx, yMin, zMin - r, cl};

Circle(1) = {2, 1, 3};
Circle(2) = {3, 1, 4};
Circle(3) = {4, 1, 5};
Circle(4) = {5, 1, 2};
Circle(5) = {7, 6, 8};
Circle(6) = {8, 6, 9};
Circle(7) = {9, 6, 10};
Circle(8) = {10, 6, 7};
Line Loop(9) = {-1, -4, -3, -2};
Line Loop(10) = {5, 6, 7, 8};
Plane Surface(11) = {9};
Plane Surface(12) = {10};

Periodic Surface 11 {1,2,3,4} = 12 {5,6,7,8};

nt = 10; // discretization theta
//Transfinite Line{1,2,3,4,5,6,7,8} = nt Using Bump 1;

// Tranfinite args: Left, Right, Alternate
//Transfinite Surface {11} Alternate;
//Transfinite Surface {12} Alternate;

Line(13) = {2, 7};
Line(14) = {3, 8};
Line(15) = {4, 9};
Line(16) = {5, 10};
Line Loop(17) = {1, -13, -5, 14};
Ruled Surface(18) = {17};
Line Loop(19) = {-14, -6, 15, 2};
Ruled Surface(20) = {19};
Line Loop(21) = {-15,-7,16,3};
Ruled Surface(22) = {21};
Line Loop(23) = {-16, -8, 13, 4};
Ruled Surface(24) = {23};


nl = 20; // discretization line
//Transfinite Line {13,14,15,16} = nl Using Bump 1;

Physical Surface("wallNoSlip") = {18,20,22,24};
//Physical Surface("wallInflowU") = {11};
//Physical Surface("wallOutflow") = {12};
Physical Surface("wallLeft") = {11};
Physical Surface("wallRight") = {12};
