

// simulations
//nb = 1;
//b1 = 0.1;
//wall = 0.8;
//wallhd = 0.1;

// test
nb = 1;
b1 = 0.2;
wall = 0.7;
wallhd = 0.4;


D = 1.0;
r = 0.5*D;
slug = 0.7*r;
pert = (0.0/100.0)*D/2.0;

For t In {0:nb-1}
 // bubble's coordinates
 xc = 0.0 + 1.0*D +(slug+r+r+r/2.0)*t;
 yc = 0.0;
 zc = 0.0;
 Include '../../bubble-shapes/rabello-sphere.geo';
EndFor

wallLength = D+D;

/*
 *              6           2
 *              o --------- o 
 *
 *
 *
 *              o --------- o 
 *              5           3
 *
 * */

k=10000;
Point(k+1) = { 0.0*D,         0.0,  0.0, wall}; // center
Point(k+2) = { 0.0*D,  1.5*D-pert,  0.0, wallhd}; // up
Point(k+3) = { 0.0*D,  5.0*D-pert,  0.0, wall}; // up

Point(k+4) = { wallLength*D,         0.0,  0.0, wall}; // center
Point(k+5) = { wallLength*D,  1.5*D-pert,  0.0, wallhd}; // up
Point(k+6) = { wallLength*D,  5.0*D-pert,  0.0, wall}; // up
Line(k+29) = {k+01, k+02};
Line(k+30) = {k+02, k+03};
Line(k+31) = {k+03, k+06};
Line(k+32) = {k+06, k+05};
Line(k+33) = {k+05, k+04};
Extrude {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Line{k+29, k+30, k+31, k+32, k+33};
}
Extrude {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Line{k+34, k+37, k+41, k+45, k+49};
}
Extrude {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Line{k+52, k+55, k+59, k+63, k+67};
}
Extrude {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Line{k+70, k+73, k+77, k+81, k+85};
}

Physical Surface('wallRight') = {k+90, k+94, k+40, k+36, k+58, k+76, k+72, k+54};
Physical Surface('wallLeft') = {k+66, k+48, 10102, k+84, k+69, k+51, 10105, k+87};
//Physical Surface('wallInflowZeroU') = {k+98, k+80, k+62, k+44};
Physical Surface('wallNoSlip') = {k+98, k+80, k+62, k+44};

// outer
Periodic Surface k+48{k+45,k+43,k+32,k+47} = k+40{-(k+37),k+39,-(k+30),k+35};
Periodic Surface k+102{k+32,k+97,k+81,k+101} = k+94{-(k+30),k+93,-(k+73),k+89};
Periodic Surface k+84{k+81,k+79,k+63,k+83} = k+76{-(k+73),k+75,-(k+55),k+71};
Periodic Surface k+66{k+63,k+61,k+45,k+65} = k+58{-(k+55),k+57,-(k+37),k+53};


// inner
Periodic Surface k+51{k+49,k+47,k+33} = k+36{-(k+34),k+35,-(k+29)};
Periodic Surface k+105{k+33,k+101,k+85} = k+90{-(k+29),k+89,-(k+70)};
Periodic Surface k+87{k+85,k+83,k+67} = k+72{-(k+70),k+71,-(k+52)};
Periodic Surface k+69{k+67,k+65,k+49} = k+54{-(k+52),k+53,-(k+34)};


/*
j=200*0;
For t In {1:nb}
 Physical Surface(Sprintf("bubble%g",t)) = {j+10, j+40, j+49, j+25, j+13, j+37, j+52, j+22, j+16, j+34, j+43, j+46, j+31, j+19, j+7, j+28};
 j=200*t;
EndFor
*/

// refining
//Transfinite Line {k+29, k+34, k+52, k+70, k+67, k+85, k+33, k+49} = wallhd*150 Using Progression 1;
Transfinite Line {k+29, k+34, k+52, k+70, k+67, k+85, k+33, k+49} = wallhd*20 Using Progression 1;
