use <utility.scad>

$fn = 100;
difference() {
  union() {
    // outer shell and base
    ring(h = 3, r1 = 18, r2 = 3, $fn = $fn);
    ring(h = 65, r1 = 18, r2 = 14.5, $fn = $fn);

    // ridge attached to outer shell
    difference() {
      union() {
        translate([-13, 0, 53.5]) rotate([0, 90, 0]) cylinder(h = 6, r = 6, center = true);
        translate([-16, -6, 0]) cube(size = [6, 12, 53.5]);
        ring(h = 54, r1 = 14.5, r2 = 14, $fn = $fn);
      }
      cylinder(h = 65, r = 13);
    }

    // inner screw hole
    difference() {
      hull() {
        mirror([0, 1, 0]) translate([0, 1, 0]) cylinder(h = 23, r = 4);
        translate([0, 1, 0]) cylinder(h = 23, r = 4);
      }
      hull() {
        mirror([0, 1, 0]) translate([0, 1, 0]) cylinder(h = 23, r = 2);
        translate([0, 1, 0]) cylinder(h = 23, r = 2);
      }
    }
  }
  // hole in outer shell
  translate([15, 0, 53.5]) rotate([0, 90, 0]) cylinder(h = 6, r = 7, center = true);

  // small cylindrical indent at the base
  cylinder(h = 0.5, r1 = 14, r2 = 13);
}
