$fn=100; // Set resolution for smooth cylinders

// Steering bellcrank for Tamiya TT-02R A3 part
// Dimensions: 4.8mm main hole, 8mm bearing cutouts, 2.5mm tie rod holes
// Arms: 18mm and 14mm lengths, 5.7mm thickness
main_body_height_mm=5.7;
long_arm_hole_offset_mm=18;
short_arm_hole_offet_mm=14;

center_total_diameter_mm=10;
ends_total_diameter_mm=6;
long_ends_total_height_mm=6;
short_ends_total_height_mm=17;
ends_total_thread_height_mm=30;

long_ends_total_height_from_origin_mm = long_ends_total_height_mm-main_body_height_mm;
short_ends_total_height_from_origin_mm = short_ends_total_height_mm-main_body_height_mm;
long_ends_z_start_mm=long_ends_total_height_mm/2;
short_ends_z_start_mm=short_ends_total_height_mm/2;




main_pivet_hole_diameter_mm=6;

//bearing_diameter_mm=4.6;
bearing_diameter_mm=8.1;
bearing_depth_mm=1.7;
nuggin_thread_z_start=10;
nugging_thread_diameter=2.8;

difference() {
    union() {
        // Central section
        cylinder(d=center_total_diameter_mm, h=main_body_height_mm);
        // Tapered arm to x=18mm
        hull() {
            translate([0,-5,0]) cube([0.1,10,main_body_height_mm]);    // Wide base at central cylinder edge
            translate([long_arm_hole_offset_mm,-ends_total_diameter_mm/2,0]) cube([0.1,ends_total_diameter_mm,main_body_height_mm]);  // Original width at end
        }
        // Tapered arm to x=-14mm
        hull() {
            translate([0,-5,0]) cube([0.1,10,main_body_height_mm]);   // Wide base at central cylinder edge
            translate([-short_arm_hole_offet_mm,-ends_total_diameter_mm/2,0]) cube([0.1,ends_total_diameter_mm,main_body_height_mm]); // Original width at end
        }
    }
    // Main pivot hole (4.8mm diameter)
    cylinder(d=main_pivet_hole_diameter_mm, h=100, center=true);
    
    // Bottom bearing pocket (8mm diameter, 1.85mm deep)
    cylinder(d=bearing_diameter_mm, h=bearing_depth_mm);
    // Top bearing pocket (8mm diameter, 1.85mm deep)
    translate([0,0,main_body_height_mm-bearing_depth_mm]) cylinder(d=bearing_diameter_mm, h=bearing_depth_mm);
    
    union() {
        translate([long_arm_hole_offset_mm,0,long_ends_z_start_mm]) cylinder(d=ends_total_diameter_mm, h=long_ends_total_height_mm, center=true);
        translate([-short_arm_hole_offet_mm,0,short_ends_z_start_mm]) cylinder(d=ends_total_diameter_mm, h=short_ends_total_height_mm, center=true);
    }
}


difference() {
    union() {
        translate([long_arm_hole_offset_mm,0,long_ends_z_start_mm]) cylinder(d=ends_total_diameter_mm, h=long_ends_total_height_mm, center=true);
        translate([-short_arm_hole_offet_mm,0,short_ends_z_start_mm]) cylinder(d=ends_total_diameter_mm, h=short_ends_total_height_mm, center=true);
    }
    // Tie rod hole at x=18mm (2.5mm diameter)
    translate([long_arm_hole_offset_mm,0,nuggin_thread_z_start]) cylinder(d=nugging_thread_diameter, h=ends_total_thread_height_mm, center=true);
    // Tie rod hole at x=-14mm (2.5mm diameter)
    translate([-short_arm_hole_offet_mm,0,nuggin_thread_z_start]) cylinder(d=nugging_thread_diameter, h=ends_total_thread_height_mm, center=true);
}