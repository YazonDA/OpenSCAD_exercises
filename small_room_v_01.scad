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
window_Z = 780;
window_X = 675;
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
        difference()
        {
            difference()
            {
            // base for draw room with wall
                translate([-room_thick_wall/2, -room_thick_wall/2, -room_thick_wall/2])
                cube([room_width + room_thick_wall, room_length+room_thick_wall, room_high]);
            // small room
                translate([0, 0, 0])
                cube([room_width, room_length, room_high]);
            }    
            // base for draw window
            translate([window_X, -room_thick_wall, window_Z])
            cube([window_length, window_width, window_high]);
        }

        translate([door_X, room_length-room_thick_wall/2, 0])
        cube([door_length, door_width, window_high]);
    }
}

// ===========================================================
// ===========================================================
// !!! BLOCK OF SHELF`S SIZE !!!
shelf_thick = 18;
shelf_width_S = 225;
shelf_width_L = 450;

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
// !!! BLOCK OF BOILER`S SIZE !!!
boiler_length = 1500;
boiler_width = 200;
boiler_high = 430;
dX_boiler = 550;
dY_boiler = 0;
dZ_boiler = 180;
// ===========================================================
// !!! DRAW BOILER SET !!!
color("white", 1)
{
// !!! draw boiler !!!
    rotate([0, 0, 0])
    translate([dX_boiler, dY_boiler, dZ_boiler])
    cube([boiler_length, boiler_width, boiler_high]);
// !!! draw vert tube !!!
    rotate([0, 0, 0])
    translate([65, 60, 0])
    cylinder(r=20, h=2500, center=false);
// !!! draw horiz tube !!! 22 33
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
for(i = [   [[780, 1280, 1580, 1880], 0],
            [[780, 1080, 1380, 1680, 1980], 1000]]) // shelf height set
    for(dZ = i[0])
    {
        shelf_length = 1000;
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
for(dZ = [470, 790, 1110, 1430, 1750, 2070]) // shelf height set
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
for(dZ = [600, 900, 1200, 2200]) // shelf height set
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
// !!! draw bad !!!
    color("indigo", 1)
    rotate([0, 0, 0])
    translate([0, i, 0])
    cube([bad_length, bad_width, bad_high]);
}
