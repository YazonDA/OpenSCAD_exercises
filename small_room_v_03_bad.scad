// My dictionary of this project
	// length (or Y-axis size) = L;
	// width (or X-axis size) = W;
	// hight (or Z-axis size) = H;

	// X-axis shift = dX (from windom to door);
	// Y-axis shift = dY (view the window from right to left);
	// Z-axis shift = dZ (from floor to ceiling);

	// color = clr;

	// stick = ST; plywood = PW; Bad = BD;
	
//====================================================
// draw one stick

ST_clr = "yellow";
ST_size = 50;
ST_W = ST_size;
ST_H = ST_size;

module ST_draw(length){
	color(ST_clr, 1)
	cube([length, ST_size, ST_size]);
}

//====================================================
// draw one plywood

PW_clr = "red";
PW_H = 4;

module PW_draw(length, width){
	color(PW_clr, 1)
	cube([length, width, PW_H]);
}

//====================================================
// draw bad

module BD_draw(){

// draw frame
l1 = 2000;
l2 = 800 - 2 * ST_size;

ST_draw(l1);
translate([0, l2 + ST_size, 0])
	ST_draw(l1);
translate([2 * ST_size, ST_size, 0])
	rotate([0, 0, 90])
		ST_draw(l2);
translate([l1/2, ST_size, 0])
	rotate([0, 0, 90])
		ST_draw(l2);
translate([- ST_size + l1, ST_size, 0])
	rotate([0, 0, 90])
		ST_draw(l2);

// draw plywood
x = 500;
y = 800;
translate([0, 0, -PW_H])
	PW_draw(x, y);
translate([l1/2-x/3, 0, -PW_H])
	PW_draw(300, y);
translate([l1-x, 0, -PW_H])
	PW_draw(x, y);
}

//====================================================
//
BD_draw();

