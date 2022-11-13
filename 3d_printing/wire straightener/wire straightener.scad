include <OpenSCAD-common.scad>


$fn=150;



base_h = 45;
base_w = 100;
base_th = 15;

n_bearings = 5;

bearing_gap = base_w/ (n_bearings+1);

// echo(bearing_gap/3);

bearing_mount_h = 10;


bearing_hub_d = 7;
bearing_hub_h = .8;
bearing_d = 13;
bearing_h = 6;
bearing_middle_d = 9.5;
bearing_middle_h = 4;


//m4 nut
module m4_nut(th=3.1){
    hextrude(h=th, d=7);
}

m4_hole_d = 4.3;

slider_w = 12;
slider_h = 16; //maybe?
slider_d = base_th - 3;

slider_hole_o  = slider_h - 3 - 3.1 - 1.5 - bearing_hub_d/2;

slider_tab_w = 1;
slider_tab_th = 3;

slider_pos = 15 + 1*2;

// mounting_nut_dp = 10;


// !wire_straightener();

//624zz v bearing
module 624_bearing(){
    %cylinder(h=bearing_h/2 - bearing_middle_h/2, d=bearing_d);
    %translate([0, 0, bearing_h/2 - bearing_middle_h/2 -.01]) cylinder(h=bearing_middle_h/2, d1=bearing_d, d2=bearing_middle_d);
    %translate([0, 0, bearing_h/2 -.01]) cylinder(h=bearing_middle_h/2, d1=bearing_middle_d, d2=bearing_d);


    %translate([0, 0, bearing_h/2 + bearing_middle_h/2]) cylinder(h=bearing_h/2 - bearing_middle_h/2, d=bearing_d);

}

module slider(delta=0.2){

    difference(){
        union(){
            translate([-slider_w/2 - delta, 0, 0]) cube([slider_w + 2*delta, slider_h + delta*base_h/.2, slider_d + 2.5*delta]);
            translate([-slider_w/2 - slider_tab_w - delta, 0, slider_d/2 - slider_tab_th/2 - delta]) cube([slider_w + 2*slider_tab_w + 2*delta, slider_h + delta*base_h/.2, slider_tab_th + delta + 3*delta]);
            if(delta==0) translate([0, slider_hole_o, slider_d]) cylinder(h=bearing_hub_h, d2=bearing_hub_d-.5, d1=9);

        }
        // m4_nut();
        if(delta==0){
        translate([0, slider_hole_o, 1]) cylinder(h=slider_d + 2, d=m4_hole_d);

        translate([0, slider_hole_o, slider_d + bearing_hub_h]) 624_bearing();

        translate([0, slider_hole_o, slider_d/2 - 1.6]) hull() {
            m4_nut();
            translate([0, -slider_h, 0]) m4_nut();
        }

        translate([0, slider_h - 3 + .2, slider_d/2]) rotate([270, 0, 0]) cylinder(h=slider_h +2, d=m4_hole_d);

        translate([0, slider_h - 3, slider_d/2]) rotate([90, 0, 0]) hull() {
            m4_nut(3.2);
            translate([0, base_th, 0]) m4_nut(3.2);
        }
        }
    }

}


// !rotate([90, 0, 0]) slider(0);


module wire_straightener(cutout=0, mounting_nut_dp=10){
    difference() {
        union() {
            cube([base_w, base_h, base_th]);
            translate([2*bearing_gap, bearing_mount_h, 0]) cylinder(h=base_th + bearing_hub_h, d=bearing_hub_d);
            translate([4*bearing_gap, bearing_mount_h, 0]) cylinder(h=base_th + bearing_hub_h, d=bearing_hub_d);
            cube([base_w, 2, base_th +2]);

            translate([bearing_gap/3, bearing_mount_h, 0]) cylinder(h=base_th + bearing_hub_h, d=bearing_hub_d);
        }

        // make a smaller test print
        // translate([2.5*bearing_gap, -1, -1]) cube([2*base_w, 2*base_h, 2*base_th]);

        //bearing mounts
        // if(cutout==0) translate([2*bearing_gap, bearing_mount_h, base_th + bearing_hub_h]) 624_bearing();
        translate([2*bearing_gap, bearing_mount_h, -1]) cylinder(h=base_th + 2, d=m4_hole_d);
        translate([2*bearing_gap, 0, 7]) hull() {
            translate([0, -bearing_mount_h, 0])m4_nut(3.2);
            translate([0, bearing_mount_h, 0]) m4_nut(3.2);
        }

        if(cutout==0) translate([4*bearing_gap, bearing_mount_h, base_th + bearing_hub_h]) 624_bearing();
        translate([4*bearing_gap, bearing_mount_h, -1]) cylinder(h=base_th + 2, d=m4_hole_d);
        translate([4*bearing_gap, 0, 7]) hull() {
            translate([0, -bearing_mount_h, 0])m4_nut(3.2);
            translate([0, bearing_mount_h, 0]) m4_nut(3.2);
        }


        //bearing mount sliders
        if(cutout==0) {
        translate([1*bearing_gap, base_h - 4, base_th - 6]) rotate([90, 0, 0]) hull() {
            m4_nut();
            translate([0, base_th, 0]) m4_nut();
        }
        translate([1*bearing_gap, -1, base_th - 6]) rotate([270, 0, 0]) cylinder(h=base_h + 2, d=m4_hole_d);


        translate([1*bearing_gap, -slider_h - 9.5, base_th - slider_d + 0.01]) slider();
        translate([1*bearing_gap, slider_pos*1, base_th - slider_d + 0.01]) %slider(0);


        translate([3*bearing_gap, base_h - 4, base_th - 6]) rotate([90, 0, 0]) hull() {
            m4_nut();
            translate([0, base_th, 0]) m4_nut();
        }
        translate([3*bearing_gap, -1, base_th - 6]) rotate([270, 0, 0]) cylinder(h=base_h + 2, d=m4_hole_d);

        translate([3*bearing_gap, -slider_h - 9.5, base_th - slider_d + 0.01]) slider();
        translate([3*bearing_gap, slider_pos, base_th - slider_d + 0.01]) %slider(0);


        translate([5*bearing_gap, base_h - 4, base_th - 6]) rotate([90, 0, 0]) hull() {
            m4_nut();
            translate([0, base_th, 0]) m4_nut();
        }
        translate([5*bearing_gap, -1, base_th - 6]) rotate([270, 0, 0]) cylinder(h=base_h + 2, d=m4_hole_d);

        translate([5*bearing_gap, -slider_h - 9.5, base_th - slider_d + 0.01]) slider();
        translate([5*bearing_gap, slider_pos, base_th - slider_d + 0.01]) %slider(0);
        }


        //mounting screws
        translate([bearing_gap/3, 10, -1]) {
            translate([0, 0, base_th - 3]) cylinder(h=4 + 1, d=7.2);
            cylinder(h=base_th+2, d=m4_hole_d);
        }
        translate([bearing_gap/3, base_h - 10, -1])  {
            translate([0, 0, base_th - 3]) cylinder(h=4 + 1, d=7.2);
            cylinder(h=base_th+2, d=m4_hole_d);
        }

        translate([base_w - bearing_gap/3, 10, -1])  {
            translate([0, 0, base_th - 3]) cylinder(h=4 + 1, d=7.2);
            cylinder(h=base_th+2, d=m4_hole_d);
        }
        translate([base_w - bearing_gap/3, base_h - 10, -1])  {
            translate([0, 0, base_th - 3]) cylinder(h=4 + 1, d=7.2);
            cylinder(h=base_th+2, d=m4_hole_d);
        }


        




    }
    if(cutout) {
        translate([bearing_gap/3, 10, -cutout]) {
            cylinder(h=base_th+2 +cutout, d=m4_hole_d);
            translate([0, 0, cutout-mounting_nut_dp]) hull(){
                m4_nut(3.2);
                translate([-20, 0, 0]) m4_nut(3.2);
            }
        }
        translate([bearing_gap/3, base_h - 10, -cutout])  {
            cylinder(h=base_th+2 +cutout, d=m4_hole_d);
            translate([0, 0, cutout-mounting_nut_dp]) hull(){
                m4_nut(3.2);
                translate([-20, 0, 0]) m4_nut(3.2);
            }
        }

        translate([base_w - bearing_gap/3, 10, -cutout])  {
            cylinder(h=base_th+2 +cutout, d=m4_hole_d);
            translate([0, 0, cutout-mounting_nut_dp]) hull(){
                m4_nut(3.2);
                translate([20, 0, 0]) m4_nut(3.2);
            }
        }
        translate([base_w - bearing_gap/3, base_h - 10, -cutout])  {
            cylinder(h=base_th+2 +cutout, d=m4_hole_d);
            translate([0, 0, cutout-mounting_nut_dp]) hull(){
                m4_nut(3.2);
                translate([20, 0, 0]) m4_nut(3.2);
            }
        }


    }
}

// wire_straightener();

// translate([2*bearing_gap - 5, bearing_mount_h - 5, 10.2]) cube([10, 10, 0.2]);
// translate([4*bearing_gap - 5, bearing_mount_h - 5, 10.2]) cube([10, 10, 0.2]);

module wire_straightener_aligned(cutout=0, mounting_nut_dp=10){
    translate([base_w, -base_th -bearing_h/2 -bearing_hub_h, 0]) rotate([90, 0, 180]) wire_straightener(cutout, mounting_nut_dp);
}


difference() {
    translate([bearing_gap/3, bearing_mount_h, 0.01]) cylinder(h=base_th + bearing_hub_h, d=bearing_hub_d);
    wire_straightener();
    translate([bearing_gap/3, 10, -1]) {
            
            cylinder(h=base_th+2, d=m4_hole_d+.01);
        }
        translate([bearing_gap/3, bearing_mount_h, base_th + bearing_hub_h]) 624_bearing();
}


difference() {
    union() {
        translate([bearing_gap/3, base_h - 10, base_th])  {
            translate([0, 0,  - 4]) cylinder(h=4 + 1, d=7.2);
            cylinder(h=bearing_hub_h + bearing_h + 5, d=7.2 + 2.5);
        }

        hull() {
            translate([bearing_gap/3, 10, base_th + bearing_hub_h + bearing_h +1]) cylinder(h=4, d=7.2 + 2.5);
            translate([bearing_gap/3, base_h - 10, base_th + bearing_hub_h + bearing_h +1]) cylinder(h=4, d=7.2 + 2.5);
        }
    }
    translate([bearing_gap/3, 10, base_th + bearing_hub_h + bearing_h -0.01]) cylinder(h=4 + 1.02, d=7.2);

    // for (i = [0:.1:20]) {
    //     translate([bearing_gap/3, base_h - 10, base_th + bearing_hub_h + bearing_h -0.01]) rotate([0, 0,i]) translate([0, -base_h + 20, 0]) cylinder(h=4 + 1.02, d=7.2);
    // }

    for (i = [0:1:20]) {
        hull() {
            translate([bearing_gap/3, base_h - 10, base_th + bearing_hub_h + bearing_h -0.01]) rotate([0, 0,i]) translate([0, -base_h + 20, 0]) cylinder(h=4 + 1.02, d=7.2);
            translate([bearing_gap/3, base_h - 10, base_th + bearing_hub_h + bearing_h -0.01]) rotate([0, 0,i+1]) translate([0, -base_h + 20, 0]) cylinder(h=4 + 1.02, d=7.2);
        }
    }

    translate([bearing_gap/3, base_h - 10, base_th + bearing_hub_h + bearing_h -0.01]) cylinder(h=4 + 1.02, d=7.2);

    translate([bearing_gap/3, base_h - 10, 0]) cylinder(h=base_th + bearing_hub_h + bearing_h + 20, d=m4_hole_d);


}
