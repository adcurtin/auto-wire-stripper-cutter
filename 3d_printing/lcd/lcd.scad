use <lcd_cover.scad>
use <lcd_supports.scad>

$fn=50;




// LCD ASSY BRACKET FOR REPRAP DISCOUNT SMART CONTROLLER
// THIS BRACKET FIX LCD-ASSY TO PSU-Y PART ON MK2S TYPE Y-AXIS
// PLEASE REFER TO THINGIVERSE -> https://www.thingiverse.com/thing:4720224
// JANUARY 2021

module lcd_mount_holes(total_h=10, screwhead_h=4, screwhead_d=6.2){

    // Fixation holes to lcd supports

    translate([15,    10, 22.8]) rotate([90,0,0]) screw(total_h + 10, screwhead_h, screwhead_d);
    translate([15,    10, 33.8]) rotate([90,0,0]) screw(total_h + 10, screwhead_h, screwhead_d);
    translate([15+63, 10, 22.8]) rotate([90,0,0]) screw(total_h + 10, screwhead_h, screwhead_d);
    translate([15+63, 10, 33.8]) rotate([90,0,0]) screw(total_h + 10, screwhead_h, screwhead_d);
}

module screw(total_h, screwhead_h, screwhead_d){
    translate([0, 0, total_h-screwhead_h]) cylinder(h=screwhead_h + 0.01, d=screwhead_d);
    cylinder(h=total_h, d=3.4);
}


lcd_mount_holes(18);







// bracket_holes();

//bottom of bottom hole
echo(22.8 - 1.7);
//top of top hole
echo(33.8 + 1.7);

echo((20-(35.5-21.1))/2);

module lcd(){
    translate([73, 61.5, .8]) rotate([90, 0, 90]) left_lcd_support();
    translate([10, 61.5, .8]) rotate([90, 0, 90]) support();
    translate([18.5, 16.5 + 2.5, 69.44+2.2]) rotate([45, 180, 0]) translate([0, 0-.5, 0]) lcd_cover();
}

lcd();