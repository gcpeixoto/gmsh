/** File: sinusoidal-wavy-channel-2d.geo
* Author: Gustavo Charles P. de Oliveira
* Date: June, 18th, 2013
*
* Description: Geometry of a 2D wavy passage with PBC implemented by Ragamdia. 
*	       See paper Int. Journal of Thermal Sciences, v. 67, pp. 152-166, 2013.  
*/


ds = 0.5; 

x0 = 0;
y0 = 0;
z0 = 0;

// Geometric data of profile 
a = 0.5; // semi-amplitude
factor_ratio = 8;
L = a * factor_ratio; // wavy passage length 

Hmax = 2; // max width
factor_ratio2 = 0.4;
Hmin = Hmax * factor_ratio2; // min width

np = 15; // number of points over the sinusoidal curve 
dx = L/(np - 1); // distribution of points over the curve


nPer = 3; // number of added periodic passages: 0 => one passage 
gap = L; // period


// Profiler function 
For k In {0:nPer}

  xk = k*gap; // displacement
   
  For t In {1:np}
    vecX[t] = x0 + (t - 1)*dx + xk;
    vecY[t] = 2*a * Sin( Pi * vecX[t] / L ) * Sin( Pi * vecX[t] / L );
    vecYSym[t] = - 2*a * Sin( Pi * vecX[t] / L ) * Sin( Pi * vecX[t] / L ); // symmetry
    pp = newp;
    Point(pp) = {vecX[t],y0 + Hmin/2 + vecY[t],z0,ds};
    vecP[t] = pp;
    pp = newp;
    Point(pp) = {vecX[t],y0 - Hmin/2 + vecYSym[t],z0,ds};
    vecPSym[t] = pp;
  EndFor
  
  ll = newl;
  Line(ll) = {vecPSym[1],vecP[1]};
   
  aux = np - 1;
  For t In {1:aux}
    ll = newl;
    //Printf("vecP: = %g", vecP[t]);
    //Printf("vecPSym: = %g", vecPSym[t]);
    Line(ll) = {vecP[t],vecP[t+1]};
  EndFor

  ll = newl;
  Line(ll) = {vecP[np],vecPSym[np]};

  For t In {1:aux}
    ll = newl;
    //Printf("vecP: = %g", vecP[t]);
    //Printf("vecPSym: = %g", vecPSym[t]);
    Line(ll) = {vecPSym[t+1],vecPSym[t]};
  EndFor

EndFor
Line Loop(31) = {4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 1, 2, 3};
Plane Surface(32) = {31};
