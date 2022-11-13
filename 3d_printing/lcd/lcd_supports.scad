include <OpenSCAD-common.scad>

// PRUSA iteration4
// lcd supports
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

// THIS IS A MODIFICATION OF THE ORIGINAL PRUSA SCAD FILE FOR MK3S LCD SUPPORTS

// LCD-COVER SUPPORTS A AND B. 
// THESE BRACKETS FIX REPRAP DISCOUNT SMART CONTROLLER LCD_COVER ASSY TO LCD_ASSY BRACKET
// PLEASE REFER TO THINGIVERSE -> https://www.thingiverse.com/thing:4720224
// JANUARY 2021

module body()
{
           
    difference() 
        {
            
        // base block
            
        union(){
            
            translate([-55,-2,0]) cube([69,81+(87-55),10]); 
           
        }

            union ()
            {
                // outer body shape
                
                translate([-69.6,32,-1]) rotate([0,0,45]) cube([60,53,15]); 
                translate([13.7,89.7+18,-1]) rotate([0,0,135]) cube([60,42+30,15]);
                translate([-19,-9,-1]) cube([60,9,15] );   
                translate([7,-3,-1]) cube([60,68+(87-55),16]);  
                translate([-16,60+(87-55),-1]) cube([60,50,15] );
                translate([-41, -45,-1]) rotate([0,0,45]) cube([60,80,13]);  
                
                // pcb cout out

                translate([4,1.5,-1]) cube([1.8,56.5+(87-55),17]);  
                
                difference(){
                translate([0,7.5-3.5,-1]) cube([5.8,44.5+(87-55)+3.5,17]);      
                translate([7-3 + .01,1.5+1,-1] ) cube([5.8,5.8+3,17]);
                }
                
                translate([4.8,3.5,-1]) cube([5.8,52.5+(87-55),17]);
                translate([8,-5,-1] ) rotate([0,0,45]) cube([5,5,17]);
                translate([8,58+(87-55),-1]) rotate([0,0,45]) cube([5,5,17]);
                        
            }

            // pcb inserts
            translate([4,3,8]) rotate([45,0,0]) cube([1.8,5,5]); 
            translate([4,56.5+(87-55),8]) rotate([45,0,0]) cube([1.8,5,5]);     
            translate([4,3,-5]) rotate([45,0,0]) cube([1.8,5,5]); 
            translate([4,56.5,-5]) rotate([45,0,0]) cube([1.8,5,5]);     
        }
}

// body();


module support()
{

    difference() 
    {
    
        union()
        {
            rotate([0,0,45]) body();
            // screw block
            translate([-72,22,0])  cube([30,16,10]);    
        }
        
        // lower angled part cut
        translate([-75,-2,-1])  cube([20,14,15]);    
        translate([-70,-2,-1]) cube([20,14,15]);    
        translate([-50,-16.3,-1]) rotate([0,0,45]) cube([20,20,15]);    
        
        difference(){
        translate([-76.5,-2,-1]) cube([15,40+2+(87-55)-18,15]);    
        rotate([0,0,45]) translate([-10,7.5,-1]) cube([5.8,44.5+(87-55)+2,17]); 
        }
        difference()
        {
            translate([-28,0,-1]) rotate([0,0,45]) cube([10,40,15]);    
            translate([-38,-12,-1]) cube([20,20,15]);    
            translate([-58,23.5,-1]) cube([25,25,15]);    
        }
        
        // screw holes
        translate([-71,18+4,5]) rotate([0,90,0]) cylinder(h=22, r=1.75, $fn=30);  
        translate([-70,29+4,5]) rotate([0,90,0]) cylinder(h=22, r=1.75, $fn=30);  
        
        // nut traps
        //FIXME
        // #translate([-58,15.1+4,5-2.8]) cube([2.2,5.8,29.7]);    
        // translate([-58,26.1+4,5-2.8]) cube([2.2,5.8,29.7]); 

        translate([-58,15.1+4,5]) 
        translate([0, 5.4/2, 0]) hull() {
            rotate([0, 90, 0]) M3_hex_nut();
            translate([0,0,22]) rotate([0, 90, 0]) M3_hex_nut();
        }

        translate([-58,26.1+4,5])
        translate([0, 5.4/2, 0]) hull() {
            rotate([0, 90, 0]) M3_hex_nut();
            translate([0,0,22]) rotate([0, 90, 0]) M3_hex_nut();
        }
     
        // version
        //translate([-20,2,9.5]) rotate([0,0,0]) linear_extrude(height = 0.6) 
        //{ text("R1",font = "helvetica:style=Bold", size=5, center=true); }   
    }
}


module left_lcd_support()
{
    difference() {
        support();
        rotate([0,0,45]) 
        translate([-2, 34+1.5, -1]) cube([10, 16, 12]);
    }
     
    rotate([0,0,45]) 
    difference()
    {
        // sd card shield
        
        translate([-4,2.5+(87-70),10])  cube([2,70,10]); 
        translate([-5,2.5+(87-70),20]) rotate([0,90,0]) cylinder( h=4, r=7, $fn=30); 
        translate([-5,2.5+(87-70)+(70),20]) rotate([0,90,0]) cylinder( h=4, r=7, $fn=30); 


    }
}


translate([-60,-2,0]) rotate([0,0,180]) 
support();
left_lcd_support();


