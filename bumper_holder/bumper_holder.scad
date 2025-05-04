// Base dimensions
base_width = 18;
base_length = 88;
base_thickness = 2; // Adjust as needed

// Outer hole parameters
outer_hole_diameter = 2; // Diameter with tolerance
outer_hole_spacing = 69.5;
outer_hole_offset_y = 2; // Offset of the outer holes from the base center (y-axis)

// Calculate outer hole center positions
outer_hole1_x = -outer_hole_spacing / 2;
outer_hole2_x = outer_hole_spacing / 2;

// Create the base plate
module base() {
  cube([base_length, base_width, base_thickness], center = true);
}

// Create an outer hole (using cylinder for subtraction)
module outer_hole() {
  // Use a slightly taller cylinder for clean subtraction
  cylinder(d = outer_hole_diameter, h = base_thickness + 1, center = true);
}


difference() {
  // 1. Start with the base
  base();

  // 2. Subtract the main holes
  // Outer holes
  translate([outer_hole1_x, outer_hole_offset_y, 0]) outer_hole();
  translate([outer_hole2_x, outer_hole_offset_y, 0]) outer_hole();
}