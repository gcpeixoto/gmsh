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
cl1 = 0.5;  // refinamento do contorno externo
cl2 = 0.1; // refinamento à jusante do contorno interno
cl3 = 0.1; // refinamento à montante do contorno interno

// dimensionamento
r = 0.5; // raio da esfera
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
xc = Fabs(L)/2; 
yc = Fabs(W)/2; 
zc = Fabs(H)/2; 

Point(9) = {xc,yc,zc,cl2};    // centro
Point(10) = {xc+r,yc,zc,cl2}; // +x >> jusante
Point(11) = {xc,yc+r,zc,cl3}; // +y
Point(12) = {xc-r,yc,zc,cl3}; // -x
Point(13) = {xc,yc-r,zc,cl3}; // -y
Point(14) = {xc,yc,zc+r,cl3}; // +z
Point(15) = {xc,yc,zc-r,cl3}; // -z

// arcos equador
C1 = newc;
Circle(C1) = {13, 9, 10};
C2 = newc;
Circle(C2) = {10, 9, 11};
C3 = newc;
Circle(C3) = {11, 9, 12};
C4 = newc;
Circle(C4) = {12, 9, 13};

// arcos hemisfério superior
C5 = newc;
Circle(C5) = {13, 9, 14};
C6 = newc;
Circle(C6) = {10, 9, 14};
C7 = newc;
Circle(C7) = {11, 9, 14};
C8 = newc;
Circle(C8) = {12, 9, 14};

// arcos hemisfério inferior
C9 = newc;
Circle(C9) = {13, 9, 15};
C10 = newc;
Circle(C10) = {10, 9, 15};
C11 = newc;
Circle(C11) = {11, 9, 15};
C12 = newc;
Circle(C12) = {12, 9, 15};

// superfícies
Line Loop(35) = {27, -30, 26};
Ruled Surface(36) = {35};

Line Loop(37) = {30, -29, 25};
Ruled Surface(38) = {37};

Line Loop(39) = {27, -28, -23};
Ruled Surface(40) = {-39};

Line Loop(41) = {28, -29, -24};
Ruled Surface(42) = {-41};

Line Loop(43) = {34, -33, 25};
Ruled Surface(44) = {-43};

Line Loop(45) = {33, -32, 24};
Ruled Surface(46) = {-45};

Line Loop(47) = {32, -31, 23};
Ruled Surface(48) = {-47};

Line Loop(49) = {34, -31, -26};
Ruled Surface(50) = {49};

// ESTRATÉGIA DE REFINAMENTO: ESCOLHER UMA E TESTAR

// 1. reduzir comprimento característico cl2 e cl3

// 2. malhamento transfinito

np1 = 30; // número de nós sobre os arcos da esfera (montante)
np2 = 110; // número de nós sobre os arcos da esfera (jusante)


//Transfinite Line {25,26,30,34} = np1 Using Bump 1;
//Transfinite Line {-28,23,-24,-32} = np2 Using Progression 1.1;


// 3. estratégia de refinamento via BoundaryLayer: hwall * ratio^(dist/hwall)

// definindo superfície da esfera como física
Physical Surface(51) = {50, 42, 48, 38, 40, 46, 44, 36};

// definando campos 
// hfar: tamanho do elemento distante da esfera
// hwall_n: tamanho do elemento normal à esfera
// hwall_t: tamanho do elemento tangente à esfera
// ratio: razão entre duas camadas sucessivas na C-L
// thickness: espessura máxima da C-L

Field[1] = BoundaryLayer;
Field[1].EdgesList = {25,26,30,34};
Field[1].NodesList = {11:15};
Field[1].hfar = 0.5;
Field[1].hwall_n = 0.08;
Field[1].hwall_t = 0.05;
Field[1].ratio = 1.1;
Field[1].thickness = 0.01;
Background Field = 1;



// DEFINIÇÃO DO VOLUME FINAL

Surface Loop(52) = {16, 21, 20, 8, 12, 22};
Surface Loop(53) = {38, 36, 40, 48, 50, 44, 46, 42};
Volume(54) = {52, 53};
Physical Volume(55) = {54};

Printf("Imprimindo variáveis…");
Printf("np1 = %g",np1);
Printf("np2 = %g",np2);


