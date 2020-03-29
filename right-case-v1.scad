include <roundedcube.scad>;
include <m5-screw-mount.scad>;

case_height = 14;
case_width = 120;
case_depth = 105;
case_corner_radius = 4;
case_thickness = 2;

difference () {
    roundedcube([case_depth, case_width, case_height], true, case_corner_radius, "z");

    translate([0, 0, case_thickness]) {
        roundedcube(
            [case_depth - case_thickness, case_width - case_thickness, case_height - case_thickness],
            true,
            case_corner_radius,
            "z"
        );
    }
}

m5_screw_mount(case_height, true);