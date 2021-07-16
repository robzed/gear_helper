// Print an image with different gears

use <pd-gears/pd-gears.scad>

gear_module = 0.5;
thickness = 1;
hole_diameter = 1;

A4_height = 297;
A4_width = 210;

show_A4_sheet_size = false;

if(show_A4_sheet_size) {
    color("white") translate([0,0,-10]) square([A4_width, A4_height], center = false);
}

function module_to_circular_pitch(module_val) = module_val * PI;

minimum_teeth = 5; //5;
maximum_teeth = 54; // 54

mm_per_tooth = module_to_circular_pitch(gear_module);

for (teeth =[minimum_teeth:maximum_teeth]) {
    number_per_row = 5; //teeth < 10 ? 7 : (teeth < 20) ? 6 :  5;
    
    x = 34 * floor(teeth%number_per_row)+33;
    y = 27 * floor(teeth/number_per_row)-8;
    translate([x, y, 0]) {
        gear(mm_per_tooth, teeth, thickness, hole_diameter, center = true, pressure_angle  = 20);
        translate([outer_radius(mm_per_tooth,teeth), 0, 0]) text(str(teeth), size = 4);
    }
}


// http://rasterweb.net/raster/2012/07/16/openscad-to-dxf/
//    projection(cut=false) import("gear_module_0.5.stl");
