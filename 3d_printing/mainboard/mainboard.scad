include <OpenSCAD-common.scad>
use <melzi.scad>

// Melzi Dimensions approx 210mm x 50mm x 17mm
melzi_dimensions = [208.3, 49.55, 1.7];
melzi_hole_offset = [3.81, 3.81, 0];


$fn=50;


base_th = 3.5;

th=2;
case_clearance = 1;


case_w = melzi_dimensions[1] + 2*th + 2*case_clearance;
case_l = melzi_dimensions[0] + 2*th + 2*case_clearance;

case_h  = 8;

mount_tab_w = 20;

mount_tab_l = 35;

mount_tab_gap = 160;

mount_tab_r = 10;



// melzi_holes();/
translate([0,0,base_th + 2]) %melzi_pcb();


module mainboard_case(cutout=0){

    if(cutout==0) {
    difference() {
        translate([-case_l/2, -case_w/2, 0]) roundedRect([case_l, case_w, case_h],6);
        translate([-melzi_dimensions[0]/2 - case_clearance, -melzi_dimensions[1]/2 - case_clearance, base_th]) roundedRect([melzi_dimensions[0]+2*case_clearance, melzi_dimensions[1]+2*case_clearance, case_h],4+case_clearance);
        melzi_holes() cylinder(h=30, d=2.8, center = true);

        translate([40, -melzi_dimensions[1]/2, base_th + 1])  rotate([90, 0, 0]) roundedRect([20+13,10,10],3);
        // #translate([-100, melzi_dimensions[1]/2, th + 42])  rotate([-90, 0, 0]) roundedRect([200,40,10],7);
    }
    melzi_holes() difference() {
        cylinder(h=base_th+2, d=6);
        cylinder(h=30, d=2.8, center = true);
    }

    translate([0, 0, 0]) difference() {
        union() {
            translate([-mount_tab_w/2 + mount_tab_gap/2,  melzi_dimensions[1]/2 - mount_tab_r, 0])  roundedRect([mount_tab_w, mount_tab_l, 3.5], mount_tab_r);
            translate([-mount_tab_w/2 - mount_tab_gap/2,  melzi_dimensions[1]/2 - mount_tab_r, 0])  roundedRect([mount_tab_w, mount_tab_l, 3.5], mount_tab_r);
            translate([-mount_tab_w/2 + mount_tab_gap/2, -melzi_dimensions[1]/2 - mount_tab_l + mount_tab_r, 0])  roundedRect([mount_tab_w, mount_tab_l, 3.5], mount_tab_r);
            translate([-mount_tab_w/2 - mount_tab_gap/2, -melzi_dimensions[1]/2 - mount_tab_l + mount_tab_r, 0])  roundedRect([mount_tab_w, mount_tab_l, 3.5], mount_tab_r);
        }
        translate([ mount_tab_gap/2,  melzi_dimensions[1]/2 - 2*mount_tab_r + mount_tab_l, -1]) cylinder(h=10, d=4);
        translate([-mount_tab_gap/2,  melzi_dimensions[1]/2 - 2*mount_tab_r + mount_tab_l, -1]) cylinder(h=10, d=4);
        translate([ mount_tab_gap/2, -melzi_dimensions[1]/2 + 2*mount_tab_r - mount_tab_l, -1]) cylinder(h=10, d=4);
        translate([-mount_tab_gap/2, -melzi_dimensions[1]/2 + 2*mount_tab_r - mount_tab_l, -1]) cylinder(h=10, d=4);
    }
    }

    if(cutout) {
        translate([ mount_tab_gap/2,  melzi_dimensions[1]/2 - 2*mount_tab_r + mount_tab_l, -1]) children();
        translate([-mount_tab_gap/2,  melzi_dimensions[1]/2 - 2*mount_tab_r + mount_tab_l, -1]) children();
        translate([ mount_tab_gap/2, -melzi_dimensions[1]/2 + 2*mount_tab_r - mount_tab_l, -1]) children();
        translate([-mount_tab_gap/2, -melzi_dimensions[1]/2 + 2*mount_tab_r - mount_tab_l, -1]) children();
    
    }


}


mainboard_case(0) cylinder(h=10, d=2);
