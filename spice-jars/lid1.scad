use <utility.scad>

$fn = 100;
deg1 = 23.97;
deg2 = 35.87;

union() {
  cylinder(h = 2, r = 18);
  ring(h = 8, r1 = 18, r2 = 17);
  difference() {
    union() {
      wedge(h = 19, r1 = 14.5, r2 = 12.5, deg1 = 360 - deg1, deg2 = 360 + deg1, $fn = $fn);
      wedge(h = 19, r1 = 14.5, r2 = 12.5, deg1 =       deg2, deg2 = 180 - deg2, $fn = $fn);
      wedge(h = 19, r1 = 14.5, r2 = 12.5, deg1 = 180 + deg1, deg2 = 180 - deg1, $fn = $fn);
      wedge(h = 19, r1 = 14.5, r2 = 12.5, deg1 = 180 + deg2, deg2 = 360 - deg2, $fn = $fn);
    }
    translate([0, 0, 12]) rotate([90, 0, 0]) {
      rotate([-0, 90, 0]) translate([0, 0, -14.5]) union() {
        linear_extrude(height = 29) polygon(points=[[0, 8], [0, 7], [14.5, 0], [14.5, 8]]);
        linear_extrude(height = 29) polygon(points=[[0, 8], [0, 7], [-14.5, 0], [-14.5, 8]]);
      }
    }
  }

  ring(h = 28, r1 = 5, r2 = 3);
}

