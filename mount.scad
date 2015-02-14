/* Mini to micro servo mount for the Gaui X3
 *
 * License: CC BY 4.0 http://creativecommons.org/licenses/by/4.0/
 *
 * Created: 2015-02-14
 * Author: Christian Axelsson
 * E-mail: christian@smiler.se
 */

$fn=99;

thickness = 3.0;            // Thickness of plate
servo_cut_margin = 1.5;     // Width of edge between servo cut and plate edge
frame_mount_margin = 3.0;   // Margin between frame mount hole and plate edge
fillet_radius = 3.0;        // Corner fillet radius

hole_distance = 42.1;       // Center to center frame mount hole distance
hole_spacing = 7.5;         // Center to center frame mount hole sDDDDpacing
hole_diameter = 3.0;        // Frame mount hole diameter
hole_nuttrap = 2.0;         // Depth of frame mount hole nut trap

// TGY 306G-HV servo
servo_hole_distance = 28.0; // Center to center servo hole distance
servo_hole_diameter = 2.0;  // Servo mount hole mount hole diameter
servo_width = 12.5;         // Width of servo
servo_length = 23.5;        // Length of servo
servo_hole_nuttrap = 1.8;   // Depth of servo mount hole nuttrap

module main() {
    difference() {
        shell(servo_width + 2*servo_cut_margin, hole_distance + hole_diameter + 2*frame_mount_margin);
        servo_cut();
        #holes();
    }
}

module shell(width, length) {
    hull() {
        cube(size=[width - 2*fillet_radius, length, thickness], center=true);
        translate([width/2 - fillet_radius, length/2 - fillet_radius, 0]) {
            cylinder(h=thickness, r=fillet_radius, center=true);
        }
        translate([-width/2 + fillet_radius, length/2 - fillet_radius, 0]) {
            cylinder(h=thickness, r=fillet_radius, center=true);
        }
        translate([-width/2 + fillet_radius, -length/2 + fillet_radius, 0]) {
            cylinder(h=thickness, r=fillet_radius, center=true);
        }
        translate([width/2 - fillet_radius, -length/2 + fillet_radius, 0]) {
            cylinder(h=thickness, r=fillet_radius, center=true);
        }
    }
}

module servo_cut() {
    cube(size=[servo_width, servo_length, 10], center=true);
}

module holes() {
    // Frame mount holes
    translate([hole_spacing/2, hole_distance/2, 0]) {
        hole(hole_diameter);
        nuttrap(5.5, hole_nuttrap);
    }
    translate([-hole_spacing/2, -hole_distance/2, 0]) {
        hole(hole_diameter);
        nuttrap(5.5, hole_nuttrap);
    }
    translate([hole_spacing/2, -hole_distance/2, 0]) {
        hole(hole_diameter);
        nuttrap(5.5, hole_nuttrap);
    }
    translate([-hole_spacing/2, hole_distance/2, 0]) {
        hole(hole_diameter);
        nuttrap(5.5, hole_nuttrap);
    }
    
    // Servo mount holes
    translate([0, servo_hole_distance/2, 0]) {
        hole(servo_hole_diameter);
        nuttrap(4.5, servo_hole_nuttrap);
    }
    translate([0, -servo_hole_distance/2, 0]) {
        hole(servo_hole_diameter);
        nuttrap(4.5, servo_hole_nuttrap);
    }
}

module hole(diameter) {
    cylinder(h=thickness+2, d=diameter, center=true);
}

module nuttrap(diameter, depth) {
    translate([0,0,thickness/2 - depth]) {
        cylinder(r = diameter/2 / cos(180/6) + 0.05, h=depth+1, $fn=6, center=false);
    }
}

main();
