/*
Based on the layout of the II-57 series house
tipdoma.com/2009/10/ceriya-ii-57/
*/

// ===========================================================
// ===========================================================
// !!! BLOCK OF ROOM`S SIZE !!!
// small room`s size (high, lenght, width)
room_high = 2560;
room_length = 3300;
room_width = 3050;
// wall`s thickness
room_thick_wall = 90;
// window`s cube
window_high = 1590;
window_length = 1630;
window_width = room_thick_wall * 2;
// window`s coord by wall
dX_window = 675;
dY_window = -room_thick_wall;
dZ_window = 780;
// door`s cube
door_high = 2000;
door_length = 950;
door_width = room_thick_wall * 2;
// door`s ccord by wall
door_X = room_width - door_length - 40;
// ===========================================================
// !!! DRAW ROOM BASE !!!
//set white color for all
color("lightsalmon", 1)
{
    difference()
    {
        // base for draw walls of room
        translate([-room_thick_wall/2, -room_thick_wall/2, -room_thick_wall/2])
        cube([room_width + room_thick_wall, room_length+room_thick_wall, room_high]);

        // base for room self
        translate([0, 0, 0])
        cube([room_width, room_length, room_high]);
        
        // base for draw window
        translate([dX_window, dY_window, dZ_window])
        cube([window_length, window_width, window_high]);
    
        // base for door
        translate([door_X, room_length-room_thick_wall/2, 0])
        cube([door_length, door_width, door_high]);
    }
}

// ===========================================================
// ===========================================================
// !!! BLOCK OF SHELF`S SIZE !!!
shelf_thick = 18;
shelf_width_S = 225;
shelf_width_L = 450;
// module for draw one shelf
// arg
// > size=shelf_width_S or shelf_width_L (width 22.5cm or 45cm)
// > length (length of this shelf)
module shelf_draw(size=shelf_width_S, length)
{
    color("lightyellow", 1)
    cube([size, length, shelf_thick]);
};

// ===========================================================
// !!! BLOCK OF WARDROBE`S SIZE !!!
// ===========================================================
// !!! BLOCK OF CABINET`S SIZE !!!


// ===========================================================
// ===========================================================
// !!! BLOCK OF WINDOWSILL`S SIZE !!!
windowsill_length = 1710;
windowsill_width = 95;
windowsill_high = 50;
dX_windowsill = 640;
dY_windowsill = -45;
dZ_windowsill = 731;
// ===========================================================
// !!! draw windowsill !!!
color("white", 1)
rotate([0, 0, 0])
translate([dX_windowsill, dY_windowsill, dZ_windowsill])
cube([windowsill_length, windowsill_width, windowsill_high]);

// ===========================================================
// ===========================================================
// !!! BLOCK OF RADIATOR`S SIZE !!!
boiler_length = 1500;
boiler_width = 200;
boiler_high = 430;
dX_boiler = 550;
dY_boiler = 0;
dZ_boiler = 180;
// ===========================================================
// !!! DRAW RADIATOR SET !!!
color("white", 1)
{
// !!! draw radiator !!!
    rotate([0, 0, 0])
    translate([dX_boiler, dY_boiler, dZ_boiler])
    cube([boiler_length, boiler_width, boiler_high]);
// !!! draw vertical tube !!!
    rotate([0, 0, 0])
    translate([65, 60, 0])
    cylinder(r=20, h=2500, center=false);
// !!! draw horizontal tube !!! h = [22, 33]cm
    for(dZ=[220, 330])
    {
        translate([65, 60, dZ])
        rotate([0, 90, 0])
        cylinder(r=20, h=dX_boiler, center=false);
    }
}

// ===========================================================
// ===========================================================
// !!! DRAW SHELVES NEAR THE WINDOW !!!
for(i = [   [[780, 1305, 1630, 1955], 0],
            [[780, 1123, 1448, 1823, 2198], 1200]]) // shelf height set
    for(dZ = i[0])
    {
        shelf_length = 1200;
        dX = room_width-shelf_width_S;
        dY = i[1];
        rotate([0, 0, 0])
        translate([dX, dY, dZ])
        shelf_draw(shelf_width_S, shelf_length);
    }

// ===========================================================
// ===========================================================
// !!! DRAW WARDROBE !!!
// !!! draw shelf rack !!!
for(dZ = [900-shelf_thick, 1700]) // rack distance set
{
    dX = room_length-shelf_width_L;
    dY = 0;
    rack_height = 2500;
    rotate([90, 0, 90])
    translate([dX, dY, dZ])
    shelf_draw(shelf_width_L, rack_height);
}
// !!! draw wardrobe`s shelves !!!
for(dZ = [533, 866, 1193, 1533, 1883, 2233]) // shelf height set
{
    shelf_length = 800;
    dX = room_length-shelf_width_L;
    dY = -1700;
    rotate([0, 0, 90])
    translate([dX, dY, dZ])
    shelf_draw(shelf_width_L, shelf_length);
}

// ===========================================================
// ===========================================================
// !!! DRAW SHELVES BETWEEN BADS !!!
// !!! draw bad`s shelves !!!
for(dZ = [558, 878, 1198, 2198]) // shelf height set
{
    shelf_length = 900; // #001 POINT OF ATTENTION == 900
    dX = 0;
    dY = dX_bad_L+bad_width+shelf_thick;
    rotate([0, 0, 0])
    translate([dX, dY, dZ])
    shelf_draw(shelf_width_L, shelf_length);
}

// ===========================================================
// ===========================================================
// !!! BLOCK OF BAD`S SIZE !!!
bad_length = 2000;
bad_width = 800;
bad_high = 170;
dX_bad_L = (room_length-1750) - 900/2 - bad_width - 2*shelf_thick; // #001 POINT OF ATTENTION == 900
dX_bad_R = dX_bad_L + bad_width + 2*shelf_thick + 900; // #001 POINT OF ATTENTION == 900
// ===========================================================
// !!! DRAW BADS!!!
// !!! draw bad rack !!!
for(i=[dX_bad_L, dX_bad_R])
{  
    for(dZ = [i, i+bad_width+shelf_thick]) // rack distance set
    {
        dX = 0;
        dY = 0;
        rack_height = 2500;
        rotate([90, 0, 0])
        translate([0, 0, -dZ])
        shelf_draw(shelf_width_L,rack_height);
    }

// !!! draw open bad !!!
    color("red", 1)
    rotate([0, 0, 0])
    translate([0, i, 290])
    cube([bad_length, bad_width, bad_high]);
/*
// !!! draw close bad !!!
    color("blueviolet", 1)
    translate([bad_high, i, 460])
    rotate([0, -90, 0])
    cube([bad_length, bad_width, bad_high]);
*/
// !!! doors of bad !!!
	shelf_thick = 18;
	dr_width = 830;
	for(length=[[2000, 500], [440, 40]])
	{
	    if (i == dX_bad_L)
	    	{
            iX = shelf_width_L;
	    	iY = shelf_thick;}
		else
			{
			iX = shelf_width_R;
			iY = shelf_thick/2;}
	
	    color("red", 1) //lightyellow
	    translate([iX, i - iY, length[1]])
	    cube([shelf_thick, dr_width, length[0]]);
	}
}
