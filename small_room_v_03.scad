// My dictionary of this project
	// length (or Y-axis size) = L;
	// width (or X-axis size) = W;
	// hight (or Z-axis size) = H;

	// X-axis shift = dX (from windom to door);
	// Y-axis shift = dY (view the window from right to left);
	// Z-axis shift = dZ (from floor to ceiling);

	// color = clr;

	// Room = RM; wall = w; window = WD; door = DR;
	// draw for all of room
	
	// BookShelf = BS; shelf = s; rack = r;
	// Bad = BD
//====================================================
RM_draw();

RM_H = 2560; // by Z-axis
RM_L = 3300; // by Y-axis
RM_W = 3050; // by X-axis
RM_clr = "lightsalmon";
w_W = 90; // wall`s thickness

WD_H = 1590; WD_L = 1630; WD_W = w_W * 2;
WD_dX = 675; WD_dY = -WD_W * 0.75; WD_dZ = 780;

DR_H = 2000; DR_L = 950; DR_W = w_W * 2;
DR_dX = RM_W - DR_L - 40;
DR_dY = RM_L - DR_W * 0.25; DR_dZ = 0;

module RM_draw(){
	color(RM_clr, 1)
	difference()	{
		RM_base_draw();
		RM_wind_draw();
 		RM_door_draw();}}

module RM_base_draw(){
	difference(){
		// base for draw walls of room
	    translate([-w_W, -w_W, -w_W])
	    cube([RM_W + 2 * w_W, RM_L + 2 * w_W, RM_H + w_W - 0.5]);
	    // base for room self
	    translate([0, 0, 0])
	    cube([RM_W, RM_L, RM_H]);}}

module RM_wind_draw(){
    // base for draw window
    translate([WD_dX, WD_dY, WD_dZ])
    cube([WD_L, WD_W, WD_H]);}

module RM_door_draw(){
    // base for door
    translate([DR_dX, DR_dY, DR_dZ])
    cube([DR_L, DR_W, DR_H]);}
//====================================================
// narrow shelf = N; wide shelf = W;
N = 225; W = 450;

// BS01 - near window; BS02 - next by BS01;
// BS03 - between bads; BS04 - near wardrobe;
// BS03_l and BS03_r - bad as BS (rack without selves) 
BS_clr = "lightyellow";
desk_thick = 18;

s_001_L = 1200;
BD_W = 850;

// BS01
BS01_L = s_001_L; BS01_W = N;
s_BS01_H = [780, 1440, 1760, 2080];
r_BS01_H = [2030+50, 2030+50];
BS01_di = [RM_W-BS01_W, 0, 0]; // dX, dY, dZ
length_BS01 = BS01_L + (r_BS01_H[0] == 0 ? 0 : desk_thick) + (r_BS01_H[1] == 0 ? 0 : desk_thick);

// BS02
BS02_L = s_001_L; BS02_W = N;
s_BS02_H = [780, 1100, 1440, 1760, 2080];
r_BS02_H = [0, 2030+50];
BS02_di = [RM_W-BS01_W, length_BS01, 0]; // dX, dY, dZ

// BS03_l
BS03_l_L = BD_W; BS03_l_W = W;
s_BS03_l_H = [];
r_BS03_l_H = [2550, 2550];
BS03_l_di = [0, 150, 0]; // dX, dY, dZ
length_BS03_l = BS03_l_L + (r_BS03_l_H[0] == 0 ? 0 : desk_thick) + (r_BS03_l_H[1] == 0 ? 0 : desk_thick);
echo(length_BS03_l);

// BS03
BS03_L = 900; BS03_W = W;
s_BS03_H = [558, 878, 1198, 2198];
r_BS03_H = [0, 0];
BS03_di = [0, length_BS03_l+BS03_l_di[1], 0]; // dX, dY, dZ
length_BS03 = BS03_L + (r_BS03_H[0] == 0 ? 0 : desk_thick) + (r_BS03_H[1] == 0 ? 0 : desk_thick);

// BS03_r
BS03_r_L = BD_W; BS03_r_W = W;
s_BS03_r_H = [];
r_BS03_r_H = [2550, 2550];
BS03_r_di = [0, length_BS03_l+BS03_l_di[1]+length_BS03, 0]; // dX, dY, dZ
length_BS03_r = BS03_r_L + (r_BS03_r_H[0] == 0 ? 0 : desk_thick) + (r_BS03_r_H[1] == 0 ? 0 : desk_thick);

// BS04_l
BS04_l_L = 1000; BS04_l_W = W;
s_BS04_l_H = [1100, 2150];
r_BS04_l_H = [2150+50, 2150+50];
BS04_l_di = [-RM_L, 0, 0]; // dX, dY, dZ
length_BS04_l = BS04_l_L + (r_BS04_l_H[0] == 0 ? 0 : desk_thick) + (r_BS04_l_H[1] == 0 ? 0 : desk_thick);

// BS04
BS04_L = 800; BS04_W = W;
s_BS04_H = [500, 830, 1160, 1490, 1820, 2150];
r_BS04_H = [2150+50, 2150+50];
BS04_di = [-RM_L, length_BS04_l, 0]; // dX, dY, dZ

module BS_draw(BS_W, s_BS_L, s_BS_H, r_BS_H, BS_di, angle)
{
	rotate([0,0,angle]){
		translate(BS_di){
		    color(BS_clr, 1)
		    for(j=[0, 2, 1]){
		        if(j<2){
		            ds = r_BS_H[0] == 0 ? 0 : desk_thick;
		            translate([0,(s_BS_L+ds)*j,0])
		            cube([BS_W, desk_thick, r_BS_H[j]]);}
		        else{
			        for(h=s_BS_H){
			    		ds = r_BS_H[0] == 0 ? 0 : desk_thick;
			    		translate([0,ds,h])
			        	shelf_draw(BS_W, s_BS_L);}}}}}
}

module shelf_draw(BS_W, s_BS_L)
{
    cube([BS_W, s_BS_L, desk_thick]);
}

BS_draw(BS01_W, BS01_L, s_BS01_H, r_BS01_H, BS01_di);
BS_draw(BS02_W, BS02_L, s_BS02_H, r_BS02_H, BS02_di);
BS_draw(BS03_l_W, BS03_l_L, s_BS03_l_H, r_BS03_l_H, BS03_l_di);
BS_draw(BS03_W, BS03_L, s_BS03_H, r_BS03_H, BS03_di);
BS_draw(BS03_r_W, BS03_r_L, s_BS03_r_H, r_BS03_r_H, BS03_r_di);
BS_draw(BS04_l_W, BS04_l_L, s_BS04_l_H, r_BS04_l_H, BS04_l_di, -90);
BS_draw(BS04_W, BS04_L, s_BS04_H, r_BS04_H, BS04_di, -90);
