$fn=100; // Set resolution for smooth cylinders

// Steering bellcrank for Tamiya TT-02R A3 part
// Dimensions: 4.8mm main hole, 8mm bearing cutouts, 2.5mm tie rod holes
// Arms: 18mm and 14mm lengths, 5.7mm thickness

center_total_diameter_mm=10;
ends_total_diameter_mm=6;
ends_total_height_mm=12;
ends_total_thread_height_mm=6;

difference() {
    union() {
        // Central section
        cylinder(d=center_total_diameter_mm, h=5.7);
        // Arm to x=18mm
        translate([0,-2.5,0]) cube([18,5,5.7]);
        // Arm to x=-14mm
        translate([-14,-2.5,0]) cube([14,5,5.7]);
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
        translate([18,0,0]) cylinder(d=ends_total_diameter_mm, h=ends_total_height_mm, center=true);
        translate([-14,0,0]) cylinder(d=ends_total_diameter_mm, h=ends_total_height_mm, center=true);
    }
    // Tie rod hole at x=18mm (2.5mm diameter)
    translate([18,0,nuggin_thread_z_start]) cylinder(d=2.5, h=ends_total_thread_height_mm, center=true);
    // Tie rod hole at x=-14mm (2.5mm diameter)
    translate([-14,0,nuggin_thread_z_start]) cylinder(d=2.5, h=ends_total_thread_height_mm, center=true);
};


// translate([-14,0,0]) cylinder(d=2.5, h=6, center=true);