/*
Based on the layout of the II-57 series house
tipdoma.com/2009/10/ceriya-ii-57/
*/
// small room`s size (high, lenght, width)
rm_h = 2560;
rm_l = 3300;
rm_w = 3050;
// wall`s thickness
rm_th_wll = 100;
// window`s cube
wnd_h = 1590;
wnd_l = 1630;
wnd_w = rm_th_wll * 2;
// window`s coord by wall
wnd_z = 780;
wnd_x = 675;
// door`s cube
dr_h = 2000;
dr_l = 950;
dr_w = rm_th_wll * 2;
// door`s ccord by wall
dr_x = rm_w - dr_l - 40;


difference()
{
    difference()
    {
        difference()
        {
            // base for draw room with wall
            translate([-rm_th_wll/2, -rm_th_wll/2, -rm_th_wll/2])
            {color("peachpuff", 1)
            {cube([rm_w + rm_th_wll, rm_l+rm_th_wll, rm_h]);}
            }
            // small room
            translate([0, 0, 0])
            {cube([rm_w, rm_l, rm_h]);}
        }    
        // base for draw window
        translate([wnd_x, -rm_th_wll, wnd_z])
        {cube([wnd_l, wnd_w, wnd_h]);}
    }

    translate([dr_x, rm_l-rm_th_wll/2, 0])
    {cube([dr_l, dr_w, wnd_h]);}
}