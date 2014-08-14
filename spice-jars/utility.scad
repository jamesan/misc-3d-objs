function calc_res(r, fa = 12, fs = 2, fn = 0) =
  ( r < GRID_FINE ? 3 :
  ( fn > 0 ? max(fn, 3) :
  ceil(max(min(360.0 / fa, r*2*PI / fs), 5))));

module arc(r1 = 1, r2 = 0.5, deg1 = 0, deg2 = 360, $fa = 12, $fs = 2, $fn = 0) {
  r1 = (r1 == 0 ? r2 : r1);
  r2 = (r1 == r2 ? 0 : r2);

  // derived parameters
  res = calc_res(r1, $fa, $fs, $fn);
  r = r2 / r1;
  degd = (deg2 - deg1) / res;

  // calc caching
  cos_degd = cos(degd);
  sin_degd = sin(degd);
  r_cos_degd = r * cos_degd;
  r_sin_degd = r * sin_degd;
  union() {
    for ( deg = [deg1 : degd : deg2 - degd] ) {
      rotate(deg, [0, 0, 1])
      scale([r1, r1, 0])
      polygon(points=[[r, 0], [1, 0], [cos_degd, sin_degd], [r_cos_degd, r_sin_degd]]);
    }
  }
}

module wedge(h = 1, r1 = 1, r2 = 0.5, deg1 = 0, deg2 = 360, $fa = 12, $fs = 2, $fn = 0) {
  r1 = (r1 == 0 ? r2 : r1);
  r2 = (r1 == r2 ? 0 : r2);

  // derived parameters
  res = calc_res(r1, $fa, $fs, $fn);
  r = r2 / r1;
  degd = (deg2 - deg1) / res;

  // calc caching
  cos_degd = cos(degd);
  sin_degd = sin(degd);
  r_cos_degd = r * cos_degd;
  r_sin_degd = r * sin_degd;

  if (abs(deg2 - deg1) >= 360) {
    ring(h = h, r1 = r1, r2 = r2);
  } else {
    linear_extrude(height = h) {
      for ( deg = [deg1 : degd : deg2 - degd] ) {
        rotate(deg, [0, 0, 1])
        scale([r1, r1, 0])
        polygon(points=[[r, 0], [1, 0], [cos_degd, sin_degd], [r_cos_degd, r_sin_degd]]);
      }
    }
  }
}

module ring(h = 1, r1 = 1, r2 = 0.5, $fa = 12, $fs = 2, $fn = 0) {
  r1 = (r1 == 0 ? r2 : r1);
  r2 = (r1 == r2 ? 0 : r2);

  difference() {
    cylinder(h = h, r = r1);
    cylinder(h = h, r = r2);
  }
}
