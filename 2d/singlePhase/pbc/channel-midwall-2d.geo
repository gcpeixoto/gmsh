/*
 File: channel-midwall-2d.geo
 Author: Gustavo Charles P. de Oliveira
 Date: Apr 19th, 2013
 Description: Generates a channel with lateral periodicity and a mid wall.
	      The mid wall width should tend to zero to suit to imposition
  	      of boundary conditions or definition of physical groups. 
              Also useful to represent a pattern of protruded channel.


  # GENERAL PATTERN 
      
      . 
      .
      . 
      ^     
      | 
       _______________
      |       |   |   |
      |       |   |   |
      |       |   |   |
      |   |   |       |
      |   |   |       |
      |___|___|_______|
      |       |   |   | 
      |       |   |   |  
      |	  |   |	  |   |
      |   |   |       |
      |___|___|_______| ——> . . . 


  # PERIODIC MODULE ON X-AXIS

	
       y^
	|	

			       0.5L		
                               |—-|
                7______________6      ___
                |              |       |
                |              |       | H2
                |    2____3 _  |       |
	      __8    |    | |  5__    _|_
             |       |    | |     |    |
           P |       |    | |H2   | P  | H1
             |______1|    4_|_____|   _|_       ——> x
                     
                 L1    L     L1
             |———————|-———|———————|


	P: periodic walls (flow entrance/exit) 


   # MODELLING CRITERIA

 	L —> 0 => thin wall
        L/2    => border to recompose the pattern

*/

/* BEGIN OF CODE */

/* —- Parameters */

wall = 0.05; // characteristic length

xMin = 0.0;
yMin = 0.0;
zMin = 0.0;

L = 0.00001; // as thin as wished
L1 = 2.5; 
H1 = 0.5;
H2 = 0.5;
LT = 2*L1 + L; // total length

npy = 10; // number of periodic points
deltaY = (H1 - yMin)/(npy - 1);

/* —- Periodic nodes */

For y In {1:npy}
pp = newp;
Point(pp) = {xMin,yMin + deltaY * (y-1),zMin,wall};
//NodeCoord[y] = pp;
EndFor

For y In {1:npy}
pp = newp;
Point(pp) = {xMin + LT,yMin + deltaY * (y-1),zMin,wall};
//NodeCoord[y] = pp;
EndFor

/* -- Periodic lines */

k = 0;
For i In {1:npy - 1}
ll = newl;
Line(ll) = {i,i+1};
k+=1;
EndFor

k = 0;
For i In {1:npy - 1}
ll = newl;
Line(ll) = {i + npy,i + npy + 1};
k+=1;
EndFor

/* —- Internal Points */

aux = 2*npy; // auxiliar indice

// Bottom {1,2,3,4}
Point(aux+1) = {xMin + L1,yMin,zMin,wall};
Point(aux+2) = {xMin + L1,yMin + H2,zMin,wall};
Point(aux+3) = {xMin + L1 + L,yMin + H2,zMin,wall};
Point(aux+4) = {xMin + L1 + L,yMin,zMin,wall};

// Top {5,6,7,8}
Point(aux+5) = {xMin + LT - L/2,yMin + H1,zMin,wall};
Point(aux+6) = {xMin + LT - L/2,yMin + H1 + H2,zMin,wall};
Point(aux+7) = {xMin + L/2,yMin + H1 + H2,zMin,wall}; 
Point(aux+8) = {xMin + L/2,yMin + H1,zMin,wall};

/* —- Internal lines */

ll = newl;
Line(ll) = {1,aux+1};
Line(ll+1) = {aux+1,aux+2};
Line(ll+2) = {aux+2,aux+3};
Line(ll+3) = {aux+3,aux+4};
Line(ll+4) = {aux+4,npy+1};

Line(ll+5) = {2*npy,aux+5};
Line(ll+6) = {aux+5,aux+6};
Line(ll+7) = {aux+6,aux+7};
Line(ll+8) = {aux+7,aux+8};
Line(ll+9) = {aux+8,npy};


/* —- Adaption */

wLocal = wall/5;
Transfinite Line{ll+1,ll+3} = 90 Using Bump wLocal; 
Transfinite Line{ll+2} = 30 Using Bump wLocal; 

// 10 pontos
Physical Line("wallNoSlip") = {28, 27, 26, 25, 24, 23, 22, 21, 20, 19};
Physical Line("wallPeriodic11") = {1, 2, 3, 4, 5, 6, 7, 8, 9};
Physical Line("wallPeriodic12") = {10, 11, 12, 13, 14, 15, 16, 17, 18};

// 20 pontos
//Physical Line("wallNoSlip") = {39, 40, 41, 42, 43, 44, 45, 48, 47, 46};
//Physical Line("wallPeriodic11") =  {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19};
//Physical Line("wallPeriodic12") = {20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38};

// 35 pontos
//Physical Line("wallPeriodic11") =  {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34};
//Physical Line("wallPeriodic12") = {35, 36, 37, 38, 39, 40, 41, 42, 44, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68};
//Physical Line("wallNoSlip") = {74, 75, 76, 77, 78, 69, 70, 71, 72, 73};
