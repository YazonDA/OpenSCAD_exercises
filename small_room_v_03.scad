RM_draw();

// length (or Y-axis size) = L;
// width (or X-axis size) = W;
// hight (or Z-axis size) = H;

// X-axis shift = dX (from windom to door);
// Y-axis shift = dY (view the window from right to left);
// Z-axis shift = dZ (from floor to ceiling);

// color = clr;

// Room = RM; wall = w; window = WD; door = DR;

RM_H = 2560; // by Z-axis
RM_L = 3300; // by Y-axis
RM_W = 3050; // by X-axis
RM_clr = "lightsalmon";
w_W = 90; // wall`s thickness

WD_H = 1590;
WD_L = 1630;
WD_W = w_W * 2;
WD_dX = 675;
WD_dY = -WD_W * 0.75;
WD_dZ = 780;

DR_H = 2000;
DR_L = 950;
DR_W = w_W * 2;
DR_dX = RM_W - DR_L - 40;
DR_dY = RM_L - DR_W * 0.25;
DR_dZ = 0;

module RM_draw()
{
	color(RM_clr, 1)
	difference()
	{
		RM_base_draw();
		RM_wind_draw();
 		RM_door_draw();
	}
}

module RM_base_draw()
{
	difference()
	{
		// base for draw walls of room
	    translate([-w_W, -w_W, -w_W])
	    cube([RM_W + 2 * w_W, RM_L + 2 * w_W, RM_H + w_W - 0.5]);
	
	    // base for room self
	    translate([0, 0, 0])
	    cube([RM_W, RM_L, RM_H]);
	}
}

module RM_wind_draw()
{
    // base for draw window
    translate([WD_dX, WD_dY, WD_dZ])
    cube([WD_L, WD_W, WD_H]);
}

module RM_door_draw()
{
    // base for door
    translate([DR_dX, DR_dY, DR_dZ])
    cube([DR_L, DR_W, DR_H]);
}




// BookShelf = BS; shelf = s; rack = r;
// narrow shelf = N; wide = W;

// BS01 - near window; BS02 - next by BS01;
// BS03 - between bads; BS04 - near wardrobe;

N = 225;
W = 450;

s_001_L = 1200;

s_BS01_L = s_001_L; s_BS01_W = N;
s_BS01_H = [780, 1440, 1760, 2080];
//s_BS01_dX = 0; s_BS01_dY = ; s_BS01_dZ = ;

r_BS01_W = N;
r_BS01_H = [2030+50, 2030+50];
//r_BS01_dX = ; r_BS01_dY = ; r_BS01_dZ = ;

s_BS02_L = s_001_L; s_BS02_W = N;
s_BS02_H = [780, 1100, 1440, 1760, 2080];
//s_BS02_dX = ; s_BS02_dY = ; s_BS02_dZ = ;

r_BS02_H = [2030+50, 0];
r_BS02_W = N;
//r_BS02_dX = ; r_BS02_dY = ; r_BS02_dZ = ;
