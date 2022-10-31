include <OpenSCAD-common.scad>

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


endstop_w = 5.75;
endstop_l = 12.6;
endstop_h = 6.5;
endstop_screw_d = 1.9;
endstop_screw_gap = 6.65;
endstop_screw_z_o = 1.5;

endstop_z_o =  33.5 + 5;

endstop_e_h = 2.5; //extra heigh above the switch

//slop in the leadscrews, endstop springs to help

endstop_spring_od = 5.3; //outside diameter for clearance
endstop_spring_id = 3.4;
endstop_spring_l = 25;
endstop_spring_c_l = 10;

endstop_spring_e_d = 5.1; //end diameter to hold the springs
endstop_spring_e_l = 4;


//z axis attachment
attachment_h = 30;
attachment_w = 25;
attachment_screw_l = 12;
attachment_nut_dp = 8;
attachment_nut_rotation = 30;

threaded_rod_d = 10.4;
blade_stepper_gap = 92.265;


//blade holder
top_blade_holder_w = 40.4;
top_blade_holder_r = 4;
top_blade_holder_l = 21.8;
top_blade_holder_h = 3.25;
top_blade_holder_screw_gap = 26.8;


bottom_blade_holder_w = 43;
bottom_blade_holder_r = 8;
bottom_blade_holder_l = 24.8 + 3.4;
bottom_blade_holder_h = 3.25;
bottom_blade_holder_screw_gap = 28.5;
bottom_blade_holder_screw_x = 15.4;


blade_holder_w  = 13.6;
blade_holder_l  = 8;
blade_holder_h  = 15;

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
blade_overlap = 0.0;


blade_holder_screw_d = 2.4;
screwhole_d = 3.3;
base_screwhole_d = 4.3;



linear_rod_d = 8;
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

linear_slider_nut_dp = 12;



translate([0, linear_rod_gap/2, 0]) linear_rod();
translate([0, -linear_rod_gap/2, 0]) linear_rod();

translate([0, linear_rod_gap/2, 55]) linear_slider(0);
translate([0, -linear_rod_gap/2, 55]) linear_slider(0);


module linear_slider(cutout=0) {
    difference() {
        union() {
            intersection() {
                cylinder(h=linear_slider_base_th, d=linear_slider_base_d);
                translate([-linear_slider_base_d/2, -linear_slider_base_w/2, 0]) cube([linear_slider_base_d, linear_slider_base_w, linear_slider_base_th]);
            }
            cylinder(h=linear_slider_base_th + linear_slider_l, d=linear_slider_d);
        }
        translate([0, 0, -1]) linear_rod();

        translate([linear_slider_screw_gap/2, 0, -1]) cylinder(h=linear_slider_base_th + 2, d=linear_slider_screw_d);
        translate([-linear_slider_screw_gap/2, 0, -1]) cylinder(h=linear_slider_base_th + 2, d=linear_slider_screw_d);

    }

    if(cutout) {
        translate([linear_slider_screw_gap/2, 0, -1]) cylinder(h=linear_slider_base_th + 2 + cutout, d=linear_slider_screw_d);
        translate([-linear_slider_screw_gap/2, 0, -1]) cylinder(h=linear_slider_base_th + 2 + cutout, d=linear_slider_screw_d);

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


module linear_bearing() {
    difference() {
        cylinder(h=linear_bearing_l, d=linear_bearing_d);
        translate([0, 0, -1]) linear_rod();
    }
}


module linear_rod() {
    cylinder(h=linear_rod_l, d=linear_rod_d);
}



module mounting_board(){
}

module lcd_board() {
}

module mainboard() {
}

module top_blade(cutout=0){
    translate([0, 0, blade_y_offset-blade_cut]) {
        if(cutout) translate([-10, 0, blade_notch_o + blade_notch_w/2]) rotate([0, 90, 0]) cylinder(h=blade_th+20, d=blade_notch_w);
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
        difference() {
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

module nema17(screw_len = 10, cutout=0){
    translate([-nema_w/2, -nema_w/2, 0]) cube([nema_w, nema_w, nema_h]);
    translate([nema_screw_w/2, nema_screw_w/2, nema_h]) cylinder(h=screw_len, d=screwhole_d);
    translate([-nema_screw_w/2, nema_screw_w/2, nema_h]) cylinder(h=screw_len, d=screwhole_d);
    translate([nema_screw_w/2, -nema_screw_w/2, nema_h]) cylinder(h=screw_len, d=screwhole_d);
    translate([-nema_screw_w/2, -nema_screw_w/2, nema_h]) cylinder(h=screw_len, d=screwhole_d);

    hull() {
        translate([0, 0, nema_h - 0.01]) cylinder(h=nema_bushing_h +2, d=nema_bushing_d);
        if(cutout) {
            translate([0, 0, nema_h - 0.01]) cylinder(h=nema_bushing_h +50, d=nema_bushing_d);
            translate([nema_w, 0, nema_h - 0.01]) cylinder(h=nema_bushing_h +50, d=nema_bushing_d);
        }
    }

    //stepper shaft
    translate([0, 0, nema_h]) cylinder(h=15, d=5);
}

module endstop_switch(screw_len = 0){
    difference() {
        translate([-endstop_l/2, 0, 0]) cube([endstop_l, endstop_w, endstop_h]);

        translate([endstop_screw_gap/2, -1, endstop_screw_z_o]) rotate([270,0,0]) cylinder(h=2*endstop_w, d= endstop_screw_d);
        translate([-endstop_screw_gap/2, -1, endstop_screw_z_o]) rotate([270,0,0]) cylinder(h=2*endstop_w, d= endstop_screw_d);
    }

    if(screw_len>0) {
        translate([endstop_screw_gap/2, -screw_len, endstop_screw_z_o]) rotate([270,0,0]) cylinder(h=2*screw_len+endstop_w, d= endstop_screw_d);
        translate([-endstop_screw_gap/2, -screw_len, endstop_screw_z_o]) rotate([270,0,0]) cylinder(h=2*screw_len+endstop_w, d= endstop_screw_d);
    }

    translate([-endstop_l/2, 0, endstop_h]) rotate([0, -20, 0]) {
        cube([endstop_l +5,  endstop_w, 1]);
        translate([endstop_l + 3, 0, 2]) rotate([270, 0, 0]) cylinder(h=endstop_w, d=3); 
    }
}

module z_axis_motor_mount(){
    translate([0, blade_stepper_gap/2, 0]) nema17();
    translate([0, -blade_stepper_gap/2, 0]) nema17();
}

module z_axis_motors(){
    translate([0, blade_stepper_gap/2, 0]) nema17(cutout=1);
    translate([0, -blade_stepper_gap/2, 0]) nema17(cutout=1);
}

module z_axis_endstop_mount(screw_len=30){
    translate([-endstop_l/2, -blade_stepper_gap/2 + nema_w/2, nema_h + motor_mount_th + 4]) 
    translate([0, 0, 0]) {
        difference() {
            union() {
                translate([-endstop_l/2, -12, 0]) cube([endstop_l + 7, 6+4, endstop_z_o + endstop_h + endstop_e_h]);
                translate([-nema_w/2 + endstop_l/2, -13, 0]) cube([nema_w, 15, 3]);
            }
            translate([6, -endstop_w + 4, endstop_z_o]) endstop_switch(screw_len);
            translate([endstop_l/2, blade_stepper_gap/2 - nema_w/2, -nema_h - 0.01]) z_axis_motors();
        
            translate([-2, -7, endstop_z_o + endstop_h + endstop_e_h - endstop_spring_c_l]) endstop_spring();

        }

       if(screw_len) %translate([6, -endstop_w +4, endstop_z_o]) endstop_switch();
    }
}

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
        translate([-9.3, -top_blade_holder_w/2, 0]) roundedRect(size=[top_blade_holder_l + top_blade_holder_r, top_blade_holder_w, top_blade_holder_h], radius=top_blade_holder_r);
        translate([12.5, -top_blade_holder_w/2, -1]) cube([top_blade_holder_l, top_blade_holder_w + 2, top_blade_holder_h + 2]);
        // blade holder screws
        translate([1.6, top_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=screwhole_d);
        translate([1.6, -top_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=screwhole_d);
    }

    tbh_mid_w = top_blade_holder_screw_gap - 6;

    //pyramid part
    hull() {
        translate([-9.3, -tbh_mid_w/2, 91]) cube([top_blade_holder_l - 0.01, tbh_mid_w, top_blade_holder_h]);
        translate([0, 0, 55 + blade_holder_h]) translate([-blade_holder_l/2, -blade_holder_w/2, 0]) cube([blade_holder_l, blade_holder_w, blade_holder_h]);
    }

    difference() {
        translate([-blade_holder_l/2, -blade_holder_w/2, 55]) cube([blade_holder_l, blade_holder_w, blade_holder_h]);
        top_blade(1);
        scale([1.1, 1, 1]) translate([0, 0, blade_overcut + 0.1]) bottom_blade(1);

        translate([0, -10, 55 - 0.01]) rotate([0, -15, 0]) translate([0, 0, -1]) cube([.2, 20, 6]);
    }
}

module bottom_blade_holder(){
    difference(){
        translate([-blade_holder_l/2, -blade_holder_w/2, 35.04]) cube([blade_holder_l, blade_holder_w, blade_holder_h]);
        scale([1.1, 1, 1]) translate([0, 0, -blade_overcut - 0.1]) top_blade(1);
        bottom_blade(1);

        translate([0, -10, 50.04]) rotate([0, 180-15, 0]) translate([0, 0, -1]) cube([.2, 20, 6]);
    }
    difference(){
        translate([-blade_holder_l/2, -bottom_blade_holder_w/2, 3.5]) roundedRect(size=[bottom_blade_holder_l + bottom_blade_holder_r*2, bottom_blade_holder_w, bottom_blade_holder_h], radius=bottom_blade_holder_r);
        translate([bottom_blade_holder_l - blade_holder_l/2, -bottom_blade_holder_w/2, 3.5 -1]) cube([bottom_blade_holder_l, bottom_blade_holder_w + 2, bottom_blade_holder_h + 2]);
        // blade holder screws
        translate([bottom_blade_holder_screw_x, bottom_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=base_screwhole_d);
        translate([bottom_blade_holder_screw_x, -bottom_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=base_screwhole_d);
    }

    bbh_mid_w = bottom_blade_holder_screw_gap - 8;
    //pyramid part
    difference() {
        hull() {
            translate([-blade_holder_l/2 - 0.01, -bbh_mid_w/2, 3.5]) cube([bottom_blade_holder_l, bbh_mid_w, top_blade_holder_h]);
            translate([0, 0, 35.1]) rotate([180, 0, 0]) translate([-blade_holder_l/2, -blade_holder_w/2, 0]) cube([blade_holder_l, blade_holder_w, blade_holder_h]);
        }
        translate([-blade_holder_l/2 - 0.1, 0, 16.5 + 3.5]) rotate([0, 90, 0]) cylinder(h=2.1, d=10.2);
    }
}

module leadscrew_nut(){
    cylinder(h=3.6, d=22.2);

    for (i = [1:2]) {
        rotate([0, 0, 45+180*i]) translate([0, 8, 0]) cylinder(h=attachment_screw_l, d=screwhole_d);
        //nut slots
        hull() {
            rotate([0, 0, 45+180*i]) translate([0, 8, attachment_nut_dp]) rotate([0, 0, attachment_nut_rotation+45+45+90+180*i]) M3_hex_nut();
            rotate([0, 0, 45 + 45/2 + 180*i]) translate([0, 18, attachment_nut_dp]) rotate([0, 0, attachment_nut_rotation+45+45+90+180*i]) M3_hex_nut();
        }
    }
    for (i = [1:2]) {
        rotate([0, 0, 45+90+180*i]) translate([0, 8, 0]) cylinder(h=attachment_screw_l, d=screwhole_d);
        //nut slots
        hull() {
            rotate([0, 0, 45+90+180*i]) translate([0, 8, attachment_nut_dp]) rotate([0, 0, attachment_nut_rotation+45+45+90+180*i]) M3_hex_nut();
            rotate([0, 0, 90+45/2+180*i]) translate([0, 18, attachment_nut_dp])  rotate([0, 0, attachment_nut_rotation+45+45+90+180*i]) M3_hex_nut();
        }
    }
}

module z_axis_attachment(){
    difference() {
        hull() {
            translate([0, blade_stepper_gap/2, 0]) cylinder(h=attachment_h, d=attachment_w, $fn=150);
            translate([0, -blade_stepper_gap/2, 0]) cylinder(h=attachment_h, d=attachment_w, $fn=150);
        }


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
    translate([-blade_holder_l/2, 0, 0]) difference() {
        translate([-container_l, -container_w/2, 0]) roundedRect(size=[container_l, container_w, container_h], radius=container_radius);
        translate([-container_l + container_th, -container_w/2 + container_th, container_th]) roundedRect(size=[container_l - 2*container_th, container_w - 2*container_th, container_h], radius=container_radius - container_th);

        hull() {
            translate([-container_l, -container_w/2, container_h]) roundedRect(size=[container_l, container_w, container_h], radius=container_radius);
            translate([-container_l + container_th, -container_w/2 + container_th, container_h-container_th]) roundedRect(size=[container_l - 2*container_th, container_w - 2*container_th, container_h], radius=container_radius - container_th);
        }

        translate([5, 0, 20]) rotate([0, -90, 0]) cylinder(h=50, d=10.2);
    }
}

module spool_holder_base(){
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
}

module spool_cylinder(){
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

module spool_cap() {
    // spool cylinder cap
    translate([spool_base_x/2, spool_side_th + spool_h, spool_d/2]) rotate([270, 0, 0]) {
        cylinder(h=2, d=28);
        translate([0, 0, -10]) cylinder(h=11, d=spool_cylinder_d - 2*spool_cylinder_th);
    }
}

/* #################################################### */

translate([0, 0, 91 + 20]) z_axis_attachment();

// z_axis_endstop_mount();

// mirror([0,1,0]) z_axis_endstop_mount(0);

top_blade_holder();

%top_blade();
%bottom_blade();

bottom_blade_holder();


// container(container_small_l);
// translate([-container_small_l, 0, 0])
// container();



translate([136, -27, 0]){
    spool_cylinder();
    spool_cap();
    spool_holder_base();
}

include <extruder/compact_extruder_mount.scad>
translate([71.15, -5, 40 + 1.2]) rotate([0,0,90]) extruder_combined(); 



/******************************
 * original models
 ******************************/

 // translate([0, 0, 4]) z_axis_motor_mount();


translate([0, 1.45, 36 + 11.72])
import("extruderStepper_housing.3mf");

translate([0, 0, 36 + 11.72])
import("linearMotion_motorsHousing.3mf");


/******************************
 * original models replaced
 ******************************/

// translate([-0, 0, -48])
// import("original models/linearMotion_attachment.3mf");

// translate([0, 0, 36 + 11.72])
// import("original models/topBlade_housing.3mf");

// translate([0*40, 0, 36 + 11.72])
// import("original models/bottomBlade_housing.3mf");

// translate([3.72, 0, 11.72 + 36])
// import("original models/container.3mf");

// translate([-136, 27, 11.72 + 36]){
//     import("original models/spoolHolder_base.3mf");
//     import("original models/spoolHolder_cylinder_cap.3mf");
//     import("original models/spoolHolder_cylinder.3mf");
// }

// translate([71.15, -6.45, 40 + 1.2]) rotate([0,0,90])
// #import("extruder/compact_extruder_mount combined.stl");
