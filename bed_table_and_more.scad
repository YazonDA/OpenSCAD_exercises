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
// draw BookShelfs
	// narrow shelf = N; wide shelf = W;
	// sizes	
		N = 225; W = 450;

		// BS03 - between bads;
		// BS03_l and BS03_r - bad as BS (rack without selves) 
		r_BS_clr = "lightyellow";
		s_BS_clr = "violet";
		desk_thick = 18;

		BD_W = 850;

		// BS03_l
		BS03_l_L = BD_W; BS03_l_W = W;
		s_BS03_l_H = [];
		r_BS03_l_H = [2550, 2550];
		BS03_l_di = [0, 250, 0]; // dX, dY, dZ
		length_BS03_l = BS03_l_L + (r_BS03_l_H[0] == 0 ? 0 : desk_thick) + (r_BS03_l_H[1] == 0 ? 0 : desk_thick);
		//echo(length_BS03_l);

		
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

		BS_draw(BS03_l_W, BS03_l_L, s_BS03_l_H, r_BS03_l_H, BS03_l_di);
		}
	
	
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
