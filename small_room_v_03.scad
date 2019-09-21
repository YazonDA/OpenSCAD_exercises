// BookShelf = BS; shelf = s; rack = r;
// length = L; width = W; hight = H;
// narrow shelf = N; wide = W;
// X-axis shift = dX (from windom to door);
// Y-axis shift = dY (view the window from right to left);
// Z-axis shift = dZ (from floor to ceiling);
// 
// BS01 - near window; BS02 - next by BS01;
// BS03 - between bads; BS04 - near wardrobe;

N = 225;
W = 450;

s_001_L = 1200;

s_BS01_L = s_001_L; s_BS01_W = N;
s_BS01_H = [780, 1440, 1760, 2080];
s_BS01_dX = 0; s_BS01_dY = ; s_BS01_dZ = ;

r_BS01_W = N;
r_BS01_H = [2030+50, 2030+50];
r_BS01_dX = ; r_BS01_dY = ; r_BS01_dZ = ;

s_BS02_L = s_001_L; s_BS02_W = N;
s_BS02_H = [780, 1100, 1440, 1760, 2080];
s_BS02_dX = ; s_BS02_dY = ; s_BS02_dZ = ;

r_BS02_H = [2030+50, 0];
r_BS02_W = N;
r_BS02_dX = ; r_BS02_dY = ; r_BS02_dZ = ;
