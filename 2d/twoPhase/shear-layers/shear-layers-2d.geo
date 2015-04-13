

w1 = 0.1; // characteristic length
b1 = 0.1;

xMin = 0.0;
yMin = 0.0;
zMin = 0.0;

L = 2.0;
H = 1.0;


Point(1) = {xMin,yMin,zMin,w1};
Point(2) = {xMin+L,yMin,zMin,w1};
Point(3) = {xMin+L,yMin+H,zMin,w1};
Point(4) = {xMin,yMin+H,zMin,w1};

// interface
Point(5) = {xMin,H/2,zMin,b1};
Point(6) = {xMin+L,H/2,zMin,b1};

Line(1) = {1,2};
Line(2) = {2,6};
Line(3) = {6,3};
Line(4) = {3,4};
Line(5) = {4,5};
Line(6) = {5,1};
Line(7) = {5,6};

Periodic Line {5} = {3};
Periodic Line {6} = {2};

Physical Line("wallNormalV") = {4};
Physical Line("wallLeft") = {5,6};
Physical Line("wallRight") = {3,2};
Physical Line("bubble1") = {7};
