// Base dimensions
base_width = 18;
base_length = 88;
base_thickness = 2; // Adjust as needed

// Outer hole parameters
outer_hole_diameter = 3.4; // Diameter with tolerance
outer_hole_spacing = 69.5;
outer_hole_offset_y = 2; // Offset of the outer holes from the base center (y-axis)

// Calculate outer hole center positions
outer_hole1_x = -outer_hole_spacing / 2;
outer_hole2_x = outer_hole_spacing / 2;


// Inner hole parameters
inner_hole_diameter = 3.4;
inner_hole_spacing = 54.5;
// Relative offset of the inner holes from the outer holes (along y-axis)
// A negative value places inner holes "below" (lesser y) the outer holes
inner_hole_relative_offset_y = -4.8;

// Calculate inner hole center positions (relative to the base center)
inner_hole1_x = -inner_hole_spacing / 2;
inner_hole2_x = inner_hole_spacing / 2;
// Calculate absolute Y position for inner holes
inner_hole_y_pos = outer_hole_offset_y + inner_hole_relative_offset_y;

// Create the base plate
module base() {
  cube([base_length, base_width, base_thickness], center = true);
}

// Create an outer hole (using cylinder for subtraction)
module outer_hole() {
  // Use a slightly taller cylinder for clean subtraction
  cylinder(d = outer_hole_diameter, h = base_thickness + 1, center = true);
}

// Create an inner hole (using cylinder for subtraction)
module inner_hole() {
  // Use a slightly taller cylinder for clean subtraction
  cylinder(d = inner_hole_diameter, h = base_thickness + 1, center = true);
}


difference() {
  // 1. Start with the base
  base();

  // 2. Subtract the main holes
  // Outer holes
  translate([outer_hole1_x, outer_hole_offset_y, 0]) outer_hole();
  translate([outer_hole2_x, outer_hole_offset_y, 0]) outer_hole();
  
  // Inner holes
  translate([inner_hole1_x, inner_hole_y_pos, 0]) inner_hole();
  translate([inner_hole2_x, inner_hole_y_pos, 0]) inner_hole();

}