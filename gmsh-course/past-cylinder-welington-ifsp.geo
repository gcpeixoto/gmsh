/* GMSH SCRIPT v2.9

Descrição: MALHA 3D COM REFINAMENTO ADAPTATIVO PARA ESCOAMENTO EM TORNO DA ESFERA

Nota 1: cuidado ao definir comprimentos característicos muito pequenos,
      pois pode exigir mais memória.

Nota 2: vide documentação para manipular o campo BoundaryLayer.

*/

// Opcionais
Geometry.Normals = 30;    // ativa visualização de vetores normais e escala para 30 
Geometry.LineNumbers = 1; // ativa índices de linhas; 0 para desativar
Mesh.Optimize = 1;        // ativa otimização de malha; 0 para desativar


// comprimentos característicos
cl1 = 0.5; // refinamento do contorno externo
cl2 = 0.1; // refinamento à jusante do contorno interno
cl3 = 0.1; // refinamento à montante do contorno interno
cl4 = 0.5; // refinamento reta central

// dimensionamento
r = 0.5; // raio da esfera
h = r;   // semi-altura do cilindro
D = 2*r; // diâmetro (medida de referência)
L = 6*D; // comprimento
W = 3*D; // largura
H = 3*D; // altura

// coordenadas do ponto de referência do domínio
x0 = 0;
y0 = 0;
z0 = 0;

// ——— DOMÍNIO EXTERNO

// pontos da base
Point(1) = {x0,y0,z0,cl1};
Point(2) = {x0+L,y0,z0,cl1};
Point(3) = {x0+L,y0+W,z0,cl1};
Point(4) = {x0,y0+W,z0,cl1};

// pontos do topo
Point(5) = {x0,y0,z0+H,cl1};
Point(6) = {x0+L,y0,z0+H,cl1};
Point(7) = {x0+L,y0+W,z0+H,cl1};
Point(8) = {x0,y0+W,z0+H,cl1};

// linhas da base
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,1};

// extrusão das linhas da base
Extrude {0, 0, H} { Line{1:4}; }

// loop da base
Line Loop(1) = {1,2,3,4};

// superfície da base
S1 = news;
Plane Surface(S1) = {-1};

// loop do topo
Line Loop(2) = {5,9,13,17};

// superfície do topo
S2 = news;
Plane Surface(S2) = {2};

// ——— DOMÍNIO INTERNO

// centro da esfera:  "Fabs" é a função "valor absoluto"
DX = L/4;
xc = Fabs(L)/2 - DX; 
yc = Fabs(W)/2; 
zc = Fabs(H)/2; 

Point(9) = {xc,yc,zc,cl2};    // centro
Point(10) = {xc+r,yc,zc,cl2}; // +x >> jusante
Point(11) = {xc,yc+r,zc,cl3}; // +y
Point(12) = {xc-r,yc,zc,cl3}; // -x
Point(13) = {xc,yc-r,zc,cl3}; // -y

Extrude{0,0,h}{ Point{10:13};}
Extrude{0,0,-h}{ Point{10:13};}

// arcos equador
C1 = newc;
Circle(C1) = {13, 9, 10};
C2 = newc;
Circle(C2) = {10, 9, 11};
C3 = newc;
Circle(C3) = {11, 9, 12};
C4 = newc;
Circle(C4) = {12, 9, 13};

Extrude{0,0,h}{ Line{C1:C4};}
Extrude{0,0,-h}{ Line{-C1:-C4};}

LL1 = newl;
Line Loop(LL1) = {35,39,43,47};
S1 = news;
Plane Surface(S1) = {LL1};

LL2 = newl;
Line Loop(LL2) = {51,55,59,63};
S2 = news;
Plane Surface(S2) = {LL2};

// linha auxiliar
dx = 0.5*r;
Lx = 2.75*D;
PC1 = newp;
Point(PC1) = {xc+r+dx,yc,zc,cl3};
PC2 = newp;
Point(PC2) = {xc+r+dx+Lx,yc,zc,cl3};

LC1 = newl;
Line(LC1) = {PC1,PC2};

// refinamento adaptativo por atrator e limiar

// constroi atrator em torno da linha auxiliar criada
Field[1] = Attractor;
Field[1].EdgesList = {LC1};

lmb = cl4/5; // comprimento característico h_in
lMb = cl1;   // comprimento característico h_out
dmb = 0.7*r;   // distância mínima do atrator
dMb = 3.5*r; // distância máxima do atrator

Field[2] = Threshold;
Field[2].IField = 1; // limiar sobre campo 1
Field[2].LcMin = lmb;
Field[2].LcMax = lMb;
Field[2].DistMin = dmb;
Field[2].DistMax = dMb;

// resultado final do malhamento
Field[3] = Min; // pega o valor mínimo da lista de campos 'FieldsList'
Field[3].FieldsList = {1,2};
Background Field = 3;

// definindo superfície do cilindro como física
Physical Surface(72) = {70, 62, 66, 58, 54, 46, 42, 38, 50, 68};


// DEFINIÇÃO DO VOLUME FINAL
Surface Loop(73) = {62, 46, 50, 66, 70, 54, 38, 42, 58, 68};
Surface Loop(74) = {16, 21, 20, 8, 12, 22};
Volume(75) = {73, 74};
Physical Volume(76) = {75};
