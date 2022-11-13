
use <lcd_supports.scad>

// PRUSA iteration4
// LCD cover
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

// THIS IS A MODIFICATION OF THE ORIGINAL PRUSA SCAD FILE FOR MK3S LCD COVER

// LCD_COVER FOR REPRAP DISCOUNT SMART CONTROLLER
// REPRAP SMART CONTROLLER ASSY (CONTROLLER AND LCD SUPPORTS) IS FIXED TO THIS LCD COVER 
// PLEASE REFER TO THINGIVERSE -> https://www.thingiverse.com/thing:4720224
// JANUARY 2021

top_offset = 0.7;

module buzzer_holes(){

    // buzzer holes
    translate( [ 0 , 0 , -1 ] ) cube( [ 1.3 ,4 , 10 ] );  
    translate( [ 2 , 0 , -1 ] ) cube( [ 1.3 , 4 , 10 ] );  
    translate( [ 4 , 0 , -1 ] ) cube( [ 1.3 , 4 , 10 ] );  
    translate( [ 6 , 0 , -1 ] ) cube( [ 1.3 , 4 , 10 ] );  
    translate( [ 8 , 0 , -1 ] ) cube( [ 1.3 , 4 , 10 ] );  
    translate( [ 10 , 0 , -1 ] ) cube( [ 1.3 , 4 , 10 ] );  
    translate( [ 12 , 0 , -1 ] ) cube( [ 1.3 , 4 , 10 ] );  
    
    // buzzer holes corners
    translate( [ -0.75+12, 0 , -0.5 ] ) rotate([0,45,0]) cube( [ 2 , 4 , 2 ] );  
    translate( [ -0.75+10 , 0 , -0.5 ] ) rotate([0,45,0]) cube( [ 2 , 4 , 2 ] );  
    translate( [ -0.75+8 , 0 , -0.5 ] ) rotate([0,45,0]) cube( [ 2 , 4 , 2 ] );  
    translate( [ -0.75+6 , 0 , -0.5 ] ) rotate([0,45,0]) cube( [ 2 , 4 , 2 ] );  
    translate( [ -0.75+4 , 0 , -0.5 ] ) rotate([0,45,0]) cube( [ 2 , 4 , 2 ] );  
    translate( [ -0.75+2 , 0 , -0.5 ] ) rotate([0,45,0]) cube( [ 2 , 4 , 2 ] );  
    translate( [ -0.75 , 0 , -0.5 ] ) rotate([0,45,0]) cube( [ 2 , 4 , 2 ] );  

}

module knob_hole(){
    
    // knob hole
    translate( [ 0 , 0 , -1 ] ) cylinder( h = 10, r = 6, $fn=30);
    translate( [ 0 , 0 , -1.2 ] ) cylinder( h = 2, r1 = 7, r2 = 6, $fn=30);
    
}

module reset_button_cutout(){
    
// reset button cutout
translate( [ 0 , 0 , -1 ] ) cube( [ 1 , 6 , 9 ] );  
translate( [ 4 , 0 , -1 ] ) cube( [ 1 , 2.5 , 9 ] );  
translate( [ 24.5 , 10 , -1 ] ) cube( [ 1 , 8 , 9 ] );  
translate( [ 12 , 17 , -1 ] ) cube( [ 13.5 , 1 , 9 ] ); 
translate( [ 6.5 , 4 , -1 ] ) cube( [ 13 , 1 , 9 ] ); 
translate( [ 0.7 , 5.28 , -1 ] ) rotate([0,0,45]) cube( [ 17 , 1 , 9 ] );  
translate( [ 19.5 , 4 , -1 ] ) rotate([0,0,45]) cube( [ 8.5 , 1 , 9 ] );  
translate( [ 4.7 , 1.8 , -1 ] ) rotate([0,0,45]) cube( [ 3.55 , 1 , 9 ] );
}

module main_body()
{
    difference() 
    {
        union() 
        {
            // main body
            
            translate( [ -77 , -4.5-2 , 0 ] ) cube( [ 155-57 , 43.3+15+19.5+4.5+3.4+2 , 2 ] );
            translate( [ -77 , -4.5-2 , 0 ] ) rotate([35,0,0]) cube( [ 155-57 , 2 , 20.08 ] );
            translate( [ -77 , -3.5 , -1-5 ] ) rotate([35,0,0]) cube( [ 7 , 5 , 15 ] ); 
            translate( [ 71-57 , -3.5 , -1-5 ] ) rotate([35,0,0]) cube( [ 7 , 5 , 15 ] );
            translate( [ -77 , -14.7 + top_offset , 14.2-4 ] )  cube( [ 155-57 , 2 , 11.8+4 ] );
            translate( [ -77 , 43.3+15+19.5+3.4 , 0 ] ) cube( [ 155-57 , 2+1 , 17 ] );
            
            // M3 hole body
            
            translate( [ -77+1.5+1+2.5 , 1+51+9.5-2.5 , 0.5 ] ) rotate([0,0,90])  cylinder( h = 14.5+1.2-6-0.5, r = 4, $fn=6); // 
            translate( [ -77+1.5+1+2.5+88 , 1+51+9.5-2.5 , 0.5 ] ) rotate([0,0,90])  cylinder( h = 14.5+1.2-6-0.5, r = 4, $fn=6); //
        }
        
        // LCD window

        translate( [ -77+1.5+8.5-0.25 , 1-0.25 , 1.2 ] ) cube( [ 78.5 , 51.5 , 10 ] );  // LCD window
        translate( [ -77+1.5+8.5+1.5 , 1+4.5 , -1 ] ) cube( [ 75 , 42 , 10 ] );  // LCD window
        
        // buzzer holes and corners
        translate([ -77+1.5+1+93-10-17.76-(13.3/2) , 1+51+9.5+17-8.55-2 , 0 ]) buzzer_holes();
        
        // knob hole
        translate([ -77+1.5+1+93-10 , 1+51+9.5+17-8.53 , 0 ]) knob_hole(); //1+51+9.5-2.5
        
        // reset button cutout
        translate([ 9-17.76-18.08-18.5 , 69.3-11.3+0.5+1 , 0 ]) reset_button_cutout();

        // rear support cutout
        // translate( [ -64.5 , -12.7 , 14 ] ) cube( [ 10 , 3 , 16 ] );  
        // translate( [ 55.5-57 , -12.7 , 14 ] ) cube( [ 10 , 3 , 16 ] ); 

    }
}

// !main_body();

module pcb_clip()
{
    difference()
    {
    union()
        {
            translate( [ -3 , -12 , 17.5 ] ) cube( [ 7 , 4+0.25 , 5 ] ); 
            translate( [ -3 , -10.6 , 12.5-3 ] ) cube( [ 1 , 2.6+0.25 , 7+3 ] );  
            translate( [ 3 , -10.6 , 12.5-3 ] ) cube( [ 1 , 2.6+0.25 , 7+3 ] ); 
        }
        translate( [ -4 , -8+0.25 , 18.5 ] ) rotate([30,0,0]) cube( [ 10 , 6 , 6 ] );  
        translate( [ 2.5 , -12 , 14.5+1.2-6+(17.5-15.7) ] ) cube( [ 1 , 4+0.25 , 0.2 ] );  
        translate( [ -2.5 , -12 , 14.5+1.2-6+(17.5-15.7) ] ) cube( [ 1 , 4+0.25 , 0.2 ] ); 
        translate( [ 2.5 , -12 , 17.3 ] ) cube( [ 1 , 4+0.25 , 0.2 ] );  
        translate( [ -2.5 , -12 , 17.3 ] ) cube( [ 1 , 4+0.25 , 0.2 ] );   
          
    }        
}   

module lcd_cover(){
difference()
{
    union()
    {

    translate( [ -57/2 , 0+1 , 15.7-17.5] ) pcb_clip();
    main_body();

    // reset button
    translate( [ -77+1.5+1+93-10-17.76-(93-47.16-17.76-10) , 1+51+9.5+17-8.21 , 0 ] ) cylinder( h = 14.5-7+1.2 , r = 3.5, $fn=30);

    //left side
    translate( [ -77 , -14.7 , 0 ] ) cube( [ 1.5 , 43.3+15+19.5+14.7+3.4 , 26 ] );  
    translate( [ -76.5 , -15 , 0 ] ) cube( [ 4 , 43.3+15+19.5+15+3.4 , 14.5+1.2-6 ] ); 

    //right side
    translate( [ 76.5-57 , -14.7 , 0 ] ) cube( [ 1.5 , 43.3+15+19.5+14.7+3.4 , 26 ] ); 
    translate( [ 73.5-57 , -14 , 0 ] ) cube( [ 4 , 43.3+15+19.5+14+3.4 , 14.5+1.2-6 ] );

    //rear side reinforcement

    echo( 43.3+15+19.5+3.4-3.4+1.4);

    translate( [ -54.5 , -11.7 , 8-4 ] ) cube( [ 110-57 , 4+1 , 6.5+1.2-6+4] );  //
    translate( [ 65.5-57 , -11.7 , 8-4 ] ) cube( [ 12 , 4+1 , 6.5+1.2-6+4 ] );  //
    translate( [ -76.5 , -11.7 , 8-4 ] ) cube( [ 12 , 4+1 , 6.5+1.2-6+4 ] );  //
    translate( [ 65.5-57 , -14.7 , 14.5-2-4 ] ) cube( [ 12 , 4+1 , 11.5+2+4 ] );  
    translate( [ -76.5 , -14.7 , 14.5-2-4 ] ) cube( [ 12 , 4+1 , 11.5+2+4 ] );
    translate( [ -44 , -14.7 , 14.5-2-4 ] ) cube( [ 89-57 , 4+1 , 11.5+2+4 ] );  
    translate( [ -43.5 , -12.7 , 15 ] ) rotate([-90,0,0]) cylinder( h = 2+1, r = 11, $fn=60);  
    translate( [ 44.5-57 , -12.7 , 15 ] ) rotate([-90,0,0]) cylinder( h = 2+1, r = 11, $fn=60);
    translate( [ -43.5-11 , -14.7 , 14.5-2-4-11 ] ) cube( [ 110-57 , 4+1 , 11.5+2+4 ] );  
 
    //front and left side reinforcement
    difference()
    {
        union()
            {
                translate( [ -77 , 43.3+15+19.5+3.4-3.4+1.4 , 0 ] ) cube( [ 155-57, 3.4-1.4 , 25 ] );
                translate( [ -77+(155-57)-20-70 , 43.3+15+19.5+3.4-3.4+1.4-5+3 , 0 ] ) cube( [ 70 , 5+3.4-1.4-3 , 14.5+1.2-1.5 ] );     
                
                //front left side reinforcement
                translate( [ -77 , 43.3+15+19.5+3.4-3.4+1.4-5 , 0 ] ) cube( [ 20 , 5+3.4-1.4 , 14.5+1.2-1.5 ] ); 
                translate( [ -76.5 , 43.3+15+19.5+3.4-3.4+1.4-5-10 , 0 ] ) cube( [ 4 , 10 , 14.5+1.2-1.5 ] ); 
                
                //front right side reinforcement
                translate( [ -77+(155-57)-20 , 43.3+15+19.5+3.4-3.4+1.4-5+3 , 0 ] ) cube( [ 20 , 5+3.4-1.4-3 , 14.5+1.2-1.5 ] );
                translate( [ 73.5-57 , 43.3+15+19.5+3.4-3.4+1.4-5-10 , 0 ] ) cube( [ 4 , 15 , 14.5+1.2-1.5 ] );                 
            }
        
            //front left side reinforcement
            translate( [ -76.5+12-0.5 , 43.3+15+19.5+3.4-3.4+1.4-6 , 0 ] ) cube( [ 10+1 , 4+6 , 20 ] ); 
            translate( [ -60+0.20+0.5 , 43.3+15+19.5+3.4-3.4+1.4-6 , 25 ] ) rotate([0,120,0]) cube( [ 12+1-4 , 10 , 10 ] );

            //front right side reinforcement
            translate( [ 65.5-57-10-0.5 , 43.3+15+19.5+3.4-3.4+1.4-6 , 0 ] ) cube( [ 10+1 , 4+6 , 20 ] ); 
            translate( [ 49-57+0.25-0.5 , 43.3+15+19.5+3.4-3.4+1.4-6 , 25 ] ) rotate([0,60,0]) cube( [ 12+1 , 10 , 10 ] );     
  
    }
    }


// cutout superior encaje placa

//translate( [ -77+1.5 , -10.7+2-1 , 14.5+1.2-6 ]) cube([76.5-57-(-77+1.5),10,20]);
    
    // SD card opening
    // translate( [ -80 , 1-0.25+(51.5/2)-14 , 14.5+1.2-0.75 ] ) cube( [ 10 , 28 , 5 ] );

    // backlight switch opening
    translate( [ -80 , 30 +1, 14.5+1.2-0.75 + 1 ] ) cube( [ 10 , 13 , 6 ] );

    // LCD cut-out
    translate( [ -80+6 , 1-0.25+(51.5/2)-24 , 14.5+1.2-6-5 ] ) cube( [ 10-5 , 28+20 , 6 ] );

    // front and rear angle
    translate( [ -81 , -9.3-2 +top_offset, -17 ] ) rotate([35,0,0]) cube( [ 164 , 14 , 54.08 ] );  
    translate( [ -78 , 72.7+15+19.5-6-1+1 , -3 ] ) rotate([45,0,0]) cube( [ 160 , 14 , 54.08 ] );

    // M3 screw thread

    translate( [ -77+1.5+1+2.5+88 , 1+51+9.5-2.5 , 3 ] ) cylinder( h = 20, r = 1.4, $fn=30);  
    translate( [ -77+1.5+1+2.5 , 1+51+9.5-2.5 , 3 ] ) cylinder( h = 20, r = 1.4, $fn=30); 
    translate( [ -77+1.5+1+2.5+88 , 1+51+9.5-2.5 , 14.5+1.2-6-1 ] ) cylinder( h = 3, r1 = 1.4, r2=2, $fn=30);  
    translate( [ -77+1.5+1+2.5 , 1+51+9.5-2.5 , 14.5+1.2-6-1 ] ) cylinder( h = 3, r1 = 1.4, r2=2, $fn=30);


    // ORIGINAL PRUSA text
    //translate([-67,51,0.6]) rotate([180,0,0]) linear_extrude(height = 2) 
    //{ text("ORIGINAL",font = "helvetica:style=Bold", size=7, center=true); }
    //translate([-18,51,0.6]) rotate([180,0,0]) linear_extrude(height = 2) 
    //{ text("PRUSA",font = "helvetica:style=Bold", size=11, center=true); }
    
    // LCD PRUSAi3 text
    translate([-18-48-1+0.75,52+5.25+1,0.6]) rotate([180,0,0]) linear_extrude(height = 2) 
    { text("WIRE CUTTER",font = "helvetica:style=Bold", size=11-3); }  

    // front cleanup
    translate( [ -100 , -64 +top_offset, 0 ] ) cube( [ 200 , 50 , 50 ] ); 

    // X sign on reset button  
    translate( [ 9-17.76-18.08-18.5+(63-44) , 69.3-11.3+(34-26)+1 , -1 ] ) rotate([0,0,45]) cube( [ 2, 8, 2 ] );  
    translate( [ 9-17.76-18.08-18.5+(57.5-44) , 69.3-11.3+(35.5-26)+1 , -1 ] ) rotate([0,0,-45]) cube( [ 2, 8, 2 ] );  

    // corners
    translate( [ 73-57 , -5-5 , -1 ] ) rotate([0,45,0]) cube( [ 7, 80+20+5, 7 ] );      
    translate( [ -82 , -5-5 , -1 ] ) rotate([0,45,0]) cube( [ 7, 80+20+5, 7 ] );  

    translate( [ -82 , 43.3+15+19.5+3.4+4+1 , -5 ] ) rotate([45,0,0]) cube( [ 200, 7, 7 ] );  
    translate( [ -77 , 43.3+15+19.5+3.4-2 , -4 ] ) rotate([0,0,45]) cube( [ 8, 8, 50 ] );  
    translate( [ 78-57 , 43.3+15+19.5+3.4-2 , -4 ] ) rotate([0,0,45]) cube( [ 8, 8, 50 ] ); 
    translate( [ 78-57 , -19 +top_offset, -4 ] ) rotate([0,0,45]) cube( [ 5, 5, 50 ] );  
    translate( [ -77 , -19 +top_offset, -4 ] ) rotate([0,0,45]) cube( [ 5, 5, 50 ] );  
    
    // LCD corners

    translate( [ -100 , -40 , -50.01 ] ) cube( [ 200 , 50 , 50 ] ); 
    
    translate( [ -77+1.5+8.5+1.5 , 1+4.5+0.75 , -5.2 ] ) rotate([45,0,0]) cube( [ 75 , 5 , 5 ] );  // LCD window superior
    translate( [-77+1.5+8.5+1.5 , 1+4.5+0.75+42-2+0.5 , -5.2 ] ) rotate([45,0,0]) cube( [ 75 , 5 , 5 ] );  // LCD window inferior
    
    // fr side corners
    
    rotate([35,0,0]) translate( [ -78+1 , -7-2 +top_offset, -4 ] ) rotate([0,0,45]) cube( [ 5, 5, 50 ] );  
    rotate([35,0,0]) translate( [ 79-57-1 , -7-2 +top_offset , -4 ] ) rotate([0,0,45]) cube( [ 5, 5, 50 ] ); 
    
    // version
    //translate([-73,15,4]) rotate([90,0,90]) linear_extrude(height = 2) 
    //{ text("R2",font = "helvetica:style=Bold", size=7, center=true); }
      
}

// print support for backlight switch opening

translate( [ -76.5 , 34.5-(9-(0.5+(51.5/2)-14+0.5)) , 16.70-(16.5-(14.5+1.2-0.75)) +1 ] ) cube( [ 1 , 5 , 4.1+0.5 +1] );
translate( [ -76.5 , 27-(9-(0.5+(51.5/2)-14+0.5)) +1 , 16.70-(16.5-(14.5+1.2-0.75)) +1 ] ) cube( [ 1 , 5 , 4.1+0.5 +1] ); 


// print support for SD card opening

// translate( [ -76.5 , 15-(9-(0.5+(51.5/2)-14+0.5)) , 16.70-(16.5-(14.5+1.2-0.75)) ] ) cube( [ 1 , 5 , 4.1+0.5 ] );
// translate( [ -76.5 , 25-(9-(0.5+(51.5/2)-14+0.5)) , 16.70-(16.5-(14.5+1.2-0.75)) ] ) cube( [ 1 , 5 , 4.1+0.5 ] ); 
}


// translate([10 - 1.5 - 63, 80.2 + .5, 4 + 1.8 + 14.2]) rotate([-90, 45, 90]) left_lcd_support();
// translate([10 - 1.5, 80.2 + .5, 4 + 1.8 + 14.2]) rotate([-90, 45, 90]) support();


lcd_cover();

