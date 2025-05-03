// Base dimensions
base_width = 20;
base_length = 90;
base_thickness = 16; // Adjust as needed

// Outer hole parameters
outer_hole_diameter = 11; // Diameter with tolerance
outer_hole_spacing = 69.5;
outer_hole_offset_y = 2; // Offset of the outer holes from the base center (y-axis)

// Calculate outer hole center positions
outer_hole1_x = -outer_hole_spacing / 2;
outer_hole2_x = outer_hole_spacing / 2;
// outer_hole_y remains outer_hole_offset_y

// Inner hole parameters
inner_hole_diameter = 6.5;
inner_hole_spacing = 54.5;
// Relative offset of the inner holes from the outer holes (along y-axis)
// A negative value places inner holes "below" (lesser y) the outer holes
inner_hole_relative_offset_y = -4.8;

// Calculate inner hole center positions (relative to the base center)
inner_hole1_x = -inner_hole_spacing / 2;
inner_hole2_x = inner_hole_spacing / 2;
// Calculate absolute Y position for inner holes
inner_hole_y_pos = outer_hole_offset_y + inner_hole_relative_offset_y;

// Channel parameters
channel_diameter = 5; // The width of the channel, defined as a diameter for hulling cylinders
channel_height = base_thickness + 1; // Ensure it cuts through completely

// --- Modules ---

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

// Wing Dimensions
wing_length = 200; // Total length of the wing (X-axis)
wing_height = 50;  // Max height of the wing at the front (Z-axis)
back_width = 20;   // Width of the wing at the mounting face (Y-axis)
front_taper_width = 10; // Width of the wing at the very front, top edge (Y-axis) - Adjust taper here
wing_start_z_mm = wing_height/2 - base_thickness/2;
wing_bottom_thickness_mm=5;

module triangle_2d(base, height) {
  // Define the points of the 2D triangle in the XY plane
  // Starting at origin [0,0]
  points = [
    [0, 0],                 // Point 1: Origin
    [base, 0],     // Point 2: Along the X axis
    [0, height]    // Point 3: Along the Y axis (creates a right-angled triangle)
    // For an isosceles triangle centered on Y axis:
    // [triangle_base / 2, triangle_height]
  ];
  // Create the 2D polygon
  polygon(points);
}

module wing() {

    difference(){
    
    translate([0,base_width,wing_start_z_mm])
        cube([wing_length,back_width,wing_height],center = true);
    
    // Remove front part
    translate([0,base_width/2, base_thickness/2 + wing_height])
        rotate([90, 180, 270])
        linear_extrude(height = wing_length, center = true) {
         triangle_2d(base = back_width, height = wing_height);
    }
    
    // Remove back part
    translate([0,base_width/2 + back_width, -base_thickness/2 ])
        rotate([90, 0, 270])
        linear_extrude(height = wing_length, center = true) {
         triangle_2d(base = back_width-wing_bottom_thickness_mm, height = wing_height);
    }
   }
}


// --- Main Assembly ---

union()
{
    wing();

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

      // 3. Subtract the smooth connecting channels using hull()

      // Channel 1 (Left side: connects outer_hole1 and inner_hole1)
      hull() {
        // Cylinder at outer hole 1 center
        translate([outer_hole1_x, outer_hole_offset_y, 0])
          cylinder(d = channel_diameter, h = channel_height, center = true);
        // Cylinder at inner hole 1 center
        translate([inner_hole1_x, inner_hole_y_pos, 0])
          cylinder(d = channel_diameter, h = channel_height, center = true);
      }

      // Channel 2 (Right side: connects outer_hole2 and inner_hole2)
      hull() {
        // Cylinder at outer hole 2 center
        translate([outer_hole2_x, outer_hole_offset_y, 0])
          cylinder(d = channel_diameter, h = channel_height, center = true);
        // Cylinder at inner hole 2 center
        translate([inner_hole2_x, inner_hole_y_pos, 0])
          cylinder(d = channel_diameter, h = channel_height, center = true);
      }
    }
}