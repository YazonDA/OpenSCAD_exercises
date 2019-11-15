// My dictionary of this project
	// length (or Y-axis size) = L;
	// width (or X-axis size) = W;
	// hight (or Z-axis size) = H;

	// X-axis shift = dX (from windom to door);
	// Y-axis shift = dY (view the window from right to left);
	// Z-axis shift = dZ (from floor to ceiling);

	// color = clr;

	// side part =
	//			SPi for inner;
	//			SPo for outer;
	//			SPt for transverse;
	// plywood = PW; Bad = BD;
	
//====================================================
// draw outer side part

	SPo_clr = "yellow";
	SPo_W = 25;
	SPo_H = 100;
	SPo_L = 2000;

module SPo_draw(length){
	color(SPo_clr, 1)
	cube([length, SPo_W, SPo_H]);}
module SPo_draw_green(length){
	color("green", 1)
	cube([length, SPo_W, SPo_H]);}

//====================================================
// draw inner side part

	SPi_clr = "orange";
	SPi_W = 20;
	SPi_H = 30;
	SPi_L = SPo_L;

module SPi_draw(length){
	color(SPi_clr, 1)
	cube([length, SPi_W, SPi_H]);}

//====================================================
// draw transverse side part

	SPt_clr = "brown";
	SPt_W = 50;
	SPt_H = 50;
	SPt_L = 800;

module SPt_draw(length){
	color(SPt_clr, 1)
	cube([length, SPt_W, SPt_H]);}

//====================================================
// draw one plywood

	PW_clr = "red";
	PW_H = 3.2;
	PW_W = 800;
	PW_L = 450;

module PW_draw(length, width){
	color(PW_clr, 1)
	cube([length, width, PW_H]);}

//====================================================
// draw bad

// draw 1/2 frame
module piece_1_BD_draw(){

	l1 = SPo_L;
	l2 = SPt_L + 2 * SPo_W;
	l2_1 = SPt_L;
	l3 = SPi_L;

	// draw outer detail
		translate([SPo_W, 0, 0])
			SPo_draw(l1);
	
	// draw transverse outer detail
		translate([SPo_W, 0, 0])
			rotate([0, 0, 90])
				SPo_draw_green(l2);

	// draw inner detail
		translate([SPo_W, SPo_W, SPo_H - SPi_H - 15])
			SPi_draw(l3);

	// draw transverse details
		for (i=[0:2]){
			translate([SPt_W + SPo_W + i * 400, SPo_W, 5])
				rotate([0, 0, 90])
					SPt_draw(l2_1);}

	// draw 1/2 plywood
		x = PW_L;
		y = PW_W;
		translate([SPo_W + 400, SPo_W, 5 - PW_H])
			PW_draw(x, y);}

//====================================================
// draw mattress

module mattress(){

	L_m = 2000;
	H_m = 100;
	W_m = 800;
	clr_m = "pink";

	translate([SPo_W, SPo_W, SPo_H - 15])
		color(clr_m, 1)
			cube([L_m, W_m, H_m]);}


//====================================================
//
rotate([0, -$t*90, 0])
translate([-300, 0, 0])
{
piece_1_BD_draw();
mattress();
translate([2000 + 2 * SPo_W, 800 + 2 * SPo_W, 0])
	rotate([0,0,180])
		piece_1_BD_draw();
}