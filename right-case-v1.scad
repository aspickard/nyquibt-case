include <roundedcube.scad>;
include <m5-screw-mount.scad>;

case_height = 20;
case_width = 120;
case_depth = 105;
case_corner_radius = 4;
case_thickness = 2;

screw_1_x_offset = 37.4; // 75 / 2 ?
screw_1_y_offset = 27.8; // 55.5 / 2?

screw_2_x_offset = 18.2; // 36.5 / 2?
screw_2_y_offset = -29.4; // 59 / 2?

screw_3_x_offset = -39; // 79 / 2?
screw_3_y_offset = -29.4; // 59 / 2?

difference () {
    roundedcube([case_width, case_depth, case_height], true, case_corner_radius, "z");

    translate([0, 0, case_thickness]) {
        roundedcube(
            [case_width - case_thickness, case_depth - case_thickness, case_height - case_thickness],
            true,
            case_corner_radius,
            "z"
        );
    }
}

translate([screw_1_x_offset, screw_1_y_offset, 0]) {
    m5_screw_mount(case_height, true);
}

translate([screw_2_x_offset, screw_2_y_offset, 0]) {
    m5_screw_mount(case_height, true);
}

translate([screw_3_x_offset, screw_3_y_offset, 0]) {
    m5_screw_mount(case_height, true);
}