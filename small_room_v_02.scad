/*
Based on the layout of the II-57 series house
tipdoma.com/2009/10/ceriya-ii-57/
*/


// ===========================================================
// ===========================================================
// !!! BLOCK OF ROOM`S BASE!!!
// SIZES (high, lenght, width)
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
// !!! BLOCK OF WINDOWSILL !!!
// SIZES

// ===========================================================
// !!! draw windowsill !!!


// ===========================================================
// ===========================================================
// !!! BLOCK OF RADIATOR !!!
// SIZES

// ===========================================================
// !!! DRAW RADIATOR SET !!!
// !!! draw radiator !!!

// !!! draw vertical tube !!!

// !!! draw horizontal tube !!! h = [22, 33]cm


// ===========================================================
// ===========================================================
// !!! BLOCK OF SHELF !!!
// SIZES
// constant of shelves
shelf_thick = 18;
shelf_width_S = 225;
shelf_width_L = 450;
shelf_color = "lightyellow";
// MODULE for DRAW one shelf
// The arguments >
// > size=shelf_width_S or shelf_width_L (width 22.5cm or 45cm)
// > length (length of this shelf)
module shelf_draw(size, length)
{
    cube([size, length, shelf_thick]);
};

// constant of rack

// sizes of rack 001 (near the window)
size_001 = shelf_width_S;
length_001 = 1200;
shelves_high_001 = [780, 1305, 1630, 1955];
rack_stand_001 = [2198+50, 1955+50];
// sizes of rack 002 (next near the window)
size_002 = shelf_width_S;
length_002 = 1200;
shelves_high_002 = [780, 1123, 1448, 1823, 2198];
rack_stand_002 = [2198+50, 0];
// sizes of rack 003 (between bads)
size_003 = shelf_width_L;
length_003 = 900;
shelves_high_003 = [558, 878, 1198, 2198];
rack_stand_003 = [0, 0];
// sizes of rack 004 (near the wardrobe)
size_004 = shelf_width_L;
length_004 = 800;
shelves_high_004 = [533, 866, 1193, 1533, 1883, 2233];
rack_stand_004 = [2233+50, 2233+50];
// MODULE for DRAW one rack
// The arguments >
// > size=shelf_width_S or shelf_width_L (width 22.5cm or 45cm)
// > length=??mm (length of this shelf)
// > shelves_high=[??mm] (list of shelf heights from the floor)
// > rack_stand=[left, right] (rack design: list if height of each rack)
module rack_draw(size, length, shelves_high, rack_stand)
{
    color(shelf_color , 1)
    for(j=[0, 2, 1])
    {
        if(j<2)
        {
            translate([0,(length+shelf_thick)*j,0])
            cube([size, shelf_thick, rack_stand[j]]);
        }
        else
        {
	        for(h=shelves_high)
	    	{
	    		translate([0,shelf_thick,h])
	        	shelf_draw(size, length);
	        }
	    }
	}
}

// ===========================================================
// !!! DRAW RACKS !!!
// !!! draw racks 001 !!!
translate([room_width,length_001+2*shelf_thick,0])
rotate([0,0,180])
rack_draw(size_001, length_001, shelves_high_001, rack_stand_001);
// !!! draw racks 002 !!!
translate([room_width,length_001+2*shelf_thick+length_002+shelf_thick,0])
rotate([0,0,180])
rack_draw(size_002, length_002, shelves_high_002, rack_stand_002);
// !!! draw racks 003 !!!
translate([0, dX_bad_L+bad_width+shelf_thick, 0])
rotate([0,0,0])
rack_draw(size_003, length_003, shelves_high_003, rack_stand_003);
// !!! draw racks 004 !!!
translate([900, room_length, 0])
rotate([0,0,-90])
rack_draw(size_004, length_004, shelves_high_004, rack_stand_004);

// ===========================================================
// !!! BLOCK OF WARDROBE`S SIZE !!!

// ===========================================================
// !!! BLOCK OF CABINET`S SIZE !!!


// ===========================================================
// ===========================================================
// !!! BLOCK OF BAD !!!
// SIZES
// sizes of bad
bad_length = 2000;
bad_width = 800;
bad_high = 170;
bad_color = "blueviolet";
dX_bad_L = 250;
dX_bad_R = dX_bad_L+bad_width+length_003+2*shelf_thick;
// MODULE for DRAW one bad
// The arguments >
module bad_draw()
{
    color(bad_color, 1)
    translate([bad_high, shelf_thick, 460])
	rotate([0, -90, 0])
	cube([bad_length, bad_width, bad_high]);
	translate([0, 0, 0])
	rack_draw(shelf_width_L, bad_width, [], [2500, 2500]);
}

// sizes of bad doors

// MODULE for DRAW one bad door
// The arguments >
// >
module bad_door_draw();
/*{
    color("lightyellow", 1)
    cube([size, length, shelf_thick]);
};*/

// MODULE for DRAW one 
// The arguments >
// >
module bad_door_draw();
/*{
    color("lightyellow", 1)
    cube([size, length, shelf_thick]);
};*/

// ===========================================================
// !!! DRAW BADS!!!

// !!! draw open bad !!!

// !!! draw close bad !!!
translate([0,dX_bad_L,0]) bad_draw();
translate([0,dX_bad_R,0]) bad_draw();
// !!! doors of bad !!!

