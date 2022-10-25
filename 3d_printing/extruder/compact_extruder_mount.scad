// Avoid openscad artefacts in preview
epsilon = 0.01 * 1;

$fn=100;

// Which one would you like to see?
part = "nah"; // [first:Main Part,second:Idler,both:Main Part and Idler]




// Select idler version (V2 should provide further strength, but is bulkier)
idler_version = 2; // [1:V1 (open design), 2:V2 (closed two part splitted design)]

idler_bushing_d = 7;
idler_bushing_h = 0.2;

idler_screw_len = 16;
idler_screwhead_d = 11;

// Increase this if your slicer or printer make holes too tight (default 0.1)
extra_radius = 0.1;

// Add a clamping handle (manually remove tension for filament insertion)
add_clamping_handle = 1; // [0:No, 1:Yes]

// Add a M3 screwhole trough handle (only for V2 idler) - use a M3 screw and corresonding nut to add further strength
add_handle_screw = 1;  // [0:No, 1:Yes]

tensioner_bolt_gap = 4;

// Major diameter of metric 3mm thread
m3_major = 2.85*1;
m3_radius = 3.2/2;//m3_major / 2 + extra_radius; //for m3 clearance holes
m3_wide_radius = 3.3/2;//m3_major / 2 + extra_radius + 0.2;

// echo(2*m3_radius);

// Diameter of metric 3mm hexnut screw head
m3_head_radius = 3 + extra_radius;

// Height of base (default: 5mm)
base_height = 5*1;        // [2:0.1:10]

/* [Drive gear parameters] */
// Outer diameter of drive gear
drive_gear_dia = 9;
drive_gear_outer_radius = drive_gear_dia / 2;

// Diameter of hobbed section
drive_gear_hobbed_dia = 7.4;
drive_gear_hobbed_radius = drive_gear_hobbed_dia / 2;

// How far is the hobbed section away from outer face
drive_gear_hobbed_offset = 3.2;

// Height of drive gear (only important for gears with height >13mm)
drive_gear_height = 11;
drive_gear_length = max(13, drive_gear_height);
drive_gear_tooth_depth = 0.2;


/* [Mounting Options] */
add_mounting_plate = 0; // [0:None,1:Anet A8 Mount,2: Generic Mount]

// Base width for frame plate (Generic mount only)
base_width = 15;
// Base width for frame plate (Generic mount only)
base_length = 60;


top_height = 1*4.9;




// Stepper (nema 17) dimensions
nema17_width = 42.3 * 1;
nema17_hole_offsets = [
	[-15.5, -15.5, 1.5],
	[-15.5,  15.5, 1.5],
	[ 15.5, -15.5, 1.5],
	[ 15.5,  15.5, 1.5 + base_height]
];



/* [Filament Inlet] */

// Select inlet type (For now: normal and M5 pushfit without thread as option!)
inlet_type = 0; // [0:Normal, 1:Pushfit]


/* [Filament Outlet] */
// Add thread to hole (set to 'no', if your printer can't handle fine details)
outlet_thread = 0; // [0:No, 1:Yes]

// Select your pushfit thread (recommended: M5)
outlet_dia = 8; // [5:M5, 6:M6, 7:M7, 8:M8, 9:M9, 10:M10]


//length of the outlet guide tube
outlet_len = 42 + 6.5 - 1;
//output
outlet_base_len = 42;


/* [Filament Diameter] */
// Choose your filament diameter
filament_diameter = 3; // [1.75:1.75, 3.00:3.00]
filament_offset = [
	drive_gear_hobbed_radius + filament_diameter / 2 - drive_gear_tooth_depth,
	0,
	base_height + drive_gear_length - drive_gear_hobbed_offset - 2.5
];




// helper function to render a rounded slot
module rounded_slot(r = 1, h = 1, l = 0, center = false)
{
	hull()
	{
		translate([0, -l / 2, 0])
			cylinder(r = r, h = h, center = center);
		translate([0, l / 2, 0])
			cylinder(r = r, h = h, center = center);
	}
}


// mounting plate for nema 17
module nema17_mount()
{
	// settings
	width = nema17_width;
	height = base_height;
	edge_radius = 27;
	axle_radius = drive_gear_outer_radius + 1 + extra_radius;

	difference()
	{
		// base plate
		translate([0, 0, height / 2])
            union() {
    			intersection()
    			{
    				cube([width, width, height], center = true);
    				cylinder(r = edge_radius, h = height + 2 * epsilon, $fn = 128, center = true);
    			}
                translate([nema17_hole_offsets[3][0], nema17_hole_offsets[3][1], base_height/2]) cylinder(h=idler_bushing_h, d=idler_bushing_d);
            }

        translate([filament_diameter + 1 + filament_offset[0], -nema17_width / 2 + 4, base_height])
        hull() {
            rotate([0, 90, 0]) cylinder(r = 3.15 + 2.5 * extra_radius - .1, h = 2.5 + 3 * extra_radius, center = true, $fn = 6);
            translate([0, 0, -20]) rotate([0, 90, 0]) cylinder(r = 3.15 + 2.5 * extra_radius - .1, h = 2.5 + 3 * extra_radius, center = true, $fn = 6);
        
        }

		// center hole
		translate([0, 0, -epsilon]	)
			cylinder(r = 11.25 + extra_radius, h = base_height + 2 * epsilon, $fn = 64);

		// axle hole
		translate([0, 0, -epsilon])
			cylinder(r = axle_radius, h = height + 2 * epsilon, $fn = 64);

		// mounting holes
		for (a = nema17_hole_offsets)
			translate(a)
			{
				cylinder(r = m3_radius, h = height * 4, center = true, $fn = 50);
				cylinder(r = m3_head_radius, h = height + epsilon, $fn = 50);
			}

	}
}


// plate for mounting extruder on frame
module frame_mount()
{
	// settings
	width = base_width;
	length = base_length;
	height = base_height;
	hole_offsets = [
		[0,  length / 2 - 6, 2.5],
		[0, -length / 2 + 6, 2.5]
	];
	corner_radius = 3;

	difference()
	{
		// base plate
		intersection()
		{
			union()
			{
				translate([0, 0, height / 2])
					cube([width, length, height], center = true);
				translate([base_width / 2 - base_height / 2 - corner_radius / 2, 0, height + corner_radius / 2])
					cube([base_height + corner_radius, nema17_width, corner_radius], center = true);
				translate([base_width / 2 - base_height / 2, 0, 6])
					cube([base_height, nema17_width, 12], center = true);
			}

			cylinder(r = base_length / 2, h = 50, $fn = 64);
		}

		// rounded corner
		translate([base_width / 2 - base_height - corner_radius, 0, height + corner_radius])
			rotate([90, 0, 0])
				cylinder(r = corner_radius, h = nema17_width + 2 * epsilon, center = true, $fn = 64);

		// mounting holes
		for (a = hole_offsets)
			translate(a)
			{
				cylinder(r = m3_wide_radius, h = height * 2 + 2 * epsilon, center = true, $fn = 50);
				cylinder(r = m3_head_radius, h = height + epsilon, $fn = 50);
			}

		// nema17 mounting holes
		translate([base_width / 2, 0, nema17_width / 2 + base_height])
			rotate([0, -90, 0])
			for (a = nema17_hole_offsets)
				translate(a)
				{
					cylinder(r = m3_radius, h = height * 4, center = true, $fn = 50);
					cylinder(r = m3_head_radius, h = height + epsilon, $fn = 50);
				}
	}
}

// plate for mounting extruder on frame
module frame_mount_anet()
{
    base_width_anet = 15;
    base_length_anet = 60;

	// settings
	width = 60;
	length = nema17_width+base_height;
	height = base_height;
	hole_offsets = [
		[40,  length / 2 - 8, 2.5],
		[40-23, length / 2 - 8 - 16, 2.5]
	];
	corner_radius = 3;

	difference()
	{
		// base plate
        union(){
            intersection()
            {
                union()
                {
                    translate([20, -height / 2, height / 2])
                        cube([width, length, height], center = true);
                    translate([base_width_anet / 2 - base_height / 2 - corner_radius / 2, -height / 2, height + corner_radius / 2])
                        cube([base_height + corner_radius, nema17_width+height, corner_radius], center = true);
                    translate([base_width_anet / 2 - base_height / 2, -height / 2, 6])
                        cube([base_height, nema17_width+height, 12], center = true);
                }

                union(){
                    translate([25, -height / 2, 0])
                    cylinder(r = base_length_anet / 2, h = 50, $fn = 64);
                    translate([15, -height / 2, 0])
                    cylinder(r = base_length_anet / 2, h = 50, $fn = 64);
                }
            }
            // Triangle support

            difference(){
                translate([height/2+2*epsilon, -length/2 - height/2 + epsilon, epsilon])
                    cube([40,height , 36]);

                translate([0, -length/2 - height/2 - 2*epsilon, 43.5])
                    rotate([0,45,0])
                        cube([60,height + 4*epsilon, 30]);
            }
        }

		// rounded corner
		translate([base_width_anet / 2 - base_height - corner_radius, -height / 2, height + corner_radius])
			rotate([90, 0, 0])
				cylinder(r = corner_radius, h = nema17_width + height + 2 * epsilon, center = true, $fn = 64);

		// mounting holes
		for (a = hole_offsets)
			translate(a)
			{
				cylinder(r = m3_wide_radius, h = height * 2 + 2 * epsilon, center = true, $fn = 50);
				cylinder(r = m3_head_radius, h = height + epsilon, $fn = 50);
			}

		// nema17 mounting holes
		translate([base_width_anet / 2, 0, nema17_width / 2 + base_height])
			rotate([0, -90, 0])
			for (a = nema17_hole_offsets)
				translate(a)
				{
					cylinder(r = m3_radius, h = height * 4, center = true, $fn = 50);
					cylinder(r = m3_head_radius, h = height + epsilon, $fn = 50);
				}
	}
}


// inlet for filament
module filament_tunnel()
{
	// settings
	width = 8;
	length = nema17_width;
	height = filament_offset[2] - base_height + 4;

	translate([0, 0, height / 2])
	{
        union()
        {

            difference()
            {
                union()
                {
                    // base
                    translate([-width/2 - height, -length/2, -height/2])
                        cube([width + height, length, height + top_height], center = false);

                    // inlet strengthening
                    translate([0, -length / 2, -height / 2 + filament_offset[2] - base_height])
                        rotate([90, 0, 0])
                            cylinder(r = 3.5, h = 1, center = true, $fn = 64);

                    // outlet strengthening
                    translate([0, length / 2, -height / 2 + filament_offset[2] - base_height])
                        rotate([90, 0, 0])
                            cylinder(r = 3.5, h = 1, center = true, $fn = 64);

                    // idler tensioner
                    intersection()
                    {
                        translate([5 - width/2, -length / 2, -height/2])
                            cube([width, 16, height + top_height], center = false);
                        translate([-17.8, -20 ,-height/2])
                            cylinder(r = 27, h = height + top_height + 2 * epsilon, center = false, $fn = 64);
                    }

                    // outlet pushfitting housing
                    translate([0, length / 2 - 8 + epsilon, -height / 2 + filament_offset[2] - base_height])
                    rotate([-90, 0, 0])
                    cylinder(r = outlet_dia/2 + 1.5, h = outlet_base_len);


                    // hull() {
                    translate([0, length / 2 + epsilon, -height / 2 + filament_offset[2] - base_height])
                        rotate([-90, 0, 0]) cylinder(r = outlet_dia/2 + 1.5, h = outlet_base_len);

                    // translate([0, outlet_base_len + length / 2 + epsilon, -height / 2 + filament_offset[2] - base_height])
                    //     rotate([-90, 0, 0]) cylinder(r1 = outlet_dia/2 + 1.5, d2=3, h = outlet_len - outlet_base_len);



                    translate([-outlet_dia/2, length / 2 + epsilon,  - height/2 - base_height])
                        cube([outlet_dia + 3 - 3, outlet_base_len, outlet_dia + 3]);
                    // }

                     // echo(drive_gear_length - drive_gear_hobbed_offset - 2.5 - height / 2);



                    translate([0, length / 2 + epsilon - 8, -height / 2 + filament_offset[2] - base_height])
                    rotate([90, 0, 0])
                    cylinder(r1 = outlet_dia/2 + 1.5, r2 = 3, h = 4);

                }

                // middle cutout for drive gear
                translate([-filament_offset[0], 0, -height/2 - epsilon])
                    cylinder(r = 11.25 + extra_radius, h = height + top_height +  2 * epsilon, center = false, $fn = 64);

                // middle cutout for idler
                translate([11 + filament_diameter / 2, 0, -height/2 - epsilon])
                    cylinder(r = 12.5, h = height + top_height + 2 * epsilon, center = false, $fn = 64);

                // idler mounting hexnut


                //adcurtin

                // translate([-10, 3+outlet_base_len + length / 2 + epsilon, -height / 2 + filament_offset[2] - base_height])
                //         cube(20);// rotate([-90, 0, 0]) cylinder(r1 = outlet_dia/2 + 1.5, d2=3, h = outlet_len - outlet_base_len);


                //bottom tensioner bolt hole
                translate([-4, -nema17_width / 2 + 4, .25 - tensioner_bolt_gap/2])
                    rotate([0, 90, 0])
                        cylinder(r = m3_radius, h = 50, center = false, $fn = 64);


                //bottom nut slot
                // translate([filament_diameter + 3, -nema17_width / 2 + 4, 5 - tensioner_bolt_gap/2])
                //     cube([2.5 + 3 * extra_radius, 5.5 + 2.5 * extra_radius, 10 + tensioner_bolt_gap/2], center = true);
                translate([filament_diameter + 1, -nema17_width / 2 + 4, -tensioner_bolt_gap/2])
                hull() {
                    rotate([0, 90, 0]) cylinder(r = 3.15 + 2.5 * extra_radius - 0.25, h = 2.5 + 3 * extra_radius, center = true, $fn = 6);
                    translate([0, 0, -20]) rotate([0, 90, 0]) cylinder(r = 3.15 + 2.5 * extra_radius - .1, h = 2.5 + 3 * extra_radius, center = true, $fn = 6);
                
                }


                //top tensioner bolt hole
                translate([-4, -nema17_width / 2 + 4, .25 + tensioner_bolt_gap/2 + 2*m3_radius])
                    rotate([0, 90, 0])
                        cylinder(r = m3_radius, h = 50, center = false, $fn = 64);


                // //top nut slot
                translate([filament_diameter + 1, -nema17_width / 2 + 4, tensioner_bolt_gap/2 + 2*m3_radius])
                hull() {
                    rotate([0, 90, 0]) cylinder(r = 3.15 + 2.5 * extra_radius - .25, h = 2.5 + 3 * extra_radius, center = true, $fn = 6);
                    translate([0, 0, 20]) rotate([0, 90, 0]) cylinder(r = 3.15 + 2.5 * extra_radius -.1, h = 2.5 + 3 * extra_radius, center = true, $fn = 6);

                }


                // cylinder(r = 3.15 + 2.5 * extra_radius, h = 2.5 + 3 * extra_radius, center = true, $fn = 6);






                // rounded corner
                hull() {
                translate([-height - width / 2 - 1, -epsilon, height / 2])
                    rotate([90, 0, 0])
                        cylinder(r = height, h = length + 4 * epsilon, center = true, $fn = 64);

                translate([-height - width / 2 - 1, -epsilon, height / 2 + top_height])
                    rotate([90, 0, 0])
                        cylinder(r = height, h = length + 4 * epsilon, center = true, $fn = 64);
                }

                // funnnel inlet
                if (inlet_type == 0)
                {
                    // normal type
                    translate([0, -length / 2 + 1 - epsilon, -height / 2 + filament_offset[2] - base_height])
                        rotate([90, 0, 0])
                            cylinder(r1 = filament_diameter / 2, r2 = filament_diameter / 2 + 1 + epsilon / 1.554,
                                h = 3 + epsilon, center = true, $fn = 50);
                }
                else
                {
                    // inlet push fit connector m5 hole
                    translate([0, -length / 2 - 1 + 2.5 + epsilon, -height / 2 + filament_offset[2] - base_height])
                        rotate([90, 0, 0])
                            cylinder(r = 2.25, h = 5 + 2 * epsilon, center = true, $fn = 50);

                    // funnel inlet outside
                    translate([0, -length / 2 + 4, -height / 2 + filament_offset[2] - base_height])
                        rotate([90, 0, 0])
                            cylinder(r1 = filament_diameter / 2, r2 = filament_diameter / 2 + 1,
                                h = 2, center = true, $fn = 50);

                }

                // funnnel outlet inside
                translate([0, 12, -height / 2 + filament_offset[2] - base_height])
                    rotate([90, 0, 0])
                        cylinder(r1 = filament_diameter / 2, r2 = filament_diameter / 2 + 1.25,
                            h = 8, center = true, $fn = 50);

                // outlet push fit connector hole
                // translate([0, length / 2 + 1 - 2.5 + epsilon, -height / 2 + filament_offset[2] - base_height])
                //     rotate([90, 0, 0])
                //         cylinder(r = outlet_dia/2, h = 8 + 2 * epsilon, center = true, $fn = 50);

                // funnel outlet outside
                // #translate([0, length / 2 - 4, -height / 2 + filament_offset[2] - base_height])
                //     rotate([90, 0, 0])
                //         cylinder(r1 = filament_diameter / 2 + 1, r2 = filament_diameter / 2,
                //             h = 2, center = true, $fn = 50);

                // filament path
                translate([0, 1, -height / 2 + filament_offset[2] - base_height])
                    rotate([90, 0, 0])
                        cylinder(r = filament_diameter / 2 + 2 * extra_radius,
                            h = length + 2 * epsilon + 100, center = true, $fn = 50);

                // screw head inlet
                translate(nema17_hole_offsets[2] - [filament_offset[0], 0, height / 2 + 1.5])
                    sphere(r = m3_head_radius, $fn = 50);
            }

            if(outlet_thread){
                // add outlet thread
                translate([0, length / 2 +  2*epsilon, -height / 2 + filament_offset[2] - base_height])
                    rotate([90, 0, 0])
                    thread_in(outlet_dia,8);
            }
        }
	}
}


// render drive gear
module drive_gear()
{
	r = drive_gear_outer_radius - drive_gear_hobbed_radius;
    difference()
    {
        rotate_extrude(convexity = 10)
        {
            difference()
            {
                square([drive_gear_outer_radius, drive_gear_length]);
                translate([drive_gear_hobbed_radius + r, drive_gear_length - drive_gear_hobbed_offset])
                    circle(r = r, $fn = 50);

            }
        }
        cylinder(r=2.5,h=20);
    }
}


// render 608zz
module bearing_608zz()
{
	difference()
	{
		cylinder(r = 11, h = 7, center = true, $fn = 64);
		cylinder(r = 4, h = 7 + 2 * epsilon, center = true, $fn = 50);
	}
}


//fix hinge screw
// idler with 608 bearing, simple version
module idler_608_v1()
{
	// settings
	width = nema17_width;
	height = filament_offset[2] - base_height + 4;
	edge_radius = 27;
	hole_offsets = [-width / 2 + 4, width / 2 - 4];
	bearing_bottom = filament_offset[2] / 2 - base_height / 2 - 6;
	offset = drive_gear_hobbed_radius - drive_gear_tooth_depth + filament_diameter;
	pre_tension = 0.25;
	gap = 1;

	// base plate
	translate([0, 0, height / 2 + idler_bushing_h])
	difference()
	{
		union()
		{
			// base
			intersection()
			{
				translate([-width/2, -width/2, -height/2]) cube([width, width, height + top_height - idler_bushing_h], center = false);
				translate([0, 0, -height/2])
					cylinder(r = edge_radius, h = height + top_height + 2 * epsilon, $fn = 128, center = false);
				translate([offset + 10.65 + gap, 0, 0])
					translate([-15/2, -nema17_width/2, -height/2]) cube([15, nema17_width + epsilon, height + top_height], center = false);
			}

			// bearing foot enforcement
			translate([offset + 11 - pre_tension, 0, -height / 2])
				cylinder(r = 4 - extra_radius + 1, h = height - .5, $fn = 64);

			// spring base enforcement
			translate([17.15, -nema17_width / 2 + 4, .25 - tensioner_bolt_gap/2 - idler_bushing_h])
				rotate([0, 90, 0])
					cylinder(r = 3.75, h = 4, $fn = 64);

            // spring base enforcement
            translate([17.15, -nema17_width / 2 + 4, .25 + tensioner_bolt_gap/2 + filament_diameter - idler_bushing_h])
                rotate([0, 90, 0])
                    cylinder(r = 3.75, h = 4, $fn = 64);

            if(add_clamping_handle)
            hull(){
                translate([17.15, -nema17_width / 2 - 8, -height/2])
                    cylinder(r = 3, h = height + top_height - idler_bushing_h, $fn = 64);
                translate([17.15 -4,-width/2 - 5, -height/2])
                    cube([8, 10, height + top_height - idler_bushing_h], center = false);
            }

		}

		translate([offset + 11 - pre_tension, 0, bearing_bottom])
			difference()
			{
				// bearing spare out
				cylinder(r = 11.5, h = 25, $fn = 64);

				// bearing mount
				cylinder(r = 4 - extra_radius, h = 7.5, $fn = 64);

				// bearing mount base
				cylinder(r = 4 - extra_radius + 1, h = 0.5, $fn = 64);
			}

		// bearing mount hole
		translate([offset + 11 - pre_tension, 0, 0])
			cylinder(r = 2.5, h = 50, center = true, $fn = 64);

		// bottom tensioner bolt slot
        // adcurtin
		translate([17.15, -nema17_width / 2 + 4, .25 - tensioner_bolt_gap/2 - idler_bushing_h])
			rotate([0, 90, 0])
				rounded_slot(r = m3_wide_radius, h = 20, l = 1.5, center = true, $fn = 64);

        // top tensioner bolt slot
        translate([17.15, -nema17_width / 2 + 4, .25 + tensioner_bolt_gap/2 + 2*m3_radius - idler_bushing_h])
            rotate([0, 90, 0])
                rounded_slot(r = m3_wide_radius, h = 20, l = 1.5, center = true, $fn = 64);


		// fastener cutout
		translate([offset - 18.85 + gap, -20 , -height/2 -2])
			cylinder(r = 27, h = height + top_height + 4, center = false, $fn = 64);

		// mounting hole
		translate([15.5, 15.5, 0])
		{
			cylinder(r = m3_wide_radius, h = height * 4, center = true, $fn = 50);
			translate([0, 0, top_height -1]) cylinder(r = m3_head_radius, h = height + epsilon, $fn = 50);
		}

        // outlet pushfitting housing
        translate([offset, width/2 + epsilon, 1.5])
        rotate([90, 0, 0])
        cylinder(r = outlet_dia/2 + 1.5, h = 8);

        translate([offset, width/2 +epsilon*2 -8, 1.5])
        rotate([90, 0, 0])
        cylinder(r1 = outlet_dia/2 + 1.5, r2 = 3, h = 4);

	}

	translate([offset + 11 - pre_tension, 0, filament_offset[2] - base_height])
		%bearing_608zz();
}


//fix hinge screw, spring screws, and height
// new idler with 608 bearing
module idler_608_v2()
{
	// settings
	width = nema17_width;
	height = filament_offset[2] - base_height + 4;
	edge_radius = 27;
	hole_offsets = [-width / 2 + 4, width / 2 - 4];
	bearing_bottom = filament_offset[2] / 2 - base_height / 2 - 6;
	offset = drive_gear_hobbed_radius - drive_gear_tooth_depth + filament_diameter;
	pre_tension = 0.25;
	gap = 1;
	top = 2;

    screw_bushing_height = idler_screw_len - height - top_height + 0.2;

    top_height = top_height - top + screw_bushing_height;



    // echo(screw_bushing_height);

	// base plate
	translate([0, 0, height / 2 + 0])
	difference()
	{
		union()
		{
			// base
			translate([0, 0, top / 2])
			intersection()
			{
				translate([-width/2, -width/2, -height/2 - top/2 + idler_bushing_h]) cube([width, width, height + top - idler_bushing_h + top_height], center = false);
				translate([0, 0, -height/2 -top/2])
					cylinder(r = edge_radius, h = height + top + 2 * epsilon + top_height, $fn = 128, center = false);
				translate([offset + 10.65 + gap -15/2, -nema17_width/2, -height/2 -top/2])
					cube([15, nema17_width + epsilon, height + top  + top_height], center = false);
			}

			// bearing foot enforcement
			translate([offset + 11 - pre_tension, 0, -height / 2 + idler_bushing_h])
				cylinder(r = 4 - extra_radius + 1, h = height - .5 - idler_bushing_h - epsilon, $fn = 64);


            // bearing screw top bushing - my screw is too long
            // translate([offset + 11 - pre_tension, 0, height / 2 + top_height + top])
            //     cylinder(d = idler_screwhead_d, h = screw_bushing_height, $fn = 64);


			// // spring base enforcement
			// translate([17.15, -nema17_width / 2 + 4, .25])
			// 	rotate([0, 90, 0])
			// 		cylinder(r = 3.75, h = 4, $fn = 64);

            // spring base enforcement
            // translate([17.15, -nema17_width / 2 + 4, .25 - tensioner_bolt_gap/2 - idler_bushing_h])
            //     rotate([0, 90, 0])
            //         cylinder(r = 3.75, h = 4, $fn = 64);

            // // spring base enforcement
            // translate([17.15, -nema17_width / 2 + 4, .25 + tensioner_bolt_gap/2 + filament_diameter - idler_bushing_h])
            //     rotate([0, 90, 0])
            //         cylinder(r = 3.75, h = 4, $fn = 64);


            if(add_clamping_handle)
            hull(){
                translate([17.15, -nema17_width / 2 - 8, -height/2 + idler_bushing_h])
                    cylinder(r = 3, h = height+ top - idler_bushing_h + top_height, $fn = 64);
                translate([17.15 -4,-width/2 -5, -height/2 + idler_bushing_h])
                    cube([8, 10, height+ top - idler_bushing_h + top_height], center = false);
            }
		}

		translate([offset + 11 - pre_tension, 0, bearing_bottom])
			difference()
			{
				// bearing spare out
				cylinder(r = 11.5, h = 8, $fn = 64);

				// bearing mount
				cylinder(r = 4 - extra_radius, h = 8, $fn = 64);

				// bearing mount base
				cylinder(r = 4 - extra_radius + 1, h = 0.5, $fn = 64);

				// bearing mount top
				translate([0, 0, 7.5])
					cylinder(r = 4 - extra_radius + 1, h = 0.5, $fn = 64);
			}

		// bearing mount hole
		translate([offset + 11 - pre_tension, 0, 0])
			cylinder(d = 4.8, h = 50, center = true, $fn = 64); //m5 self tap hole

		// tensioner bolt slot
		// #translate([17.15, -nema17_width / 2 + 4, .25])
		// 	rotate([0, 90, 0])
		// 		rounded_slot(r = m3_wide_radius, h = 50, l = 1.5, center = true, $fn = 64);

        // bottom tensioner bolt slot
        // adcurtin
        translate([17.15, -nema17_width / 2 + 4, .25 - tensioner_bolt_gap/2])
            rotate([0, 90, 0])
                rounded_slot(r = m3_wide_radius, h = 20, l = 1.5, center = true, $fn = 64);

        // top tensioner bolt slot
        translate([17.15, -nema17_width / 2 + 4, .25 + tensioner_bolt_gap/2 + 2*m3_radius])
            rotate([0, 90, 0])
                rounded_slot(r = m3_wide_radius, h = 20, l = 1.5, center = true, $fn = 64);


		// fastener cutout
		translate([offset - 18.85 + gap, -20, -height/2 -epsilon])
			cylinder(r = 27, h = height + top + 2 * epsilon + top_height, center = false, $fn = 64);

		// mounting hole
		translate([15.5, 15.5, 0])
		{
			cylinder(r = m3_wide_radius, h = height * 4, center = true, $fn = 50);
			translate([0, 0, height / 2 + top - 4 + top_height])
				cylinder(r = m3_head_radius, h = height + epsilon, $fn = 50);
		}

        // outlet pushfitting housing
        translate([offset, width/2 + epsilon, 1.5])
        rotate([90, 0, 0])
        cylinder(r = outlet_dia/2 + 1.5, h = 8);

        translate([offset, width/2 +epsilon*2 -8, 1.5])
        rotate([90, 0, 0])
        cylinder(r1 = outlet_dia/2 + 1.5, r2 = 3, h = 4);

        if(add_handle_screw){
        // screwhole for handle
        translate([17.4, -nema17_width / 2 - 5, -height/2-epsilon])
             cylinder(d = 2.9, h = height+ top + 4*epsilon + top_height, $fn = 50);

       // translate([17.4, -nema17_width / 2 - 5, height/2 + top - 4])
       //      cylinder(r = m3_head_radius, h = height + epsilon, $fn = 50);
        }
	}

	translate([offset + 11 - pre_tension, 0, filament_offset[2] - base_height])
		%bearing_608zz();
}



// new idler splitted in printable parts
module idler_608_v2_splitted()
{
    idler_height = filament_offset[2] - base_height + 4 - idler_bushing_h + top_height;

    // echo(idler_height);

	intersection()
	{
		translate([0, 0, -idler_bushing_h]) idler_608_v2();
		translate([-nema17_width/2, -nema17_width/2 - 18, 0]) cube([nema17_width, nema17_width+35, idler_height/2], center = false);
	}

	translate([nema17_width + 8, 0, idler_height])
		rotate([0, 180, 0])
			difference()
			{
				translate([0, 0, -idler_bushing_h]) idler_608_v2();
				translate([-nema17_width/2, -nema17_width/2 - 20, -idler_height/2]) cube([nema17_width + 2, nema17_width + 2 +35, idler_height], center = false);
			}

}


// compose all parts
module compact_extruder()
{
	// motor plate
	nema17_mount();


	// mounting plate
    if(add_mounting_plate==2){
	translate([-nema17_width / 2 - base_height, 0, base_width / 2])
		rotate([0, 90, 0])
			frame_mount();
    }

    if(add_mounting_plate==1){
	translate([-nema17_width / 2 - base_height, 0, 15 / 2])
		rotate([0, 90, 0])
			frame_mount_anet();
    }

	// filament inlet/outlet
	translate([filament_offset[0], 0, base_height - epsilon])
		filament_tunnel();

	// drive gear
	color("grey")
		%translate([0, 0, base_height - 2.5])
			drive_gear();

	// filament
	// color("red")
	// 	%translate(filament_offset - [0, 0, epsilon])
	// 		rotate([90, 0, 0])
	// 			cylinder(r = filament_diameter / 2, h = 100 + 2*outlet_len, $fn = 50, center = true);
}



module thread_in(dia,hi,thr=16)
{
	p = get_coarse_pitch(dia);
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	t = (hi-p)/p;			// number of turns
	n = t*thr;				// number of segments
	echo(str("dia=",dia," hi=",hi," p=",p," h=",h," Rmin=",Rmin," s=",s));
	difference()
	{
		cylinder(r = (dia/2)+1.5,h = hi);
		translate([0,0,-1]) cylinder(r = (dia/2)+0.1, h = hi+2);
	}
	for(sg=[0:n])
		th_in_pt(Rmin+0.1,p,s,sg,thr,h,(hi-p)/n);
}
// function for thread pitch
function get_coarse_pitch(dia) = lookup(dia, [
[1,0.25],[1.2,0.25],[1.4,0.3],[1.6,0.35],[1.8,0.35],[2,0.4],[2.5,0.45],[3,0.5],[3.5,0.6],[4,0.7],[5,0.8],[6,1],[7,1],[8,1.25],[10,1.5],[12,1.75],[14,2],[16,2],[18,2.5],[20,2.5],[22,2.5],[24,3],[27,3],[30,3.5],[33,3.5],[36,4],[39,4],[42,4.5],[45,4.5],[48,5],[52,5],[56,5.5],[60,5.5],[64,6],[78,5]]);

module th_in_pt(rt,p,s,sg,thr,h,sh)
// rt = radius of thread (nearest centre)
// p = pitch
// s = segment length (degrees)
// sg = segment number
// thr = segments in circumference
// h = ISO h of thread / 8
// sh = segment height (z)
{
//	as = 360 - (((sg % thr) * s) - 180);	// angle to start of seg
//	ae = as - s + (s/100);		// angle to end of seg (with overlap)
	as = ((sg % thr) * s - 180);	// angle to start of seg
	ae = as + s -(s/100);		// angle to end of seg (with overlap)
	z = sh*sg;
	pp = p/2;
	//         2,5
	//          /|
	//  1,4 /  |
 	//        \  |
	//          \|
	//         0,3
	//  view from front (x & z) extruded in y by sg
	//
	polyhedron(
		points = [
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z],				//0
			[cos(as)*rt,sin(as)*rt,z+(3/8*p)],						//1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/4*p)],		//2
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh],			//3
			[cos(ae)*rt,sin(ae)*rt,z+(3/8*p)+sh],					//4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+(3/4*p)+sh]],	//5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

module extruder_combined() {
    // rotate([0,-90,180])
    {
       compact_extruder();

    if(idler_version == 2){
    translate([0, 0, base_height])
        idler_608_v2();
    }
    else
    {
     translate([0, 0, base_height])
            idler_608_v1();
    }
}
}

if (part == "first") {
        if(add_mounting_plate == 1){
            rotate([0,-90,180])
                compact_extruder();
        }
        else{
            compact_extruder();
        }
	} else if (part == "second") {
		if(idler_version == 2){
            idler_608_v2_splitted();
        }
        else
        {
            idler_608_v1();
        }
	} else if (part == "both") {
		extruder_combined();
	} else {
		//extruder_combined();
	}

//translate([20, 0, 0])
//	idler_608_v2_splitted();