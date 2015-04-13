

// variables

i=100*t;
j=200*t;

/*
 *            2
 *            o 
 *          / 1`,     
 *       5 o  o  o 4    
 *          \  ,'
 *            o 
 *            3
 *
 * */

Point(i+1) = {xc, yc, zc, b1}; // center
Point(i+2) = {xc+r+pert, yc, zc, b1}; // right
Point(i+3) = {xc-r-pert, yc, zc, b1}; // left
Point(i+4) = {xc, yc, zc+r-pert, b1}; // up
Point(i+5) = {xc, yc, zc-r+pert, b1}; // down
Ellipse(j+1) = {i+4, i+1, i+1, i+2};
Ellipse(j+2) = {i+2, i+1, i+1, i+5};
Ellipse(j+3) = {i+3, i+1, i+1, i+5};
Ellipse(j+4) = {i+4, i+1, i+1, i+3};
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/4} {
  Line{j+1, j+2, j+3, j+4};
}
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/4} {
  Line{j+5, j+14, j+11, j+8};
}
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/4} {
  Line{j+17, j+20, j+23, j+26};
}
Extrude {{0, 0, 1}, {xc, yc, zc}, Pi/4} {
  Line{j+29, j+32, j+35, j+38};
}

