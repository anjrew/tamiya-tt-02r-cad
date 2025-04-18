$fn=100; // Set resolution for smooth cylinders

// Steering bellcrank for Tamiya TT-02R A3 part
// Dimensions: 4.8mm main hole, 8mm bearing cutouts, 2.5mm tie rod holes
// Arms: 18mm and 14mm lengths, 5.7mm thickness

long_arm_hole_offset_mm=18;
short_arm_hole_offet_mm=14;

center_total_diameter_mm=10;
ends_total_diameter_mm=6;
ends_total_height_mm=12;
ends_total_thread_height_mm=6;

main_body_height_mm=5.7;

difference() {
    union() {
        // Central section
        cylinder(d=center_total_diameter_mm, h=main_body_height_mm);
        // Tapered arm to x=18mm
        hull() {
            translate([0,-5,0]) cube([0.1,10,main_body_height_mm]);    // Wide base at central cylinder edge
            translate([long_arm_hole_offset_mm,-ends_total_diameter_mm/2,0]) cube([0.1,5,main_body_height_mm]);  // Original width at end
        }
        // Tapered arm to x=-14mm
        hull() {
            translate([0,-5,0]) cube([0.1,10,main_body_height_mm]);   // Wide base at central cylinder edge
            translate([-short_arm_hole_offet_mm,-ends_total_diameter_mm/2,0]) cube([0.1,ends_total_diameter_mm,main_body_height_mm]); // Original width at end
        }
    }
    // Main pivot hole (4.8mm diameter)
    cylinder(d=4.8, h=6, center=true);
    // Bottom bearing pocket (8mm diameter, 1.85mm deep)
    cylinder(d=8.2, h=1.85);
    // Top bearing pocket (8mm diameter, 1.85mm deep)
    translate([0,0,5.7-1.85]) cylinder(d=8.2, h=1.85);
}

nuggin_thread_z_start=-(ends_total_height_mm/2);

difference() {
    union() {
        translate([long_arm_hole_offset_mm,0,0]) cylinder(d=ends_total_diameter_mm, h=ends_total_height_mm, center=true);
        translate([-short_arm_hole_offet_mm,0,0]) cylinder(d=ends_total_diameter_mm, h=ends_total_height_mm, center=true);
    }
    // Tie rod hole at x=18mm (2.5mm diameter)
    translate([long_arm_hole_offset_mm,0,nuggin_thread_z_start]) cylinder(d=2.5, h=ends_total_thread_height_mm, center=true);
    // Tie rod hole at x=-14mm (2.5mm diameter)
    translate([-short_arm_hole_offet_mm,0,nuggin_thread_z_start]) cylinder(d=2.5, h=ends_total_thread_height_mm, center=true);
}