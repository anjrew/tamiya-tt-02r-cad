  // Constants for dimensions (all in mm)
WIDTH_MM = 200; // 20 cm
HEIGHT_MM = 10; // 5 cm
DEPTH_MM = 50; // Assumed depth for bumper stability
CENTER_POINT_OFFSET_MM = 25; // Slight point at center
ANGLE_DEG = 10; // Slight angle for Formula 1 wing-like slope
BACKPLATE_THICKNESS_MM=5;

// Calculate height increase due to angle
ANGLE_HEIGHT_MM = DEPTH_MM * tan(ANGLE_DEG);

CLAMP_DEPTH_MM=25;
CLAMP_HIEGHT_MM=20;
CLAMP_WIDTH_MM=100;

// Define points for polyhedron
// Base: 4 points forming a rectangle
// Top: 2 points for angled top with central point
points = [
    // Base (z=0)
    [0, 0, 0],                  // 0: Front-left corner
    [WIDTH_MM, 0, 0],           // 1: Front-right corner
    [WIDTH_MM, DEPTH_MM, 0],    // 2: Back-right corner
    [0, DEPTH_MM, 0],           // 3: Back-left corner
    // Top (z=HEIGHT_MM + angle height)
    [WIDTH_MM / 2, 0, HEIGHT_MM],                       // 4: Front center (lower)
    [WIDTH_MM / 2, DEPTH_MM, HEIGHT_MM + ANGLE_HEIGHT_MM + CENTER_POINT_OFFSET_MM] // 5: Back center (higher with point)
];

// Define faces for polyhedron
faces = [
    [0, 1, 2, 3], // Bottom face
    [0, 4, 5, 3], // Left side
    [1, 2, 5, 4], // Right side
    [0, 3, 5, 4], // Front face
    [2, 1, 4, 5], // Back face
    [3, 2, 5]     // Top face (triangle 1)
];


rotate([-90, 0, 0])

    union(){
        // Create the bumper
        translate([WIDTH_MM/4, DEPTH_MM - CLAMP_HIEGHT_MM, -CLAMP_DEPTH_MM])
            cube(size=[CLAMP_WIDTH_MM,CLAMP_HIEGHT_MM, CLAMP_DEPTH_MM]);
        
        cube(size=[WIDTH_MM, DEPTH_MM, BACKPLATE_THICKNESS_MM]);
        translate([0,0,BACKPLATE_THICKNESS_MM])
            polyhedron(points, faces);
    }