// serpentine.geo 

// Opcionais
Geometry.Points = 0;                 
Geometry.PointNumbers = 0;     
Geometry.Lines = 1;
Geometry.Normals = 30;            // ativa visualização de vetores normais e escala para 30 
Geometry.LineNumbers = 0;      // ativa índices de linhas; 0 para desativar
Geometry.SurfaceNumbers = 0;
Mesh.Optimize = 0;                   // ativa otimização de malha; 0 para desativar

Geometry.ExtrudeSplinePoints = 20; // controle de pontos de interpolação para extrusão


// comprimentos característicos
cl1 = 0.2; // refinamento do contorno interno
cl2 = 0.4; // refinamento do contorno externo

// dimensionamento
r1 = 0.5;              // raio interno
r2 = 1.0;              // raio externo
D1 = 2*r1;           // diâmetro interno 
D2 = 2*r2;           // diâmetro externo
D = 0.5*(D1+D2); // diâmetro médio (medida de referência)

// coordenadas do ponto de referência do domínio
x0 = 0;
y0 = 0;
z0 = 0;

// centro da circunferência
xc = x0+3*D; // deslocamento 
yc = y0; 
zc = z0; 

Point(1) = {xc,yc,zc,cl1};      // centro
Point(2) = {xc+r1,yc,zc,cl1}; // +x 
Point(3) = {xc,yc,zc+r1,cl1}; // +z
Point(4) = {xc-r1,yc,zc,cl1}; // -x
Point(5) = {xc,yc,zc-r1,cl1}; // -z

Point(6) = {xc+r2,yc,zc,cl2}; // +x 
Point(7) = {xc,yc,zc+r2,cl2}; // +z
Point(8) = {xc-r2,yc,zc,cl2}; // -x
Point(9) = {xc,yc,zc-r2,cl2}; // -z

C1 = newc;
Circle(C1) = {5, 1, 2};
C2 = newc;
Circle(C2) = {2, 1, 3};
C3 = newc;
Circle(C3) = {3, 1, 4};
C4 = newc;
Circle(C4) = {4, 1, 5};

C5 = newc;
Circle(C5) = {9, 1, 6};
C6 = newc;
Circle(C6) = {6, 1, 7};
C7 = newc;
Circle(C7) = {7, 1, 8};
C8 = newc;
Circle(C8) = {8, 1, 9};


// PARÂMETROS DA SERPENTINA

nv = 6; // número de voltas

// direção do eixo (padrão: eixo ao longo de Z)
xa = 0;
ya = 0;
za = 1;

// ponto sobre o eixo
xp = 0;
yp = 0;
zp = 0;

// translação (separação da serpentina)
xt = 0;
yt = 0;
zt = 2*D;

Line Loop(9) = {7, 8, 5, 6};
Line Loop(10) = {3, 4, 1, 2};
Plane Surface(11) = {9, 10};
Plane Surface(12) = {10};


For i In {1:nv}

If (i == 1 )
a1[] = Extrude {{xt,yt,zt}, {xa, ya, za}, {xp, yp, zp}, 2*Pi} {  Surface{11}; };
a2[] = Extrude {{xt,yt,zt}, {xa, ya, za}, {xp, yp, zp}, 2*Pi} {  Surface{12}; };
EndIf

If ( i != 1 )
is1 = a1[0];
is2 = a2[0];
a1[] = Extrude {{xt,yt,zt}, {xa, ya, za}, {xp, yp, zp}, 2*Pi} {  Surface{is1}; };
a2[] = Extrude {{xt,yt,zt}, {xa, ya, za}, {xp, yp, zp}, 2*Pi} {  Surface{is2}; };
EndIf

EndFor

// VOLUME GLOBAL SÃO TODAS AS ESPIRAIS
For i In {1:nv}
v[i-1] = 2*i-1;
EndFor
Physical Volume("global") = {v[]};
