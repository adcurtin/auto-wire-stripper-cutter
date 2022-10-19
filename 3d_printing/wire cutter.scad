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
container_l = 80;
container_w = 42.8;
container_th = 2;
container_radius = 8;

container_small_l = 16;




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



blade_w = 7.2;
blade_th = 1;
blade_tang_l = 10;


blade_holder_screw_d = 2.4;
screwhole_d = 3.3;
base_screwhole_d = 4.3;

module blade_holder(){
    difference() {
        translate([-blade_holder_l/2, -blade_holder_w/2, 0]) cube([blade_holder_l, blade_holder_w, blade_holder_h]);
        translate([-0.7, -blade_w/2, -1]) cube([blade_th, blade_w, blade_tang_l + 1]);

        translate([0, 0, 3]) rotate([0, 90, 0]) cylinder(h=blade_holder_l*2, d=blade_holder_screw_d, center = true);

    }
}


module top_blade_holder(){
    translate([0, 0, 36 + 11.72 + 48]) difference() {
        translate([-9.3, -top_blade_holder_w/2, 0]) roundedRect(size=[top_blade_holder_l + top_blade_holder_r, top_blade_holder_w, top_blade_holder_h], radius=top_blade_holder_r);
        translate([12.5, -top_blade_holder_w/2, -1]) cube([top_blade_holder_l, top_blade_holder_w + 2, top_blade_holder_h + 2]);
        // blade holder screws
        translate([1.6, top_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=screwhole_d);
        translate([1.6, -top_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=screwhole_d);
    }

    tbh_mid_w = top_blade_holder_screw_gap - 6;

    //pyramid part
    hull() {
        translate([-9.3, -tbh_mid_w/2, 36 + 11.72 + 48]) cube([top_blade_holder_l, tbh_mid_w, top_blade_holder_h]);
        translate([0, 0, 36 + 11.72 + 13 + blade_holder_h]) blade_holder();
    }

    translate([0, 0, 36 + 11.72 + 13]) blade_holder();
}

module bottom_blade_holder(){

    translate([0.6, 0, 40.6]) rotate([180, 0, 0]) blade_holder();

    difference(){
        translate([-3.4, -bottom_blade_holder_w/2, 0]) roundedRect(size=[bottom_blade_holder_l + bottom_blade_holder_r*2, bottom_blade_holder_w, bottom_blade_holder_h], radius=bottom_blade_holder_r);
        translate([bottom_blade_holder_l - 3.4, -bottom_blade_holder_w/2, -1]) cube([bottom_blade_holder_l, bottom_blade_holder_w + 2, bottom_blade_holder_h + 2]);
        // blade holder screws
        translate([bottom_blade_holder_screw_x, bottom_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=base_screwhole_d);
        translate([bottom_blade_holder_screw_x, -bottom_blade_holder_screw_gap/2, -1]) cylinder(h=20, d=base_screwhole_d);
    }

    bbh_mid_w = bottom_blade_holder_screw_gap - 8;
    //pyramid part
    difference() {
        hull() {
            translate([-3.4, -bbh_mid_w/2, 0]) cube([bottom_blade_holder_l, bbh_mid_w, top_blade_holder_h]);
            translate([0.6, 0, 40.6 - 13]) rotate([180, 0, 0]) blade_holder();
        }
        translate([-3.5, 0, 16.5]) rotate([0, 90, 0]) cylinder(h=2.1, d=10.2);
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

module attachment(){
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
    difference() {
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


// translate([-0, 0, -48]) 
// import("original models/linearMotion_attachment.3mf");


translate([0, 0, 48 + 36 + 11.72]) attachment();

// translate([0, 0, 36 + 11.72])
// import("original models/topBlade_housing.3mf");

top_blade_holder();

// translate([0*40, 0, 36 + 11.72])
// import("original models/bottomBlade_housing.3mf");

translate([0, 0, 3.5]) bottom_blade_holder();



// translate([3.72, 0, 11.72 + 36])
// import("original models/container.3mf");

translate([-3.72 - container_small_l, 0, 0]) container();

//small container
translate([-3.72, 0, 0]) container(container_small_l);




// translate([-136, 27, 11.72 + 36]){
    // import("original models/spoolHolder_base.3mf");
    // import("original models/spoolHolder_cylinder_cap.3mf");
    // import("original models/spoolHolder_cylinder.3mf");
// }


//fix bearing, make clearance indent for nonrotating screwhead
translate([136, -27, 0]){
    spool_cylinder();
    spool_cap();
    spool_holder_base();
}




//translate([71.15, -6.45, 40 + 1.2]) rotate([0,0,90])
//#import("extruder/compact_extruder_mount combined.stl");

include <extruder/compact_extruder_mount.scad>
translate([71.15, -6.45, 40 + 1.2]) rotate([0,0,90]) extruder_combined(); 




translate([0, 0, 36 + 11.72])
import("extruderStepper_housing.3mf");



translate([0, 0, 36 + 11.72])
import("linearMotion_motorsHousing.3mf");



