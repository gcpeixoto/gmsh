// Gmsh project created on Tue May 12 01:57:49 2015

Mesh.Points = 1;
Mesh.PointNumbers = 1;

c = 0.04;
Point(1) = {0.0, 0.0, 0, c};
Point(2) = {1.0, 0.0, 0, c};
Point(3) = {1.0, 1.0, 0, c};
Point(4) = {0.0, 1.0, 0, c};
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};
Physical Line("wallNormalU") = {2,4};
Physical Line("wallNormalV") = {1,3};
