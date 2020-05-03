// My dictionary of this project
	// length (or Y-axis size) = L;
	// width (or X-axis size) = W;
	// hight (or Z-axis size) = H;

	// X-axis shift = dX (from windom to door);
	// Y-axis shift = dY (view the window from right to left);
	// Z-axis shift = dZ (from floor to ceiling);

	// color = clr;

	// Room = RM; wall = w; window = WD; door = DR;
	// windowsill = WS; radiator = RDR;
	
	// BookShelf = BS; shelf = s; rack = r;
	// Bad = BD; desk = DSK;
	x = -370;
	y = -268;
	z = -350;

//====================================================
// draw for all of room

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
	 
	translate([x,y,z])
	RM_draw();

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
	// draw windowsill
		WS_L = 1710;
		WS_W = 95;
		WS_H = 50;
		WS_di = [640, -45, 731];

		translate([x,y,z])
		color("white", 1)
		rotate([0, 0, 0])
		translate([WS_di[0], WS_di[1], WS_di[2]])
		cube([WS_L, WS_W, WS_H]);
	
	// ===========================================================
	// draw radiator set
		RDR_L = 880;
		RDR_W = 200;
		RDR_H = 430;
		RDR_di = [550, 0, 180];

		translate([x,y,z])
		color("white", 1){
		// !!! draw radiator !!!
		    rotate([0, 0, 0])
		    translate([RDR_di[0], RDR_di[1], RDR_di[2]])
		    cube([RDR_L, RDR_W, RDR_H]);
		// !!! draw vertical tube !!!
		    rotate([0, 0, 0])
		    translate([65, 60, 0])
		    cylinder(r=20, h=2500, center=false);
		// !!! draw horizontal tube !!! h = [22, 33]cm
		    for(dZ=[220, 330]){
		        translate([65, 60, dZ])
		        rotate([0, 90, 0])
		        cylinder(r=20, h=RDR_di[0], center=false);}}
	
//====================================================
// draw BookShelfs
	// narrow shelf = N; wide shelf = W;
	// sizes	
		N = 225; W = 450;

		// BS01 - near window; BS02 - next by BS01;
		// BS03 - between bads; BS04 - near wardrobe;
		// BS03_l and BS03_r - bad as BS (rack without selves) 
		r_BS_clr = "lightyellow";
		s_BS_clr = "violet";
		desk_thick = 18;

		s_001_L = 1200;
		BD_W = 850;

		// BS01
		BS01_L = s_001_L; BS01_W = N;
		s_BS01_H = [780, 1440, 1760, 2040];
		r_BS01_H = [2040, 2040];
		BS01_di = [RM_W-BS01_W, 0, 0]; // dX, dY, dZ
		length_BS01 = BS01_L + (r_BS01_H[0] == 0 ? 0 : desk_thick) + (r_BS01_H[1] == 0 ? 0 : desk_thick);

		// BS02
		BS02_L = s_001_L; BS02_W = N;
		s_BS02_H = [780, 1200, 1620, 2040];
		r_BS02_H = [0, 2040];
		BS02_di = [RM_W-BS01_W, length_BS01, 0]; // dX, dY, dZ

		// BS03_l
		BS03_l_L = BD_W; BS03_l_W = W;
		s_BS03_l_H = [];
		r_BS03_l_H = [2550, 2550];
		BS03_l_di = [0, 250, 0]; // dX, dY, dZ
		length_BS03_l = BS03_l_L + (r_BS03_l_H[0] == 0 ? 0 : desk_thick) + (r_BS03_l_H[1] == 0 ? 0 : desk_thick);
		//echo(length_BS03_l);

		// BS03
		BS03_L = 800; BS03_W = W;
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
		r_BS04_l_H = [0, 0];
		BS04_l_di = [-RM_L, 0, 0]; // dX, dY, dZ
		length_BS04_l = BS04_l_L + (r_BS04_l_H[0] == 0 ? 0 : desk_thick) + (r_BS04_l_H[1] == 0 ? 0 : desk_thick);

		// BS04
		BS04_L = 800; BS04_W = W;
		s_BS04_H = [770, 1115, 1460, 1805, 2150];
		r_BS04_H = [2150, 2150];
		BS04_di = [-RM_L, length_BS04_l, 0]; // dX, dY, dZ

	module BS_draw(BS_W, s_BS_L, s_BS_H, r_BS_H, BS_di, angle){
		rotate([0,0,angle]){
			translate(BS_di){
			    for(j=[0, 2, 1]){
			        if(j<2){
			            ds = r_BS_H[0] == 0 ? 0 : desk_thick;
			            translate([0,(s_BS_L+ds)*j,0])
			            color(r_BS_clr, 1)
			            cube([BS_W, desk_thick, r_BS_H[j]]);}
			        else{
				        for(h=s_BS_H){
				    		ds = r_BS_H[0] == 0 ? 0 : desk_thick;
				    		translate([0,ds,h-desk_thick])
				        	shelf_draw(BS_W, s_BS_L);}}}}}}

	module shelf_draw(BS_W, s_BS_L){
	    color(s_BS_clr, 1)
	    cube([BS_W, s_BS_L, desk_thick]);}

	// draw all BookShelfs
		translate([x,y,z]){

		BS_draw(BS01_W, BS01_L, s_BS01_H, r_BS01_H, BS01_di);
		BS_draw(BS02_W, BS02_L, s_BS02_H, r_BS02_H, BS02_di);
		BS_draw(BS03_l_W, BS03_l_L, s_BS03_l_H, r_BS03_l_H, BS03_l_di);
		BS_draw(BS03_W, BS03_L, s_BS03_H, r_BS03_H, BS03_di);
		BS_draw(BS03_r_W, BS03_r_L, s_BS03_r_H, r_BS03_r_H, BS03_r_di);
		BS_draw(BS04_l_W, BS04_l_L, s_BS04_l_H, r_BS04_l_H, BS04_l_di, -90);
		BS_draw(BS04_W, BS04_L, s_BS04_H, r_BS04_H, BS04_di, -90);
		}
	
	//====================================================
	// draw base DSC
		//b_DSK_L = 1500;
		//b_DSK_W = N;
		//b_DSK_H = desk_thick;
		//b_DSK_di = [2780, 60, 780-desk_thick];

		//translate([b_DSK_di[0], b_DSK_di[1], b_DSK_di[2]])
		//rotate([0, 0, 90])
		//shelf_draw(b_DSK_W, b_DSK_L);

		// draw move DSC
		//m_DSK_L = 1500;
		//m_DSK_W = W;
		//m_DSK_H = desk_thick;
		//m_DSK_di = [2780, 60+b_DSK_W, 780-desk_thick];

		//translate([m_DSK_di[0], m_DSK_di[1], m_DSK_di[2]])
		//rotate([0, 0, 90])
		//color("red", 1)
		//cube([m_DSK_W, m_DSK_L, desk_thick]);

//====================================================
// DRAW BED
	{// My dictionary of this project
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

		SPt_clr = "blue";
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
		/*
		l2_1 - 365
		длина ножки от верхней кромки упора для ортопедического основания
		l2_1 - 715
		длина уголка от верхней кромки упора для ортопедического основания
		l2_1 = SPt_L
		SPt_L = 800
		ОСЬ вращение:
			на КРОВАТИ	== 300мм от изголовья

			на СТОЙКЕ	== 350мм от стены
			ВЫСОТА		== 350мм от пола
		*/

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
					for (i=[1:2]){
						translate([SPt_W + SPo_W + i * 400, SPo_W, 5])
							rotate([0, 0, 90])
								SPt_draw(l2_1);}

				// draw corner details
					translate([SPt_W + SPo_W - 50, SPo_W, 85])
							rotate([0, 90, 0])
								SPt_draw(l2_1 - 715);
					translate([SPt_W + SPo_W - 50, SPo_W + 750, 85])
							rotate([0, 90, 0])
								SPt_draw(l2_1 - 715);

				// draw 1/2 plywood
					x = PW_L;
					y = PW_W;
					translate([SPo_W + 400, SPo_W, 5 - PW_H])
						PW_draw(x, y);}

		// draw mattress

			module mattress(){
				L_m = 2000;
				H_m = 100;
				W_m = 800;
				clr_m = "pink";
				translate([SPo_W, SPo_W, SPo_H])
					color(clr_m, 1)
						cube([L_m, W_m, H_m]);}}

		module bed_self(){
			// draw axis
				color("brown", 1)
					translate([300,400,-20])
						rotate([90,0,0])
							cylinder(r=20, h=1000, center=true);

			// draw legs
				color("brown", 1){
					translate([SPt_W + SPo_W - 100 + 2000, SPo_W, 0])
						rotate([0, 90, 0])
							SPt_draw(SPt_L - 430);
					translate([SPt_W + SPo_W - 100 + 2000, SPo_W + 750, 0])
						rotate([0, 90, 0])
							SPt_draw(SPt_L - 430);}

			mattress();
			
			piece_1_BD_draw();
			
			translate([2000 + 2 * SPo_W, 800 + 2 * SPo_W, 0])
				rotate([0,0,180])
						piece_1_BD_draw();}
		
//====================================================
// TURN ANIMATION
//rotate([0, -$t*90, 0])
	rotate([0, -$t*90, 0])
		translate([-300, 0, 20])
			bed_self();

	rotate([0, -90 + $t*90, 0])
		translate([-300, 1686, 20])
			bed_self();
