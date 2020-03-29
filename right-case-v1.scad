include <roundedcube.scad>;

case_height = 1.4;
case_width = 12;
case_depth = 10.5;
case_corner_radius = 0.6;
case_thickness = .2;

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