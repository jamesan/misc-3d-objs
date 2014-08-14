use <utility.scad>

$fn = 50;

union() {
    // Create hallow cylinder for 0 < z < 12.
    difference() {
        cylinder(h = 12, r = 20, $fn = 90);
        cylinder(h = 12, r = 18, $fn = 90);
    }
    // Create hallow cylinder for 12 < z < 13.
    translate([0, 0, 12]) difference() {
        cylinder(h = 1, r = 20, $fn = 90);
        cylinder(h = 1, r = 16, $fn = 90);
    }

    // Create shape for z > 13.
    difference() {
        // Create outer shell for z > 13.
        intersection() {
            // Wrap extruded X-Z project with a cylindrical r = 20 boundary.
            cylinder(h = 47, r = 20, $fn = 90);
            // Describe X-Z projection of outer shell stretched across -20 < y < 20.
            rotate([90, 0, 0]) translate([0, 0, -20]) difference() {
                // NOTE: 2D objects need to be extruded before they can be diff'd.
                linear_extrude(height = 40) union() {
                    // Describe 2D project of z > 13 outline, except for the arcs.
                    polygon(points = [[20,12],[20,13],[-4.22,26.32],[4.22,41.68],[20,33],[20,36],[0,47],[-20,36],[-20,12]]);
                    // Describe the outer arc of r = 11.17.
                   translate([0, 34, 0]) arc(r1 = 11.17, r2 = 8.76, deg1 = 61.19, deg2 = 241.19);
                }
                // Describe the inner arc of r = 8.76.
                linear_extrude(height = 40) translate([0, 34, 0]) circle(r = 8.76);
                // Rounding sharp corners.
                linear_extrude(height = 40) translate([0, 42.2, 0]) arc(r1 = 4.2, r2 = 5, deg1 = 61.19, deg2 = 118.81);
            }
        }
        // Create inner shell for z > 13 by subtracting the cross figure from the hallowed volume.
        difference() {
            // Create hallowed volume for z > 13.
            intersection() {
                rotate([90, 0, 0]) translate([0, 0, -20]) linear_extrude(height = 40) difference() {
                    polygon(points = [[-16,12],[-16,35.20],[-10.29,38.34],[-5.5,24.26],[16,12.45],[16,12]]);
                    translate([0, 34, 0]) circle(r = 11.17);
                }
                cylinder(h = 47, r = 16, $fn = 90);
            }
            // Create cross figure centred along z-axis.
            translate([0, 0, 21]) {
                cube([11, 2, 10], center = true);
                cube([2, 11, 10], center = true);
            }
        }
    }
}
