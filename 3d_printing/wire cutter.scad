include <OpenSCAD-common.scad>
use <extruder/compact_extruder_mount.scad>
use <wire straightener/wire straightener.scad>
use <lcd/lcd.scad>
use <mainboard/mainboard.scad>



fast_preview = 0;

module fp(){
    if(fast_preview) render() children();
    else children();
}

//animation
anim = 2*($t < 0.5 ? $t : (1-$t));

anim_height = 20*anim;

// echo(anim_height);

$fn=150;


ep = 0.01 * 1;


spool_bearing_d = 16;
spool_bearing_th = 4.9;
spool_bearing_screwhead_d = 12;
spool_bearing_screwhead_th = 3;
spool_cylinder_th = 2;
spool_cylinder_d = 18.5;
spool_h     = 48;
spool_d     = 130;


corner_rad = 7;

spool_base_x  = 40;
spool_base_y  = 53;
spool_base_th = 3.5;
spool_side_th = 4.8;


container_h = 36;
container_l = 120;
container_w = 42.8;
container_th = 2;
container_radius = 8;

container_small_l = 16;




motor_mount_th = 3.65;

nema_w = 42.3;
nema_h = 36;
nema_screw_w = 31;
nema_bushing_h = motor_mount_th;
nema_bushing_d = 23;

z_axis_stop_height = 47.5;


mech_endstop_w = 5.75;
mech_endstop_l = 12.6;
mech_endstop_h = 6.5;
mech_endstop_screw_d = 1.9;
mech_endstop_screw_gap = 6.65;
mech_endstop_screw_z_o = 1.5;


mech_endstop_e_h = 2.5; //extra height above the switch
mech_endstop_z_o =  z_axis_stop_height - mech_endstop_h - mech_endstop_e_h;//33.5 + 5;


//slop in the leadscrews, endstop springs to help

mech_endstop_spring_od = 5.3; //outside diameter for clearance
mech_endstop_spring_id = 3.4;
mech_endstop_spring_l = 25;
mech_endstop_spring_c_l = 10;

mech_endstop_spring_e_d = 5.1; //end diameter to hold the springs
mech_endstop_spring_e_l = 4;



optical_endstop_z_o = z_axis_stop_height - 8;




z_flag_base_th  = 3.25;
z_flag_base_w   = 20;
z_flag_base_l   = 12;

z_flag_base_o   = 19.65;



z_flag_w        = 2;
z_flag_l        = 8;
z_flag_h        = 10;


//z axis attachment
attachment_h = 30;
attachment_w = 25;
attachment_screw_l = 14;
attachment_nut_dp = 8;
attachment_nut_rotation = 30;

threaded_rod_d = 10.4;
blade_stepper_gap = 92.265;





//blade holder
top_blade_holder_w = 65;
top_blade_holder_r = 4;
top_blade_holder_l = 22;
top_blade_holder_h = 3.25;
top_blade_holder_screw_gap = 57;


bottom_blade_holder_w = 43;
bottom_blade_holder_r = 8;
bottom_blade_holder_l = 24.8 + 3.4;
bottom_blade_holder_h = 3.25;
bottom_blade_holder_screw_gap = 28.5;
bottom_blade_holder_screw_x = 15.4;


blade_holder_w  = 13.6;
blade_holder_l  = 8;
blade_holder_h  = 15 + .8;

//blades
blade_w = 7;
blade_th = 1;
top_blade_h = 11.25;
bottom_blade_h = 13.15;
bottom_blade_e_w = 11;
bottom_blade_e_w_h = 3.75;
bottom_blade_e_w_h_o = 2.8;

blade_cut = 3.3;
blade_notch_w = 2.5;
blade_notch_o = top_blade_h - 4.6;

blade_y_offset = 49 + blade_cut;
blade_overcut = 1;

blade_overlap = .1;
blade_over_angle = 4;


blade_holder_screw_d = 2.4;
screwhole_d = 3.3;
base_screwhole_d = 4.3;



linear_rod_d = 8.1;
linear_rod_l = 175;
linear_rod_gap = 34;

linear_bearing_d = 15;
linear_bearing_l = 17;

linear_slider_d = 15;
linear_slider_l = 40;

linear_slider_base_th = 5.3;
linear_slider_base_d = 32;
linear_slider_base_w = 21;

// linear_slider_screwhead_d = 5.6;
linear_slider_screw_d = screwhole_d;
linear_slider_screw_gap = 23.75;

linear_slider_nut_dp = 10;



mounting_board_w = 300;
mounting_board_l = 500;
mounting_board_th = 18;



module linear_slider(cutout=0) {
    difference() {
        union() {
            intersection() {
                cylinder(h=linear_slider_base_th, d=linear_slider_base_d);
                translate([-linear_slider_base_d/2, -linear_slider_base_w/2, 0]) cube([linear_slider_base_d, linear_slider_base_w, linear_slider_base_th]);
            }
            cylinder(h=linear_slider_base_th + linear_slider_l, d=linear_slider_d);
        }
        if(cutout==0) translate([0, 0, -1]) linear_rod();

        translate([linear_slider_screw_gap/2, 0, -1]) cylinder(h=linear_slider_base_th + 2, d=linear_slider_screw_d);
        translate([-linear_slider_screw_gap/2, 0, -1]) cylinder(h=linear_slider_base_th + 2, d=linear_slider_screw_d);

    }

    if(cutout) {
        translate([linear_slider_screw_gap/2, 0, -1]) cylinder(h=linear_slider_base_th + linear_slider_nut_dp + 0.5, d=linear_slider_screw_d);
        translate([-linear_slider_screw_gap/2, 0, -1]) cylinder(h=linear_slider_base_th + linear_slider_nut_dp + 0.5, d=linear_slider_screw_d);

        // nut slots
        hull() {
            translate([linear_slider_screw_gap/2, 0, linear_slider_nut_dp]) M3_hex_nut();
            translate([linear_slider_screw_gap, 0, linear_slider_nut_dp]) M3_hex_nut();
        }

        hull() {
            translate([-linear_slider_screw_gap/2, 0, linear_slider_nut_dp]) M3_hex_nut();
            translate([-linear_slider_screw_gap, 0, linear_slider_nut_dp]) M3_hex_nut();
        }
    }
}

// !linear_slider(1);


module linear_bearing() {
    difference() {
        cylinder(h=linear_bearing_l, d=linear_bearing_d);
        translate([0, 0, -1]) linear_rod();
    }
}


module linear_rod(extra_d=0) {
    cylinder(h=linear_rod_l, d=linear_rod_d + extra_d);
}



// top_blade();

module top_blade(cutout=0){
    translate([0, 0, blade_y_offset-blade_cut]) {
        if(cutout) translate([-10, 0, blade_notch_o + blade_notch_w/2]) rotate([0, 90, 0]) cylinder(h=blade_th+20, d=blade_notch_w);
        translate([0, 0, blade_cut]) rotate([0, blade_over_angle, 0]) translate([0, 0, -blade_cut]) 
        difference() {
            union() {
                translate([-blade_th, -blade_w/2, 0]) cube([blade_th, blade_w, top_blade_h]);
            }
            if(cutout==0) hull() {
                translate([-10, 0, blade_notch_o + blade_notch_w/2]) rotate([0, 90, 0]) cylinder(h=blade_th+20, d=blade_notch_w);
                translate([-1, 0, top_blade_h + blade_notch_o]) rotate([0, 90, 0]) cylinder(h=blade_th+2, d=blade_notch_w);
            }

            if(cutout==0)
            translate([0, 0, blade_cut]) 
            scale([1, 1, 1.4]) 
            rotate([180+45, 40, 0]) 
            translate([-3, 0, 0]) cube([blade_cut+4, blade_cut+1, blade_cut+1]);
        }
    }
}

module bottom_blade(cutout=0){
    translate([-blade_overlap, 0, blade_y_offset + blade_cut + blade_overcut]) rotate([0, 180, 0]) {
        if(cutout) translate([-10, 0, blade_notch_o + blade_notch_w/2]) rotate([0, 90, 0]) cylinder(h=blade_th+20, d=blade_notch_w);
        translate([0, 0, blade_cut]) rotate([0, blade_over_angle, 0]) translate([0, 0, -blade_cut])  difference() {
            union() {
                translate([-blade_th, -blade_w/2, 0]) cube([blade_th, blade_w, bottom_blade_h]);
                translate([-blade_th, -bottom_blade_e_w/2, bottom_blade_e_w_h_o]) cube([blade_th, bottom_blade_e_w, bottom_blade_e_w_h]);
            }
            if(cutout==0) hull() {
                translate([-10, 0, blade_notch_o + blade_notch_w/2]) rotate([0, 90, 0]) cylinder(h=blade_th+20, d=blade_notch_w);
                translate([-1, 0, top_blade_h + blade_notch_o]) rotate([0, 90, 0]) cylinder(h=blade_th+2, d=blade_notch_w);
            }

            if(cutout==0)
            translate([0, 0, blade_cut]) 
            scale([1, 1, 1.4]) 
            rotate([180+45, 40, 0]) 
            translate([-3, 0, 0]) cube([blade_cut+4, blade_cut+1, blade_cut+1]);
        }
    }
}

module nema17(screw_len = 15, cutout=0){
    translate([-nema_w/2, -nema_w/2, 0]) cube([nema_w, nema_w, nema_h]);
    translate([nema_screw_w/2, nema_screw_w/2, nema_h]) cylinder(h=screw_len, d=screwhole_d);
    translate([-nema_screw_w/2, nema_screw_w/2, nema_h]) cylinder(h=screw_len, d=screwhole_d);
    translate([nema_screw_w/2, -nema_screw_w/2, nema_h]) cylinder(h=screw_len, d=screwhole_d);
    translate([-nema_screw_w/2, -nema_screw_w/2, nema_h]) cylinder(h=screw_len, d=screwhole_d);

    hull() {
        translate([0, 0, nema_h - 0.01]) cylinder(h=nema_bushing_h +2, d=nema_bushing_d);
        if(cutout) {
            translate([0, 0, nema_h - 0.01]) cylinder(h=nema_bushing_h +10 +z_axis_stop_height, d=nema_bushing_d);
            translate([nema_w, 0, nema_h - 0.01]) cylinder(h=nema_bushing_h +10 +z_axis_stop_height, d=nema_bushing_d);
        }
    }

    //stepper shaft
    translate([0, 0, nema_h]) cylinder(h=15, d=5);
}

module mech_endstop_switch(screw_len = 0){
    difference() {
        translate([-mech_endstop_l/2, 0, 0]) cube([mech_endstop_l, mech_endstop_w, mech_endstop_h]);

        translate([mech_endstop_screw_gap/2, -1, mech_endstop_screw_z_o]) rotate([270,0,0]) cylinder(h=2*mech_endstop_w, d= mech_endstop_screw_d);
        translate([-mech_endstop_screw_gap/2, -1, mech_endstop_screw_z_o]) rotate([270,0,0]) cylinder(h=2*mech_endstop_w, d= mech_endstop_screw_d);
    }

    if(screw_len>0) {
        translate([mech_endstop_screw_gap/2, -screw_len, mech_endstop_screw_z_o]) rotate([270,0,0]) cylinder(h=2*screw_len+mech_endstop_w, d= mech_endstop_screw_d);
        translate([-mech_endstop_screw_gap/2, -screw_len, mech_endstop_screw_z_o]) rotate([270,0,0]) cylinder(h=2*screw_len+mech_endstop_w, d= mech_endstop_screw_d);
    }

    translate([-mech_endstop_l/2, 0, mech_endstop_h]) rotate([0, -20, 0]) {
        cube([mech_endstop_l +5,  mech_endstop_w, 1]);
        translate([mech_endstop_l + 3, 0, 2]) rotate([270, 0, 0]) cylinder(h=mech_endstop_w, d=3); 
    }
}

// !extruder_motor_mount(1);

module extruder_motor_mount(cutout=0){


    // translate([0, 1.45, 36 + 11.72])
    // import("extruderStepper_housing.3mf");


    translate([71.125, -5, 3.5]) nema17();

    if(cutout) color("blue") {
        translate([41.4, 6.325, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d - .29);
        translate([41.4, -16.325, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d - .29);
        translate([100.85, 6.325, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d - .29);
        translate([100.85, -16.325, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d - .29);
    }
}

module z_axis_motor_mount(cutout=0){
    translate([0, blade_stepper_gap/2, 0]) nema17();
    translate([0, -blade_stepper_gap/2, 0]) nema17();

    if(cutout) translate([0,0,-4]){

        //middle screw holes
        translate([bottom_blade_holder_screw_x, bottom_blade_holder_screw_gap/2, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([bottom_blade_holder_screw_x, -bottom_blade_holder_screw_gap/2, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);

        //outside screw holes
        translate([12.4, 78.725, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([-11.6, 78.725, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);

        translate([12.4, -78.725, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([-11.6, -78.725, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
    }
}

module z_axis_motors(){
    translate([0, blade_stepper_gap/2, 0]) nema17(cutout=1);
    translate([0, -blade_stepper_gap/2, 0]) nema17(cutout=1);
}

module z_axis_mechanical_endstop_mount(screw_len=30){
    translate([-mech_endstop_l/2, -blade_stepper_gap/2 + nema_w/2, nema_h + motor_mount_th + 4]) 
    translate([0, 0, 0]) {
        difference() {
            union() {
                translate([-mech_endstop_l/2 +2, -nema_w + 5, 0]) cube([mech_endstop_l + 4, 6, mech_endstop_z_o + mech_endstop_h + mech_endstop_e_h]);
                translate([-nema_w/2 + mech_endstop_l/2, -nema_w, 0]) cube([nema_w, 11, 3]);
            }
            translate([6 -2, -mech_endstop_w - nema_w + 5, mech_endstop_z_o]) mech_endstop_switch(screw_len);
            translate([mech_endstop_l/2, blade_stepper_gap/2 - nema_w/2, -nema_h - 0.01]) z_axis_motors();
        
            // translate([-2, -7, mech_endstop_z_o + mech_endstop_h + mech_endstop_e_h - mech_endstop_spring_c_l]) mech_endstop_spring();

        }

       if(screw_len) %translate([6 -2, -mech_endstop_w -nema_w + 5, mech_endstop_z_o]) mech_endstop_switch();
    }
}

module z_axis_optical_endstop_mount(screw_len=30){
    translate([0, -blade_stepper_gap/2 + nema_w/2, nema_h + motor_mount_th + 4]) 
    translate([0, 0, 0]) {
        difference() {
            union() {
                hull() {
                    if(screw_len) translate([-(optical_endstop_pcb_length + 8)/2 + 3.35, -nema_w + 5 - 0.5, optical_endstop_z_o - 7]) cube([optical_endstop_pcb_length + 8, 6.5, 15]);
                    translate([-11, -nema_w + 5 - 0.5, 12]) cube([22, 6.5, z_axis_stop_height - 12]);
                }
                translate([-11, -nema_w + 5 - 0.5, 0]) cube([22, 6.5, z_axis_stop_height]);
                translate([-nema_w/2, -nema_w, 0]) cube([nema_w, 11, 3]);
            }
            if(screw_len) translate([optical_endstop_pcb_length/2 + 3.35, - nema_w + 5 - 0.5 -0.01, optical_endstop_z_o]) rotate([-90, 0, 180]) optical_endstop_pcb(1) {
                translate([0, 0, 1-screw_len]) cylinder(h=screw_len, d=screwhole_d);
                translate([0, 0, -2.5]) rotate([180, 0, 0]) M3_hex_nut(h=4.1);
            }

            translate([0, blade_stepper_gap/2 - nema_w/2, -4 - 2-nema_h - 0.01]) z_axis_motors();

        }

       if(screw_len) %translate([optical_endstop_pcb_length/2 + 3.35, - nema_w + 5 - 0.5, optical_endstop_z_o]) rotate([-90, 0, 180]) optical_endstop_pcb();
    }
}

// z_axis_mechanical_endstop_mount();


// z_axis_optical_endstop_mount();
// !optical_endstop_pcb();

module endstop_spring() {
    difference() {
        union() {
            cylinder(h=endstop_spring_e_l, d=endstop_spring_e_d);
            translate([0, 0, endstop_spring_e_l]) cylinder(h=endstop_spring_l - endstop_spring_e_l, d=endstop_spring_od);
        }
        translate([0, 0, -1]) cylinder(h=endstop_spring_l+2, d=endstop_spring_id);
    }
}


// module blade_holder(){
//     difference() {
//         translate([-blade_holder_l/2, -blade_holder_w/2, 0]) cube([blade_holder_l, blade_holder_w, blade_holder_h]);
//         // translate([-0.7, -blade_w/2, -1]) cube([blade_th, blade_w, blade_tang_l + 1]);

//         // translate([0, 0, 3]) rotate([0, 90, 0]) cylinder(h=blade_holder_l*2, d=blade_holder_screw_d, center = true);

//     }
// }

module top_blade_holder(){
    translate([0, 0, 91]) difference() {
        union(){
            difference() {
                translate([-9.3, -top_blade_holder_w/2, -30]) roundedRect(size=[top_blade_holder_l + top_blade_holder_r, top_blade_holder_w, top_blade_holder_h + 30], radius=top_blade_holder_r);
                translate([12.5, -top_blade_holder_w/2 - 1, -31]) cube([top_blade_holder_l, top_blade_holder_w + 2, top_blade_holder_h + 32]);
            }
            hull() {
                translate([0, linear_rod_gap/2, 55.7 - 91]) linear_slider();
            }
            hull() {
                translate([0, -linear_rod_gap/2, 55.7 - 91]) linear_slider();
            }
        }

        translate([-20, -top_blade_holder_w/2, -40]) cube([top_blade_holder_l +20, top_blade_holder_w + 2, 10]);

        translate([-20, -top_blade_holder_w/2, top_blade_holder_h]) cube([top_blade_holder_l +20, top_blade_holder_w + 2, 10]);


        translate([-20, linear_rod_gap/2 + linear_slider_base_w/2 - 4, -31]) cube([40, 20, 31]);
        mirror([0,1,0]) translate([-20, linear_rod_gap/2 + linear_slider_base_w/2 - 4, -31]) cube([40, 20, 31]);





        // blade holder screws
        translate([1.6, top_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=screwhole_d);
        translate([1.6, -top_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=screwhole_d);


        translate([0, linear_rod_gap/2, 55.7 - 91]) linear_slider(1);
        translate([0, -linear_rod_gap/2, 55.7 - 91]) linear_slider(1);

    }


    // hull() translate([0, linear_rod_gap/2, 55.7]) linear_slider(0);

    // tbh_mid_w = top_blade_holder_screw_gap - 6;

    //pyramid part
    // hull() {
    //     translate([-9.3, -tbh_mid_w/2, 91]) cube([top_blade_holder_l - 0.01, tbh_mid_w, top_blade_holder_h]);
    //     translate([0, 0, 55 + blade_holder_h]) translate([-blade_holder_l/2, -blade_holder_w/2, 0]) cube([blade_holder_l, blade_holder_w, blade_holder_h]);
    // }

    difference() {
        translate([-blade_holder_l/2, -blade_holder_w/2 + 1/2, 55 - 0.4]) cube([blade_holder_l, blade_holder_w -1, blade_holder_h]);
        top_blade(1);
        scale([1.1, 1, 1]) translate([0, 0, blade_overcut + 0.1 + .2]) bottom_blade();

        translate([-blade_th * 1.2, -blade_holder_w/2 -1, 50]) cube([2.4*blade_th, blade_holder_w + 2, 5]);


        translate([0, -10, 55 - 0.01]) rotate([0, -15, 0]) translate([0, 0, -1]) cube([.2, 20, 6]);
    }
}

module bottom_blade_holder(){
    difference(){
        translate([-blade_holder_l/2, -blade_holder_w/2, 35.04]) cube([blade_holder_l, blade_holder_w, blade_holder_h]);
        scale([1.1, 1, 1]) translate([0, 0, -blade_overcut - 0.1 -.2]) top_blade();

        translate([-blade_th * 1.2, -blade_holder_w/2 -1, 50]) cube([2.4*blade_th, blade_holder_w + 2, 10]);

        bottom_blade(1);

        translate([0, -10, 50.04]) rotate([0, 180-15, 0]) translate([0, 0, -1]) cube([.2, 20, 6]);
    }
    difference(){
        translate([-blade_holder_l/2 - 5, -bottom_blade_holder_w/2, 3.5]) roundedRect(size=[bottom_blade_holder_l + bottom_blade_holder_r*2, bottom_blade_holder_w, bottom_blade_holder_h + 35 + 1], radius=bottom_blade_holder_r);
        translate([bottom_blade_holder_l - blade_holder_l/2, -bottom_blade_holder_w/2, 3.5 -1]) cube([bottom_blade_holder_l, bottom_blade_holder_w + 2, bottom_blade_holder_h + 42]);

        translate([blade_holder_l, -bottom_blade_holder_w/2 - 1, 3.5 + bottom_blade_holder_h]) cube([bottom_blade_holder_l, bottom_blade_holder_w/2 - 7 + 1, bottom_blade_holder_h + 52]);
        translate([blade_holder_l, 7, 3.5 + bottom_blade_holder_h]) cube([bottom_blade_holder_l, bottom_blade_holder_w/2 - 7 + 1, bottom_blade_holder_h + 52]);

        translate([0, linear_rod_gap/2, 0]) linear_rod();
        translate([0, -linear_rod_gap/2, 0]) linear_rod();

        // blade holder screws
        translate([bottom_blade_holder_screw_x, bottom_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=base_screwhole_d);
        translate([bottom_blade_holder_screw_x, -bottom_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=base_screwhole_d);


        translate([71.15 -0, -5, 40 + 1.2]) rotate([0,0,90]) extruder_combined(1);

        //magnet spot
        translate([-blade_holder_l/2 - 0.1 - 5, 0, 16.5 + 3.5]) rotate([0, 90, 0]) cylinder(h=2.1, d=10.2);

    }

    // bbh_mid_w = bottom_blade_holder_screw_gap - 8;
    //pyramid part
    // difference() {
    //     hull() {
    //         translate([-blade_holder_l/2 - 0.01, -bbh_mid_w/2, 3.5]) cube([bottom_blade_holder_l, bbh_mid_w, top_blade_holder_h]);
    //         translate([0, 0, 35.1]) rotate([180, 0, 0]) translate([-blade_holder_l/2, -blade_holder_w/2, 0]) cube([blade_holder_l, blade_holder_w, blade_holder_h]);
    //     }
    //     translate([-blade_holder_l/2 - 0.1, 0, 16.5 + 3.5]) rotate([0, 90, 0]) cylinder(h=2.1, d=10.2);
    // }
}

module leadscrew_nut(){
    cylinder(h=3.6, d=22.2);

    for (i = [1:4]) {
        rotate([0, 0, 45+90*i]) translate([0, 8, 0]) cylinder(h=attachment_screw_l, d=screwhole_d);
        //nut slots
        hull() {
            translate([8*cos(45+90*i), 8*sin(45+90*i), attachment_nut_dp])  M3_hex_nut();
            translate([28*cos(45+90*i), 8*sin(45+90*i), attachment_nut_dp])  M3_hex_nut();
        }
    }
}

module z_axis_endstop_flag(cutout=0) {
    difference() {
        union() {
            translate([z_flag_base_w/2, -blade_stepper_gap/2 - z_flag_base_o, -0.01]) rotate([0, 0, 180]) roundedRect([z_flag_base_w,z_flag_base_l,z_flag_base_th],2);
            translate([z_flag_w/2, -blade_stepper_gap/2 - z_flag_base_o - (z_flag_base_l - z_flag_l)/2 -1, -z_flag_h]) rotate([0, 0, 180]) cube([ z_flag_w, z_flag_l, z_flag_h]);
               
        }

        //screwholes
        if(cutout==0) {
            translate([z_flag_base_w/2 - 5, -blade_stepper_gap/2 - z_flag_base_o - z_flag_base_l/2, -0.02 ]) cylinder(h=z_flag_base_th +2, d=screwhole_d);
            translate([z_flag_base_w/2 - 5, -blade_stepper_gap/2 - z_flag_base_o - z_flag_base_l/2, -1 ]) cylinder(d= 6.1, h = 1.5 + 1, $fn = 50);

            translate([-z_flag_base_w/2 + 5, -blade_stepper_gap/2 - z_flag_base_o - z_flag_base_l/2, -0.02 ]) cylinder(h=z_flag_base_th +2, d=screwhole_d);
            translate([-z_flag_base_w/2 + 5, -blade_stepper_gap/2 - z_flag_base_o - z_flag_base_l/2, -1 ]) cylinder(d= 6.1, h = 1.5 + 1, $fn = 50);

        }

    }




    if(cutout) {

        translate([z_flag_base_w/2 - 5, -blade_stepper_gap/2 - z_flag_base_o - z_flag_base_l/2, -0.01 ]) cylinder(h=attachment_screw_l, d=screwhole_d);
        hull() {
            translate([z_flag_base_w/2 - 5, -blade_stepper_gap/2 - z_flag_base_o - z_flag_base_l/2, attachment_nut_dp]) M3_hex_nut();
            translate([24, -blade_stepper_gap/2 - z_flag_base_o - z_flag_base_l/2, attachment_nut_dp]) M3_hex_nut();
        }

        translate([-z_flag_base_w/2 +5 , -blade_stepper_gap/2 - z_flag_base_o - z_flag_base_l/2, -0.01 ]) cylinder(h=attachment_screw_l, d=screwhole_d);

        hull() {
            translate([-z_flag_base_w/2+5, -blade_stepper_gap/2 - z_flag_base_o - z_flag_base_l/2, attachment_nut_dp]) M3_hex_nut();
            translate([-24, -blade_stepper_gap/2 - z_flag_base_o - z_flag_base_l/2, attachment_nut_dp]) M3_hex_nut();
        }

    }

}

module z_axis_attachment(){
    difference() {
        hull() {
            translate([0, blade_stepper_gap/2 + 24, 0]) cylinder(h=attachment_h, d=attachment_w, $fn=150);
            translate([0, -blade_stepper_gap/2 - 24, 0]) cylinder(h=attachment_h, d=attachment_w, $fn=150);
        }

        translate([0, linear_rod_gap/2, 55.7 - 91]) linear_slider(1);
        translate([0, -linear_rod_gap/2, 55.7 - 91]) linear_slider(1);

        translate([0, linear_rod_gap/2, 0]) linear_rod(2);
        translate([0, -linear_rod_gap/2, 0]) linear_rod(2);


        z_axis_endstop_flag(1);

        // #z_axis_endstop_flag();



        //blade holder
        translate([-9.3, -top_blade_holder_w/2, -ep]) roundedRect(size=[top_blade_holder_l + top_blade_holder_r, top_blade_holder_w, top_blade_holder_h], radius=top_blade_holder_r);
        // blade holder screws
        translate([1.6, top_blade_holder_screw_gap/2, 0]) cylinder(h=20, d=screwhole_d);
        translate([1.6, -top_blade_holder_screw_gap/2, 0]) cylinder(h=20, d=screwhole_d);
        //blade holder nut slots
        hull() {
            translate([1.6, top_blade_holder_screw_gap/2, attachment_nut_dp]) M3_hex_nut();
            translate([attachment_w, top_blade_holder_screw_gap/2, attachment_nut_dp]) M3_hex_nut();
        }
        hull() {
            translate([1.6, -top_blade_holder_screw_gap/2, attachment_nut_dp]) M3_hex_nut();
            translate([attachment_w, -top_blade_holder_screw_gap/2, attachment_nut_dp]) M3_hex_nut();
        }

        //threaded rods
        translate([0, blade_stepper_gap/2, -1]) cylinder(h=attachment_h + 2, d=threaded_rod_d);
        translate([0, -blade_stepper_gap/2, -1]) cylinder(h=attachment_h + 2, d=threaded_rod_d);

        translate([0, blade_stepper_gap/2, -ep]) leadscrew_nut();
        translate([0, -blade_stepper_gap/2, -ep]) leadscrew_nut();
    }
}

module container(container_l = container_l) {
    translate([-5-blade_holder_l/2, 0, 0]) difference() {
        translate([-container_l, -container_w/2, 0]) roundedRect(size=[container_l, container_w, container_h], radius=container_radius);
        translate([-container_l + container_th, -container_w/2 + container_th, container_th]) roundedRect(size=[container_l - 2*container_th, container_w - 2*container_th, container_h], radius=container_radius - container_th);

        hull() {
            translate([-container_l, -container_w/2, container_h]) roundedRect(size=[container_l, container_w, container_h], radius=container_radius);
            translate([-container_l + container_th, -container_w/2 + container_th, container_h-container_th]) roundedRect(size=[container_l - 2*container_th, container_w - 2*container_th, container_h], radius=container_radius - container_th);
        }

        translate([5, 0, 20]) rotate([0, -90, 0]) cylinder(h=50, d=10.2);
    }
}

module wire_straightener_mount(cutout=0){
    screw_offset = 5.55556;
    back_offset = 15;

    mount_w = 70;



   
    difference() {
        translate([130, 0, 40 -1]) 
        union() {
            translate([-10 + screw_offset, -20 - back_offset, -39]) {
                cube([20, 20, 50 +33.99]);
                translate([0, 10 - mount_w/2, 0]) roundedRect([20, mount_w, spool_base_th], radius=bottom_blade_holder_r);
                

            }

            translate([100 -10 - screw_offset, -20 - back_offset, -39]) {
                cube([20, 20, 50 +33.99]);
                translate([0, 10 - mount_w/2, 0]) roundedRect([20, mount_w, spool_base_th], radius=bottom_blade_holder_r);
            

            }

        }
        translate([130, 0, 40 -1]) wire_straightener_aligned(cutout=20, mounting_nut_dp=10);

        translate([130, 0, 40 -1]) translate([-5, -18.8, 0]) cube([120, 10, 50]);


        //mounting base screw holes
        translate([130 + screw_offset, - mount_w/2 - back_offset, -10]) cylinder(h=20, d=base_screwhole_d);
        translate([130 + screw_offset,  mount_w/2 - back_offset - 20, -10]) cylinder(h=20, d=base_screwhole_d);
        translate([220 + screw_offset, - mount_w/2 - back_offset, -10]) cylinder(h=20, d=base_screwhole_d);
        translate([220 + screw_offset,  mount_w/2 - back_offset - 20, -10]) cylinder(h=20, d=base_screwhole_d);
    }

    if(cutout) {
        translate([130 + screw_offset, - mount_w/2 - back_offset, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([130 + screw_offset,  mount_w/2 - back_offset - 20, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([220 + screw_offset, - mount_w/2 - back_offset, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([220 + screw_offset,  mount_w/2 - back_offset - 20, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
    }


    // translate([130, 0, 40 -1]) 
    // wire_straightener_aligned();
    // translate([130, 0, 40 -1]) 
    // wire_straightener_aligned(cutout=20, mounting_nut_dp=10);


}

module lcd_mount(cutout=0){
    // translate([130, 70, 0]) 
    // lcd();
    // lcd_mount_holes(total_h=10);

    screw_offset = 5;

    mount_w = 16;

    mount_tab_l = 30;
    mount_h = 45;

    // translate([130, 70, 0]) 
    difference(){
        union() {
            translate([10 - mount_w/2 + screw_offset, -mount_w, 0]) {
                cube([mount_w, mount_w, mount_h]);
                translate([0, mount_w/2 - mount_tab_l, 0]) roundedRect([mount_w, mount_tab_l, spool_base_th], radius=mount_w/2);
                translate([mount_w/2 - mount_tab_l, 0, 0]) roundedRect([mount_tab_l, mount_w, spool_base_th], radius=mount_w/2);
            }

            translate([10-mount_w/2 + 63 + screw_offset, -mount_w, 0]) {
                cube([mount_w, mount_w, mount_h]);
                translate([0, mount_w/2 - mount_tab_l, 0]) roundedRect([mount_w, mount_tab_l, spool_base_th], radius=mount_w/2);
                translate([mount_w/2, 0, 0]) roundedRect([mount_tab_l, mount_w, spool_base_th], radius=mount_w/2);

            }

        }

        lcd_mount_holes(total_h=mount_w);
        translate([-mount_tab_l/2 + mount_w/2, -mount_w/2, -1]) cylinder(h=20, d=base_screwhole_d);
        translate([63 + 10 + screw_offset +mount_tab_l  - mount_w/2, -mount_w/2, -1]) cylinder(h=20, d=base_screwhole_d);

        translate([10 + screw_offset, -mount_tab_l, -1]) cylinder(h=20, d=base_screwhole_d);
        translate([63 + 10 + screw_offset, -mount_tab_l, -1]) cylinder(h=20, d=base_screwhole_d);


    }
    if(cutout){
        translate([-mount_tab_l/2 + mount_w/2, -mount_w/2, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([63 + 10 + screw_offset +mount_tab_l  - mount_w/2, -mount_w/2, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);

        translate([10 + screw_offset, -mount_tab_l, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([63 + 10 + screw_offset, -mount_tab_l, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
    }
}



module spool_holder_base(cutout=0){
    //base
    difference() {
        hull() {
            //base plate
            cube([spool_base_x, spool_base_y, 0.1]);

            translate([spool_base_x/2, 0, spool_d/2]) rotate([270, 0, 0]) cylinder(h=50, d=spool_bearing_d + 2*spool_cylinder_th);

        }


        difference() {
            hull() {
                translate([-2, corner_rad + spool_side_th, corner_rad + spool_base_th]) rotate([0, 90, 0]) cylinder(h=spool_base_x + 4, r=corner_rad);
                translate([-2, spool_side_th, spool_d]) cube([spool_base_x + 4, spool_base_y, corner_rad]);
                translate([-2, spool_base_y, spool_base_th]) cube([spool_base_x + 4, 1, 1]);
            }
            //bearing bushing
            translate([spool_base_x/2, 0, spool_d/2]) rotate([270, 0, 0]) cylinder(h=spool_side_th + 0.4, d=7.5);
        }


        //screwhole - m5 self tapping
        translate([spool_base_x/2, -10, spool_d/2]) rotate([270, 0, 0]) cylinder(h=50, d=4.8);

        //base screws for spool holder
        translate([10.5, 43.2, -1]) cylinder(h=2*spool_base_th + 10, d=base_screwhole_d);
        translate([28.8, 19.6, -1]) cylinder(h=2*spool_base_th + 10, d=base_screwhole_d);
    }
    if(cutout){
        translate([10.5, 43.2, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([28.8, 19.6, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
    }
}

module spool_cylinder(spool_h=spool_h){
    //spool cylinder
    translate([spool_base_x/2, spool_side_th + 0.4, spool_d/2]) rotate([270, 0, 0]) difference() {
        union() {
            cylinder(h=spool_bearing_th + spool_side_th*2 - 0.2, d=spool_bearing_d + 2*spool_cylinder_th);
            translate([0, 0, spool_bearing_th + spool_side_th*2 - 0.2]) cylinder(h=2, d1=spool_bearing_d + 2*spool_cylinder_th, d2=spool_cylinder_d);
            cylinder(h=spool_h - 0.2, d=spool_cylinder_d);
        }
        translate([0,0,-1]) cylinder(h=spool_h, d=5);

        translate([0,0,-1]) cylinder(h=spool_bearing_th +1, d=spool_bearing_d);
        translate([0,0,-1]) cylinder(h=spool_bearing_th + spool_bearing_screwhead_th+1, d=spool_bearing_screwhead_d);

        translate([0, 0, spool_bearing_th + spool_side_th*2]) cylinder(h=spool_h, d=spool_cylinder_d - 2*spool_cylinder_th);
    }
}

module spool_cap(spool_h=spool_h) {
    // spool cylinder cap
    translate([spool_base_x/2, spool_side_th + spool_h, spool_d/2]) rotate([270, 0, 0]) {
        cylinder(h=2, d=28);
        translate([0, 0, -10]) cylinder(h=11, d=spool_cylinder_d - 2*spool_cylinder_th);
    }
}


module power_module(cutout=0, insert=0) {
    power_h = 3.5 + 8.5 + 2 + 6;
    power_w = 16.6 + 4 + 5+1;
    power_l = 24.7 + 11.6 + 10;

    power_front = 5;

    tab_w = 20;

    con_w = 16.6;
    con_l = 24.7;
    con_h = 8.8;

    pin_d = 2.0;
    pin_o = 10;


    switch_w = 19.6;
    switch_l = 12.7;
    switch_h = 20;
    switch_th = 2;

    ep = 0.1;



    difference() {
        intersection(){
            union() {
                translate([0, -power_front, 0]) cube([power_w, power_l + power_front, power_h]);
                translate([-power_w, 0, 0]) roundedRect([power_w*3, tab_w, spool_base_th], tab_w/2);
                translate([power_w/2 - tab_w/2, power_l - power_w, 0]) roundedRect([tab_w, power_w*2, spool_base_th],tab_w/2);
            }
            if(insert) union() {
                translate([power_w/2 - con_w/2 + ep, -0.01 -power_front, -0.01]) cube([con_w - 2*ep, con_l - ep, power_h/2 - con_h/2]);
                translate([power_w/2 - con_w + ep, tab_w/2 - tab_w/6 + ep, -0.01]) cube([2*con_w - 2*ep, tab_w/3 - 2*ep, power_h/2 - con_h/2 - .3 - ep - .1]);
            }
        }



        // anderson connector
        translate([power_w/2 - con_w/2, -0.01 -power_front, power_h/2 - con_h/2]) cube([con_w, con_l, con_h]);

        //bottom insert
        if(insert==0) {
            translate([power_w/2 - con_w/2, -0.01 -power_front, -0.01]) cube([con_w, con_l, con_h]);
            translate([power_w/2 - con_w, tab_w/2 - tab_w/6, -0.01]) cube([2*con_w, tab_w/3, power_h/2 - con_h/2]);
        }

        // anderson locking pin / m2
        translate([power_w/2, pin_o -power_front, -1]) cylinder(h = power_h+2, d=pin_d);
        if(insert==0) translate([power_w/2, pin_o -power_front, -1]) cylinder(h = power_h+2, d=2.4);
        translate([power_w/2, pin_o -power_front, power_h - 2.5]) cylinder(h = power_h+2, d=4);



        //switch hole
        translate([power_w/2 - switch_w/2, power_l - switch_l - 3 , -1]) cube([switch_w, switch_l, switch_h+2]);
        translate([2, power_l - switch_l - 3 - 4 -power_front, -0.01]) cube([power_w-4, switch_l + 5 +power_front, switch_h - switch_th]);

        // middle cutout for wires
        translate([power_w/2 - 12/2, con_l - 0.02 -power_front, -.01]) cube([12, switch_l, power_h/2 + con_h/2 - 1.3]);

        // side cutout for wires
        translate([6, power_l - 10 - 3, -3]) rotate([0, -90, 0]) roundedRect([6+1.5,8,12],3);//cube([12, 10, 6]);


        translate([-power_w + tab_w/2, tab_w/2, -1]) cylinder(h=spool_base_th+2, d=base_screwhole_d);
        translate([2*power_w - tab_w/2, tab_w/2, -1]) cylinder(h=spool_base_th+2, d=base_screwhole_d);
        translate([power_w/2, power_l + power_w - tab_w/2, -1]) cylinder(h=spool_base_th+2, d=base_screwhole_d);

    }

    if(insert==0) translate([power_w/2 - con_w/2, -0.01 -power_front, power_h/2 + con_h/2]) cube([con_w, con_l, .2]);

    if(cutout) {
        translate([-power_w + tab_w/2, tab_w/2, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([2*power_w - tab_w/2, tab_w/2, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);
        translate([power_w/2, power_l + power_w - tab_w/2, -1 - mounting_board_th]) plus(h=2*mounting_board_th, d=base_screwhole_d);

    }

}

// !power_module(0,0);

module mounting_board(){
    difference() {
        // current size
        color("burlywood") translate([-container_l - container_small_l - 10, -mounting_board_w/2, -mounting_board_th]) cube([mounting_board_l, mounting_board_w, mounting_board_th]);


        translate([0, 0, 4]) z_axis_motor_mount(1);

        extruder_motor_mount(1);

        translate([0, 0, 0.01]) wire_straightener_mount(1);

        translate([136 + 140, -27, 0.01]) spool_holder_base(1);

        translate([135, 70, 0.01]) lcd_mount(1);

        translate([172, -95, -mounting_board_th]) mainboard_case(1) plus(h=2*mounting_board_th, d=base_screwhole_d);;

        translate([295, -145, 0.01]) power_module(1);

    }
}

module plus(h, d, w=.2){
    translate([-w/2, -d/2, 0]) cube([w, d, h]);
    translate([-d/2, -w/2, 0]) cube([d, w, h]);
}

/* #################################################### */

// echo(anim_height);

translate([0, 0, anim_height]) {

translate([0, 0, 91 + 0*20]) {
    z_axis_attachment();
    z_axis_endstop_flag();
}

%translate([0, linear_rod_gap/2, 55.7]) linear_slider(0);
%translate([0, -linear_rod_gap/2, 55.7]) linear_slider(0);

fp() top_blade_holder();

%top_blade();

}

%bottom_blade();

fp() bottom_blade_holder();


%translate([0, linear_rod_gap/2, 0]) linear_rod();
%translate([0, -linear_rod_gap/2, 0]) linear_rod();

// z_axis_mechanical_endstop_mount();
// mirror([0,1,0]) z_axis_mechanical_endstop_mount(0);

z_axis_optical_endstop_mount();
mirror([0,1,0]) z_axis_optical_endstop_mount(0);


container(container_small_l);
translate([-container_small_l, 0, 0])
container();



translate([71.15, -5, 40 + 1.2]) rotate([0,0,90]) fp() extruder_combined(); 




wire_straightener_mount();

translate([130, 0, 40 -1]) fp() wire_straightener_aligned();


// translate([130, 0, 40 -1]) wire_straightener_aligned(cutout=20, mounting_nut_dp=10);



translate([136 + 140, -27, 0]){
    spool_cylinder();
    spool_cap();
    spool_holder_base();
}

translate([135, 70, 0]) fp() lcd();

translate([135, 70, 0]) lcd_mount();

translate([172, -95, 0]) fp() mainboard_case();

translate([295, -145, 0]) {
    power_module();
    power_module(insert=1);
}

// !projection()
// mounting_board();

/******************************
 * original models
 ******************************/

 // translate([0, 0, 4]) z_axis_motor_mount();


translate([0, 1.45, 36 + 11.72])
import("extruderStepper_housing.3mf");

translate([0, 0, 36 + 11.72])
import("linearMotion_motorsHousing.3mf");
